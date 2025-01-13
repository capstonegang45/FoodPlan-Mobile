// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'dart:convert';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_plan/helpers/chattbot_helper.dart';
import 'package:food_plan/provider/chat_provider.dart';
import 'package:food_plan/widgets/custom_bottom_nav.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  int _selectedIndex = 2;
  final TextEditingController _messageController = TextEditingController();

  void _onItemTapped(int index) {
    if (index != _selectedIndex) {
      setState(() {
        _selectedIndex = index;
      });

      switch (index) {
        case 0:
          Navigator.pushReplacementNamed(context, '/beranda');
          break;
        case 1:
          Navigator.pushReplacementNamed(context, '/deteksi');
          break;
        case 2:
          break;
        case 3:
          Navigator.pushReplacementNamed(context, '/rencana');
          break;
      }
    }
  }

  Future<void> _sendMessage() async {
    String message = _messageController.text.trim();
    if (message.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Pesan tidak boleh kosong")),
      );
      return;
    }

    final chatProvider = Provider.of<ChatProvider>(context, listen: false);
    final now = DateTime.now();
    final formattedTime = DateFormat('hh:mm a').format(now);
    // Add user's message first
    chatProvider.addMessage(message, "user",
        avatar: null, time: formattedTime); // Avatar user default
    chatProvider.setBotTypingStatus(true);

    try {
      final response = await sendMessageAndGetResponse(message);

      // Get the avatar from the backend
      String? avatarBase64 = response['avatar'];

      // If avatar exists and is valid, use it, else leave it null
      if (avatarBase64 != null && avatarBase64.contains('base64,')) {
        avatarBase64 = avatarBase64.split('base64,').last;
      }

      // Add bot's response, but keep its avatar null
      chatProvider.addMessage(
        response['answer'],
        "bot",
        avatar: null, // Use the default icon for the bot
      );

      // If avatar is received for the user, update the user's message
      if (avatarBase64 != null) {
        for (int i = chatProvider.chatHistory.length - 2; i >= 0; i--) {
          if (chatProvider.chatHistory[i]['sender'] == 'user') {
            chatProvider.updateAvatar(i, avatar: avatarBase64);
            break; // Stop after updating the most recent user message
          }
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    }
    chatProvider.setBotTypingStatus(false);

    _messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final chatProvider = Provider.of<ChatProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'FOODPLAN APP',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.teal[900],
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsetsDirectional.symmetric(horizontal: 15.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(8.0),
                itemCount: chatProvider.chatHistory.length,
                itemBuilder: (context, index) {
                  final chat = chatProvider.chatHistory[index];
                  final isUserMessage = chat["sender"] == "user";
                  String? avatarBase64 = chat["avatar"];
                  final color =
                      isUserMessage ? Colors.teal[100] : Colors.grey[300];

                  return Row(
                    mainAxisAlignment: isUserMessage
                        ? MainAxisAlignment.end
                        : MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (!isUserMessage) ...[
                        CircleAvatar(
                          backgroundColor: Colors.grey[400],
                          child: const Center(
                            child: FaIcon(
                              FontAwesomeIcons.robot,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        )
                      ],
                      Flexible(
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 4),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: color,
                            borderRadius: BorderRadius.only(
                              topLeft: const Radius.circular(12),
                              topRight: const Radius.circular(12),
                              bottomLeft: isUserMessage
                                  ? const Radius.circular(12)
                                  : Radius.zero,
                              bottomRight: isUserMessage
                                  ? Radius.zero
                                  : const Radius.circular(12),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                chat["message"] ?? "",
                                style: const TextStyle(fontSize: 16),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                chat["time"] ??
                                    "", // Tambahkan waktu di sini (dapat diubah sesuai kebutuhan)
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      if (isUserMessage) ...[
                        const SizedBox(width: 8),
                        CircleAvatar(
                          backgroundColor: Colors.teal[300],
                          backgroundImage: avatarBase64 != null
                              ? MemoryImage(base64Decode(avatarBase64))
                              : null,
                          child: avatarBase64 == null
                              ? const Icon(Icons.person, color: Colors.white)
                              : null,
                        ),
                      ],
                    ],
                  );
                },
              ),
            ),
            if (chatProvider.isBotTyping) ...[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  children: [
                    const CircleAvatar(
                      backgroundColor: Colors.grey,
                      child: FaIcon(
                        FontAwesomeIcons.robot,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 8),
                    // Gunakan TyperAnimatedText dari animated_text_kit
                    AnimatedTextKit(
                      isRepeatingAnimation: false,
                      totalRepeatCount: 1,
                      pause: const Duration(milliseconds: 500),
                      displayFullTextOnTap: true,
                      animatedTexts: [
                        TyperAnimatedText(
                          "Bot is typing...",
                          speed:
                              const Duration(milliseconds: 100), // Kecepatan ketikan
                          textStyle: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      decoration: InputDecoration(
                        hintText: "Tulis pesan...",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: _sendMessage,
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(12),
                    ),
                    child: const Icon(Icons.send),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

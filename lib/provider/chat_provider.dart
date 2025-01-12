import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

class ChatProvider with ChangeNotifier {
  final List<Map<String, String>> _chatHistory = [];
  List<Map<String, String>> get chatHistory => List.unmodifiable(_chatHistory);

  void addMessage(String message, String sender, {String? avatar, String? time}) {
    final now = DateTime.now();
    final formattedTime = DateFormat('hh:mm a').format(now);
    _chatHistory.add({
      "message": message,
      "sender": sender,
      "avatar": avatar ?? "",
      "time": formattedTime,
    });
    notifyListeners();
  }

  void updateAvatar(int index, {String? avatar}) {
    if (index >= 0 && index < chatHistory.length) {
      chatHistory[index]['avatar'] = avatar ?? "";
      notifyListeners(); // Notify listeners to update UI
    }
  }

  void clearHistory() {
    _chatHistory.clear();
    notifyListeners();
  }
}

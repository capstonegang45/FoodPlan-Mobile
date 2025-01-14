// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:food_plan/models/config.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SentimentPopup extends StatefulWidget {
  const SentimentPopup({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SentimentPopupState createState() => _SentimentPopupState();
}

class _SentimentPopupState extends State<SentimentPopup> {
  double _rating = 3.0; // Default rating
  final TextEditingController _reviewController = TextEditingController();
  final String _apiUrl = "$baseUrl/add_sentiment"; // API URL

  Future<void> _submitData() async {
    final review = _reviewController.text.trim();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token == null || token.isEmpty) {
      throw Exception('Token tidak ditemukan');
    }

    if (review.isEmpty || _rating <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please provide a rating and a review")),
      );
      return;
    }

    final response = await http.post(
      Uri.parse(_apiUrl),
      headers: {
        "Content-Type": "application/json",
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({"rating": _rating.toInt(), "review": review}),
    );

    if (response.statusCode == 201) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Sentiment submitted successfully!")),
      );
      Navigator.of(context).pop();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to submit sentiment")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/img/logolagi.png',
            width: 150,
            height: 150,
          ),
          Text('Beri Nilai'),
          Text('Silahkan berikan penilaian anda',
              style: TextStyle(fontSize: 14))
        ],
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("Rating"),
            RatingBar.builder(
              initialRating: _rating,
              minRating: 1,
              maxRating: 5,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => const Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {
                setState(() {
                  _rating = rating;
                });
              },
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _reviewController,
              decoration: const InputDecoration(
                labelText: "Review",
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text("Cancel"),
        ),
        ElevatedButton(
          onPressed: _submitData,
          child: const Text("Submit"),
        ),
      ],
    );
  }
}

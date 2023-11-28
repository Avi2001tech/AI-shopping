import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

class OpenAIAPI {
  static const String apiKey =
      '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';
  static const String apiUrl = 'https://api.openai.com/v1/chat/completions';

  static Future<String> getChatGPTResponse(String prompt) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey',
      },
      body: jsonEncode({
        'model': 'gpt-3.5-turbo',
        'messages': [
          {'role': 'user', 'content': prompt},
        ],
        'temperature': 0.7,
      }),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final Map<String, dynamic> assistantMessage =
          data['choices'][0]['message'];
      return assistantMessage['content'];
    } else {
      throw Exception('Failed to get response from ChatGPT API');
    }
  }

  static Future<String> getImageGeneration(String prompt) async {
    final response = await http.post(
      Uri.parse('https://api.openai.com/v1/images/generations'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey',
      },
      body: jsonEncode({
        'prompt': prompt,
        'model': 'dall-e-3',
        'size': '1024x1024',
        'quality': 'standard',
        'n': 2,
      }),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      return data['data'][0]['url'];
    } else {
      throw Exception('Failed to get response from Image Generation API');
    }
  }
}

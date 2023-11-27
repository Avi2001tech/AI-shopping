import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

class OpenAIAPI {
  static const String apiKey =
      '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';
  static const String apiUrl =
      'https://api.openai.com/v1/engines/davinci/completions';

  static Future<String> getChatGPTResponse(String prompt) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey',
      },
      body: jsonEncode({
        'prompt': prompt,
        'max_tokens': 500,
      }),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      return data['choices'][0]['text'];
    } else {
      throw Exception('Failed to get response from ChatGPT API');
    }
  }
}

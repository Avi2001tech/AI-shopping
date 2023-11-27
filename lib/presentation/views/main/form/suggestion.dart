import 'package:flutter/material.dart';

import 'OpenAIAPI.dart';
import 'form_data.dart';

class suggestPage extends StatefulWidget {
  final FormData formData;

  const suggestPage({Key? key, required this.formData}) : super(key: key);

  @override
  _suggestPageState createState() => _suggestPageState();
}

class _suggestPageState extends State<suggestPage> {
  String chatGPTResponse = ''; // Variable to store ChatGPT response
  String progressMessage = ''; // Variable to store progress message
  String errorMessage = ''; // Variable to store error message

  Future<String> getChatGPTResponse() async {
    try {
      String prompt = widget.formData.toParagraph();
      final response = await OpenAIAPI.getChatGPTResponse(prompt);
      return response;
    } catch (e) {
      setState(() {
        errorMessage = 'Error generating ChatGPT Response: $e';
      });
      throw Exception('Failed to get response from ChatGPT API: $e');
    }
  }

  void _handleButtonPress() async {
    // Update progress message
    setState(() {
      progressMessage = 'Generating ChatGPT Response...';
    });

    try {
      // Call the function to get ChatGPT response
      String response = await getChatGPTResponse();

      // Update the state with the generated response
      setState(() {
        chatGPTResponse = response;
        progressMessage = ''; // Clear progress message
        errorMessage = ''; // Clear error message
      });
    } catch (e) {
      // Handle errors if any
      setState(() {
        errorMessage = 'Error generating ChatGPT Response: $e';
        progressMessage = ''; // Clear progress message
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Suggestion Page',
          style: TextStyle(
            color: Colors.white, // Set the desired text color
          ),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFF3a086b),
        iconTheme: IconThemeData(
          color: Colors.white, // Set the color of the back arrow
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'So your needs are:', // Add a label for clarity
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
                color: Color(0xFFf59cde),
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              widget.formData.toParagraph(),
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                _handleButtonPress();
              },
              style: ElevatedButton.styleFrom(
                primary: Color(0xFF3a086b), // Set your desired background color
              ),
              child: Text(
                'Yes, suggest accordingly!!!',
                style: TextStyle(
                  color: Colors.white, // Set your desired text color
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Our Suggestion:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
                color: Color(0xFFf59cde),
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              progressMessage, // Display progress message
              style: TextStyle(fontSize: 16.0, color: Colors.blue),
            ),
            Text(
              errorMessage, // Display error message
              style: TextStyle(fontSize: 16.0, color: Colors.red),
            ),
            Text(
              chatGPTResponse, // Display ChatGPT response
              style: TextStyle(fontSize: 16.0),
            ),
          ],
        ),
      ),
    );
  }
}

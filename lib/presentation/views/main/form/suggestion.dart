import 'package:flutter/material.dart';

import 'form_data.dart';

class suggestPage extends StatelessWidget {
  final FormData formData;

  const suggestPage({Key? key, required this.formData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Next Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Occasion: ${formData.occasion}'),
            Text('Body Height: ${formData.bodyHeight}'),
            Text('Gender: ${formData.gender?.name ?? 'Not specified'}'),
            Text('Skin Tone: ${formData.skinTone ?? 'Not specified'}'),
            Text('Waist Size: ${formData.waistSize ?? 'Not specified'}'),
            Text('Body Shape: ${formData.bodyShape ?? 'Not specified'}'),
          ],
        ),
      ),
    );
  }
}

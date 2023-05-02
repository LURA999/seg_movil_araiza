import 'package:flutter/material.dart';

class FormDialog extends StatelessWidget {
  const FormDialog({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FormDialog'),
      ),
      body: const Center(
        child: Text('FormDialog'),
      ),
    );
  }
}

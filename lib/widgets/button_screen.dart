import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/services.dart';
import '../services/letter_mediaquery.dart';

class ButtonScreen extends StatelessWidget {
  final String textButton;
  final int btnPosition;

  const ButtonScreen({
    super.key,
    required this.textButton,
    required this.btnPosition,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
        onPressed: Provider.of<VarProvider>(context).varControl
            ? () {
                if (btnPosition == 1) {
                Navigator.of(context).pushNamed('scanner_qr');
                }
              }
            : null,
        child: Text(textButton,style: getTextStyleButtonField(context)
        )
      ),
    );
  }
}

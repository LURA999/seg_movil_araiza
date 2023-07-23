import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/services.dart';

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
    double responsivePadding = MediaQuery.of(context).orientation == Orientation.portrait ? MediaQuery.of(context).size.width * 0.02 : MediaQuery.of(context).size.height * 0.02;

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
        child: Padding(
          padding: EdgeInsets.all(responsivePadding),
          child: Text(textButton,style: getTextStyleButtonField(context)
          ),
        )
      ),
    );
  }
}

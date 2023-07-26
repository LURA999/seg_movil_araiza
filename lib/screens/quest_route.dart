import 'package:flutter/material.dart';

import '../widgets/widgets.dart';

class QuestRoute extends StatelessWidget {
  const QuestRoute({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> param = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    // Accede a los parámetros individualmente
    int periodo = param['periodo'];

    print(periodo);    

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Text('QuestRoute'),
          ),
        const SizedBox(child: Navbar(contexto2: 'tour_seh',))
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

import 'widgets.dart';

SizedBox bottomInfo(BuildContext context, String calories, String taxes, String month) {

  List<Map<String, dynamic>> infoList = [
    {'title': 'Calorias', 'info': 'Esta ronda debes consumir la siguiente cantidad de calorias en ingredientes o platos cocinados: '},
    {'title': 'Impuestos', 'info': 'Esta ronda debes pagar la siguiente cantidad de dinero por impuestos: '},
    {'title': 'Mes', 'info': 'El mes actual que representa el progreso del juego, actualmente estas en el siguiente mes: '},
    ];

  return SizedBox(
    width: MediaQuery.of(context).size.width - 50,
    child: Stack(
      alignment: AlignmentDirectional.topStart,
      children: [
        ElevatedButton(
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
          style: ElevatedButton.styleFrom(
            fixedSize: const Size(50, 50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          child: const Icon(Icons.menu),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 10),
            //   child: ElevatedButton(
            //     onPressed: () {
            //       _showDialog(context, infoList[0], calories);
            //     },
            //     style: ElevatedButton.styleFrom(
            //       fixedSize: const Size(150, 50),
            //       shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(15),
            //       ),
            //     ),
            //     child: Column(
            //       children: [
            //         const Text(
            //           'Calorias',
            //           style: TextStyle(fontWeight: FontWeight.bold),
            //         ),
            //         Text(calories),
            //       ],
            //     ),
            //   ),
            // ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 10),
            //   child: ElevatedButton(
            //     onPressed: () {
            //       _showDialog(context, infoList[1], taxes);
            //     },
            //     style: ElevatedButton.styleFrom(
            //       fixedSize: const Size(150, 50),
            //       shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(15),
            //       ),
            //     ),
            //     child: Column(
            //       children: [
            //         const Text(
            //           'Impuestos',
            //           style: TextStyle(fontWeight: FontWeight.bold),
            //         ),
            //         Text(taxes),
            //       ],
            //     ),
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: ElevatedButton(
                onPressed: () {
                  _showDialog(context, infoList[2], month);
                },
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(150, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: Column(
                  children: [
                    const Text(
                      'Mes',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(month),
                  ],
                ),
              ),
            ),
          ],
        )
      ],
    ),
  );
}

void _showDialog(BuildContext context, Map<String, dynamic> infoList, String value) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertInfoDialog(
        isScanCorrect: true,
        data: infoList,
        value: value,
        // height: MediaQuery.of(context).size.height - 50,
        width: MediaQuery.of(context).size.width * 2 / 3,
      );
    },
  );
}

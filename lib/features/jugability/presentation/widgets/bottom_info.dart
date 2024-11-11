import 'package:flutter/material.dart';

SizedBox bottomInfo(BuildContext context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width - 50,
        child: Stack(
          alignment: AlignmentDirectional.topStart,
          children: [
            ElevatedButton(
              onPressed: () {},
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size(150, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: const Column(
                      children: [
                        Text('Calorias', style: TextStyle(fontWeight: FontWeight.bold),),
                        Text('6'),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size(150, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: const Column(
                      children: [
                        Text('Impuestos', style: TextStyle(fontWeight: FontWeight.bold),),
                        Text('5'),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size(150, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: const Column(
                      children: [
                        Text('Mes', style: TextStyle(fontWeight: FontWeight.bold),),
                        Text('Enero'),
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
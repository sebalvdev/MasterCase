import 'package:flutter/material.dart';
import 'package:master_case/config/routes/app_routes.dart';

import '../../../../core/constants/constants.dart';

Widget buttons(BuildContext context) {
  return SingleChildScrollView(
    child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 80),
          child: SizedBox(child: Image.asset('assets/images/reverso.jpg')),
        ),
        const SizedBox(
          height: 15,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ListTile(
            tileColor: blue,
            leading: const Padding(
              padding: EdgeInsets.only(left: 15),
              child: Icon(
                Icons.settings,
                color: black,
              ),
            ),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            title: Center(
                child: Text(
              'Instrucciones',
              style: TextStyle(color: black, fontSize: h2),
            )),
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.instruction);
            },
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ListTile(
            tileColor: blue,
            leading: const Padding(
              padding: EdgeInsets.only(left: 15),
              child: Icon(
                Icons.ac_unit_outlined,
                color: black,
              ),
            ),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            title: Center(
                child: Text(
              'Creditos',
              style: TextStyle(color: black, fontSize: h2),
            )),
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.credits);
            },
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ListTile(
            tileColor: blue,
            leading: const Padding(
              padding: EdgeInsets.only(left: 15),
              child: Icon(
                Icons.logout_outlined,
                color: black,
              ),
            ),
            title: Center(
                child: Text(
              'Salir',
              style: TextStyle(color: black, fontSize: h2),
            )),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            onTap: () async {
              Navigator.pushNamedAndRemoveUntil(
                  context, AppRoutes.menu, (route) => false);
            },
          ),
        ),
      ],
    ),
  );
}

import 'package:flutter/material.dart';

import '../../../../core/constants/constants.dart';

class AlertInfoDialog extends StatefulWidget {
  const AlertInfoDialog(
      {super.key,
      required this.isScanCorrect,
      required this.data,
      required this.value,
      // required this.height,
      this.width = 300});
  final bool isScanCorrect;
  final Map<String, dynamic> data;
  final String value;
  // final double height;
  final double width;

  @override
  State<AlertInfoDialog> createState() => _InfoElementDialogState();
}

class _InfoElementDialogState extends State<AlertInfoDialog>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.elasticOut,
    );

    _animationController.forward(from: 0.2);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.data.isNotEmpty) {
      return AlertDialog(
        title: Center(
            child: Text(
          widget.data['title'].toUpperCase(),
          style: TextStyle(fontSize: h2, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        )),
        content: SizedBox(
          // height: widget.height,
          width: widget.width,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  widget.data["info"],
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: h2),
                ),
                Text(
                  widget.value,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: h1),
                ),
                // Text(data["data"].description, textAlign: TextAlign.center,style: TextStyle(fontSize: h2),),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: yellow,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text('Regresar',
                      style: TextStyle(color: black, fontSize: h2)),
                ),
              ],
            ),
          ),
        ),
      );
    }
    return AlertDialog(
      title: const Center(child: Text('Error')),
      content: SizedBox(
        height: 225,
        child: ScaleTransition(
          scale: _animation,
          child: const Icon(
            Icons.cancel,
            color: Colors.red,
            size: 200,
          ),
        ),
      ),
    );
  }
}

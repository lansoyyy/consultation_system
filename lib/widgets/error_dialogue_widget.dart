import 'package:consultation_system/constant/colors.dart';
import 'package:flutter/material.dart';
import '../../../../widgets/text_widget.dart';

class ErrorDialog extends StatelessWidget {
  final VoidCallback onPressed;
  final String caption;

  const ErrorDialog(
      {super.key, required this.caption, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: primary,
      child: Container(
        decoration: BoxDecoration(
          color: primary,
          borderRadius: BorderRadius.circular(20),
        ),
        height: 350,
        width: 300,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 20,
            ),
            NormalText(
              color: Colors.white,
              fontSize: 18,
              label: caption,
            ),
            const SizedBox(
              height: 20,
            ),
            const Icon(
              Icons.close,
              size: 180,
              color: Colors.red,
            ),
            const SizedBox(
              height: 30,
            ),
            MaterialButton(
              minWidth: 300,
              height: 50,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100)),
              onPressed: onPressed,
              child: NormalText(
                color: primary,
                fontSize: 18,
                label: 'Close',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

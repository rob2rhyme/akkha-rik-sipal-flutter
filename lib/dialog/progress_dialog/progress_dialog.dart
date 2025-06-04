//lib/dialog/progress_dialog/progress_dialog.dart
import 'package:flutter/material.dart';
import 'package:akkha_rik_lipi_sipal/utils/color.dart';

class ProgressDialog extends StatelessWidget {
  final Widget? child;
  final bool? inAsyncCall;
  final double? opacity;
  final Color? color;
  final Animation<Color>? valueColor;

  const ProgressDialog({
    super.key, // ✅ Super parameter used
    @required this.child,
    @required this.inAsyncCall,
    this.opacity = 0.0,
    this.color = AppColor.transparent,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetList = [];
    widgetList.add(child!);

    if (inAsyncCall!) {
      final modal = Stack(
        children: [
          Opacity(
            opacity: opacity!,
            child: ModalBarrier(dismissible: false, color: color),
          ),
          Center(
            child: Container(
              height: 100,
              width: 100,
              padding: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                color: AppColor.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                    color: AppColor.txtColor999,
                    spreadRadius: 0.1,
                    offset: Offset(0, 20.0),
                    blurRadius: 25.0,
                  ),
                ],
              ),
              child: const CircularProgressIndicator(),
            ),
          ),
        ],
      );
      widgetList.add(modal);
    }

    return Stack(children: widgetList);
  }
}

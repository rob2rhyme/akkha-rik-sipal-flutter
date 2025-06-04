//lib/dialog/complete_dialog/complete_dialog_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:akkha_rik_lipi_sipal/utils/color.dart';
import 'package:akkha_rik_lipi_sipal/utils/constant.dart';

class CompleteDialog extends StatefulWidget {
  final Function restartFunction;
  final String image;

  const CompleteDialog({
    super.key, // 👈 Super parameter used here
    required this.restartFunction,
    this.image = "assets/icons/ic_drag_restart.webp",
  });

  @override
  CompleteDialogState createState() => CompleteDialogState();
}

class CompleteDialogState extends State<CompleteDialog> {
  Function? restartFunction;

  @override
  void initState() {
    restartFunction = widget.restartFunction;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      child: Scaffold(
        backgroundColor: AppColor.transparent,
        body: Center(
          child: Wrap(
            children: [
              Container(
                padding: EdgeInsets.all(
                  MediaQuery.of(context).size.height * 0.1,
                ),
                child: Image.asset(
                  Constant.getAssetDragImages() + "ic_welldone.webp",
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.15,
                  vertical: MediaQuery.of(context).size.height * 0.01,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Get.close(2);
                      },
                      child: Image.asset(
                        "assets/icons/ic_home.webp",
                        height: 55,
                        width: 55,
                      ),
                    ),
                    InkWell(
                      onTap: () => restartFunction!(),
                      child: Image.asset(widget.image, height: 55, width: 55),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

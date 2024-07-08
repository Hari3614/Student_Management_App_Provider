import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:student_management_provider/core/constants.dart';

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({
    super.key,
    this.lefticon,
    this.righticon,
    required this.title,
    this.onTapLeft,
    this.onTapright,
  });
  final IconData? lefticon;
  final IconData? righticon;
  final String title;
  final void Function()? onTapLeft;
  final void Function()? onTapright;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: GoogleFonts.oswald(
            color: appBarClrBlk, fontSize: 20, fontWeight: FontWeight.w700),
      ),
      elevation: 0,
      leading: InkWell(
        child: Icon(lefticon, color: appBarClrBlk),
        onTap: () {
          onTapLeft!();
        },
      ),
      actions: [
        InkWell(
            onTap: onTapright,
            child: Icon(
              righticon,
              color: appBarClrBlk,
              size: 30,
            ))
      ],
      centerTitle: true,
      backgroundColor: appBarClrWhite,
      shape: const ContinuousRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
    );
  }
}

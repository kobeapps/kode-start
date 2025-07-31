import 'package:flutter/cupertino.dart';
import 'package:kode_start_imc/theme/app_colors.dart';

class BottomButtonWidget extends StatelessWidget {
  const BottomButtonWidget({
    super.key,
    required this.onPressed,
    required this.title,
  });

  final VoidCallback onPressed;
  final String title;

  @override
  Widget build(BuildContext context) {
    final paddingBottom = MediaQuery.of(context).padding.bottom;
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: onPressed,
      child: Container(
        height: 65 + paddingBottom,
        padding: EdgeInsets.only(bottom: paddingBottom),
        color: AppColors.primaryColorDark,
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              color: AppColors.white,
              fontSize: 14.5,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}

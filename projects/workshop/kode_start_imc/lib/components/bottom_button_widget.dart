import 'package:flutter/cupertino.dart';
import 'package:kode_start_imc/theme/app_colors.dart';

class BottomlabelLargeWidget extends StatelessWidget {
  const BottomButtonWidget({
    Key? key,
    required this.onPressed,
    required this.title,
  }) : super(key: key);

  final VoidCallback onPressed;
  final String title;

  @override
  Widget build(BuildContext context) {
    final paddingBottom = MediaQuery.of(context).padding.bottom;
    return CupertinolabelLarge(
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

import 'package:flutter/material.dart';
import 'package:kode_start_imc/theme/app_colors.dart';

class UserInputWidget extends StatelessWidget {
  const UserInputWidget({
    Key? key,
    required this.title,
    required this.value,
    required this.onIncrease,
    required this.onDecrease,
    required this.measureUnit,
    this.height,
    this.onIncreaseHold,
    this.onIncreaseRelease,
    this.onDecreaseHold,
    this.onDecreaseRelease,
  }) : super(key: key);

  final String title;
  final int value;
  final String measureUnit;
  final void Function() onIncrease;
  final void Function()? onIncreaseHold;
  final void Function()? onIncreaseRelease;
  final Function onDecrease;
  final Function? onDecreaseHold;
  final Function? onDecreaseRelease;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: AppColors.white,
              fontSize: 14,
              fontWeight: FontWeight.w900,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Container(
              height: height ?? 170,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColors.primaryColorLight,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => onDecrease(),
                    onTapDown: (_) {
                      if (onDecreaseHold != null) {
                        onDecreaseHold!();
                      }
                    },
                    onTapUp: (details) {
                      if (onDecreaseRelease != null) {
                        onDecreaseRelease!();
                      }
                    },
                    child: Container(
                      width: 48,
                      height: 48,
                      margin: const EdgeInsets.only(left: 21),
                      decoration: BoxDecoration(
                        color: AppColors.primaryColorDark,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.remove,
                        color: AppColors.white,
                        size: 42,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 108,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          value.toString(),
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: 50,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        Text(
                          measureUnit,
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: 14.5,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: onIncrease,
                    onTapDown: (_) {
                      if (onIncreaseHold != null) {
                        onIncreaseHold!();
                      }
                    },
                    onTapUp: (details) {
                      if (onIncreaseRelease != null) {
                        onIncreaseRelease!();
                      }
                    },
                    child: Container(
                      width: 48,
                      height: 48,
                      margin: const EdgeInsets.only(right: 21),
                      decoration: BoxDecoration(
                        color: AppColors.primaryColorDark,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.add,
                        color: AppColors.white,
                        size: 42,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

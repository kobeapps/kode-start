import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kode_start_imc/components/app_bar_widget.dart';
import 'package:kode_start_imc/components/user_input_widget.dart';
import 'package:kode_start_imc/result_page.dart';
import 'package:kode_start_imc/theme/app_colors.dart';

import 'components/bottom_button_widget.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int height = 170;
  int weight = 65;

  Timer? _timer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        leftIcon: Icon(
          Icons.person,
          color: AppColors.white,
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        color: AppColors.black,
        child: Column(
          children: [
            const SizedBox(height: 30),
            UserInputWidget(
              title: 'Qual a sua altura?',
              value: height,
              onIncrease: () {
                increaseHeight();
              },
              onIncreaseHold: () {
                _timer = Timer.periodic(
                  const Duration(milliseconds: 200),
                  (timer) {
                    increaseHeight();
                  },
                );
              },
              onIncreaseRelease: () => _timer?.cancel(),
              onDecrease: () {
                decreaseHeight();
              },
              onDecreaseHold: () {
                _timer = Timer.periodic(
                  const Duration(milliseconds: 200),
                  (timer) {
                    decreaseHeight();
                  },
                );
              },
              onDecreaseRelease: () => _timer?.cancel(),
              measureUnit: 'cm',
            ),
            const SizedBox(height: 20),
            UserInputWidget(
              height: 140,
              title: 'Qual o seu peso?',
              value: weight,
              onIncrease: () {
                increaseWeight();
              },
              onIncreaseHold: () {
                _timer = Timer.periodic(
                  const Duration(milliseconds: 200),
                  (timer) {
                    increaseWeight();
                  },
                );
              },
              onIncreaseRelease: () => _timer?.cancel(),
              onDecrease: () {
                decreaseWeight();
              },
              onDecreaseHold: () {
                _timer = Timer.periodic(
                  const Duration(milliseconds: 200),
                  (timer) {
                    decreaseWeight();
                  },
                );
              },
              onDecreaseRelease: () => _timer?.cancel(),
              measureUnit: 'kg',
            ),
            const Spacer(),
            BottomButtonWidget(
              title: 'CALCULAR O RESULTADO',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ResultPage(
                      weight: weight,
                      height: height,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void increaseHeight() {
    return setState(() {
      height++;
    });
  }

  void decreaseHeight() {
    return setState(() {
      height--;
    });
  }

  void increaseWeight() {
    return setState(() {
      weight++;
    });
  }

  void decreaseWeight() {
    return setState(() {
      weight--;
    });
  }
}

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:kode_start_imc/components/app_bar_widget.dart';
import 'package:kode_start_imc/components/bottom_button_widget.dart';
import 'package:kode_start_imc/theme/app_colors.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({Key? key, required this.height, required this.weight})
      : super(key: key);

  final int height;
  final int weight;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        leftIcon: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: AppColors.white,
          ),
        ),
      ),
      body: Container(
        color: AppColors.black,
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'RESULTADO',
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: AppColors.primaryColorLight,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _calculateIMC().toStringAsFixed(1),
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 50,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Text(
                      _resultIMC(),
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 14.5,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            BottomButtonWidget(
              title: 'CALCULAR NOVAMENTE',
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }

  double _calculateIMC() {
    return weight / (pow(height / 100, 2));
  }

  String _resultIMC() {
    double imc = _calculateIMC();
    if (imc < 18.5) {
      return 'Abaixo do Peso';
    } else if (imc >= 18.5 && imc <= 24.9) {
      return 'Peso Normal';
    } else if (imc >= 25 && imc <= 29.9) {
      return 'Sobrepeso';
    } else if (imc >= 30 && imc <= 34.9) {
      return 'Obesidade Grau I';
    } else if (imc > 35 && imc <= 39.9) {
      return 'Obesidade Grau II';
    } else {
      return 'Obesidade Grau III ou Mórbida';
    }
  }
}

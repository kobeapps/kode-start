import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:kode_start_imc/components/app_bar_component.dart';
import 'package:kode_start_imc/result_page.dart';
import 'package:kode_start_imc/theme/app_colors.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int height = 170;
  int weight = 65;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarComponent(context),
      body: Container(
        width: MediaQuery.of(context).size.width,
        color: AppColors.black,
        child: Column(
          children: [
            SizedBox(height: 30),
            _buildHeightComponent(),
            SizedBox(height: 20),
            _buildWeightComponent(),
            Spacer(),
            _buildCalculateButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeightComponent() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Qual a sua altura?",
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w900,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Container(
              height: 170,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColors.primaryColorLight,
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      if (height > 0) {
                        setState(() {
                          height--;
                        });
                      }
                    },
                    child: Container(
                      width: 48,
                      height: 48,
                      margin: EdgeInsets.only(left: 21),
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
                  Spacer(),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        height.toString(),
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: 50,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      Text(
                        "cm",
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: 14.5,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        height++;
                      });
                    },
                    child: Container(
                      width: 48,
                      height: 48,
                      margin: EdgeInsets.only(right: 21),
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

  Widget _buildWeightComponent() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Qual o seu peso?",
            style: TextStyle(
              color: AppColors.white,
              fontSize: 14,
              fontWeight: FontWeight.w900,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Container(
              height: 170,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColors.primaryColorLight,
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      if (weight > 0) {
                        setState(() {
                          weight--;
                        });
                      }
                    },
                    child: Container(
                      width: 48,
                      height: 48,
                      margin: EdgeInsets.only(left: 21),
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
                  Spacer(),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        weight.toString(),
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: 50,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      Text(
                        "kg",
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: 14.5,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        weight++;
                      });
                    },
                    child: Container(
                      width: 48,
                      height: 48,
                      margin: EdgeInsets.only(right: 21),
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

  Widget _buildCalculateButton() {
    return GestureDetector(
      onTap: () {
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
      child: Container(
        height: 65 + MediaQuery.of(context).padding.bottom,
        color: AppColors.primaryColorDark,
        child: Center(
          child: Text(
            "CALCULAR O RESULTADO",
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

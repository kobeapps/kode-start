import 'package:flutter/material.dart';
import 'package:rick_morty_thiago_arend/components/app_bar_component.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarComponent(context),
      body: Center(
        child: Text('Olá mundo'),
      ),
    );
  }
}

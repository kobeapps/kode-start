import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});
  @override
  Widget build(BuildContext context) =>
      const SizedBox(width: 36, height: 36, child: CircularProgressIndicator());
}

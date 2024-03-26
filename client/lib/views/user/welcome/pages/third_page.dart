import 'package:flutter/material.dart';

class ThirdPage extends StatelessWidget {
  final VoidCallback onTap;
  final VoidCallback back;

  const ThirdPage({super.key,  required this.onTap, required this.back});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Third Page'),
              ElevatedButton(
                  onPressed: (){
                    onTap();
                  },
                  child: const Text('Next page')),
              ElevatedButton(
                  onPressed: (){
                    back();
                  },
                  child: const Text('Previous page')),
            ],
          ),
        )
    );
  }
}

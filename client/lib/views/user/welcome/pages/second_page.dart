import 'package:flutter/material.dart';

class SecondPage extends StatelessWidget {
  final VoidCallback onTap;
  final VoidCallback back;

  const SecondPage({super.key,  required this.onTap, required this.back});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Second Page'),
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

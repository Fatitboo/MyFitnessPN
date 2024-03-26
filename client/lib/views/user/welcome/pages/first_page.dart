import 'package:flutter/material.dart';

class FirstPage extends StatelessWidget {
  final VoidCallback onTap;
  const FirstPage({super.key,  required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('first page'),
              ElevatedButton(
                  onPressed: (){
                    onTap();
                  },
                  child: const Text('Next page')),
            ],
          ),
        )
    );
  }
}

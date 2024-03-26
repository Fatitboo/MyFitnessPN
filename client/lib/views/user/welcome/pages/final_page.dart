import 'package:flutter/material.dart';

class FinalPage extends StatelessWidget {
  final VoidCallback back;
  final VoidCallback onTap;
  const FinalPage({super.key,  required this.back, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Final Page'),
              ElevatedButton(
                  onPressed: (){
                    back();
                  },
                  child: const Text('Previous page')),
              ElevatedButton(
                  onPressed: (){
                    onTap();
                  },
                  child: const Text('Application page')),
            ],
          ),
        )
    );
  }
}

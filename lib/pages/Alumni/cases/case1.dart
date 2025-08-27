import 'package:flutter/material.dart';

class Case1 extends StatefulWidget {
  const Case1({super.key});

  @override
  State<Case1> createState() => _Case1State();
}

class _Case1State extends State<Case1> {
  bool _isLoading = true;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF002f24),
      body: Center(
        child: SizedBox(
          width: 600,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Case 1',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
           
            ],
          ),
        ),
      ),
    );
          }
}

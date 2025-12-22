import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flower App Home Page')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
        child: Column(
          spacing: 10,
          children: [
            const Center(child: Text('Welcome to Flower App!')),
            ElevatedButton(
              onPressed: () {
                // Navigate to another page or perform an action
              },
              child: const Text('Get Started'),
            ),
            OutlinedButton(onPressed: () {}, child: const Text('Learn More')),
            FilledButton.icon(
              onPressed: () {},
              label: const Text('Explore'),
              icon: const Icon(Icons.explore),
            ),

            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Enter your name',
                hintText: 'John Doe',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

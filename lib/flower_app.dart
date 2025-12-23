import 'package:easy_localization/easy_localization.dart';
import 'package:flower_app/core/constants/text_strings.dart';
import 'package:flower_app/core/theme/light_theme.dart';
import 'package:flutter/material.dart';

class FlowerApp extends StatelessWidget {
  const FlowerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: IAppText.appName,
      debugShowCheckedModeBanner: false,
      theme: LightTheme().themeData,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

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
            ElevatedButton(
              onPressed: null,
              child: const Text('Disabled Button'),
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

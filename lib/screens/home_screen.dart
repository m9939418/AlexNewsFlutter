import 'package:alex_news_flutter/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<ThemeProvider>(context);

    return Scaffold(
      body: Center(
        child: SwitchListTile(
          title: const Text('Theme'),
          secondary: themeState.getDarkTheme
              ? const Icon(Icons.dark_mode_outlined)
              : const Icon(Icons.light_mode_outlined),
          onChanged: (bool value) {
            setState(() {
              themeState.setDarkTheme = value;
            });
          },
          value: themeState.getDarkTheme,
        ),
      ),
    );
  }
}

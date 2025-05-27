import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:minum_music_app/theme/theme_provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the ThemeProvider instance.
    // listen: false is important here to prevent rebuilding the SettingsPage itself
    // when the theme changes, as we are only using it to *call a method*.
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(12),
        ),
        padding: EdgeInsets.all(16),
        margin: EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Theme '),
            // Use a Consumer or Provider.of with listen: true for the switch itself
            // if you want the switch's state to reflect the current theme immediately.
            Consumer<ThemeProvider>(
              builder: (context, currentThemeProvider, child) {
                return Switch(
                  activeColor:  Colors.green,
                  value: currentThemeProvider.isDarkMode, // Use the current theme state for the switch
                  onChanged: (value) {
                    currentThemeProvider.toggleTheme(); // Call the toggle method
                  },
                );
              },
            ),
           
          ],
        ),
      ),
    );
  }
}
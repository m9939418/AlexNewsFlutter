import 'package:alex_news_flutter/providers/theme_provider.dart';
import 'package:alex_news_flutter/screens/bookmarks_screen.dart';
import 'package:alex_news_flutter/screens/home_screen.dart';
import 'package:alex_news_flutter/widgets/vetical_spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({super.key});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<ThemeProvider>(context);

    return Drawer(
      child: Material(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: ListView(
          children: [
            DrawerHeader(
                decoration:
                    BoxDecoration(color: Theme.of(context).primaryColor),
                child: Column(
                  children: [
                    Flexible(
                      child: Image.asset(
                        'assets/images/newspaper.png',
                        height: 60,
                        width: 60,
                      ),
                    ),
                    const VerticalSpacing(20),
                    Flexible(
                      child: Text(
                        'News App',
                        style: GoogleFonts.lobster(
                          textStyle: const TextStyle(
                            fontSize: 20,
                            letterSpacing: 0.6,
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
            const VerticalSpacing(20),
            ListTitlesWidget(
              label: "HOME",
              icon: IconlyBold.home,
              fct: () {
                /** 開啟 『 Home 』頁 **/
                Navigator.pushReplacement(
                  context,
                  PageTransition(
                    type: PageTransitionType.rightToLeft,
                    child: const HomeScreen(),
                    inheritTheme: true,
                    ctx: context,
                  ),
                );
              },
            ),
            ListTitlesWidget(
              label: "BookMarks",
              icon: IconlyBold.bookmark,
              fct: () {
                /** 開啟 『 BookMarks 』頁 **/
                Navigator.pushReplacement(
                  context,
                  PageTransition(
                    type: PageTransitionType.rightToLeft,
                    child: const BookMarksScreen(),
                    inheritTheme: true,
                    ctx: context,
                  ),
                );
              },
            ),
            const Divider(
              thickness: 2,
            ),
            SwitchListTile(
              title: const Text(
                'Theme',
                style: TextStyle(fontSize: 20),
              ),
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
          ],
        ),
      ),
    );
  }
}

class ListTitlesWidget extends StatelessWidget {
  final String label;
  final IconData icon;
  final Function fct;

  const ListTitlesWidget({
    super.key,
    required this.label,
    required this.icon,
    required this.fct,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(
        label,
        style: const TextStyle(fontSize: 20),
      ),
      onTap: () {
        fct();
      },
    );
  }
}

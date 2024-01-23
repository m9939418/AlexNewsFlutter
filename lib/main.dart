import 'package:alex_news_flutter/consts/theme_data.dart';
import 'package:alex_news_flutter/providers/news_provider.dart';
import 'package:alex_news_flutter/providers/theme_provider.dart';
import 'package:alex_news_flutter/screens/blog_detail_screen.dart';
import 'package:alex_news_flutter/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeProvider themeProvider = ThemeProvider();

  @override
  void initState() {
    getCurrentAppTheme();
    super.initState();
  }

  void getCurrentAppTheme() async {
    themeProvider.setDarkTheme =
        await themeProvider.darkThemePreferences.getTheme();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) {
            return themeProvider;
          }),
          ChangeNotifierProvider(create: (_) {
            return NewsProvider();
          }),
        ],
        child:
            Consumer<ThemeProvider>(builder: (context, themeProvider, child) {
          return MaterialApp(
            title: 'News App',
            theme: Styles.themeData(themeProvider.getDarkTheme, context),
            home: const HomeScreen(),
            routes: {
              NewsDetailsScreen.routerName: (ctx) => const NewsDetailsScreen(),
            },
          );
        }));
  }
}

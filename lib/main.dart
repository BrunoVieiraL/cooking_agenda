import 'package:cooking_agenda/provider/themes_provider.dart';
import 'package:cooking_agenda/view/add_receitas.dart';
import 'package:cooking_agenda/view/config_page.dart';
import 'package:cooking_agenda/view/home_page.dart';
import 'package:cooking_agenda/view/lista_receitas_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'view/info_page.dart';
import 'view/splash_page.dart';

void main() async {
  runApp(const MyApp());
  WidgetsFlutterBinding.ensureInitialized();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => ThemeProvider(),
        builder: (context, _) {
          final themeProvider = Provider.of<ThemeProvider>(context);
          return MaterialApp(
            themeMode: themeProvider.themeMode,
            theme: Themes.lightTheme,
            darkTheme: Themes.darkTheme,
            debugShowCheckedModeBanner: false,
            initialRoute: '/',
            routes: {
              '/': (_) => const SplashPage(),
              '/homePage': (_) => const HomePage(),
              '/listaReceitas': (_) => const ListaReceitas(
                    tipoReceita: '',
                  ),
              '/addReceita': (_) => const AddReceitaPage(),
              '/configPage': (_) => const ConfigPage(),
              '/infoPage': (_) => const InfoPage(),
            },
          );
        });
  }
}

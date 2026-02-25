import 'package:flutter/material.dart';
import 'package:mobilesoftware/core/providers/auth_provider.dart';
import 'package:provider/provider.dart';

import 'helpers/database_helper.dart';
import 'router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final dbHelper = DatabaseHelper();
  await dbHelper.database;
  await dbHelper.initializeDatabase();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AuthProvider(),
      child: MaterialApp.router(
        // Use MaterialApp.router
        routerConfig: router, // Provide the router configuration
        title: 'Usman',
        theme: ThemeData(
          primaryColor: const Color(0xFF0066CC),
          scaffoldBackgroundColor: const Color(0xFFF5F5F5),
          colorScheme: ColorScheme.fromSwatch()
              .copyWith(secondary: const Color(0xFFFFFFFF)),
          textTheme: const TextTheme(
            titleLarge: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFFFFFFFF),
            ),
            titleMedium: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Color(0xFF0066CC),
            ),
            bodyMedium: TextStyle(
              fontSize: 16,
              color: Colors.black,
              height: 1.5,
            ),
            bodyLarge: TextStyle(
              fontSize: 18,
              color: Color(0xFFFFFFFF),
            ),
            bodySmall: TextStyle(
              // Use bodySmall for one purpose
              fontSize: 16,
              color: Color(0xFFFFA500),
            ),
            labelLarge: TextStyle(
              // Use labelLarge for buttons
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            labelSmall: TextStyle(
              // Use labelSmall for error text
              fontSize: 14,
              color: Color(0xFFB00020),
              fontWeight: FontWeight.w400,
            ),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF0066CC),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
              textStyle: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ).copyWith(
              backgroundColor: WidgetStateProperty.resolveWith<Color>(
                (Set<WidgetState> states) {
                  if (states.contains(WidgetState.disabled)) {
                    return const Color(0xFFBDBDBD);
                  }
                  return const Color(0xFF0066CC);
                },
              ),
            ),
          ),
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.black,
          ),
        ),
        // No need for onGenerateRoute anymore, GoRouter handles routing
        // onGenerateRoute: (settings) { ... }
        // home: const UsersScreen(), // No need for home, initialRoute is in GoRouter
      ),
    );
  }
}

/*
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('Hello World!'),
        ),
      ),
    );
  }
}
*/
/*
import 'package:flutter/material.dart';
import 'router.dart'; // Import your router.dart file

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router( // Use MaterialApp.router
      routerConfig: router, // Provide the router configuration
      title: 'My App',
      theme: ThemeData( // Keep your theme for now, but you can remove it if needed for further simplification
        primaryColor: const Color(0xFF0066CC),
        scaffoldBackgroundColor: const Color(0xFFF5F5F5),
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: const Color(0xFFFFFFFF)),
        textTheme: const TextTheme(
          titleLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFFFFFFFF)),
          titleMedium: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Color(0xFF0066CC)),
          bodyMedium: TextStyle(fontSize: 16, color: Colors.black, height: 1.5),
          bodyLarge: TextStyle(fontSize: 18, color: Color(0xFFFFFFFF)),
          bodySmall: TextStyle(fontSize: 16, color: Color(0xFFFFA500)),
          labelLarge: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
          labelSmall: TextStyle(fontSize: 14, color: Color(0xFFB00020), fontWeight: FontWeight.w400),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF0066CC), foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20), textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),).copyWith(backgroundColor: WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {if (states.contains(WidgetState.disabled)) {return const Color(0xFFBDBDBD);}return const Color(0xFF0066CC);},),),),
        appBarTheme: const AppBarTheme(backgroundColor: Colors.blue, foregroundColor: Colors.black,),
      ),
    );
  }
}*/
/*
import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Import Provider
import 'package:mobilesoftware/core/providers/auth_provider.dart'; // Import AuthProvider
import 'router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider( // Re-introduce ChangeNotifierProvider
      create: (context) => AuthProvider(), // Create AuthProvider
      child: MaterialApp.router(
        routerConfig: router,
        title: 'My App',
        theme: ThemeData(
          primaryColor: const Color(0xFF0066CC),
          scaffoldBackgroundColor: const Color(0xFFF5F5F5),
          colorScheme: ColorScheme.fromSwatch().copyWith(secondary: const Color(0xFFFFFFFF)),
          textTheme: const TextTheme(
            titleLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFFFFFFFF)),
            titleMedium: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Color(0xFF0066CC)),
            bodyMedium: TextStyle(fontSize: 16, color: Colors.black, height: 1.5),
            bodyLarge: TextStyle(fontSize: 18, color: Color(0xFFFFFFFF)),
            bodySmall: TextStyle(fontSize: 16, color: Color(0xFFFFA500)),
            labelLarge: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
            labelSmall: TextStyle(fontSize: 14, color: Color(0xFFB00020), fontWeight: FontWeight.w400),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF0066CC), foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20), textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),).copyWith(backgroundColor: WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {if (states.contains(WidgetState.disabled)) {return const Color(0xFFBDBDBD);}return const Color(0xFF0066CC);},),),),
          appBarTheme: const AppBarTheme(backgroundColor: Colors.blue, foregroundColor: Colors.black,),
        ),
      ),
    );
  }
}*/
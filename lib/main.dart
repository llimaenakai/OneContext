import 'package:flutter/material.dart';
//import 'package:mobilesoftware/screens/add_user_screen.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/home_screen.dart';
import 'screens/error_screen.dart';
import 'helpers/database_helper.dart';
import 'package:mobilesoftware/screens/users_screen.dart';
import 'package:provider/provider.dart';
import 'package:mobilesoftware/core/providers/auth_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final dbHelper = DatabaseHelper();
  await dbHelper.database;
  await dbHelper.initializeDatabase();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AuthProvider(),
      child: MaterialApp(
        title: 'My App',
        theme: ThemeData(
          primaryColor: const Color(0xFF0066CC),
          scaffoldBackgroundColor: const Color(0xFFF5F5F5),
          colorScheme: ColorScheme.fromSwatch().copyWith(secondary: const Color(0xFFFFFFFF)),
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
            bodySmall: TextStyle( // Use bodySmall for one purpose
              fontSize: 16,
              color: Color(0xFFFFA500),
            ),
            labelLarge: TextStyle( // Use labelLarge for buttons
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            labelSmall: TextStyle( // Use labelSmall for error text
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
              backgroundColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                  if (states.contains(MaterialState.disabled)) {
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
        onGenerateRoute: (settings) {
          if (settings.name == '/login') {
            return MaterialPageRoute(builder: (context) => const LoginScreen());
          } else if (settings.name == '/signup') {
            return MaterialPageRoute(builder: (context) => const SignUpScreen());
          } else if (settings.name == '/home') {
            return MaterialPageRoute(builder: (context) => HomeScreen());
          }
          return MaterialPageRoute(builder: (context) => ErrorScreen());
        },
        home: const UsersScreen(),
      ),
    );
  }
}
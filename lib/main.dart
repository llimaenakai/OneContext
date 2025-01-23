import 'package:flutter/material.dart';
import 'package:mobilesoftware/screens/add_user_screen.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/home_screen.dart';
import 'screens/error_screen.dart';
import 'helpers/database_helper.dart';
import 'package:mobilesoftware/screens/users_screen.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final dbHelper = DatabaseHelper();
  await dbHelper.database; // Initialize DB
  await dbHelper.initializeDatabase();  //Added this to securely initialize user after table creation (as previously shown)!
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: (settings) {
        if (settings.name == '/login') {
          return MaterialPageRoute(builder: (context) => LoginScreen());
        } else if (settings.name == '/signup') {
          return MaterialPageRoute(builder: (context) => SignUpScreen());
        } else if (settings.name == '/home') {
          return MaterialPageRoute(builder: (context) => HomeScreen());
        }
        return MaterialPageRoute(builder: (context) => ErrorScreen());
      },
      home: UsersScreen(),
    );
  }
}
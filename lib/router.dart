import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobilesoftware/screens/add_user_screen.dart';
import 'package:mobilesoftware/screens/users_screen.dart';
import 'screens/home_screen.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/error_screen.dart';

final router = GoRouter(
  initialLocation: '/', // Set the initial location
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      name: 'login', // Add route names
      builder: (BuildContext context, GoRouterState state) => LoginScreen(), // Add const
    ),
    GoRoute(
      path: '/signup',
      name: 'signup', // Add route names
      builder: (BuildContext context, GoRouterState state) =>  SignUpScreen(), // Add const
    ),
    GoRoute(
      path: '/home',
      name: 'home', // Add route names
      builder: (BuildContext context, GoRouterState state) =>  HomeScreen(), // Add const
    ),
    GoRoute(
      path: '/users',
      name: 'users', // Add route names
      builder: (BuildContext context, GoRouterState state) => UsersScreen(), // Add const
    ),
    GoRoute(
      path: '/add-user',
      name: 'addUser', // Add route names
      builder: (BuildContext context, GoRouterState state) => AddUserScreen(), // Add const
    ),
    // ... Add other routes as needed
  ],
  errorBuilder: (context, state) => ErrorScreen(errorMessage: state.error.toString()), // Provide error message
);
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobilesoftware/screens/add_user_screen.dart';
import 'package:mobilesoftware/screens/error_screen.dart';
import 'package:mobilesoftware/screens/home_screen.dart';
import 'package:mobilesoftware/screens/login_screen.dart';
import 'package:mobilesoftware/screens/sell_item_screen.dart'; // Import SellItemScreen
import 'package:mobilesoftware/screens/signup_screen.dart';
import 'package:mobilesoftware/screens/users_screen.dart';

final router = GoRouter(
  initialLocation: '/login', // Set the initial location to login
  routes: <RouteBase>[
    GoRoute(
      path: '/login',
      name: 'login',
      builder: (BuildContext context, GoRouterState state) =>
          const LoginScreen(),
    ),
    GoRoute(
      path: '/signup',
      name: 'signup',
      builder: (BuildContext context, GoRouterState state) =>
          const SignUpScreen(),
    ),
    GoRoute(
      path: '/home',
      name: 'home',
      builder: (BuildContext context, GoRouterState state) =>
          const HomeScreen(),
    ),
    GoRoute(
      path: '/users',
      name: 'users',
      builder: (BuildContext context, GoRouterState state) =>
          const UsersScreen(),
    ),
    GoRoute(
      path: '/add-user',
      name: 'addUser',
      builder: (BuildContext context, GoRouterState state) =>
          const AddUserScreen(),
    ),
    GoRoute(
      path: '/sell-item', // Add route for SellItemScreen
      name: 'sellItem',
      builder: (BuildContext context, GoRouterState state) => SellItemScreen(),
    ),
    GoRoute(
      // Example route for error screen, though GoRouter has errorBuilder
      path: '/error',
      name: 'error',
      builder: (BuildContext context, GoRouterState state) => ErrorScreen(),
    ),
  ],
  errorBuilder: (context, state) => ErrorScreen(), // Default error screen
);
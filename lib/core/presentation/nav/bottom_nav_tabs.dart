import 'package:bookme/features/bookme/presentation/agents/screens/agents_screen.dart';
import 'package:bookme/features/bookme/presentation/bookings/screens/bookings_screen.dart';
import 'package:bookme/features/bookme/presentation/home/screens/home_screen.dart';
import 'package:bookme/features/bookme/presentation/user_profile/screens/user_profile_screen.dart';
import 'package:flutter/material.dart';

const List<Widget> navPages = <Widget>[
  HomeScreen(),
  AgentsScreen(),
  BookingsScreen(),
  UserProfileScreen(),
];

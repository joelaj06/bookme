import 'package:bookme/features/bookme/presentation/bookings/screens/bookings_screen.dart';
import 'package:bookme/features/bookme/presentation/home/screens/home_screen.dart';
import 'package:bookme/features/bookme/presentation/more/screens/more_screen.dart';
import 'package:bookme/features/bookme/presentation/services/screens/services_screen.dart';
import 'package:flutter/material.dart';

const List<Widget> navPages = <Widget>[
  HomeScreen(),
  ServicesScreen(),
  BookingsScreen(),
  MoreScreen()
];

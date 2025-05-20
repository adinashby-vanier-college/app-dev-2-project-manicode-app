import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'pages/landing_page.dart';
import 'pages/new_board_page.dart';
import 'pages/board_detail_page.dart';
import 'pages/profile_page.dart';
import 'pages/chat_page.dart';
import 'pages/contact_nailartist_page.dart';
import 'package:flutter_svg/flutter_svg.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ManiCode',
      theme: ThemeData(
        fontFamily: 'Roboto',
        scaffoldBackgroundColor: Color(0xFFFFF5EC),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const LandingPage(),
        '/new-board': (context) => const NewBoardPage(),
        '/board-detail': (context) => const BoardDetailPage(),
        '/profile': (context) => const ProfilePage(),
        '/chat': (context) => const ChatPage(),
        '/contact-nailartist': (context) => const ContactNailArtistPage(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
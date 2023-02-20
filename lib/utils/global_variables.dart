import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitworld_app/screens/dashboard_screen.dart';
import 'package:fitworld_app/screens/feed_screen.dart';
import 'package:fitworld_app/screens/profile_screen.dart';
import 'package:fitworld_app/screens/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:fitworld_app/screens/add_post_screen.dart';

const webScreenSize = 600;

List<Widget> homeScreenItems = [
  const FeedScreen(),
  const SearchScreen(),
  const AddPostScreen(),
  const Dashboard(),
  ProfileScreen(uid: FirebaseAuth.instance.currentUser!.uid),
];

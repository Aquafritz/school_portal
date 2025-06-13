// ignore_for_file: unused_import

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:balungao_nhs/firebase_options.dart';
import 'package:balungao_nhs/pages/views/sections/desktop/about_us.dart';
import 'package:balungao_nhs/pages/views/sections/desktop/about_us_content.dart';
import 'package:balungao_nhs/pages/views/sections/mobile/about_us_content_mobile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:balungao_nhs/launcher.dart';
import 'package:balungao_nhs/pages/admin_dashboard.dart';
import 'package:balungao_nhs/reports/enrollment_report/enrollment_report.dart';
import 'package:balungao_nhs/student_utils/student_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher_web/url_launcher_web.dart';
import 'dart:async'; // Required for runZonedGuarded
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  // Use runZonedGuarded at the top level
  runZonedGuarded(() async {
    // Ensure Flutter bindings are initialized in the same zone
    WidgetsFlutterBinding.ensureInitialized();

    await Supabase.initialize(
      url: 'https://txjuiwfelwllnaaqxvrr.supabase.co',
      anonKey:
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InR4anVpd2ZlbHdsbG5hYXF4dnJyIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDU3NDczODEsImV4cCI6MjA2MTMyMzM4MX0.08fi9SINbXX5NGpuSUuTCrVrolvdP_MdG4xYtYc7SoY',
    );

    // Perform async initialization tasks
    await SharedPreferences.getInstance();
    await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform, // This picks the right configuration
  );

    // Handle Flutter framework errors
    FlutterError.onError = (FlutterErrorDetails details) {
      FlutterError.dumpErrorToConsole(details);
    };

    // Run the app inside the same zone
    runApp(const MyApp());
  }, (error, stackTrace) {
    print('Caught error in zone: $error');
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Balungao NHS Portal',
      home: StreamBuilder<firebase_auth.User?>(
        stream: firebase_auth.FirebaseAuth.instance
            .authStateChanges(), // Update FirebaseAuth reference
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.hasData) {
              // User is signed in, fetch user data from Firestore
              return FutureBuilder<QuerySnapshot>(
                future: FirebaseFirestore.instance
                    .collection('users')
                    .where('uid',
                        isEqualTo: snapshot.data!.uid) // Query by uid field
                    .get(),
                builder: (context, userSnapshot) {
                  if (userSnapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: DefaultTextStyle(
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                        child: AnimatedTextKit(
                          animatedTexts: [
                            WavyAnimatedText('LOADING...'),
                          ],
                          isRepeatingAnimation: true,
                        ),
                      ),
                    );
                  }

                  if (userSnapshot.hasError) {
                    return Center(child: Text('Error fetching user data'));
                  }

                  if (userSnapshot.hasData &&
                      userSnapshot.data != null &&
                      userSnapshot.data!.docs.isNotEmpty) {
                    final userData = userSnapshot.data!.docs.first.data()
                        as Map<String, dynamic>;
                    final accountType = userData['accountType'];

                    // Navigate to the appropriate UI based on account type
                    if (accountType == 'admin') {
                      return AdminDashboard(); // Navigate to Admin Dashboard
                    } else if (accountType == 'instructor') {
                      return AdminDashboard(); // Navigate to Teacher UI
                    } else if (accountType == 'student') {
                      return StudentUI(); // Navigate to Student UI
                    } else {
                      return Center(child: Text('Unknown account type'));
                    }
                  }

                  return Center(child: Text('User  document does not exist.'));
                },
              );
            } else {
              // User is not signed in, navigate to the launcher
              return Launcher(
                scrollToFooter: false,
              );
              
              
            }
          }
          return Center(
            child: DefaultTextStyle(
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
              child: AnimatedTextKit(
                animatedTexts: [
                  WavyAnimatedText('LOADING...'),
                ],
                isRepeatingAnimation: true,
              ),
            ),
          );
        },
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:food_recommendation/botttomNavigation/bottomBar2.dart';
import 'package:food_recommendation/screens/LoginScreen/loginScreen.dart';

const supabaseUrl = 'https://wzbsfgadgvzmaorkcyfb.supabase.co';
const supabaseAnonKey =
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Ind6YnNmZ2FkZ3Z6bWFvcmtjeWZiIiwicm9sZSI6ImFub24iLCJpYXQiOjE3ODc3NzU1MDUsImV4cCI6MjEwMzM1MTUwNX0.YPrY0YYergSunUiriqb6ASzSnS2yxAFjiQ2kTQsM48U';

SupabaseClient get supabase => Supabase.instance.client;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Supabase.initialize(url: supabaseUrl, anonKey: supabaseAnonKey);
  runApp(MyApp());
}

String userid = "";

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'MunchMania',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Color(0xFF3EBACE),
          colorScheme: ThemeData().colorScheme.copyWith(
                secondary: Color(0xFFD8ECF1),
              ),
          scaffoldBackgroundColor: Color(0xFFF3F5F7),
        ),
        home: handleWindowDisplay());
  }
}

/// Recomputes `expiringIn` for every inventory item from its stored
/// `expiringOn` timestamp, and moves anything expired (or with a negative
/// quantity) into the app-generated todo list.
Future<void> updateExpiryOfInventory() async {
  QuerySnapshot qn = await FirebaseFirestore.instance
      .collection("users")
      .doc(userid)
      .collection("inventory")
      .get();

  for (final doc in qn.docs) {
    final data = doc.data() as Map<String, dynamic>;
    final DateTime dateTimeNow = DateTime.now();
    final DateTime dateTimeThen = (data['expiringOn'] as Timestamp).toDate();
    final String productName = data['productName'] as String;
    final String docId =
        productName[0].toUpperCase() + productName.substring(1);
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userid)
        .collection('inventory')
        .doc(docId)
        .update({
      'expiringIn': dateTimeThen.difference(dateTimeNow).inDays,
    });
  }

  int count = 0;
  for (final doc in qn.docs) {
    final data = doc.data() as Map<String, dynamic>;
    final int expiringIn = data['expiringIn'] as int? ?? 0;
    final int quantity = data['quantity'] as int? ?? 0;
    if (expiringIn < 0 || quantity < 0) {
      final String productName = data['productName'] as String;
      final String docId =
          productName[0].toUpperCase() + productName.substring(1);
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userid)
          .collection("toDoList")
          .doc("sections")
          .collection("appToUserTodo")
          .doc(docId)
          .set({
        'productName': productName,
        'quantity': 0,
        'unit': data['unit'],
        'check': false,
      });
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userid)
          .collection('inventory')
          .doc(docId)
          .delete();
      count++;
    }
  }

  if (count > 0) {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(userid)
        .collection("PersonalDetails")
        .doc("Details")
        .update({"countOfItems": FieldValue.increment(-count)});
  }
}

/// Creates the caller's `profiles` row if it doesn't exist yet. Signing up
/// writes this eagerly, but when Supabase email confirmation is enabled the
/// signup response has no active session yet (RLS blocks that insert), so
/// this is the fallback that fires the moment a real session exists.
Future<void> ensureProfileExists(User user) async {
  final existing = await supabase
      .from('profiles')
      .select('id')
      .eq('id', user.id)
      .maybeSingle();
  if (existing != null) return;

  await supabase.from('profiles').upsert({
    'id': user.id,
    'display_name': user.userMetadata?['full_name'] ?? user.email ?? '',
    'email': user.email ?? '',
    'image_url': user.userMetadata?['avatar_url'] ?? '',
  });
}

Widget handleWindowDisplay() {
  return StreamBuilder<AuthState>(
    stream: supabase.auth.onAuthStateChange,
    initialData: AuthState(AuthChangeEvent.initialSession, supabase.auth.currentSession),
    builder: (BuildContext context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Scaffold(
            backgroundColor: Colors.white,
            body: Center(
                child: SpinKitWave(
                    color: Colors.amber.shade300, type: SpinKitWaveType.start)));
      } else {
        final user = snapshot.data?.session?.user;
        if (user != null) {
          userid = user.id;
          ensureProfileExists(user);
          updateExpiryOfInventory();
          return bottomBar2();
        } else {
          return LoginPage();
        }
      }
    },
  );
}

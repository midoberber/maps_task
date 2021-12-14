import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mtms_task/modules/destination_model.dart';
import 'package:mtms_task/pages/home_page.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DestinationModel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'MTMs Task',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomePage(),
      ),
    );
  }
}

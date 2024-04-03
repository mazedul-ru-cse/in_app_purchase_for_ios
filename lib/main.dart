import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:in_app_purchase_android/in_app_purchase_android.dart';
import 'home_widget.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  if(defaultTargetPlatform == TargetPlatform.android){
    InAppPurchaseAndroidPlatformAddition.enablePendingPurchases();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeWidget(),
    );
  }
}

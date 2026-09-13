import 'package:flutter/material.dart';
import 'features/welcome/screens/welcome_screen.dart';
import 'core/config/supabapase_config.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
void main()  async{
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: SupabaseConfig.supabaseUrl,
    publishableKey: SupabaseConfig.supabaseAnonKey,
    );
    
  runApp(const DrawEasyApp());
}

class DrawEasyApp extends StatelessWidget {
  const DrawEasyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Draw Easy',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: const Color(0xFFE8673A),
        useMaterial3: true,
        fontFamily: 'CauCuPeOne',
      ),
      home: const WelcomeScreen(),
    );
  }
}

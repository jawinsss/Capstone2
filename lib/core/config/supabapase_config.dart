import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseConfig {
  static const String supabaseUrl = 'https://tyhvkhrrtsgtqwyquoau.supabase.co';
  static const String supabaseAnonKey = 'sb_publishable_TyefIuF8zKryZkyBsBMxtA_YZa417DW';

  static Future<void> initializeSupabase() async {
    await Supabase.initialize(
      url: supabaseUrl,
      publishableKey: supabaseAnonKey,
    );
  }
}
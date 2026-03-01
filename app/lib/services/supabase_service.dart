import 'package:cricstatz/config/supabase_config.dart';

class SupabaseService {
  bool get isConfigured =>
      SupabaseConfig.url.isNotEmpty && SupabaseConfig.anonKey.isNotEmpty;

  Future<void> initialize() async {
    // Placeholder: call Supabase.initialize(...) once auth/data layer is wired.
  }
}

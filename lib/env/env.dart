// lib/env/env.dart
import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env')
abstract class Env {
    @EnviedField(varName: 'SUPABASE_URL',defaultValue: '',obfuscate: true)
    static final String supabaseUrl = _Env.supabaseUrl;
    @EnviedField(varName: 'SUPABASE_ANON_KEY',defaultValue: '',obfuscate: true)
    static final String supabase_anon = _Env.supabase_anon;
}
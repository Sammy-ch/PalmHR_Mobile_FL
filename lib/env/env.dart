// lib/env/env.dart
import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env')
abstract class Env {
    @EnviedField(varName: 'SUPABASE_URL',defaultValue: '',obfuscate: true)
    static final String supabaseUrl = _Env.supabaseUrl;
    @EnviedField(varName: 'SUPABASE_ANON_KEY',defaultValue: '',obfuscate: true)
    static final String supabase_anon = _Env.supabase_anon;
    @EnviedField(varName: 'KINDE_AUTH_DOMAIN',defaultValue: '',obfuscate: true)
    static final String kindeAuthDomain = _Env.kindeAuthDomain;
    @EnviedField(varName: 'KINDE_AUTH_CLIENT_ID',defaultValue: '',obfuscate: true)
    static final String kindeAuthClientId = _Env.kindeAuthClientId;
    @EnviedField(varName: 'KINDE_LOGIN_REDIRECT_URI',defaultValue: '',obfuscate: true)
    static final String kindeLoginRedirectUri = _Env.kindeLoginRedirectUri;
    @EnviedField(varName: 'KINDE_LOGOUT_REDIRECT_URI',defaultValue: '',obfuscate: true)
    static final String kindeLogoutRedirectUri = _Env.kindeLogoutRedirectUri;
    @EnviedField(varName: 'KINDE_AUDIENCE',defaultValue: '',obfuscate: true)
    static final String kindeAudience = _Env.kindeAudience;
}
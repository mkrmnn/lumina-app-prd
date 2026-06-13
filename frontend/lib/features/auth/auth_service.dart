import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  // Backend'imizin adresi (Dün çalıştırdığımız Python sunucusu)
  final String baseUrl = 'http://127.0.0.1:8000/api/v1/auth';

  // 1. KAYIT OLMA (REGISTER) İŞLEMİ
  Future<bool> register(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/register'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      if (response.statusCode == 200) {
        return true; // Kayıt başarılı oldu
      }
      return false; // Bir hata çıktı (Örn: E-mail zaten var)
    } catch (e) {
      return false;
    }
  }

  // 2. GİRİŞ YAPMA (LOGIN) İŞLEMİ
  Future<bool> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      if (response.statusCode == 200) {
        // Giriş başarılı! Sunucudan gelen "bilet"i (token) alıyoruz.
        final data = jsonDecode(response.body);
        final String token = data['access_token'];

        // Bu bileti telefonun hafızasına gizlice kaydediyoruz.
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);

        return true; 
      }
      return false; // Şifre veya mail yanlış
    } catch (e) {
      return false;
    }
  }
}
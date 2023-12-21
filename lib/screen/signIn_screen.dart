// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:jelajah_kampus/screen/signUp_screen.dart';
// import 'package:encrypt/encrypt.dart' as encrypt;
//
// class SignInScreen extends StatefulWidget {
//   SignInScreen({Key? key}) : super(key: key);
//
// //   @override
// //   State<SignInScreen> createState() => _SignInScreenState();
// // }
//   @override
//   _SignInScreenState createState() => _SignInScreenState();
// }
//
// class _SignInScreenState extends State<SignInScreen> {
//   // TODO : 1. Deklarasi Variabel
//   final TextEditingController _usernameController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//
//   String _errorText = '';
//   bool _isSignedIn = false;
//   bool _obscurePassword = true;
//
//   // encrpyt
//   final key = encrypt.Key.fromUtf8('my32lengthsupersecretnooneknows');
//   final iv = encrypt.IV.fromLength(16);
//
//   void signIn() async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//
//     final String savedUsername = prefs.getString('username') ?? '';
//     final String encryptedSavedPassword = prefs.getString('password') ?? '';
//
//     // untuk menampilkan nama pengguna dan kata sandi
//     print('Username tersimpan: $savedUsername');
//     print('Password tersimpan: $encryptedSavedPassword');
//
//     final String enteredUsername = _usernameController.text.trim();
//     final String enteredPassword = _passwordController.text.trim();
//
//     if (enteredUsername.isEmpty || enteredPassword.isEmpty) {
//       setState(() {
//         _errorText = 'Nama Pengguna dan kata sandi harus diisi.';
//       });
//       return;
//     }
//
//     if (savedUsername.isEmpty || encryptedSavedPassword.isEmpty) {
//       setState(() {
//         _errorText = 'Pengguna belum terdaftar. Silahkan daftar terlebih dahulu.';
//       });
//       return;
//     }
//
//     final encrypter = encrypt.Encrypter(encrypt.AES(key));
//
//     // Mendekripsi kata sandi yang disimpan sebelum membandingkan
//     final decryptedSavedPassword =
//       encrypter.decrypt64(encryptedSavedPassword, iv: iv);
//
//     if (enteredUsername == savedUsername && enteredPassword == decryptedSavedPassword) {
//       setState(() {
//         _errorText = '';
//       });
//
//       // Navigasi ke ProfilScreen setelah login berhasil
//       Navigator.pushReplacementNamed(context, '/profil');
//     } else {
//       setState(() {
//         _errorText = 'Nama pengguna atau kata sandi salah.';
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return  Scaffold(
//       // TODO : 2. Pasang Appbar
//       appBar: AppBar(title: Text('Sign In'),),
//       // TODO : 3. Pasang body
//       body: Center(
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.all(16),
//             child: Column(
//               // TODO : 4. Atur mainAxisAligment dan CrossAxisAligment
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 // TODO : 5. Pasang TextFormField Nama Pengguna
//                 TextFormField(
//                   controller: _usernameController,
//                   decoration: InputDecoration(
//                     labelText: "Nama Pengguna",
//                     border: OutlineInputBorder(),
//                   ),
//                 ),
//                 // TODO : 6. Pasang TextFormField Kata Sandi
//                 SizedBox(height: 20),
//                 TextFormField(
//                   controller: _passwordController,
//                   decoration: InputDecoration(
//                     labelText: "Kata Sandi",
//                     errorText: _errorText.isNotEmpty ? _errorText : null,
//                     border: OutlineInputBorder(),
//                     suffixIcon: IconButton(
//                       onPressed: (){
//                         setState((){
//                           _obscurePassword = !_obscurePassword;
//                         });
//                       },
//                       icon: Icon(
//                         _obscurePassword ? Icons.visibility_off
//                             : Icons.visibility,
//                       ),
//                     ),
//                   ),
//                   obscureText: _obscurePassword,
//                 ),
//                 // TODO : 7. Pasang ElevatedButton Sign In
//                 SizedBox(height: 20),
//                 ElevatedButton(
//                     onPressed: (){
//                       setState(() {
//                       });
//                       Navigator.pop(context);
//                     },
//                     child: Text('Sign In')),
//                 // TODO : 8. Pasang TextButton Sign Up
//                 SizedBox(height: 10),
//                 RichText(
//                     text: TextSpan(
//                         text: 'Belum punya akun?',
//                         style: TextStyle(fontSize: 16, color: Colors.blueAccent),
//                         children: <TextSpan>[
//                           TextSpan(
//                             text: 'Daftar di sini.',
//                             style: TextStyle(
//                                 color: Colors.blue,
//                                 decoration: TextDecoration.underline,
//                                 fontSize: 16
//                             ),
//                             recognizer: TapGestureRecognizer()
//                               ..onTap = () {
//                                 Navigator.pushNamed(context, '/signup');
//                               },
//                           )
//                         ]
//                     ))
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jelajah_kampus/screen/signUp_screen.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:jelajah_kampus/screen/profile_screen.dart';

class SignInScreen extends StatefulWidget {
  SignInScreen({Key? key}) : super(key: key); // Perbaikan di sini

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String _errorText = '';
  bool _isSignedIn = false;
  bool _obscurePassword = true;

  Future<Map<String, String>> _retrieveAndDecryptDataFromPrefs() async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final String encryptedUsername = sharedPreferences.getString('username') ?? '';
    final String encryptedPassword = sharedPreferences.getString('password') ?? '';
    final String keyString = sharedPreferences.getString('key') ?? '';
    final String ivString = sharedPreferences.getString('iv') ?? '';

    final encrypt.Key key = encrypt.Key.fromBase64(keyString);
    final encrypt.IV iv = encrypt.IV.fromBase64(ivString);

    final encrypter = encrypt.Encrypter(encrypt.AES(key));

    final decryptedUsername = encrypter.decrypt64(encryptedUsername, iv: iv);
    final decryptedPassword = encrypter.decrypt64(encryptedPassword, iv: iv);

    print('decryptedUsername: $decryptedUsername');
    print('decryptedPassword: $decryptedPassword');

    return {'username': decryptedUsername, 'password': decryptedPassword};
  }



  void signIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    Map<String, String> decryptedData = await _retrieveAndDecryptDataFromPrefs();

    String savedUsername = decryptedData['username'] ?? '';
    String savedPassword = decryptedData['password'] ?? '';
    String enteredUsername = _usernameController.text.trim();
    String enteredPassword = _passwordController.text.trim();

    if (enteredUsername == savedUsername && enteredPassword == savedPassword) {
      setState(() {
        _errorText = '';
        _isSignedIn = true;
        prefs.setBool('isSignedIn', true);
      });

      WidgetsBinding.instance!.addPostFrameCallback((_) {
        Navigator.of(context).popUntil((route) => route.isFirst);
      });
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        Navigator.pushReplacementNamed(context, '/');
      });
    } else {
      setState(() {
        _errorText = 'Nama pengguna atau kata sandi salah.';
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign In'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextFormField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    labelText: "Nama Pengguna",
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: "Kata Sandi",
                    errorText: _errorText.isNotEmpty ? _errorText : null,
                    border: OutlineInputBorder(),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                    ),
                  ),
                  obscureText: _obscurePassword,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: signIn, // Perbaikan di sini
                  child: Text('Sign In'),
                ),
                SizedBox(height: 10),
                RichText(
                    text: TextSpan(
                      text: 'Belum punya akun?',
                      style: TextStyle(fontSize: 16, color: Colors.blueGrey),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Daftar di sini.',
                          style: TextStyle(
                            color: Colors.grey,
                            decoration: TextDecoration.underline,
                            fontSize: 16,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pushNamed(context, '/signup');
                            },
                        )
                      ],
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
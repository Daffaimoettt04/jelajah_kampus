import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:final_jelajah_kampus/screen/signIn_screen.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isSignedIn = false;
  String fullName = '';
  String userName = '';
  int favoriteKampusCount = 0;

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();

    final XFile? image = await _picker.pickImage(
      source: ImageSource.camera,
    );

    if (image != null) {
    }
  }

  @override
  void initState() {
    super.initState();
    retrieveUserData();
  }

  void retrieveUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    bool signedIn = prefs.getBool('isSignedIn') ?? false;

    setState(() {
      isSignedIn = signedIn;
    });

    if (signedIn) {
      String encryptedFullName = prefs.getString('fullname') ?? '';
      String encryptedUserName = prefs.getString('username') ?? '';

      String keyString = prefs.getString('key') ?? '';
      String ivString = prefs.getString('iv') ?? '';

      encrypt.Key key = encrypt.Key.fromBase64(keyString);
      encrypt.IV iv = encrypt.IV.fromBase64(ivString);

      encrypt.Encrypter encrypter = encrypt.Encrypter(encrypt.AES(key));

      String decryptedFullName = encrypter.decrypt64(encryptedFullName, iv: iv);
      String decryptedUserName = encrypter.decrypt64(encryptedUserName, iv: iv);

      setState(() {
        fullName = decryptedFullName;
        userName = decryptedUserName;
      });

      List<String>? favoriteKampus =
          prefs.getStringList('favoriteKampus') ?? [];

      setState(() {
        favoriteKampusCount = favoriteKampus.length;
      });
    }
  }

  void signIn() async {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SignInScreen()),
    );
  }

  void signOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    setState(() {
      isSignedIn = false;
      fullName = '';
      userName = '';
      favoriteKampusCount = 0;
    });
  }

  // TODO: 7. Implementasi fungsi addFavorite
  void addFavorite() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String>? favoriteKampusNames = prefs.getStringList('favoriteKampus') ?? [];
    String newFavoriteKampusName = 'Kampus Baru'; //
    favoriteKampusNames.add(newFavoriteKampusName);

    prefs.setStringList('favoriteKampus', favoriteKampusNames);

    setState(() {
      favoriteKampusCount = favoriteKampusNames.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: 200,
            width: double.infinity,
            color: Colors.blueAccent,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 200 - 50),
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 2),
                            shape: BoxShape.circle,
                          ),
                          child: const CircleAvatar(
                            radius: 50,
                            backgroundImage: AssetImage('Images/placeholder_image.png'),
                          ),
                        ),
                        if (isSignedIn)
                          IconButton(
                            onPressed: _pickImage,
                            icon: Icon(Icons.camera_alt, color: Colors.blueAccent[50]),
                          ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Divider(color: Colors.blueAccent),
                const SizedBox(height: 4),
                Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 3,
                      child: const Row(
                        children: [
                          Icon(Icons.lock, color: Colors.orange),
                          SizedBox(width: 8),
                          Text(
                            'Pengguna',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Text(
                        ': $userName',
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Divider(color: Colors.blueAccent),
                const SizedBox(height: 4),
                Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 3,
                      child: const Row(
                        children: [
                          Icon(Icons.person, color: Colors.blueAccent),
                          SizedBox(width: 8),
                          Text(
                            'Nama',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Text(
                        ': $fullName',
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                    if (isSignedIn) const Icon(Icons.edit),
                  ],
                ),
                const SizedBox(height: 4),
                Divider(color: Colors.blueAccent),
                const SizedBox(height: 4),
                Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 3,
                      child: const Row(
                        children: [
                          Icon(Icons.favorite, color: Colors.red),
                          SizedBox(width: 8),
                          Text(
                            'Favorit',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Text(
                        ': $favoriteKampusCount',
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                    if (isSignedIn) IconButton(
                      onPressed: () {
                        setState(() {
                          favoriteKampusCount++;
                        });
                        addFavorite();
                      },
                      icon: const Icon(Icons.favorite_border),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Divider(color: Colors.blueAccent),
                const SizedBox(height: 20),
                isSignedIn
                    ? TextButton(
                  onPressed: signOut,
                  child: const Text('Sign Out'),
                )
                    : TextButton(
                  onPressed: signIn,
                  child: const Text('Sign In'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
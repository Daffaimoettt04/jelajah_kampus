import 'package:flutter/material.dart';
import 'package:final_jelajah_kampus/data/kampus_data.dart';
import 'package:final_jelajah_kampus/screen/detail_screen.dart';
import 'package:final_jelajah_kampus/screen/signIn_screen.dart';
import 'package:final_jelajah_kampus/screen/signUp_screen.dart';
import 'package:final_jelajah_kampus/screen/home_screen.dart';
import 'package:final_jelajah_kampus/screen/search_screen.dart';
import 'package:final_jelajah_kampus/screen/profile_screen.dart';
import 'package:final_jelajah_kampus/screen/favorite_screen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/' : (context) => MainScreen(),
        // '/signin' : (context) => SignInScreen(),
        // '/signup' : (context) => SignUpScreen(),
        // '/profil': (context) => ProfileScreen(),
      },
      debugShowCheckedModeBanner: false,
      title: 'Jelajah Kampus Palembang',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(color: Colors.blueAccent),
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue)
            .copyWith(secondary: Colors.deepPurple[50]),
        // useMaterial3: true, // Remove this line if not required
      ),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  // TODO : 1. Deklerasikan variabel
  int _currentIndex = 0;
  final List<Widget> _children = [
    HomeScreen(),
    // SearchScreen(),
    // FavoriteScreen(),
    // ProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // TODO : 2. Buat Properti body berupa widget yang ditampilkan
      body: _children[_currentIndex],
      // TODO : 3. Buat properti bottomNavigationBar dengan nilai theme
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
            canvasColor: Colors.blueAccent[50]
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index){
            setState(() {
              _currentIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home, color: Colors.blueAccent,),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search, color: Colors.blueAccent,),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite, color: Colors.blueAccent,),
              label: 'Favorite',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person, color: Colors.blueAccent,),
              label: 'Profile',
            ),
          ],

          selectedItemColor: Colors.blueAccent,
          unselectedItemColor: Colors.blueAccent[100],
          showSelectedLabels: true,
          showUnselectedLabels: true,
        ),
      ),
      // TODO : 4. Buat data dan child dari theme
    );

  }
}

// class ScreenArguments {
//   final String title;
//   final String message;
//
//   ScreenArguments(this.title, this.message);
// }

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:final_jelajah_kampus/model/kampus.dart';
import 'package:final_jelajah_kampus/screen/detail_screen.dart';
import 'package:final_jelajah_kampus/data/kampus_data.dart';
import 'package:final_jelajah_kampus/screen/detail_screen.dart';

class FavoriteScreen extends StatefulWidget {
  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  List<Kampus> favoriteKampus = [];

  @override
  void initState() {
    super.initState();
    getFavoriteKampus();
  }

  Future<void> getFavoriteKampus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> favoriteNames = [];
    prefs.getKeys().forEach((key) {
      if (key.contains('favorite_') && prefs.getBool(key) == true) {
        favoriteNames.add(key.replaceAll('favorite_', ''));
      }
    });

    List<Kampus> favorites = kampusList
        .where((kampus) => favoriteNames.contains(kampus.name))
        .toList();

    setState(() {
      favoriteKampus = favorites;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Favorite Kampus')),
      body: favoriteKampus.isEmpty
          ? Center(
        child: Text('Belum ada kampus yang ditandai sebagai favorit.'),
      )
          : ListView.builder(
        itemCount: favoriteKampus.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(favoriteKampus[index].name),
              subtitle: Text(favoriteKampus[index].location),
              leading: Image.asset(
                favoriteKampus[index].imageAsset,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
              onTap: () {
                if (index < favoriteKampus.length) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailScreen(kampus: favoriteKampus[index]),
                    ),
                  );
                }
              },

            ),
          );
        },
      ),
    );
  }
}
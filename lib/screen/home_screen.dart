import 'package:flutter/material.dart';
import 'package:final_jelajah_kampus/model/kampus.dart';
import 'package:final_jelajah_kampus/data/kampus_data.dart';
import 'package:final_jelajah_kampus/widget/item_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Jelajah Kampus'),
        ),
        body: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          padding: EdgeInsets.all(8.0),
          itemCount: kampusList.length,
          itemBuilder: (context, index) {
            // Deklarasikan variabel candi di dalam builder
            Kampus kampus = kampusList[index];
            return ItemCard(kampus: kampus);
          },)
    );
  }
}

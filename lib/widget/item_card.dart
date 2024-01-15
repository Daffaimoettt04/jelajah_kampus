import 'package:flutter/material.dart';
import 'package:final_jelajah_kampus/model/kampus.dart';
import 'package:final_jelajah_kampus/screen/detail_screen.dart';


class ItemCard extends StatelessWidget {
  final Kampus kampus;


  ItemCard({Key? key, required this.kampus}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailScreen(kampus: kampus),
          ),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        margin: EdgeInsets.all(4),
        elevation: 1,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(
                  kampus.imageAsset,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 16,
                top: 8,
              ),
              child: Text(
                kampus.name,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 16,
                bottom: 8,
              ),
              child: Text(
                kampus.type,
                style: TextStyle(
                  fontSize: 12,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}



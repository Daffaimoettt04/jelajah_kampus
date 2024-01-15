import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:final_jelajah_kampus/model/kampus.dart';

class  DetailScreen extends StatefulWidget {
  final Kampus kampus;

  DetailScreen ({super.key, required this.kampus});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  bool isFavorite = false;
  bool isSignedIn = false;

  Future<void> _toggleFavorite() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // memeriksa apakah pengguna sudah sign in
    // if (!isSignedIn) {
    //   // jika belum sign in, arahkan ke halaman sign in
    //   WidgetsBinding.instance.addPostFrameCallback((_) {
    //     Navigator.pushReplacementNamed(context, '/signin');
    //   });
    //   return;
    // }
    bool favoriteStatus = !isFavorite;
    prefs.setBool('favorite_${widget.kampus.name}', favoriteStatus);

    setState(() {
      isFavorite = favoriteStatus;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            //detailheader
            Stack(
              children:[
                //image utama
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal :16),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset('${widget.kampus.imageAsset}',
                      width: double.infinity,
                      height: 200,
                      fit: BoxFit.cover,),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 32,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.blueAccent[100]?.withOpacity(0.8),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                        onPressed: (){
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.arrow_back,
                        )

                    ),
                  ),

                ),


              ],
            ),
            //detailinfo
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 16,),
                  //info atas
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.kampus.name,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        onPressed: (){
                          _toggleFavorite();
                        },
                        // icon: Icon(isSignedIn && isFavorite
                        //     ? Icons.favorite
                        //     :Icons.favorite_border,
                        //   color: isSignedIn && isFavorite ? Colors.red : null,),
                        icon: Icon(isFavorite
                            ? Icons.favorite
                            :Icons.favorite_border,
                          color:isFavorite ? Colors.red : null,),
                      ),
                    ],
                  ),
                  //info tegah
                  SizedBox(height: 16,),
                  Row(children: [
                    Icon(Icons.place, color: Colors.red,),
                    SizedBox(width: 8,),
                    SizedBox(width: 70,
                      child: Text('Lokasi', style: TextStyle(
                          fontWeight: FontWeight.bold),),),
                    Text(': ${widget.kampus.location}',),
                  ],),
                  Row(children: [
                    Icon(Icons.calendar_month, color: Colors.blue,),
                    SizedBox(width: 8,),
                    SizedBox(width: 70,
                      child: Text('Dibangun', style: TextStyle(
                          fontWeight: FontWeight.bold),),),
                    Text(': ${widget.kampus.built}'),
                  ],),
                  Row(children: [
                    Icon(Icons.house, color: Colors.green,),
                    SizedBox(width: 8,),
                    SizedBox(width: 70,
                      child: Text('Tipe', style: TextStyle(
                        fontWeight: FontWeight.bold,),),),
                    Text(': ${widget.kampus.type}'),
                  ],),
                  Row(children: [
                    Icon(Icons.access_time,),
                    SizedBox(width: 8,),
                    SizedBox(width: 70,
                      child: Text('Buka', style: TextStyle(
                        fontWeight: FontWeight.bold,),),),
                    Text(': ${widget.kampus.buka}'),
                  ],),
                  SizedBox(height: 16,),
                  Divider(color: Colors.blueAccent.shade100,),
                  SizedBox(height: 16,),
                  //info bawah
                  SizedBox(height: 16,),
                  Row(
                    children: [
                      Text(
                        'Deskripsi', style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16,),
                  Container(
                    height: 100,
                    child: Text('${widget.kampus.description}',
                      style: TextStyle(
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ],
              ),
            ),
            //detail gallery
            Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Divider(color: Colors.blueAccent.shade100,),
                  Text('Galeri', style: TextStyle(
                    fontSize: 16, fontWeight: FontWeight.bold,
                  ),),
                  SizedBox(height: 10,),
                  SizedBox(
                    height: 100,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: widget.kampus.imageUrls.length,
                      itemBuilder: (context, index){
                        return Padding
                          (padding: EdgeInsets.only(right: 8),
                          child: GestureDetector(
                            onTap: () {},
                            child: Container(
                              decoration: BoxDecoration(),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: CachedNetworkImage(
                                  imageUrl: widget.kampus.imageUrls[index],
                                  width: 120,
                                  height: 120,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) => Container(
                                    width: 120,
                                    height: 120,
                                    color: Colors.deepPurple[50],
                                  ),
                                  errorWidget: (context, url, error) => Icon(Icons.error),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 4,),
                  Text('Tap untuk memperbesar', style: TextStyle(
                    fontSize: 12, color: Colors.black54,
                  ),),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
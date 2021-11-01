import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modul3_kel19/screen/kelompok.dart';

class TopAiring extends StatelessWidget {
  const TopAiring({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => KelompokPage()));
      },
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        child: Container(
          color: Colors.grey[100],
          width: 150,
          height: 200,
          margin: EdgeInsets.only(right: 3),
          padding: EdgeInsets.all(5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Image.network(
                    'https://cdn.myanimelist.net/images/anime/1223/96541.jpg?s=faffcb677a5eacd17bf761edd78bfb3f',
                    width: 150,
                    height: 160,
                    fit: BoxFit.cover,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(2),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        width: 60,
                        height: 30,
                        decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.4),
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(30),
                                bottomLeft: Radius.circular(30),
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/icon_star.png',
                              width: 20,
                              height: 20,
                            ),
                            Text('8.26',
                                style: GoogleFonts.poppins(
                                    fontSize: 10, color: Colors.white))
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Center(
                child: Text(
                  'ALOHA',
                  style: GoogleFonts.poppins(fontSize: 13),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

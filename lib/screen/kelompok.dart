import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class KelompokPage extends StatefulWidget {
  const KelompokPage({Key? key}) : super(key: key);

  @override
  _KelompokPageState createState() => _KelompokPageState();
}

class _KelompokPageState extends State<KelompokPage> {
  @override
  

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kelompok 19'),
        backgroundColor: Color(0xff063970),
      ),
      backgroundColor: Colors.red[50],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 200),
                  child: CircleAvatar(
                    radius: 80,
                    backgroundImage: AssetImage('assets/pngwing.com.png'),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Kelompok 19',
                style: GoogleFonts.poppins(
                    fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color: Colors.red[100],
                    borderRadius: const BorderRadius.all(Radius.circular(10))),
                child: Text(
                  'Fiki Rilo Pambudi=>21120119120001\nHelmy Zakiudin=>21120119130040\nM Dzulfiqar Rafli Anwar=>21120119130065\nAkmal Irfan Maulana=>21120119130109',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

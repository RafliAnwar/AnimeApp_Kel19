import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class DetailFirst extends StatefulWidget {
  final int item;
  final String title;
  const DetailFirst({Key? key, required this.item, required this.title});

  @override
  _DetailFirstState createState() => _DetailFirstState();
}

class _DetailFirstState extends State<DetailFirst> {
  late Future<ShowDetail> topAiring;

  @override
  void initState() {
    super.initState();
    topAiring = fetchShowDetail(widget.item);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Color(0xff063970),
      ),
      body: ListView(
        children: [
          FutureBuilder<ShowDetail>(
            future: topAiring,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  children: [
                    Center(
                      child: Container(
                        child: Image.network(
                          snapshot.data!.imageUrl,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          bottom: 10, left: 20, right: 20, top: 2),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.title,
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Score: ${snapshot.data!.score}',
                            style: GoogleFonts.poppins(color: Colors.grey[600]),
                          ),
                          Text(
                            'Broadcast : ${snapshot.data!.broadcast}',
                            style: GoogleFonts.poppins(color: Colors.grey[600]),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            '${snapshot.data!.synopsis}',
                            textAlign: TextAlign.justify,
                          )
                        ],
                      ),
                    ),
                  ],
                );
              } else if (snapshot.hasError) {
                return const Center(child: Text('Something went wrong :('));
              }
              return Column(
                children: [
                  Center(child: const CircularProgressIndicator()),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class ShowDetail {
  final String title;
  final String imageUrl;
  final String synopsis;
  final String broadcast;
  final num score;

  ShowDetail({
    required this.title,
    required this.imageUrl,
    required this.score,
    required this.synopsis,
    required this.broadcast,
  });
  factory ShowDetail.fromJson(Map<String, dynamic> json) {
    return ShowDetail(
      title: json['title'],
      imageUrl: json['image_url'],
      score: json['score'],
      synopsis: json['synopsis'],
      broadcast: json['broadcast'],
    );
  }
}

Future<ShowDetail> fetchShowDetail(id) async {
  final response =
      await http.get(Uri.parse('https://api.jikan.moe/v3/anime/$id'));
  if (response.statusCode == 200) {
    return ShowDetail.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load shows');
  }
}

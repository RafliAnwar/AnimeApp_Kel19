import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modul3_kel19/screen/detail.dart';
import 'package:http/http.dart' as http;
import 'package:modul3_kel19/screen/detailFirst.dart';
import 'dart:convert';

//import 'package:modul3_kel19/widgets/topAiring.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Show>> shows;
  late Future<List<ShowFirst>> showsFirst;

  @override
  void initState() {
    super.initState();
    shows = fetchShows();
    showsFirst = fetchShowFirst();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // shape: RoundedRectangleBorder(
        //     borderRadius: BorderRadius.all(Radius.circular(30))),
        title: const Text('MyAnimeList'),
        backgroundColor: Color(0xff063970),
      ),
      body: Column(
        children: <Widget>[
          Text(
            'Top Airing',
            style:
                GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          /////////////////////////////////////////////////////////////////FIRST LISTVIEW
          FutureBuilder(
              future: showsFirst,
              builder: (context, AsyncSnapshot<List<ShowFirst>> snapshot) {
                if (snapshot.hasData) {
                  return Container(
                    height: 200,
                    child: ListView.builder(
                      itemCount: snapshot.data!.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          //TopAiring //Navigasi
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailFirst(
                                    item: snapshot.data![index].malId,
                                    title: snapshot.data![index].title),
                              ),
                            );
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            child: Container(
                              color: Colors.brown[50],
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
                                        snapshot.data![index].imageUrl,
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
                                                color: Colors.black
                                                    .withOpacity(0.4),
                                                borderRadius: BorderRadius.only(
                                                    bottomRight:
                                                        Radius.circular(30),
                                                    bottomLeft:
                                                        Radius.circular(30),
                                                    topLeft:
                                                        Radius.circular(30),
                                                    topRight:
                                                        Radius.circular(30))),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Image.asset(
                                                  'assets/star.png',
                                                  width: 15,
                                                  height: 13,
                                                ),
                                                Text(
                                                    '${snapshot.data![index].score}',
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 10,
                                                        color: Colors.white))
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
                                      snapshot.data![index].title,
                                      style: GoogleFonts.poppins(
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      // children: [
                      //   TopAiring(),
                      // ],
                    ),
                  );
                } else if (snapshot.hasError) {
                  return const Center(child: Text('Something went wrong :('));
                }
                return const CircularProgressIndicator();
              }),

          Text(
            'Top Anime of All Time',
            style:
                GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          //////////////////////////////////////////////////////////SECOND LISTVIEW
          FutureBuilder(
            future: shows,
            builder: (context, AsyncSnapshot<List<Show>> snapshot) {
              if (snapshot.hasData) {
                return Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        color: Colors.grey[100],
                        child: ListTile(
                          leading: CircleAvatar(
                            radius: 30,
                            backgroundImage:
                                NetworkImage(snapshot.data![index].imageUrl),
                          ),
                          title: Text(snapshot.data![index].title),
                          subtitle:
                              Text('Score: ${snapshot.data![index].score}'),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailPage(
                                    //Navigasi
                                    item: snapshot.data![index].malId,
                                    title: snapshot.data![index].title),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                );
              } else if (snapshot.hasError) {
                return const Center(child: Text('Something went wrong :('));
              }
              return const CircularProgressIndicator();
            },
          ),
        ],
      ),
    );
  }
}

class Show {
  final int malId;
  final String title;
  final String imageUrl;
  final num score;

  Show({
    required this.malId,
    required this.title,
    required this.imageUrl,
    required this.score,
  });

  factory Show.fromJson(Map<String, dynamic> json) {
    return Show(
      malId: json['mal_id'],
      title: json['title'],
      imageUrl: json['image_url'],
      score: json['score'],
    );
  }
}

Future<List<Show>> fetchShows() async {
  final response =
      await http.get(Uri.parse('https://api.jikan.moe/v3/top/anime/1'));

  if (response.statusCode == 200) {
    var topShowsJson = jsonDecode(response.body)['top'] as List;
    return topShowsJson.map((show) => Show.fromJson(show)).toList();
  } else {
    throw Exception('Failed to load shows');
  }
}

/////////////////////////////// Kelas Model List Pertama
class ShowFirst {
  final int malId;
  final String title;
  final String imageUrl;
  final num score;

  ShowFirst({
    required this.malId,
    required this.title,
    required this.imageUrl,
    required this.score,
  });
  factory ShowFirst.fromJson(Map<String, dynamic> json) {
    return ShowFirst(
      malId: json['mal_id'],
      title: json['title'],
      imageUrl: json['image_url'],
      score: json['score'],
    );
  }
}

Future<List<ShowFirst>> fetchShowFirst() async {
  final response =
      await http.get(Uri.parse('https://api.jikan.moe/v3/top/anime/1/airing'));

  if (response.statusCode == 200) {
    var topShowsJson = jsonDecode(response.body)['top'] as List;
    return topShowsJson
        .map((showFirst) => ShowFirst.fromJson(showFirst))
        .toList();
  } else {
    throw Exception('Failed to load shows');
  }
}






// actions: [
        //   IconButton(
        //     icon: Icon(
        //       Icons.home,
        //       color: Colors.amber,
        //     ),
        //     onPressed: () {
        //       // Navigator.push(
        //       //     context, MaterialPageRoute(builder: (context) => HomePage()));
        //     },
        //     color: Colors.white,
        //   ),
        //   IconButton(
        //     icon: Icon(Icons.person),
        //     onPressed: () {
        //       Navigator.push(context,
        //           MaterialPageRoute(builder: (context) => KelompokPage()));
        //     },
        //     color: Colors.white,
        //   )
        // ],
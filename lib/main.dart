import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Player',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  // State<HomePage> createState() => _HomePageState();
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _audioQuery = new OnAudioQuery();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('My Music'),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.search),
            ),
          ],
        ),
        body: FutureBuilder<List<SongModel>>(
          future: _audioQuery.querySongs(
            sortType: null,
            orderType: OrderType.ASC_OR_SMALLER,
            uriType: UriType.EXTERNAL,
            ignoreCase: true,
          ),
          builder: (context, item) {
            if (item.data == null) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (item.data!.isEmpty) {
              return const Center(
                child: Text('No Song Found.'),
              );
            }
            return ListView.builder(
              itemBuilder: (context, index) => ListTile(
                leading: const Icon(Icons.music_note),
                title: Text(item.data![index].displayNameWOExt),
                subtitle: Text('${item.data![index].artist}'),
                trailing: const Icon(Icons.more_horiz),
              ),
              itemCount: 10,
            );
          },
        ));
  }
}

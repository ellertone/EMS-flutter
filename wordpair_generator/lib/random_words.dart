import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

class RandomWords extends StatefulWidget {
  @override
  RandomWordsState createState() => RandomWordsState();
}

class RandomWordsState extends State<RandomWords> {
final randomWordPairs = <WordPair>[];
final savedWordPairs =Set<WordPair>();


Widget _buildList() {
return ListView.builder(
  padding: const EdgeInsets.all(8),
  itemBuilder: (context, item) {
    if (item.isOdd) return Divider();
    final index = item ~/ 2;
    if (index >= randomWordPairs.length) {
      randomWordPairs.addAll(generateWordPairs().take(10));
    }
    return _buildRow(randomWordPairs[index]);
  }
);
 }
 Widget _buildRow(WordPair pair) {
   final alreadySaved = savedWordPairs.contains(pair);
   return ListTile(
     title: Text(
       pair.asPascalCase,
       style: TextStyle(fontSize: 18.0)
     ),
     trailing: Icon(
       alreadySaved ? Icons.favorite : Icons.favorite_border,
       color: alreadySaved ? Colors.red : null),
       onTap: () {
         setState(() {
           if (alreadySaved) {
             savedWordPairs.remove(pair);
           } else {
             savedWordPairs.add(pair);
           }
         });
       },
   );
 }
  void _pushSaved() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
          final Iterable<ListTile> tiles = savedWordPairs.map(
            (WordPair pair) {
              return ListTile(
                title: Text(
                  pair.asPascalCase,
                  style: TextStyle(fontSize: 16.0)
                ),
              );
            }
          );
          final List<Widget> divided = ListTile.divideTiles(
            context: context,
            tiles: tiles
          ).toList();
          return Scaffold(
            appBar: AppBar(
              title: Text('Saved WordPairs'),
            ),
            body: ListView(children: divided),
          );
        }
      )
    );
  }


  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Word Pair Generator'),
        actions: <Widget>[
          IconButton(icon: const Icon(Icons.list),
           onPressed: _pushSaved),
        ],
      ),
      body: _buildList(),
    );
}
}
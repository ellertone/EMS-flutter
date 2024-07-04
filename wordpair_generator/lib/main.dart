import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter/widgets.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
 @override
 Widget build(BuildContext context) {
  
  return MaterialApp(
    theme: ThemeData(primaryColor: Colors.red),
    home: RandomWords());
 }

}
class RandomWords extends StatefulWidget {
  @override
  RandomWordsState createState() => RandomWordsState();
}

class RandomWordsState extends State<RandomWords> {
final randomWordPairs = <WordPair>[];

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
   return ListTile(
     title: Text(
       pair.asPascalCase,
       style: TextStyle(fontSize: 18.0)
     ),
   );
 }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Word Pair Generator')),
      body: _buildList(),
    );
}
}
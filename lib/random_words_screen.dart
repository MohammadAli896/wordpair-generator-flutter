import 'package:flutter/material.dart';
import 'package:wordpair_generator/dictionary_words_screen.dart';
// Not using english words package. Using my_words.dart for custom words instead
// import 'package:english_words/english_words.dart';

import 'my_words.dart'; // Importing the words list

class RandomWords extends StatefulWidget {
  const RandomWords({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _RandomWordsState createState() => _RandomWordsState();
}

// This class is the WordPair Generator screen
class _RandomWordsState extends State<RandomWords> {
  List<String> savedWords = []; //List of saved words
  Set<String> savedSet = <String>{}; //Sets of the saved words

  Widget _buildList() {
    int itemCount = (myWords.length / 2)
        .ceil(); //This is to set the item limit which at the moment is set to be half of the words since they will be joined in pairs and there is no exception errors while scrolling down
    return ListView.builder(
        //This is the main ListView that gets displayed
        padding: const EdgeInsets.all(16),
        itemCount: itemCount, // Display limit for my words
        itemBuilder: (BuildContext context, int itemCount) {
          if (itemCount.isOdd) return const Divider();
          var startIndex = itemCount * 2;
          var endIndex = startIndex + 2;

          if (endIndex > myWords.length) {
            endIndex = myWords.length;
          }

          var shuffledWords = myWords.sublist(startIndex, endIndex);
          return _buildRow(
              shuffledWords); //This is calling the widget below to generate those wordpairs
        });
  }

  //This widget is returning each word pair and adding it to a row which can then be added or removed from the savedscreen
  Widget _buildRow(List<String> shuffledWords) {
    if (shuffledWords.length < 2) {
      return Container();
    }

    String firstWord = shuffledWords[0];
    String secondWord = shuffledWords[1];

    bool alreadySaved = savedSet.contains("$firstWord $secondWord");

    return ListTile(
      title:
          Text("$firstWord $secondWord", style: const TextStyle(fontSize: 18)),
      trailing: Icon(
          //This is the logic piece of seeing whether it should display as being saved or not
          alreadySaved ? Icons.check_circle : Icons.check_circle_outline,
          color: alreadySaved ? Colors.blue[600] : null),
      onTap: () {
        //This is the action logic of adding it to the savedWords and savedSet
        setState(() {
          if (alreadySaved) {
            savedWords.remove("$firstWord $secondWord");
            savedSet.remove("$firstWord $secondWord");
          } else {
            savedWords.add("$firstWord $secondWord");
            savedSet.add("$firstWord $secondWord");
          }
        });
      },
    );
  }

  //This is the main scheme of the wordpair generator page that includes the top appbar as well as the icon that will allow the user to be routed to the savedscreen page
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('WordPair Generator'),
          backgroundColor: Colors.red[900],
          actions: [
            IconButton(
              icon: const Icon(Icons.list),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SavedWordPairsScreen(savedWords)),
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.book),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DictionaryScreen()),
                );
              },
            ),
          ],
        ),
        body: _buildList());
  }
}

// This class is the Saved Word Pairs Screen
class SavedWordPairsScreen extends StatelessWidget {
  final List<String> savedWords;

  const SavedWordPairsScreen(this.savedWords, {super.key});

  //This is the main scheme of the saved wordpairs page that includes the top appbar as well as the code for returning the saved words as a set in the list by utilzing that savedWords list
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved WordPairs'),
        backgroundColor: Colors.orange[900],
      ),
      body: ListView(
        children: savedWords.map((pair) {
          return ListTile(
            title: Text(pair),
          );
        }).toList(),
      ),
    );
  }
}

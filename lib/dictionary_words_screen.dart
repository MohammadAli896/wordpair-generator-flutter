import 'package:flutter/material.dart';

import './definition_words.dart'; //Importing the word:definition list

class DictionaryScreen extends StatelessWidget {
  const DictionaryScreen({super.key});

  Widget _buildList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: definitionWords.length,
      itemBuilder: (BuildContext context, int index) {
        String word = definitionWords[index].keys.first;
        String definition = definitionWords[index].values.first;
        return ListTile(
          title: Text(word),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DefinitionsScreen(word, definition)),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Dictionary'),
          backgroundColor: Colors.green,
        ),
        body: _buildList());
  }
}

// This class is the Definitions View/Screen
class DefinitionsScreen extends StatelessWidget {
  final String word;
  final String definition;
  const DefinitionsScreen(this.word, this.definition, {super.key});

  //This is the main scheme of the definitions page that includes the top appbar as well as the code that allows you to view the definition associated with the word
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Word Definition'),
        backgroundColor: Colors.yellow[700],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              word,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text(
              definition,
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}

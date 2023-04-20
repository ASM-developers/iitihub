import 'package:flutter/material.dart';

class SearchBar extends SearchDelegate {
  final List<String> queryResult;

  SearchBar(this.queryResult);

  @override
  //manipulation of tags should be done from here
  //remember if query's last character is # then listen for the next whitespace and add the tag into search list
  //also make a tag results column too
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results =
        queryResult.where((item) => item.startsWith(query)).toList();

    if (results.isEmpty) {
      return const Center(
        child: Text(
          'No results found.',
          style: TextStyle(fontSize: 24),
        ),
      );
    } else {
      return ListView.builder(
        itemCount: results.length,
        itemBuilder: (BuildContext context, int index) {
          final result = results[index];
          return ListTile(
            title: Text(result),
            onTap: () {
              // Handle result selection
            },
          );
        },
      );
    }
  }

  @override
  //optionally wrapping in a futurebuilder to listen to streams
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty
        ? []
        : queryResult.where((item) => item.startsWith(query)).toList();

    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        //here you can change what happens when someone clicks on an object rendered by query
        //TODO : on encountering a # await a whitespace to add to the list of tags with which we fetch a list of projects
        onTap: () {
          query = suggestionList[index];
          showResults(context);
        },
        title: Text(suggestionList[index]),
      ),
      itemCount: suggestionList.length,
    );
  }
}

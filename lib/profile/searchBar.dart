import 'package:firstapp/profile/viewProfile.dart';
import 'package:firstapp/services/models.dart';
import 'package:flutter/material.dart';

class SearchBar extends SearchDelegate {
  final Future<List<User>> Function(String) getUsersByName;

  SearchBar(this.getUsersByName);

  @override
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
    if (query.isEmpty) {
      return const Center(
        child: Text(
          'Please enter a search term.',
          style: TextStyle(fontSize: 24),
        ),
      );
    }

    return FutureBuilder<List<User>>(
      future: getUsersByName(query),
      builder: (BuildContext context, AsyncSnapshot<List<User>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text('Error'));
        } else if (snapshot.data == null || snapshot.data!.isEmpty) {
          return const Center(
            child: Text(
              'No results found.',
              style: TextStyle(fontSize: 24),
            ),
          );
        } else {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (BuildContext context, int index) {
              final result = snapshot.data![index];
              return ListTile(
                title: Text(result.name),
                onTap: () {
                  // Handle result selection
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => viewProfile(
                                user: result,
                              )));
                },
              );
            },
          );
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return const Center(
        child: Text(
          'Search for a user',
          style: TextStyle(fontSize: 24),
        ),
      );
    }

    return FutureBuilder<List<User>>(
      future: getUsersByName(query),
      builder: (BuildContext context, AsyncSnapshot<List<User>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text('Error'));
        } else {
          final suggestionList = snapshot.data ?? [];

          return ListView.builder(
            itemCount: suggestionList.length,
            itemBuilder: (context, index) => ListTile(
              onTap: () {
                query = suggestionList[index].name;
                showResults(context);
              },
              title: Text(suggestionList[index].name),
            ),
          );
        }
      },
    );
  }
}

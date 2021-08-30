import 'package:flutter/material.dart';
import 'package:maps/models/search_result.dart';

class SearchPlace extends SearchDelegate<SearchResult?> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () => this.query = '',
        icon: Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () => this.close(context, SearchResult(cancelled: true)),
      icon: Icon(Icons.arrow_back_ios),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Text('Build Results');
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          leading: Icon(Icons.location_on),
          title: Text('Select location manually'),
          onTap: () => this.close(context, SearchResult(manual: true)),
        ),
      ],
    );
  }
}

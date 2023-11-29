import 'package:algolia/algolia.dart';

class AlgoliaApplication {
  static const Algolia algolia = Algolia.init(
    applicationId: '6982X3EONS', //ApplicationID
    apiKey:
        'dba1ba12a523a74bd6c9a1737728dcc0', //search-only api key in flutter code
  );

  Future<List<AlgoliaObjectSnapshot>> getSearchResult(
      String input, SearchType searchType) async {
    print("getting results for $input");
    AlgoliaQuery query = AlgoliaApplication.algolia.instance
        .index(getCollectionName(searchType))
        .query(input)
        .setOffset(0)
        .setHitsPerPage(25);

    try {
      AlgoliaQuerySnapshot querySnap = await query.getObjects();
      var results = querySnap.hits;
      var hitsList = results;

      return hitsList;
    } on AlgoliaError catch (e) {
      print(e.error.toString());
      return [];
    }
  }
}

String getCollectionName(SearchType searchType) {
  switch (searchType) {
    case SearchType.users:
      return SearchCollections.users;

    default:
      return "";
  }
}

enum SearchType {
  users,
}

class SearchCollections {
  static const String users = 'users';
}

// class AlgoliaSearchResult {
//   String id;
//   String title;
//   String subtitle;
//   SearchType type;
//   AlgoliaSearchResult({
//     required this.id,
//     required this.title,
//     required this.subtitle,
//     required this.type,
//   });

//   Map<String, dynamic> toMap() {
//     return {
//       'objectID': id,
//       'id': id,
//       'title': title,
//       'subtitle': subtitle,
//       'type': type.index,
//     };
//   }

//   factory AlgoliaSearchResult.fromMap(Map<String, dynamic> map, {String? id}) {
//     return AlgoliaSearchResult(
//       id: id ?? map['id'] ?? '',
//       title: map['title'] ?? '',
//       subtitle: map['subtitle'] ?? '',
//       type: SearchType.values[map['type']],
//     );
//   }

//   factory AlgoliaSearchResult.fromAlgolia(AlgoliaObjectSnapshot snapshot) {
//     return AlgoliaSearchResult.fromMap(snapshot.data, id: snapshot.objectID);
//   }

//   String toJson() => json.encode(toMap());

//   factory AlgoliaSearchResult.fromJson(String source) =>
//       AlgoliaSearchResult.fromMap(json.decode(source));
// }

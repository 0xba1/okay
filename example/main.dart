// ignore_for_file: avoid_print

import 'dart:convert' as convert;

import 'package:http/http.dart' as http;
import 'package:okay/okay.dart';

/// This example uses the Google Books API to search for books about http.
/// If this is successful, it returns
/// an `ok` [Result] of [Map<String, dynamic>] of books,
/// if it fails it returns the http status code [int].
Future<Result<Map<String, dynamic>, int>> getBooks() async {
  final url =
      Uri.https('www.googleapis.com', '/books/v1/volumes', {'q': '{http}'});

  // Await the http get response, then decode the json-formatted response.
  final response = await http.get(url);

  if (response.statusCode == 200) {
    final jsonResponse =
        convert.jsonDecode(response.body) as Map<String, dynamic>;
    return ok(jsonResponse);
  } else {
    return err(response.statusCode);
  }
}

void main() async {
  final result = await getBooks();

  switch (result.type) {
    case ResultType.ok:
      print('Books: ${result.unwrap()}');
      break;
    case ResultType.err:
      print('Http request failed with status code ${result.unwrapErr()}');
      break;
  }
}

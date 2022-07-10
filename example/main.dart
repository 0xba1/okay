// ignore_for_file: avoid_print

import 'dart:convert' as convert;

import 'package:http/http.dart' as http;
import 'package:okay/okay.dart';

void main() async {
  final result = await getBooks();

  final books = result.inspectErr((ConnectionError error) {
    print('Http request failed with `ConnectionError` $error');
    switch (error) {
      case ConnectionError.noInternet:
        // Show snakbar or alert about 'No Internet'
        break;
      case ConnectionError.internalServerError:
        // Show snackbar and info to crashlytics
        break;
      case ConnectionError.badData:
        // Show snackbar and info to crashlytics
        break;
      case ConnectionError.badRequest:
        // Show snackbar and info to crashlytics
        break;
      case ConnectionError.forbidden:
        // Show snackbar
        break;
      case ConnectionError.notFound:
        // Show snackbar and info to crashlytics
        break;
      case ConnectionError.notImplemented:
        // Show snackbar and info to crashlytics
        break;
      case ConnectionError.otherError:
      // Show snackbar
    }
  }).unwrapOr({});

  // Use `Map<String, dynamic>`
  useBooks(books);
}

/// This example uses the Google Books API to search for books about http.
/// If this is successful, it returns
/// an `ok` [Result] of [Map<String, dynamic>] of books,
/// if it fails it returns the http status code [int].
Future<Result<Map<String, dynamic>, ConnectionError>> getBooks() async {
  final url =
      Uri.https('www.googleapis.com', '/books/v1/volumes', {'q': '{http}'});

  // Check for internet connection
  if (!isThereInternetConnection()) return err(ConnectionError.noInternet);

  // Await the http get response, then decode the json-formatted response.
  final response = await http.get(url);

  if (response.statusCode == 200) {
    try {
      final jsonResponse =
          convert.jsonDecode(response.body) as Map<String, dynamic>;
      return ok(jsonResponse);
    } catch (_) {
      return err(ConnectionError.badData);
    }
  }

  switch (response.statusCode) {
    case 401:
      return err(ConnectionError.badRequest);
    case 403:
      return err(ConnectionError.forbidden);
    case 404:
      return err(ConnectionError.notFound);
    case 500:
      return err(ConnectionError.internalServerError);
    case 501:
      return err(ConnectionError.notImplemented);
    default:
      return err(ConnectionError.otherError);
  }
}

/// Check if there is Internet connection.
bool isThereInternetConnection() {
  return true;
}

void useBooks(Map<String, dynamic> books) {}

enum ConnectionError {
  noInternet,
  internalServerError,
  badData,
  badRequest,
  forbidden,
  notFound,
  notImplemented,
  otherError,
}

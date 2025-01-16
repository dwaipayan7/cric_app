import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/match_model.dart';

class MatchRepository{
  final String apiUrl = "https://free-cricbuzz-cricket-api.p.rapidapi.com/cricket-livescores";

  Future<List<MatchModel>> fetchMatchDetails() async {
    try {
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'x-rapidapi-key': 'a2ddd2f724msh291031c52cd3ca9p173ddbjsnea5d83b682cc',
          'x-rapidapi-host': 'free-cricbuzz-cricket-api.p.rapidapi.com',
        },
      );

      print(response.body);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data['status'] == 'success' && data['response'] != null) {
          final List<MatchModel> matches = [];

          for (final series in data['response']) {
            final seriesName = series['seriesName'] ?? 'Unknown Series';
            final matchList = series['matchList'] as List;

            for (final match in matchList) {
              matches.add(MatchModel.fromJson(match, seriesName));
            }
          }

          return matches;
        } else {
          print('Error: Response status is not success or response is empty.');
        }
      } else {
        print('Error: Failed to fetch data. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('Exception occurred while fetching match details: $e');
    }
    return [];
  }

}


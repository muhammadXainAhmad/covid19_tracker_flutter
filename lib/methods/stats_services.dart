import "dart:convert";

import "package:covid19_tracker/constants/app_urls.dart";
import "package:covid19_tracker/models/world_stats_model.dart";
import "package:http/http.dart" as http;

class StatsServices {
  Future<WorldStatsModel> fetchWorldStats() async {
    final response = await http.get(Uri.parse(AppUrls.worldStatsApi));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return WorldStatsModel.fromJson(data);
    } else {
      throw Exception("Error");
    }
  }
}

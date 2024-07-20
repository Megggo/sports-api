class TeamsData {
  TeamsData({
    required this.success,
    required this.result,
  });

  late final int success;
  late final List<Result> result;

  TeamsData.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    result = List.from(json['result']).map((e) => Result.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['result'] = result.map((e) => e.toJson()).toList();
    return data;
  }
}

class Result {
  Result({
    required this.teamKey,
    required this.teamName,
    required this.teamPlayers,
    required this.teamLogo,
    this.teamCoaches,
  });

  late final int teamKey;
  late final String teamName;
  late final List<dynamic> teamPlayers;
  late final String teamLogo;
  late final String? teamCoaches;

  Result.fromJson(Map<String, dynamic> json) {
    teamKey = json['team_key'];
    teamName = json['team_name'];
    teamPlayers = json['players'] ?? [];
    teamLogo = json['team_logo'];
    teamCoaches = json['coaches'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['team_key'] = teamKey;
    data['team_name'] = teamName;
    data['players'] = teamPlayers;
    data['team_logo'] = teamLogo;
    data['coaches'] = teamCoaches;
    return data;
  }
}

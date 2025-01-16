class MatchModel {
  final String seriesName;
  final String matchTitle;
  final String matchVenue;
  final String matchDate;
  final String matchTime;
  final String teamOneName;
  final String teamTwoName;
  final String teamOneScore;
  final String teamTwoScore;
  final String matchStatus;
  final String currentStatus;

  MatchModel({
    required this.seriesName,
    required this.matchTitle,
    required this.matchVenue,
    required this.matchDate,
    required this.matchTime,
    required this.teamOneName,
    required this.teamTwoName,
    required this.teamOneScore,
    required this.teamTwoScore,
    required this.matchStatus,
    required this.currentStatus,
  });

  factory MatchModel.fromJson(Map<String, dynamic> json, String seriesName) {
    final teamOne = json['teamOne'];
    final teamTwo = json['teamTwo'];

    return MatchModel(
      seriesName: seriesName,
      matchTitle: json['matchTitle'] ?? 'Unknown match title',
      matchVenue: json['matchVenue'] ?? 'Unknown venue',
      matchDate: json['matchDate'] ?? 'Unknown date',
      matchTime: json['matchTime'] ?? 'Unknown time',
      teamOneName: teamOne['name'] ?? 'Unknown team',
      teamOneScore: teamOne['score'] ?? '0-0',
      teamTwoName: teamTwo['name'] ?? 'Unknown team',
      teamTwoScore: teamTwo['score'] ?? '0-0',
      matchStatus: json['matchStatus'] ?? 'Unknown status',
      currentStatus: json['currentStatus'] ?? 'Unknown status',
    );
  }
}

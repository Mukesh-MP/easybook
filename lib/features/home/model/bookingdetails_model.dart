class BookingDetails {
  BookingDetails({
    this.gameId,
    this.teamId,
    this.teamName,
    this.date,
    this.from,
    this.to,
    this.status,
    this.game,
    this.paid,
    this.hr,
    this.mobileNumber,
  });

  int? gameId;
  int? teamId;
  String? teamName;
  String? date;
  String? from;
  String? to;
  String? status;

  String? game;
  String? paid;
  String? hr;
  String? mobileNumber;
}

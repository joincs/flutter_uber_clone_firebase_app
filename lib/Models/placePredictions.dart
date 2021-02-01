class PlacePredcitions {
  String secondaryText;
  String mainText;
  String placeId;

  PlacePredcitions({this.secondaryText, this.mainText, this.placeId});

  PlacePredcitions.fromJson(Map<String, dynamic> json) {
    placeId = json['place_id'];
    mainText = json["structured_formatting"]['main_text'];
    secondaryText = json["structured_formatting"]['secondary_text'];
  }
}

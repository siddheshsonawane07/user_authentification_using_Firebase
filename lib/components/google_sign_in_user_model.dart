class UserDetails {
  String? displayName;
  String? email;

  UserDetails({this.displayName, this.email});

  UserDetails.fromJson(Map<String, dynamic> json) {
    displayName = json["displayName"];
    email = json["email"];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["displayName"] = this.displayName;
    data["email"] = this.email;

    return data;
  }
}

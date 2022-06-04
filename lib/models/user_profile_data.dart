class UserProfileData {
  String name;
  String description;
  int advance;
  int total;

  UserProfileData({required this.name, required this.description, required this.advance, required this.total});

  set setName(String name) {
    this.name = name;
  }

  set setDescription(String description) {
    this.description = description;
  }

  String get getName => name;
  String get getDescription => description;

  Map<String, dynamic> toMap() {
    var map = {'name': name, 'description': description, 'advance': advance, 'total': total};
    return map;
  }
}

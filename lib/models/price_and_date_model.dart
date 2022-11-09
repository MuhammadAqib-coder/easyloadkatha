class PriceAndDate {
  final String price;
  final String date;
  PriceAndDate({required this.price, required this.date});

  String get getPrice => price;
  String get getDate => date;

  Map<String, dynamic> toMap() {
    var map = {'price': price, 'date': date,};
    return map;
  }
}

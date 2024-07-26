class ExpenseModel {
  final int? id;
  final String name;
  final String category;
  final String imageCategory;
  final String date;
  final String amount;
  final int colorCategory;

  ExpenseModel({
    this.id,
    required this.name,
    required this.category,
    required this.imageCategory,
    required this.date,
    required this.amount,
    required this.colorCategory,
  });

  Map<String, dynamic> toDatabaseJson() => {
        'id': id,
        'name': name,
        'category': category,
        'imageCategory': imageCategory,
        'date': date,
        'amount': amount,
        'colorCategory': colorCategory,
      };

  factory ExpenseModel.fromDatabaseJson(Map<String, dynamic> json) =>
      ExpenseModel(
        id: json['id'],
        name: json['name'],
        category: json['category'],
        imageCategory: json['imageCategory'],
        date: json['date'],
        amount: json['amount'],
        colorCategory: json['colorCategory'],
      );
}

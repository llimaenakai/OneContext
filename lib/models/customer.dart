class Customer {
  int? id;
  String customerCode;
  String name;
  String? contact1;
  String? contact2;
  String? email;
  String? address;
  String? city;
  String category;
  String subCategory;
  String status;

  Customer({
    this.id,
    required this.customerCode,
    required this.name,
    this.contact1,
    this.contact2,
    this.email,
    this.address,
    this.city,
    required this.category,
    required this.subCategory,
    required this.status,
  });

  // To map data from SQLite to this model
  factory Customer.fromMap(Map<String, dynamic> map) {
    return Customer(
      id: map['id'],
      customerCode: map['customer_code'],
      name: map['name'],
      contact1: map['contact_1'],
      contact2: map['contact_2'],
      email: map['email'],
      address: map['address'],
      city: map['city'],
      category: map['category'],
      subCategory: map['sub_category'],
      status: map['status'],
    );
  }

  // To map this model to SQLite table
  Map<String, dynamic> toMap() {
    return {
      'customer_code': customerCode,
      'name': name,
      'contact_1': contact1,
      'contact_2': contact2,
      'email': email,
      'address': address,
      'city': city,
      'category': category,
      'sub_category': subCategory,
      'status': status,
    };
  }
}

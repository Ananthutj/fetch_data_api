class User {
  final String name;
  final String email;
  final String userName;
  final String phone;
  final String website;
  final String street;
  final String suite;
  final String city;
  final String zipcode;
  final String companyName;
  final String catchPhrase;
  final String bs;

  const User({
    required this.name,
    required this.email,
    required this.userName,
    required this.phone,
    required this.website,
    required this.street,
    required this.suite,
    required this.city,
    required this.zipcode,
    required this.companyName,
    required this.catchPhrase,
    required this.bs,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      email: json['email'],
      userName: json['username'],
      phone: json['phone'],
      website: json['website'],
      street: json['address']['street'],
      suite: json['address']['suite'],
      city: json['address']['city'],
      zipcode: json['address']['zipcode'],
      companyName: json['company']['name'],
      catchPhrase: json['company']['catchPhrase'],
      bs: json['company']['bs']
    );
  }
}

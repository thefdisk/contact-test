class Contact {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String notes;
  final DateTime created;
  final List<Label> labels;

  Contact({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.notes,
    required this.created,
    required this.labels,
  });

  factory Contact.fromJson(Map<String, dynamic> json) => Contact(
        id: json['id'],
        name: json['name'],
        email: json['email'],
        phone: json['phone'],
        notes: json['notes'],
        created: DateTime.parse(json["created"]),
        labels: List<Label>.from(json['labels'].map((x) => Label.fromJson(x))),
      );
}

class Label {
  final String slug;
  final String title;

  Label({required this.slug, required this.title});

  factory Label.fromJson(Map<String, dynamic> json) => Label(
        slug: json['slug'],
        title: json['title'],
      );
}

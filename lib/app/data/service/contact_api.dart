import 'dart:convert';

import 'package:contact_test/app/data/model/contact.dart';
import 'package:http/http.dart' as http;

class ContactAPI {
  static const url = 'https://demo2278480.mockable.io/contacts';

  static Future<List<Contact>> getAllContact() async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      List<Contact> listContact =
          List<Contact>.from(data.map((e) => Contact.fromJson(e))).toList();
      return listContact;
    } else {
      throw Exception('Failed load data from api');
    }
  }
}

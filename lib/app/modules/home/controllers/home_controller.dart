import 'package:contact_test/app/data/model/contact.dart';
import 'package:contact_test/app/data/service/contact_api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  late TextEditingController searchCon;
  var listContacts = <Contact>[].obs;
  var tempListContact = <Contact>[].obs;
  var isLoading = false.obs;
  var isError = false.obs;
  var searchQuery = ''.obs;

  Future<List<Contact>> getContact() async {
    try {
      isLoading.value = true;
      isError.value = false;

      final data = await ContactAPI.getAllContact();

      if (data.isNotEmpty) {
        isLoading.value = false;
        listContacts.value = data;
      }
    } catch (e) {
      isLoading.value = false;
      isError.value = true;
      print('ERRORNYA :$e');
    }
    return listContacts;
  }

  // void addContact(Contact contact) {
  //   listContacts.add(
  //     Contact(
  //       id: 1,
  //       name: contact.name,
  //       email: contact.email,
  //       phone: contact.phone,
  //       notes: contact.notes,
  //       created: DateTime.now(),
  //       labels: contact.labels,
  //     ),
  //   );
  // }

  void searchContact(String query) {
    final contacts = listContacts.where((contact) {
      final nameLower = contact.name.toLowerCase();
      final searchLower = query.toLowerCase();

      return nameLower.contains(searchLower);
    }).toList();

    searchQuery.value = query;
    tempListContact.value = contacts;
  }

  @override
  void onInit() async {
    searchCon = TextEditingController();
    await getContact();
    super.onInit();
  }

  @override
  void onClose() {
    searchCon.dispose();
    super.onClose();
  }
}

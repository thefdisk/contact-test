import 'package:contact_test/app/data/model/contact.dart';
import 'package:contact_test/app/modules/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddController extends GetxController {
  late TextEditingController nameCont;
  late TextEditingController emailCont;
  late TextEditingController phoneCont;
  late TextEditingController noteCont;
  late TextEditingController labelCont;

  var listLabels = <Label>[
    Label(slug: 'slug', title: 'Teman SMA'),
    Label(slug: 'slug', title: 'Teman Kantor'),
  ].obs;

  // var listContact = Get.find<HomeController>().listContacts.value;

  // void addContact() {
  //   listContact.add(
  //     Contact(
  //       id: 1,
  //       name: nameCont.text,
  //       email: emailCont.text,
  //       phone: phoneCont.text,
  //       notes: noteCont.text,
  //       created: DateTime.now(),
  //       labels: listLabels,
  //     ),
  //   );
  // }

  void addLabels(String label) {
    listLabels.add(Label(slug: 'slug', title: label));
  }

  @override
  void onInit() {
    nameCont = TextEditingController();
    emailCont = TextEditingController();
    phoneCont = TextEditingController();
    noteCont = TextEditingController();
    labelCont = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    nameCont.dispose();
    emailCont.dispose();
    phoneCont.dispose();
    labelCont.dispose();
    super.onClose();
  }
}

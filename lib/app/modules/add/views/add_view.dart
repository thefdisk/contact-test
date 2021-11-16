import 'package:contact_test/app/data/model/contact.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';

import '../controllers/add_controller.dart';

class AddView extends GetView<AddController> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.red),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'New Contact',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
            ),
            _buildTextField(
                key: const Key('name'),
                editingController: controller.nameCont,
                title: 'Name',
                hintText: 'Contact Name'),
            _buildTextField(
                key: const Key('email'),
                editingController: controller.emailCont,
                title: 'Email',
                hintText: 'Contact email address'),
            _buildTextField(
                key: const Key('phone'),
                editingController: controller.phoneCont,
                title: 'Phone',
                hintText: 'Phone number',
                isNumber: true),
            _buildTextField(
                key: const Key('note'),
                editingController: controller.noteCont,
                title: 'Notes',
                hintText: 'Anything about the contact'),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30, top: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Labels',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Obx(
                    () => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Wrap(
                            spacing: 2,
                            children: controller.listLabels
                                .map(
                                  (label) => InputChip(
                                    label: Text(
                                      label.title,
                                    ),
                                    labelStyle: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    backgroundColor: Colors.grey,
                                    onDeleted: () =>
                                        controller.listLabels.remove(label),
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                        IconButton(
                          onPressed: () => _buildAddLabel(),
                          icon: const Icon(
                            Icons.add,
                            color: Colors.red,
                            size: 30,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(thickness: 1, color: Colors.grey),
                  const SizedBox(height: 50),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        final data = Contact(
                          id: 1,
                          name: controller.nameCont.text,
                          email: controller.emailCont.text,
                          phone: controller.phoneCont.text,
                          notes: controller.noteCont.text,
                          created: DateTime.now(),
                          labels: controller.listLabels,
                        );
                        Get.back(result: data);
                      },
                      child: const Text(
                        'Save',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red,
                      ),
                    ),
                  ),
                  const SizedBox(height: 50),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildAddLabel() {
    return Get.dialog(
      AlertDialog(
        contentPadding: const EdgeInsets.all(16.0),
        content: Row(
          children: [
            Form(
              key: _formKey,
              child: Expanded(
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please add label';
                    }
                    return null;
                  },
                  controller: controller.labelCont,
                  autofocus: true,
                  decoration: const InputDecoration(
                    labelText: 'Label',
                    hintText: 'eg. Teman SMA',
                  ),
                  textCapitalization: TextCapitalization.words,
                ),
              ),
            )
          ],
        ),
        actions: [
          ElevatedButton(
              child: const Text('CANCEL'),
              onPressed: () {
                Get.back();
                controller.labelCont.clear();
              }),
          ElevatedButton(
            child: const Text('ADD'),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                controller.addLabels(controller.labelCont.text);
                Get.back();
                controller.labelCont.clear();
              }
            },
          )
        ],
      ),
    );
  }

  Widget _buildTextField({
    required Key key,
    required TextEditingController editingController,
    required String title,
    required String hintText,
    bool isNumber = false,
  }) {
    return Container(
      padding: const EdgeInsets.only(left: 30, right: 30, top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.red,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextField(
            key: key,
            controller: editingController,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
            keyboardType: (isNumber) ? TextInputType.number : null,
          ),
        ],
      ),
    );
  }
}

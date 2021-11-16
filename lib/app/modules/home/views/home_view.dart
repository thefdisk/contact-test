import 'package:contact_test/app/data/model/contact.dart';
import 'package:contact_test/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _buildTitle(),
            const SizedBox(height: 10),
            _buildSearch(context),
            const SizedBox(height: 20),
            Obx(
              () => Expanded(
                child: (controller.isLoading.value)
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : (controller.isError.value)
                        ? _buildError()
                        : (controller.tempListContact.isEmpty &&
                                controller.searchQuery.value != '')
                            ? _buildNoData()
                            : _buildBody(controller.tempListContact.isNotEmpty
                                ? controller.tempListContact
                                : controller.listContacts),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Padding(
      padding: const EdgeInsets.only(left: 16, top: 10, right: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
            onPressed: () {},
            child: const Text(
              'Labels',
              style: TextStyle(
                color: Colors.red,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Text(
            'Manage Contacts',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          IconButton(
            onPressed: () async {
              final data = await Get.toNamed(Routes.ADD);
              if (data == null) {
                return;
              }
              controller.listContacts.add(data);
            },
            icon: const Icon(
              Icons.add,
              color: Colors.red,
              size: 30,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearch(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      height: 50,
      child: TextField(
        controller: controller.searchCon,
        onChanged: (value) => controller.searchContact(value),
        maxLines: 1,
        style: const TextStyle(fontSize: 17),
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          filled: true,
          prefixIcon:
              Icon(Icons.search, color: Theme.of(context).iconTheme.color),
          border: const OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          fillColor: Theme.of(context).inputDecorationTheme.fillColor,
          contentPadding: EdgeInsets.zero,
          hintText: 'Search Contacts',
        ),
      ),
    );
  }

  Widget _buildBody(List<Contact> contact) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      shrinkWrap: true,
      itemCount: contact.length,
      separatorBuilder: (context, index) => const Divider(thickness: 1),
      itemBuilder: (context, index) {
        return _buildListItem(contact[index]);
      },
    );
  }

  Widget _buildListItem(Contact contact) {
    return ListTile(
      title: Text(
        contact.name,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
      trailing: SizedBox(
        height: 30,
        child: ListView.separated(
          separatorBuilder: (context, index) => const SizedBox(width: 5),
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: contact.labels.length,
          itemBuilder: (context, index) {
            return Container(
              padding: const EdgeInsets.all(3),
              decoration: const BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.all(Radius.circular(5)),
              ),
              child: Center(
                child: Text(
                  contact.labels[index].title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildNoData() {
    return const Center(
      child: Text(
        'No Contact Found',
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 30,
        ),
      ),
    );
  }

  Widget _buildError() {
    return Center(
      child: InkWell(
        onTap: () => controller.getContact(),
        borderRadius: BorderRadius.circular(15),
        child: Container(
          width: 175,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(
                Icons.refresh,
                color: Colors.red,
                size: 30,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                'Try Again!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

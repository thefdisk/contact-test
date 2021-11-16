import 'package:get/get.dart';

import 'package:contact_test/app/modules/add/bindings/add_binding.dart';
import 'package:contact_test/app/modules/add/views/add_view.dart';
import 'package:contact_test/app/modules/home/bindings/home_binding.dart';
import 'package:contact_test/app/modules/home/views/home_view.dart';

// ignore_for_file: constant_identifier_names

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.ADD,
      page: () => AddView(),
      binding: AddBinding(),
    ),
  ];
}

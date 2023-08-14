
import 'package:get/get.dart';
import '../modules/employee/create_employee_binding.dart';
import '../modules/employee/create_employee_view.dart';
import '../modules/home/home_binding.dart';
import '../modules/home/home_view.dart';
import '../modules/login/login_binding.dart';
import '../modules/login/login_view.dart';
import '../modules/signup/signup_binding.dart';
import '../modules/signup/signup_view.dart';
import '../modules/splash/splash_binding.dart';
import '../modules/splash/splash_view.dart';


part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const initial = Routes.splash;

  static final routes = [
     GetPage(
      name: _Paths.splash,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.login,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
     GetPage(
      name: _Paths.signup,
      page: () => const SignUpView(),
      binding: SignUpBinding(),
    ),
     GetPage(
      name: _Paths.home,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),

     GetPage(
      name: _Paths.createEmployee,
      page: () => const CreateEmployeeView(),
      binding: CreateEmployeeBinding(),
    ),
  ];
}

import 'package:get/get.dart';

import '../modules/artikel/bindings/artikel_binding.dart';
import '../modules/artikel/views/artikel_detail_view.dart';
import '../modules/artikel/views/artikel_view.dart';
import '../modules/bantuan/bindings/bantuan_binding.dart';
import '../modules/bantuan/views/bantuan_view.dart';
import '../modules/forgot_password/bindings/forgot_password_binding.dart';
import '../modules/forgot_password/views/forgot_password_view.dart';
import '../modules/ganti_katasandi/bindings/ganti_katasandi_binding.dart';
import '../modules/ganti_katasandi/views/ganti_katasandi_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/ikanview/bindings/ikanview_binding.dart';
import '../modules/ikanview/views/ikan_detail.dart';
import '../modules/ikanview/views/ikanview_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/mainPage/bindings/main_page_binding.dart';
import '../modules/mainPage/views/main_page_view.dart';
import '../modules/measurement/bindings/measurement_binding.dart';
import '../modules/measurement/views/measurement_view.dart';
import '../modules/notifikasiPage/bindings/notifikasi_page_binding.dart';
import '../modules/notifikasiPage/views/notifikasi_page_view.dart';
import '../modules/pelabuhan/bindings/pelabuhan_binding.dart';
import '../modules/pelabuhan/views/pelabuhan_detail.dart';
import '../modules/pelabuhan/views/pelabuhan_view.dart';
import '../modules/post/bindings/post_binding.dart';
import '../modules/post/views/post_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/profile/views/ubah_profil.dart';
import '../modules/register/bindings/register_binding.dart';
import '../modules/register/views/register_view.dart';
import '../modules/reset_password/bindings/reset_password_binding.dart';
import '../modules/reset_password/views/reset_password_view.dart';
import '../modules/splash1/bindings/splash1_binding.dart';
import '../modules/splash1/views/splash1_view.dart';
import '../modules/splash2/bindings/splash2_binding.dart';
import '../modules/splash2/views/splash2_view.dart';
import '../modules/verify_code/bindings/verify_code_binding.dart';
import '../modules/verify_code/views/verify_code_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH1;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => RegisterPage(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => ProfilView(),
      binding: ProfilBinding(),
    ),
    GetPage(
      name: _Paths.ARTIKEL,
      page: () => ArtikelPage(),
      binding: ArtikelBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH1,
      page: () => const Splash1View(),
      binding: Splash1Binding(),
    ),
    GetPage(
      name: _Paths.SPLASH2,
      page: () => const Splash2View(),
      binding: Splash2Binding(),
    ),
    GetPage(
      name: _Paths.MAIN_PAGE,
      page: () => MainPageView(),
      binding: MainPageBinding(),
    ),
    GetPage(
      name: _Paths.NOTIFIKASI_PAGE,
      page: () => NotifikasiView(),
      binding: NotifikasiPageBinding(),
    ),
    GetPage(
      name: _Paths.MEASUREMENT,
      page: () => CameraView(),
      binding: MeasurementBinding(),
    ),
    GetPage(
      name: _Paths.PELABUHAN,
      page: () => const PelabuhanView(),
      binding: PelabuhanBinding(),
    ),
    GetPage(
      name: _Paths.ARTIKEL_DETAIL,
      page: () => ArtikelDetailView(),
      binding: ArtikelBinding(),
    ),
    GetPage(
      name: _Paths.PELABUHAN_DETAIL,
      page: () => PelabuhanDetailPage(),
      binding: PelabuhanBinding(),
    ),
    GetPage(
      name: _Paths.IKANVIEW,
      page: () => const IkanView(),
      binding: IkanviewBinding(),
    ),
    GetPage(
      name: _Paths.IKAN_DETAIL,
      page: () => IkanDetailPage(),
      binding: IkanviewBinding(),
    ),
    GetPage(
      name: _Paths.FORGOT_PASSWORD,
      page: () => const ForgotPasswordView(),
      binding: ForgotPasswordBinding(),
    ),
    GetPage(
      name: _Paths.RESET_PASSWORD,
      page: () => const ResetPasswordView(),
      binding: ResetPasswordBinding(),
    ),
    GetPage(
      name: _Paths.VERIFY_CODE,
      page: () => const VerifyCodeView(),
      binding: VerifyCodeBinding(),
    ),
    GetPage(
      name: _Paths.EDIT_PROFILE,
      page: () => const UbahProfil(),
      binding: ProfilBinding(),
    ),
    GetPage(
      name: _Paths.BANTUAN,
      page: () => const BantuanView(),
      binding: BantuanBinding(),
    ),
    GetPage(
      name: _Paths.GANTI_KATASANDI,
      page: () => const GantiKatasandiView(),
      binding: GantiKatasandiBinding(),
    ),
    GetPage(
      name: _Paths.POST,
      page: () => PostView(),
      binding: PostBinding(),
    ),
  ];
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_capstone/app/modules/home/controllers/home_controller.dart';
import '../../../routes/app_pages.dart';
import '../widgets/feature_menu.dart';
import '../widgets/header.dart';
import '../widgets/horizontal_artikel.dart';
import '../widgets/horizontal_ikan.dart';
import '../widgets/horizontal_pelabuhan.dart';
import '../widgets/section_title.dart';
import '../widgets/smart_solution_card.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          NotificationListener<ScrollNotification>(
            onNotification: (notification) {
              if (notification is ScrollUpdateNotification &&
                  notification.metrics.axis == Axis.vertical) {
                controller.checkScroll(notification.metrics.pixels);
              }
              return true;
            },
            child: SingleChildScrollView(
              controller: controller.scrollController,
              physics: const ClampingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeaderSection(),
                  const SizedBox(height: 80),
                  _buildContentSection(),
                ],
              ),
            ),
          ),
          _buildAnimatedAppBar(context),
        ],
      ),
    );
  }

  Widget _buildHeaderSection() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        SizedBox(
          height: 230,
          width: double.infinity,
          child: Stack(
            children: [
              Image.asset(
                'assets/images/bg2.png',
                fit: BoxFit.cover,
                width: double.infinity,
                height: 230,
              ),
              Container(
                width: double.infinity,
                height: 230,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.black45, Colors.transparent],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
            ],
          ),
        ),
        const Positioned(top: 45, left: 16, right: 16, child: Header()),
        const Positioned(
          bottom: -60,
          left: 16,
          right: 16,
          child: SmartSolutionCard(),
        ),
      ],
    );
  }

  Widget _buildContentSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const FeatureMenu(),
          const SizedBox(height: 15),
          SectionTitle(
            title: 'Informasi Pelabuhan',
            onSeeAll: () {
              Get.toNamed(Routes.ARTIKEL);
            },
          ),
          const HorizontalArtikel(),
          const SizedBox(height: 15),
          SectionTitle(
            title: 'Informasi Pelabuhan',
            onSeeAll: () {
              Get.toNamed(Routes.PELABUHAN);
            },
          ),
          const HorizontalPelabuhan(),
          const SizedBox(height: 15),
          SectionTitle(
            title: 'Jenis Ikan',
            onSeeAll: () {
              Get.toNamed(Routes.IKANVIEW);
            },
          ),
          const HorizontalIkan(),
          const SizedBox(height: 50),
        ],
      ),
    );
  }

  Widget _buildAnimatedAppBar(BuildContext context) {
    return Obx(() => AnimatedSlide(
          duration: const Duration(milliseconds: 300),
          offset: controller.showAppBar.value ? Offset(0, 0) : Offset(0, -1),
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 300),
            opacity: controller.showAppBar.value ? 1 : 0,
            child: Container(
              height: kToolbarHeight + MediaQuery.of(context).padding.top,
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top,
                left: 20,
                right: 20,
              ),
              color: Colors.white,
              child: const Header(isAppBar: true),
            ),
          ),
        ));
  }
}

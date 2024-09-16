import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lca/widgets/image_constant.dart';
import 'package:lca/widgets/theme_helper.dart';
import 'custom_image.dart';

class CustomBottomBar extends StatelessWidget {
  final RxInt selectedIndex = 0.obs;

  final Function(BottomBarEnum)? onChanged;

  CustomBottomBar({this.onChanged});

  List<BottomMenuModel> bottomMenuList = [
    BottomMenuModel(
      icon: ImageConstant.home,
      activeIcon: ImageConstant.home,
      title: "Home".tr,
      type: BottomBarEnum.Home,
    ),
    BottomMenuModel(
      icon: ImageConstant.complaint,
      activeIcon: ImageConstant.complaint,
      title: "Complaint".tr,
      type: BottomBarEnum.Complaints,
    ),
    BottomMenuModel(
      icon: ImageConstant.user,
      activeIcon: ImageConstant.user,
      title: "Profile".tr,
      type: BottomBarEnum.Profile,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final titleStyle = theme.textTheme.titleSmall ??
        TextStyle(fontSize: 13, color: Colors.black); // Fallback style

    return Obx(() {
      return Container(
        height: 61,
        decoration: BoxDecoration(
          color: appTheme.whiteA70001,
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedFontSize: 0,
          elevation: 0,
          currentIndex: selectedIndex.value,
          type: BottomNavigationBarType.fixed,
          items: List.generate(bottomMenuList.length, (index) {
            final menuItem = bottomMenuList[index];
            return BottomNavigationBarItem(
              icon: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomImageView(
                    imagePath: menuItem.icon.isNotEmpty ? menuItem.icon : '',
                    height: 30,
                    width: 30,
                    color: appTheme.black90001,
                  ),
                  Text(
                    menuItem.title ?? "",
                    style: titleStyle,
                  ),
                ],
              ),
              activeIcon: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.green,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomImageView(
                        imagePath: menuItem.activeIcon.isNotEmpty ? menuItem.activeIcon : '',
                        height: 27,
                        width: 45,
                        color: Colors.white,
                      ),
                      Text(
                        menuItem.title ?? "",
                        style: titleStyle.copyWith(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              label: '',
            );
          }),
          onTap: (index) {
            selectedIndex.value = index;
            onChanged?.call(bottomMenuList[index].type);
          },
        ),
      );
    });
  }
}


enum BottomBarEnum {
  Home,
  Search,
  Complaints,
  Profile,
}

class BottomMenuModel {
  BottomMenuModel({
    required this.icon,
    required this.activeIcon,
    this.title,
    required this.type,
  });

  String icon;

  String activeIcon;

  String? title;

  BottomBarEnum type;
}

class DefaultWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(10),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Please replace the respective Widget here',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

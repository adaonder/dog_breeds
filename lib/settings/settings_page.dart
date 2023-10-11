import 'package:dog_breeds/common/constants/assets_images.dart';
import 'package:dog_breeds/common/constants/my_colors.dart';
import 'package:dog_breeds/common/util/app_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: buildBody(),
      ),
    );
  }

  buildBody() {
    return Padding(
      padding: const EdgeInsets.only(left: 16),
      child: Column(
        children: [
          const SizedBox(height: 8),
          Container(
              height: 4,
              width: 32,
              decoration: const BoxDecoration(color: MyColors.settingsModelDivider, borderRadius: BorderRadius.all(Radius.circular(20)))),
          buildItem(AssetsImages.help, "Help"),
          buildItem(AssetsImages.rate, "Rate Us"),
          buildItem(AssetsImages.share, "Share with Friends"),
          buildItem(AssetsImages.terms, "Terms of Use"),
          buildItem(AssetsImages.privacy, "Privacy Policy"),
          buildItemVersion(AssetsImages.osVersion, "OS Version"),
        ],
      ),
    );
  }

  Widget buildItem(String icon, String title) {
    return Column(
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Image.asset(
                icon,
                height: 32,
              ),
            ),
            const SizedBox(width: 12),
            Text(
              title,
              style: GoogleFonts.roboto(fontSize: 20),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                AssetsImages.arrowRT,
                height: 32,
                width: 32,
              ),
            )
          ],
        ),
        const Divider(
          height: 2,
          thickness: 0.5,
        )
      ],
    );
  }

  Widget buildItemVersion(String icon, String title) {
    return Column(
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Image.asset(
                icon,
                height: 32,
              ),
            ),
            const SizedBox(width: 12),
            Text(
              title,
              style: GoogleFonts.roboto(fontSize: 20),
            ),
            const Spacer(),
            FutureBuilder(
              future: AppUtil().appVersion(),
              builder: (context, snapshot) {
                if (snapshot.data == null) {
                  return const Text("");
                }
                return Text(
                  "v${snapshot.data!}",
                  style: GoogleFonts.roboto(fontWeight: FontWeight.bold, color: MyColors.settingsTextVersion),
                );
              },
            ),
            const SizedBox(width: 12),
          ],
        ),
        const Divider(
          height: 2,
          thickness: 0.5,
        )
      ],
    );
  }
}

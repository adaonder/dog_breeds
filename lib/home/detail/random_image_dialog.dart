import 'package:cached_network_image/cached_network_image.dart';
import 'package:dog_breeds/common/constants/assets_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RandomImageDialog extends StatelessWidget {
  final String imageUrl;

  const RandomImageDialog(this.imageUrl, {super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
      child: SingleChildScrollView(
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                height: 0.6.sw,
                width: 0.6.sw,
                fit: BoxFit.cover,
                progressIndicatorBuilder: (context, url, progress) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
            const SizedBox(height: 12),
            InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Image.asset(AssetsImages.close)),
          ],
        ),
      ),
    );
  }
}

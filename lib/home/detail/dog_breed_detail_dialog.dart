
import 'package:dog_breeds/common/constants/assets_images.dart';
import 'package:dog_breeds/common/constants/my_colors.dart';
import 'package:dog_breeds/common/data/bloc/random_image/random_image_bloc.dart';
import 'package:dog_breeds/common/data/model/dog_breeds_model.dart';
import 'package:dog_breeds/home/detail/random_image_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class DogBreedDetailDialog extends StatelessWidget {
  final DogBreedsModel dogBreedsModel;

  const DogBreedDetailDialog(this.dogBreedsModel, {super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12)),
                  child: SizedBox(height: 0.4.sh, width: 0.9.sw, child: dogBreedsModel.image),
                ),
                Positioned(
                  top: 8,
                  right: 12,
                  child: InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Image.asset(
                        AssetsImages.cancel,
                        height: 32,
                      )),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Breed",
                style: GoogleFonts.roboto(fontSize: 25, color: MyColors.blueD3, fontWeight: FontWeight.bold),
              ),
            ),
            const Divider(
              height: 2,
              thickness: 0.5,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                dogBreedsModel.breedName ?? "Breed",
                style: GoogleFonts.roboto(fontSize: 18, fontWeight: FontWeight.w500),
              ),
            ),
            const Divider(
              height: 2,
              thickness: 0.5,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Sub Breed",
                style: GoogleFonts.roboto(fontSize: 25, color: MyColors.blueD3, fontWeight: FontWeight.bold),
              ),
            ),
            const Divider(
              height: 2,
              thickness: 0.5,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Sub Breed 1",
                style: GoogleFonts.roboto(fontSize: 18, fontWeight: FontWeight.w500),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Sub Breed 2",
                style: GoogleFonts.roboto(fontSize: 18, fontWeight: FontWeight.w500),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: BlocConsumer<RandomImageBloc, RandomImageState>(
                      listener: (context, state) {
                        debugPrint("state: $state");
                        if (state is RandomImageLoadedState) {
                          debugPrint("imageUrl: ${state.imageUrl}");

                          showCupertinoModalPopup(
                            context: context,
                            builder: (context) {
                              return RandomImageDialog(state.imageUrl);
                            },
                            barrierColor: Colors.transparent
                          );
                        }
                      },
                      builder: (context, state) {
                        return ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: MyColors.buttonBG,
                              minimumSize: const Size(60, 60),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                          onPressed: () {
                            debugPrint("Test 1 : ${dogBreedsModel.breedName}");

                            context.read<RandomImageBloc>().add(FetchRandomImageEvent(dogBreedsModel.breedName!));
                          },
                          child: Text(
                            "Generate",
                            style: GoogleFonts.darkerGrotesque(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

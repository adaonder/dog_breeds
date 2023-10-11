import 'package:dog_breeds/common/constants/assets_images.dart';
import 'package:dog_breeds/common/constants/my_colors.dart';
import 'package:dog_breeds/common/data/model/dog_breeds_model.dart';
import 'package:dog_breeds/home/detail/dog_breed_detail_dialog.dart';
import 'package:dog_breeds/home/expandable_text_field.dart';
import 'package:dog_breeds/settings/settings_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<DogBreedsModel>? dogBreeds = [];
  String searchText = "";

  @override
  Widget build(BuildContext context) {
    dogBreeds = ModalRoute.of(context)?.settings.arguments as List<DogBreedsModel>?;

    debugPrint("dogBreeds: $dogBreeds");
    debugPrint("dogBreeds size: ${dogBreeds?.length}");

    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(
            "App Nation",
            textAlign: TextAlign.center,
            style: GoogleFonts.roboto(textStyle: const TextStyle(fontWeight: FontWeight.w900)),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
        ),
        body: SafeArea(
          child: buildBody(),
        ),
      ),
    );
  }

  buildBody() {
    return Stack(
      children: [
        buildDogs(),
        ExpandableTextField(
          child: TextField(
            decoration: InputDecoration(
              counterText: "",
              border: const OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.zero),
              hintText: "Search",
              hintStyle: GoogleFonts.roboto(color: MyColors.searchText, fontWeight: FontWeight.w500),
            ),
            maxLines: 200,
            onChanged: (value) {
              //debugPrint("text: $value");
              searchText = value;
              setState(() {});
            },
          ),
        ),
        buildBottomBar()
      ],
    );
  }

  Widget buildBottomBar() {
    return Positioned(
        bottom: 0,
        child: Container(
          width: 1.sw,
          height: 98,
          decoration: BoxDecoration(image: DecorationImage(image: Image.asset(AssetsImages.tab).image, fit: BoxFit.fill)),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    debugPrint("Home");
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(AssetsImages.home, height: 32),
                      Text("Home", style: GoogleFonts.roboto(textStyle: const TextStyle(fontSize: 12)))
                    ],
                  ),
                ),
              ),
              Container(width: 2, height: 24, color: MyColors.divider),
              Expanded(
                child: InkWell(
                  onTap: () {
                    debugPrint("Settings");
                    //Navigator.pushNamed(context, Parameters.pageSettings);
                    showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return const SettingsPage();
                        },
                        isScrollControlled: true,
                        useSafeArea: true);
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(AssetsImages.settings, height: 32),
                      Text(
                        "Settings",
                        style: GoogleFonts.roboto(textStyle: const TextStyle(fontSize: 12)),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  Widget buildDogs() {
    final currentDogBreeds = filterDogBreeds();

    return GridView.builder(
      itemCount: currentDogBreeds.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
      ),
      itemBuilder: (context, index) {
        var currentData = currentDogBreeds[index];
        return InkWell(
          onTap: () {
            showCupertinoModalPopup(
              context: context,
              builder: (context) {
                return DogBreedDetailDialog(currentData);
              },
            );
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Stack(
              fit: StackFit.expand,
              children: [
                currentData.image,
                Positioned(
                  left: 12,
                  bottom: 12,
                  child: Text(
                    currentData.breedName ?? "Breed",
                    style: GoogleFonts.roboto(textStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 16)),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      padding: const EdgeInsets.fromLTRB(12, 0, 12, 100),
    );
  }

  List<DogBreedsModel> filterDogBreeds() {
    List<DogBreedsModel> currentList = [];

    for (DogBreedsModel dogBreed in dogBreeds ?? []) {
      if (dogBreed.breedName!.contains(searchText)) {
        currentList.add(dogBreed);
      }
    }

    return currentList;
  }
}

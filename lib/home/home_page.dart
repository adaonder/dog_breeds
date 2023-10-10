import 'package:dog_breeds/common/data/model/dog_breeds_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final dogBreeds = ModalRoute.of(context)?.settings.arguments as List<DogBreedsModel>?;

    debugPrint("dogBreeds: $dogBreeds");
    debugPrint("dogBreeds size: ${dogBreeds?.length}");

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(
          "App Nation",
          textAlign: TextAlign.center,
          style: GoogleFonts.roboto(textStyle: const TextStyle(fontWeight: FontWeight.w900)),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: buildBody(dogBreeds),
      ),
    );
  }

  buildBody(List<DogBreedsModel>? dogBreeds) {
    return GridView.builder(
      itemCount: dogBreeds?.length ?? 0,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
      ),
      itemBuilder: (context, index) {
        var currentData = dogBreeds![index];
        return ClipRRect(
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
                  )),
            ],
          ),
        );
      },
      padding: const EdgeInsets.all(12),
    );
  }
}

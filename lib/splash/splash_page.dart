import 'package:dog_breeds/common/constants/assets_images.dart';
import 'package:dog_breeds/common/constants/parameters.dart';
import 'package:dog_breeds/common/data/bloc/dogs/dogs_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    context.read<DogsBloc>().add(FetchDogsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: buildBody(),
    );
  }

  Widget buildBody() {
    return BlocConsumer<DogsBloc, DogsState>(
      listener: (context, state) {
        if (state is DogsLoadedState) {
          debugPrint("Verileri geldi: ${state.apiResponse.message}");
          Navigator.pushReplacementNamed(context, Parameters.pageHome, arguments: state.apiResponse.message);
        }
      },
      builder: (context, state) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (state is DogsLoadingState) ...[
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CircularProgressIndicator(),
                ),
              ],
              Image.asset(AssetsImages.splashLogo, width: 0.2.sw),
              if (state is DogsErrorState) ...[
                Text("Hata oluştu.. : ${state.toString()}"),
              ],
            ],
          ),
        );
      },
    );
  }
}

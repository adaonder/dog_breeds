import 'package:dog_breeds/common/data/bloc/dogs/dogs_bloc.dart';
import 'package:dog_breeds/common/data/bloc/random_image/random_image_bloc.dart';
import 'package:dog_breeds/common/data/getit/locator.dart';
import 'package:dog_breeds/common/util/route_generator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  setupLocator();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((value) {
    runApp(ScreenUtilInit(
        designSize: const Size(1920, 1080),
        builder: (BuildContext context, Widget? child) {
          //For language
          return initProvider();
        }));
  });
}

Widget initProvider() {
  ///Multi Bloc
  return MultiBlocProvider(providers: [
    BlocProvider(
      create: (context) {
        return DogsBloc();
      },
    ),
    BlocProvider(
      create: (context) {
        return RandomImageBloc();
      },
    ),
  ], child: const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '\$appNation',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      onGenerateRoute: RouteGenerator.routeGenerator,
    );
  }
}

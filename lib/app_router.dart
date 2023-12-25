import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'business_logic/charater_cubit.dart';
import 'constants/strings.dart';
import 'data/models/character_model.dart';
import 'data/repository/character_repository.dart';
import 'data/wep_servies/character_wep_services.dart';
import 'presentaions/screens/character_details_screen.dart';
import 'presentaions/screens/charcter_screen.dart';

class AppRouter {
  late CharacterRepository characterRepository;
  late CharaterCubit charaterCubit;

  AppRouter() {
    characterRepository =
        CharacterRepository(characterWebServices: CharacterWebServices());
    charaterCubit = CharaterCubit(characterRepository);
  }
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case characterScreen:
        return MaterialPageRoute(
            builder: (_) =>  BlocProvider(
                  create: (context) => charaterCubit,
                  child: const CharacterScreen(),
                ));
      case characterDetailsScreen:
          final character =  settings.arguments as Results;

        return MaterialPageRoute(
            builder: (_) =>  CharacterDetailsScreen(character : character));
    }
    return null;
  }
}

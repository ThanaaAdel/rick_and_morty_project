import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_project/business_logic/charater_cubit.dart';
import 'package:rick_and_morty_project/constants/strings.dart';
import 'package:rick_and_morty_project/data/models/character_model.dart';
import 'package:rick_and_morty_project/data/repository/character_repository.dart';
import 'package:rick_and_morty_project/data/wep_servies/character_wep_services.dart';
import 'package:rick_and_morty_project/presentaions/screens/character_details_screen.dart';
import 'package:rick_and_morty_project/presentaions/screens/charcter_screen.dart';

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

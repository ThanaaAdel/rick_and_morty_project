import '../wep_servies/character_wep_services.dart';

import '../models/character_model.dart';

class CharacterRepository{
  final CharacterWebServices characterWebServices;

  CharacterRepository({required this.characterWebServices});
  Future<Character> getAllCharacters() async{
    Map<String,dynamic> characters = await characterWebServices.getAllCharacters();
    print("the data from repo : ${characters}");
return Character.fromJson(characters);
  }

}
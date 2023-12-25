
import 'package:bloc/bloc.dart';
import 'package:rick_and_morty_project/data/models/character_model.dart';
import 'package:rick_and_morty_project/data/repository/character_repository.dart';

part 'charater_state.dart';

class CharaterCubit extends Cubit<CharaterState> {
  CharaterCubit(this.characterRepository) : super(CharaterInitial());
  final CharacterRepository characterRepository; 

 void getCharacters() {
    characterRepository.getAllCharacters().then((character){
     emit(CharacterLoaded(character));

   });

  }
}

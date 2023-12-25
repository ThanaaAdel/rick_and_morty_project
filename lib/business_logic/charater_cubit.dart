
import 'package:bloc/bloc.dart';
import '../data/models/character_model.dart';
import '../data/repository/character_repository.dart';

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

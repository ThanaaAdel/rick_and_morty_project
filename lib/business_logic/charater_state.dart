part of 'charater_cubit.dart';

abstract class CharaterState {}

class CharaterInitial extends CharaterState {}

class CharacterLoaded extends CharaterState {
  final Character character;

  CharacterLoaded(this.character);
}

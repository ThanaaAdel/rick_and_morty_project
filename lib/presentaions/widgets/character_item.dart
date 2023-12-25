import 'package:flutter/material.dart';
import 'package:rick_and_morty_project/constants/colors.dart';
import 'package:rick_and_morty_project/data/models/character_model.dart';

import '../../constants/strings.dart';

class CharacterItem extends StatelessWidget {
  const CharacterItem({super.key, required this.character});
  final Results character;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsetsDirectional.fromSTEB(4, 4, 4, 4),
      padding: const EdgeInsetsDirectional.fromSTEB(4, 4, 4, 4),
      decoration: BoxDecoration(
        color: MyColors.whiteColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        onTap: (){
          Navigator.pushNamed(context, characterDetailsScreen,arguments: character);

        },
        child: GridTile(
            footer: Container(width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 15),
              color: Colors.black45,
              alignment: Alignment.bottomCenter,
              child: Text(character.name,
              maxLines: 2,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(height: 1.3,fontSize: 18,color: MyColors.whiteColor,
              fontWeight: FontWeight.bold,

              ),
              ),
            ),
            child: Hero(
              tag: character.id,
              child: Container(
        child: character.image.isNotEmpty?
        FadeInImage.assetNetwork(
          width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
              placeholder: 'assets/images/Animation - 1703426463975.gif',
              image: character.image) : Image.asset('assets/images/No-image-available.jpg'),
        ),
            )),
      ),
    );
  }
}

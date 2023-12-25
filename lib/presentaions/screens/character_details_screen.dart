import 'package:flutter/material.dart';
import '../../constants/colors.dart';
import '../../data/models/character_model.dart';

class CharacterDetailsScreen extends StatelessWidget {
  const CharacterDetailsScreen({super.key, required this.character});
  final Results character;
  Widget buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 600,
      pinned: true,
      stretch: true,
      backgroundColor: MyColors.greyColor,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          character.name,
          style: const TextStyle(color: MyColors.whiteColor),
          textAlign: TextAlign.start,
        ),
        background: Hero(
          tag: character.id,
          child: Image.network(character.image,fit: BoxFit.cover,),
        ),
      ),
    );
  }
Widget characterInfo(String title, String value){
    return RichText(
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
        children: [
          TextSpan(
              text: title,
              style: TextStyle(
                color: MyColors.whiteColor,
                fontSize: 18,
                fontWeight: FontWeight.bold,

              )
          ),
          TextSpan(
              text: value,
              style: TextStyle(
                color: MyColors.whiteColor,
                fontSize: 16,


              )
          ),
        ]
      ),
    );
}
Widget buildDivider(double endIndent){
    return Divider(
      color: MyColors.yellowColor,
      height: 30,
      thickness: 2,
      endIndent: endIndent,
    );
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.greyColor,
      body: CustomScrollView(
        slivers: [
          buildSliverAppBar(),
          SliverList(delegate: SliverChildListDelegate(
            [
           Container(padding: EdgeInsets.all(8),
           margin: EdgeInsets.fromLTRB(14, 14, 14, 0),
             child: Column(
                 mainAxisAlignment: MainAxisAlignment.start,
                 crossAxisAlignment: CrossAxisAlignment.start,

                 children: [
                   characterInfo("Name : ",character.name),
                    buildDivider(315),
                   characterInfo("Status : ",character.status),
                   buildDivider(280),
                   characterInfo("Location : ",character.location.name),
                   buildDivider(220),
                   characterInfo("Episode : ",character.episode.join(' / ')),
                   buildDivider(250),
                   characterInfo("Created : ",character.created),
                   buildDivider(200),
                   SizedBox(height: 500,),
                 ]),
           )
            ]
          )),
        ],
      ),
    );
  }
}

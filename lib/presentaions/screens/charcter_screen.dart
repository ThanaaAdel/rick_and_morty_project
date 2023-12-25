import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import '../../business_logic/charater_cubit.dart';
import '../../constants/colors.dart';
import '../../data/models/character_model.dart';
import '../widgets/character_item.dart';

class CharacterScreen extends StatefulWidget {
  const CharacterScreen({super.key});

  @override
  State<CharacterScreen> createState() => _CharacterScreenState();
}

class _CharacterScreenState extends State<CharacterScreen> {
  late List<Results> allCharacters;
  List<Results> searchForCharacters = [];
  bool _isSearching = false;
  final _searchController = TextEditingController();
  @override
  void initState() {
    BlocProvider.of<CharaterCubit>(context).getCharacters();
    super.initState();
  }

  void addSearchedForItemsToSearchesList(String searchTerm) {
    searchForCharacters = allCharacters
        .where((character) =>
            character.name.toLowerCase().startsWith(searchTerm.toLowerCase()))
        .toList();
    setState(() {});
  }

  Widget _buildSearchField() {
    return TextField(
      style: TextStyle(color: MyColors.greyColor, fontSize: 18),
      controller: _searchController,
      maxLines: 2,
      cursorColor: MyColors.greyColor,
      decoration: const InputDecoration(
        hintText: 'Find a Character ...',
        border: InputBorder.none,
        hintStyle: TextStyle(color: MyColors.greyColor, fontSize: 18),
      ),
      onChanged: (searchTerm) {
        addSearchedForItemsToSearchesList(searchTerm);
      },
    );
  }

  List<Widget> _buildAppBarActions() {
    if (_isSearching) {
      return [
        IconButton(
          onPressed: () {
            _clearSearch();
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.clear,
            color: MyColors.greyColor,
          ),
        )
      ];
    } else {
      return [
        IconButton(
          onPressed: () {
            _startSearching();
          },
          icon: const Icon(
            Icons.search,
            color: MyColors.greyColor,
          ),
        )
      ];
    }
  }

  void _startSearching() {
    ModalRoute.of(context)!
        .addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearching));
    setState(() {
      _isSearching = true;
    });
  }

  void _stopSearching() {
    _clearSearch();
    setState(() {
      _isSearching = false;
    });
  }

  void _clearSearch() {
    setState(() {
      _searchController.clear();
    });
  }

  Widget buildCharacterList() {
    return GridView.builder(
        itemCount: _searchController.text.isEmpty
            ? allCharacters.length
            : searchForCharacters.length,
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        itemBuilder: (context, index) {
          return CharacterItem(
            character: _searchController.text.isEmpty
                ? allCharacters[index]
                : searchForCharacters[index],
          );
        },
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 2 / 3,
          crossAxisSpacing: 1,
          mainAxisSpacing: 1,
        ));
  }

  Widget buildLoadedWidget() {
    return SingleChildScrollView(
      child: Container(
          color: MyColors.greyColor,
          child: Column(
            children: [
              buildCharacterList(),
            ],
          )),
    );
  }

  Widget showProgressIndicator() {
    return const Center(
        child: CircularProgressIndicator(
      color: MyColors.yellowColor,
    ));
  }

  Widget buildBlockWidget() {
    return BlocBuilder<CharaterCubit, CharaterState>(
      builder: (context, state) {
        if (state is CharacterLoaded) {
          allCharacters = (state).character.results;
          return buildLoadedWidget();
        } else {
          return showProgressIndicator();
        }
      },
    );
  }

  Widget buildAppBarTitle() {
    return const Text(
      'Character',
      style: TextStyle(color: MyColors.greyColor),
    );
  }

  Widget buildNoInternetWidget() {
    return Center(
      child: Container(
          child: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          Text(
            'Can\`t connect .. check internet',
            style: TextStyle(fontSize: 22, color: MyColors.greyColor),
          ),
          Image.asset('assets/images/No-image-available.jpg'),
        ],
      )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: _isSearching
              ? const BackButton(
                  color: MyColors.greyColor,
                )
              : Container(),
          title: _isSearching ? _buildSearchField() : buildAppBarTitle(),
          actions: _buildAppBarActions(),
          backgroundColor: MyColors.yellowColor),
      body: OfflineBuilder(
        connectivityBuilder: (
          BuildContext context,
          ConnectivityResult connectivity,
          Widget child,
        ) {
          final bool connected = connectivity != ConnectivityResult.none;
          if (connected) {
            return buildBlockWidget();
          } else {
            return buildNoInternetWidget();
          }
        },
        child: showProgressIndicator(),
      ),
    );
  }
}

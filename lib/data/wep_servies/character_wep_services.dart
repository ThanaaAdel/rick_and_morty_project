import 'package:dio/dio.dart';
import '../../constants/strings.dart';

class CharacterWebServices {
  late Dio dio;
  CharacterWebServices(){
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
      // show the error depag
      connectTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 20), 

    );
    dio = Dio(options);
  }
  Future<Map<String, dynamic>> getAllCharacters() async{

try{
      Response response = await dio.get('character');
    print("the data from web services ${response.data.toString()}");
    return response.data;
}
catch(e){
  print("the error is:${e.toString()}");
  return Map();
}
  }}



import 'package:http/http.dart' as http;

import '../model/api_model.dart';

class RemoteService {
  

  Future<List<Post>?> getPosts() async
  {
    var client = http.Client();
    var url = Uri.parse('https://jsonplaceholder.typicode.com/photos');

    var response = await client.get(url);
     if(response.statusCode == 200){
       var json = response.body;
       return postFromJson(json);
     }
  }
}
import 'package:http/http.dart' as http;
import 'package:crypto/crypto.dart';
import 'dart:convert'; 
import '../templates/user.dart';

class CodeforcesServices {
  String? apiKey;
  String? secret;
  CodeforcesServices({this.apiKey, this.secret});
  checkKey() async {
    if((apiKey == null) || (secret == null)) return false;
    final time =  DateTime.now().millisecondsSinceEpoch~/1000;
    const apiSig = "123456";
    final s = "$apiSig/user.friends?apiKey=$apiKey&time=$time#$secret";
    final bytes = utf8.encode(s);
    final hashed = sha512.convert(bytes);
    final url = "https://codeforces.com/api/user.friends?apiKey=$apiKey&time=$time&apiSig=123456$hashed";
    http.Response response = await http.get(Uri.parse(url));
    if(response.statusCode == 200) {
      var body = jsonDecode(response.body);
      if(body["status"] == "OK") {
        return true;
      }
      else {
        return false;
      }
    }
    else {
      return false;
    }
  }

  Future<User> userInfo(String username) async {
    final url = "https://codeforces.com/api/user.info?handles=$username";
    http.Response response;
    response = await http.get(Uri.parse(url));
    User user = User(handle: "//", contribution: 0, titlePhoto: "//", friendOfCount: 0);
    if(response.statusCode == 200) {
      var body = jsonDecode(response.body);
      if(body["status"] == "OK") {
        var data = body["result"];
        var tempData = data.map((myData) => User.fromJson(myData)).toList();
        return tempData[0];
      }
      else {
        return user;
      }
    }
    else {
      return user;
    }
  }
}
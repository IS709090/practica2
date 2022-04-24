import 'package:practica2/secrets.dart';
import 'package:http/http.dart' as http;

class AuddRepository {
  findSong(String bytesfile) async {
    return await http.post(Uri.parse('https://api.audd.io/'), body: {
      'api_token': auDDAPIKey,
      'audio': bytesfile,
      'return': "lyrics,apple_music,spotify"
    });
  }
}

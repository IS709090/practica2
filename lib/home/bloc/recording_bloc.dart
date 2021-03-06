import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:record/record.dart';

import '../../favorites/songClass.dart';
import '../Audd_repository.dart';
part 'recording_event.dart';
part 'recording_state.dart';

class RecordingBloc extends Bloc<RecordingEvent, RecordingState> {
  final record = Record();
  RecordingBloc() : super(RecordingInitial()) {
    on<RecordingOnSearch>(_onSearch);
    on<RecordingSaveFavorites>(_saveFavorite);
    on<RecordingGetAllFavorites>(_getFavorites);
    on<RecordingRemoveFavorite>(_deleteFavorite);
  }

  FutureOr<void> _onSearch(
      RecordingOnSearch event, Emitter<RecordingState> emit) async {
    // Import package

    // Check and request permission
    bool result = await record.hasPermission();
    if (!result || await record.isRecording()) {
      return;
    }

    emit(RecordingSearching());

    // Start recording
    await record.start();

    // Get the state of the recorder
    // bool isRecording = await record.isRecording();

    await Future.delayed(Duration(seconds: 8));

    // Stop recording
    final String? path = await record.stop();

    final String bytesFile = base64Encode(File(path!).readAsBytesSync());

    final response = await AuddRepository().findSong(bytesFile);

    if (response.statusCode == 200) {
      var jsonContent = jsonDecode(response.body);

      if (jsonContent["status"] == "success" && jsonContent["result"] != null) {
        //     	"result": {
        // "artist": "Imagine Dragons",
        // "title": "Warriors",
        // "album": "Warriors",
        // "release_date": "2014-09-18",
        final artist = jsonContent["result"]['artist'];
        final album = jsonContent["result"]['album'];
        final image =
            jsonContent['result']['spotify']['album']['images'][0]['url'];
        final title = jsonContent["result"]['title'];
        final date = jsonContent["result"]['release_date'];
        final spotifyLink =
            jsonContent["result"]['spotify']['external_urls']['spotify'];
        final appleLink = jsonContent["result"]['apple_music']['url'];
        final listnLink = jsonContent["result"]['song_link'];

        emit(RecordingFound(
            artist: artist,
            name: title,
            date: date,
            album: album,
            spotifyLink: spotifyLink,
            appleMusicLink: appleLink,
            listnLink: listnLink,
            image: image));
      } else {
        print("No se encontro!");
        emit(RecordingNotFound());
        return;
      }
    }
  }

  FutureOr<void> _saveFavorite(
      RecordingSaveFavorites event, Emitter<RecordingState> emit) async {
    var collection = FirebaseFirestore.instance.collection('favoriteSongs');
    var querySnapshot = await collection.get();
    for (var queryDocumentSnapshot in querySnapshot.docs) {
      Map<String, dynamic> datos = queryDocumentSnapshot.data();
      var name = datos['titulo'];
      if (name == event.name) {
        print("Ya se encuentra en tu lista!");
        emit(FavoriteAlreadyExists());
        return;
      }
    }
    var response =
        await FirebaseFirestore.instance.collection("favoriteSongs").add({
      "artista": event.artist,
      "imagen": event.image,
      "link": event.listnLink,
      "titulo": event.name
    });
    final user = await FirebaseFirestore.instance
        .collection("user")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    var favoriteArray = user.data()!["favorites"];
    if (!favoriteArray.contains(response.id)) {
      favoriteArray.add(response.id);
    }
    await FirebaseFirestore.instance
        .collection("user")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({'favorites': favoriteArray});
  }

  _getFavorites(RecordingGetAllFavorites event, Emitter<RecordingState> emit) {
    final usersQuery = FirebaseFirestore.instance
        .collection('favoriteSongs')
        .withConverter<Song>(
          fromFirestore: (snapshot, _) => Song.fromJson(snapshot.data()!),
          toFirestore: (song, _) => song.toJson(),
        );
    print("Hola!");
    print(usersQuery);
    emit(FavoritesLoaded(query: usersQuery));
  }

  FutureOr<void> _deleteFavorite(
      RecordingRemoveFavorite event, Emitter<RecordingState> emit) async {
    final user = await FirebaseFirestore.instance
        .collection("user")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    var favoriteArray = user.data()!["favorites"];
    favoriteArray.remove(event.id);

    await FirebaseFirestore.instance
        .collection("user")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({'favorites': favoriteArray});
    await FirebaseFirestore.instance
        .collection("favoriteSongs")
        .doc(event.id)
        .delete();
  }
}

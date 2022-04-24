part of 'recording_bloc.dart';

abstract class RecordingState extends Equatable {
  const RecordingState();

  @override
  List<Object> get props => [];
}

class RecordingInitial extends RecordingState {}

class RecordingFound extends RecordingState {
  final String artist;
  final String name;
  final String date;
  final String album;
  final String spotifyLink;
  final String appleMusicLink;
  final String listnLink;
  final String image;

  RecordingFound(
      {required this.artist,
      required this.name,
      required this.date,
      required this.album,
      required this.spotifyLink,
      required this.appleMusicLink,
      required this.listnLink,
      required this.image});

  @override
  List<Object> get props => [
        this.artist,
        this.name,
        this.date,
        this.album,
        this.spotifyLink,
        this.appleMusicLink,
        this.listnLink,
        this.image
      ];
}

class RecordingNotFound extends RecordingState {}

class FavoriteAlreadyExists extends RecordingState {}

class FavoriteDeleted extends RecordingState {}

class FavoritesLoaded extends RecordingState {
  final dynamic query;

  FavoritesLoaded({required this.query});

  @override
  List<Object> get props => [this.query];
}

class RecordingSearching extends RecordingState {}

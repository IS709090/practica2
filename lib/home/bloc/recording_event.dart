part of 'recording_bloc.dart';

abstract class RecordingEvent extends Equatable {
  const RecordingEvent();

  @override
  List<Object> get props => [];
}

class RecordingOnSearch extends RecordingEvent {}

class RecordingGetAllFavorites extends RecordingEvent {}

class RecordingRemoveFavorite extends RecordingEvent {
  final String id;

  RecordingRemoveFavorite({required this.id});

  @override
  List<Object> get props => [this.id];
}

class RecordingSaveFavorites extends RecordingEvent {
  final String artist;
  final String name;

  final String listnLink;
  final String image;

  RecordingSaveFavorites(
      {required this.artist,
      required this.name,
      required this.listnLink,
      required this.image});

  @override
  List<Object> get props =>
      [this.artist, this.name, this.listnLink, this.image];
}

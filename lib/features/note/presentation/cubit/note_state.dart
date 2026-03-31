import '../../data/models/note_model.dart';
import '../../data/models/folder_model.dart';

abstract class NoteState {}

class NoteInitial extends NoteState {}

class NoteLoading extends NoteState {}

class NotesLoaded extends NoteState {
  final List<NoteModel> notes;
  final List<FolderModel> folders;
  NotesLoaded({required this.notes, required this.folders});
}

class NoteActionSuccess extends NoteState {}

class NoteError extends NoteState {
  final String message;
  NoteError(this.message);
}

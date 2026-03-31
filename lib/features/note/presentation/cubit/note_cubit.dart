import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../domain/repositories/note_repository.dart';
import '../../data/models/note_model.dart';
import '../../data/models/folder_model.dart';
import 'note_state.dart';

class NoteCubit extends Cubit<NoteState> {
  final NoteRepository repository;

  NoteCubit({required this.repository}) : super(NoteInitial());

  String? get currentUserId => Supabase.instance.client.auth.currentUser?.id;

  Future<void> getNotes() async {
    if (currentUserId == null) {
      emit(NoteError("User not logged in"));
      return;
    }

    emit(NoteLoading());
    try {
      final notes = await repository.getNotes(currentUserId!);
      final folders = await repository.getFolders(currentUserId!);
      emit(NotesLoaded(notes: notes, folders: folders));
    } catch (e) {
      emit(NoteError(e.toString()));
    }
  }

  Future<void> addNote({
    required String title,
    required String content,
    String folder = 'Personal',
  }) async {
    if (currentUserId == null) {
      emit(NoteError("User not logged in"));
      return;
    }

    emit(NoteLoading());
    try {
      final note = NoteModel(
        id: '', 
        title: title,
        content: content,
        folder: folder,
        createdAt: DateTime.now(),
        userId: currentUserId!,
      );

      await repository.addNote(note);
      emit(NoteActionSuccess());
      getNotes(); 
    } catch (e) {
      emit(NoteError(e.toString()));
    }
  }

  Future<void> updateNote({
    required String id,
    required String title,
    required String content,
    required String folder,
  }) async {
    if (currentUserId == null) return;

    emit(NoteLoading());
    try {
      final note = NoteModel(
        id: id,
        title: title,
        content: content,
        folder: folder,
        createdAt: DateTime.now(),
        userId: currentUserId!,
      );

      await repository.updateNote(note);
      emit(NoteActionSuccess());
      getNotes();
    } catch (e) {
      emit(NoteError(e.toString()));
    }
  }

  Future<void> deleteNote(String noteId) async {
    emit(NoteLoading());
    try {
      await repository.deleteNote(noteId);
      getNotes(); 
    } catch (e) {
      emit(NoteError(e.toString()));
    }
  }

  Future<void> addFolder(String name, String color) async {
    if (currentUserId == null) return;

    emit(NoteLoading());
    try {
      final folder = FolderModel(
        id: '',
        name: name,
        color: color,
        userId: currentUserId!,
        createdAt: DateTime.now(),
      );
      await repository.addFolder(folder);
      emit(NoteActionSuccess());
      getNotes(); 
    } catch (e) {
      emit(NoteError(e.toString()));
    }
  }
}

import '../../data/models/note_model.dart';
import '../../data/models/folder_model.dart';

abstract class NoteRepository {
  Future<List<NoteModel>> getNotes(String userId);
  Future<NoteModel> addNote(NoteModel note);
  Future<void> updateNote(NoteModel note);
  Future<void> deleteNote(String noteId);

  // Folder methods
  Future<List<FolderModel>> getFolders(String userId);
  Future<FolderModel> addFolder(FolderModel folder);
  Future<void> deleteFolder(String folderId);
}

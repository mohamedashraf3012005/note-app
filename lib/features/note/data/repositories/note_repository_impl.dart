import '../../domain/repositories/note_repository.dart';
import '../datasources/note_remote_data_source.dart';
import '../models/note_model.dart';
import '../models/folder_model.dart';

class NoteRepositoryImpl implements NoteRepository {
  final NoteRemoteDataSource remoteDataSource;

  NoteRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<NoteModel>> getNotes(String userId) async {
    return await remoteDataSource.getNotes(userId);
  }

  @override
  Future<NoteModel> addNote(NoteModel note) async {
    return await remoteDataSource.addNote(note);
  }

  @override
  Future<void> updateNote(NoteModel note) async {
    await remoteDataSource.updateNote(note);
  }

  @override
  Future<void> deleteNote(String noteId) async {
    await remoteDataSource.deleteNote(noteId);
  }

  @override
  Future<List<FolderModel>> getFolders(String userId) async {
    return await remoteDataSource.getFolders(userId);
  }

  @override
  Future<FolderModel> addFolder(FolderModel folder) async {
    return await remoteDataSource.addFolder(folder);
  }

  @override
  Future<void> deleteFolder(String folderId) async {
    await remoteDataSource.deleteFolder(folderId);
  }
}

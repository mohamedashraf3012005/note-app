import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/note_model.dart';
import '../models/folder_model.dart';

abstract class NoteRemoteDataSource {
  Future<List<NoteModel>> getNotes(String userId);
  Future<NoteModel> addNote(NoteModel note);
  Future<void> updateNote(NoteModel note);
  Future<void> deleteNote(String noteId);
  
  // Folders
  Future<List<FolderModel>> getFolders(String userId);
  Future<FolderModel> addFolder(FolderModel folder);
  Future<void> deleteFolder(String folderId);
}

class NoteRemoteDataSourceImpl implements NoteRemoteDataSource {
  final SupabaseClient client;

  NoteRemoteDataSourceImpl({required this.client});

  @override
  Future<List<NoteModel>> getNotes(String userId) async {
    final response = await client
        .from('notes')
        .select()
        .eq('user_id', userId)
        .order('created_at', ascending: false);
    
    return (response as List).map((json) => NoteModel.fromJson(json)).toList();
  }

  @override
  Future<NoteModel> addNote(NoteModel note) async {
    final response = await client.from('notes').insert(note.toJson()).select().single();
    return NoteModel.fromJson(response);
  }

  @override
  Future<void> updateNote(NoteModel note) async {
    await client.from('notes').update(note.toJson()).eq('id', note.id);
  }

  @override
  Future<void> deleteNote(String noteId) async {
    await client.from('notes').delete().eq('id', noteId);
  }

  @override
  Future<List<FolderModel>> getFolders(String userId) async {
    final response = await client
        .from('folders')
        .select()
        .eq('user_id', userId)
        .order('created_at', ascending: false);
    
    return (response as List).map((json) => FolderModel.fromJson(json)).toList();
  }

  @override
  Future<FolderModel> addFolder(FolderModel folder) async {
    final response = await client.from('folders').insert(folder.toJson()).select().single();
    return FolderModel.fromJson(response);
  }

  @override
  Future<void> deleteFolder(String folderId) async {
    await client.from('folders').delete().eq('id', folderId);
  }
}

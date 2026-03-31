import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task2/features/note/presentation/cubit/note_cubit.dart';
import 'package:task2/features/note/presentation/cubit/note_state.dart';
import 'package:task2/features/note/presentation/widgets/card_diary.dart';
import 'package:task2/features/note/presentation/widgets/add_new_note.dart';
import 'package:task2/features/note/presentation/widgets/custom_appbar.dart';

class FolderDetailPage extends StatelessWidget {
  final String folderName;
  const FolderDetailPage({super.key, required this.folderName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: folderName,
        firstIcon: Icons.arrow_back,
        secondIcon: Icons.more_vert,
        colorText: const Color(0xff002D95),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: BlocBuilder<NoteCubit, NoteState>(
          builder: (context, state) {
            if (state is NotesLoaded) {
              final folderNotes = state.notes.where((n) => n.folder == folderName).toList();
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 12),
                  AddNewNote(title: folderName, subtitle: "${folderNotes.length} Notes"),
                  const SizedBox(height: 24),
                  const Text(
                    "Notes",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Expanded(
                    child: folderNotes.isEmpty
                        ? const Center(child: Text("No notes in this folder."))
                        : ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemCount: folderNotes.length,
                            itemBuilder: (context, index) {
                              final note = folderNotes[index];
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: CardDiary(
                                  note: note,
                                  color: const Color(0xff216AFD),
                                ),
                              );
                            },
                          ),
                  ),
                ],
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: const Color(0xff1660FB),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}

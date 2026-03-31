import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task2/features/note/presentation/cubit/note_cubit.dart';
import 'package:task2/features/note/presentation/cubit/note_state.dart';
import 'package:task2/features/note/presentation/screens/add_edit_note_page.dart';
import 'package:task2/features/note/presentation/widgets/card_diary.dart';
import 'package:task2/features/note/presentation/widgets/card_folders.dart';
import 'package:task2/features/note/presentation/widgets/create_new_button.dart';
import 'package:task2/features/note/presentation/widgets/custom_appbar.dart';

class MyFoldersPage extends StatelessWidget {
  const MyFoldersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8FA),
      appBar: CustomAppBar(
        title: 'My Folders',
        firstIcon: Icons.menu,
        secondIcon: Icons.notifications_outlined,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SearchBar(
              constraints: const BoxConstraints(maxHeight: 50),
              leading: const Icon(Icons.search),
              trailing: [
                IconButton(icon: const Icon(Icons.mic), onPressed: () {}),
              ],
              hintText: 'Search...',
              elevation: const WidgetStatePropertyAll(0),
              backgroundColor: WidgetStatePropertyAll(Colors.grey.shade200),
              shape: WidgetStatePropertyAll(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              ),
            ),
            const SizedBox(height: 20),
            CreateNewButton(
              title: 'Create New Folder',
              firstIcon: Icons.add,
              onPressed: () {
                _showAddFolderDialog(context);
              },
            ),
            const SizedBox(height: 24),
            BlocBuilder<NoteCubit, NoteState>(
              builder: (context, state) {
                if (state is NotesLoaded) {
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: state.folders.map((folder) {
                        final notesCount = state.notes
                            .where((n) => n.folder == folder.name)
                            .length;
                        return Padding(
                          padding: const EdgeInsets.only(right: 16),
                          child: CardFolders(
                            title: folder.name,
                            notesCount: '$notesCount notes',
                            color: Color(
                              int.parse(
                                folder.color.replaceFirst('#', '0xFF'),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  );
                }
                return const SizedBox(height: 110);
              },
            ),
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: 4),
                Text(
                  'Recent Notes',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
                TextButton(
                  onPressed: () {},
                  child: Row(
                    children: [
                      Text(
                        'View All',
                        style: TextStyle(
                          fontSize: 18,
                          color: Color(0xFF2753AD),
                          fontWeight: FontWeight.w400,
                        ),
                      ),

                      Icon(
                        Icons.keyboard_arrow_down_outlined,
                        color: Color(0xFF2753AD),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 3),
            BlocBuilder<NoteCubit, NoteState>(
              builder: (context, state) {
                if (state is NoteLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is NotesLoaded) {
                  if (state.notes.isEmpty) {
                    return const Center(child: Text("No notes yet. Create your first note!"));
                  }
                  return Column(
                    children: state.notes.take(5).map((note) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: CardDiary(
                          note: note,
                          color: note.folder == 'Work' ? Colors.green : Colors.blue,
                        ),
                      );
                    }).toList(),
                  );
                } else if (state is NoteError) {
                  return Center(child: Text("Error: ${state.message}"));
                }
                return const SizedBox();
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        backgroundColor: const Color(0xff2C6CFE),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddEditNotePage()),
          );
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  void _showAddFolderDialog(BuildContext context) {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("New Folder"),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(hintText: "Folder Name"),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              if (controller.text.isNotEmpty) {
                context.read<NoteCubit>().addFolder(
                      controller.text,
                      '#216AFD',
                    );
                Navigator.pop(context);
              }
            },
            child: const Text("Create"),
          ),
        ],
      ),
    );
  }
}

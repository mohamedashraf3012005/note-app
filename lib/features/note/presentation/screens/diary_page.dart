import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task2/features/note/data/models/note_model.dart';
import 'package:task2/features/note/presentation/cubit/note_cubit.dart';
import 'package:task2/features/note/presentation/screens/add_edit_note_page.dart';
import 'package:task2/features/note/presentation/widgets/custom_appbar.dart';
import 'package:task2/features/note/presentation/widgets/photo_section.dart';
import 'package:task2/features/note/presentation/widgets/write_box_diary.dart';

class DiaryPage extends StatelessWidget {
  final NoteModel note;
  const DiaryPage({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: note.folder,
        firstIcon: Icons.arrow_back,
        secondIcon: Icons.edit,
        onSecondIconPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddEditNotePage(initialNote: note),
            ),
          );
        },
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.circle, color: Colors.blue, size: 12),
                const SizedBox(width: 8),
                Text(
                  '${note.createdAt.day}/${note.createdAt.month}/${note.createdAt.year}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.delete_outline, color: Colors.red),
                  onPressed: () {
                    _showDeleteConfirmDialog(context);
                  },
                ),
              ],
            ),

            const SizedBox(height: 16),

            WriteBoxDiary(title: note.title, content: note.content),

            const SizedBox(height: 24),

            const Text(
              'Photos',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),

            SizedBox(
              height: 100,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  PhotoSection(imagePath: "assets/images/1.jpg"),
                  const SizedBox(width: 12),
                  PhotoSection(imagePath: "assets/images/2.jpg"),
                  const SizedBox(width: 12),
                  _buildAddPhotoButton(),
                ],
              ),
            ),

            const SizedBox(height: 32),

            const Text(
              'Tags',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),

            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                _TagChip(label: note.folder, color: Colors.blue),
              ],
            ),

            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  void _showDeleteConfirmDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Delete Note"),
        content: const Text("Are you sure you want to delete this note?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              context.read<NoteCubit>().deleteNote(note.id);
              Navigator.pop(context); // close dialog
              Navigator.pop(context); // go back to list
            },
            child: const Text("Delete", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  Widget _buildAddPhotoButton() {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade400, width: 2),
      ),
      child: const Icon(Icons.add_rounded, size: 40, color: Colors.grey),
    );
  }
}

class _TagChip extends StatelessWidget {
  final String label;
  final Color color;

  const _TagChip({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: color.withValues(alpha: 0.4)),
      ),
      child: Text(
        label,
        style: TextStyle(color: color, fontWeight: FontWeight.w600),
      ),
    );
  }
}

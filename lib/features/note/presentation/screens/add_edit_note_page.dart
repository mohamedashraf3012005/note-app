import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task2/features/note/data/models/note_model.dart';
import 'package:task2/features/note/presentation/cubit/note_cubit.dart';
import 'package:task2/features/note/presentation/cubit/note_state.dart';
import 'package:task2/features/note/presentation/widgets/custom_appbar.dart';

class AddEditNotePage extends StatefulWidget {
  final NoteModel? initialNote;
  const AddEditNotePage({super.key, this.initialNote});

  @override
  State<AddEditNotePage> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddEditNotePage> {
  late final TextEditingController _titleController;
  late final TextEditingController _contentController;
  String? _selectedFolder;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.initialNote?.title);
    _contentController =
        TextEditingController(text: widget.initialNote?.content);
    _selectedFolder = widget.initialNote?.folder;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NoteCubit, NoteState>(
      listener: (context, state) {
        if (state is NoteActionSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Note Saved successfully!')),
          );
          Navigator.pop(context); // Go back after saving
        } else if (state is NoteError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      builder: (context, state) {
        final isLoading = state is NoteLoading;
        List<String> folders = [];
        if (state is NotesLoaded) {
          folders = state.folders.map((f) => f.name).toList();
        }
        
        // Ensure selected folder is valid
        if (_selectedFolder == null && folders.isNotEmpty) {
          _selectedFolder = folders.first;
        }

        return Scaffold(
          appBar: CustomAppBar(
            title: widget.initialNote == null ? "Add New Note" : "Edit Note",
            firstIcon: Icons.arrow_back,
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _titleController,
                  decoration: const InputDecoration(
                    hintText: 'Title',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 8),
                  ),
                  style:
                      const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
                const Divider(height: 32),
                TextField(
                  controller: _contentController,
                  maxLines: 11,
                  decoration: const InputDecoration(
                    hintText: 'Start typing your note...',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.zero,
                  ),
                  style: const TextStyle(fontSize: 16, height: 1.5),
                ),
                const SizedBox(height: 16),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.format_align_left),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: const Icon(Icons.attach_file),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: const Icon(Icons.format_italic),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: const Icon(Icons.link),
                        onPressed: () {},
                      ),
                      IconButton(
                          icon: const Icon(Icons.draw), onPressed: () {}),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Folder:',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  initialValue: _selectedFolder,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.folder, color: Colors.blue),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                  ),
                  items: folders.map((folder) {
                    return DropdownMenuItem(value: folder, child: Text(folder));
                  }).toList(),
                  onChanged: (value) {
                    setState(() => _selectedFolder = value);
                  },
                ),
                const SizedBox(height: 24),
                const Text(
                  'Tags',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: [
                    _buildTagChip('Important', Colors.orange),
                    _buildTagChip('Personal', Colors.blue),
                    _buildAddTagButton(),
                  ],
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  height: 54,
                  child: ElevatedButton(
                    onPressed: isLoading
                        ? null
                        : () {
                            final title = _titleController.text.trim();
                            final content = _contentController.text.trim();

                            if (title.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Title cannot be empty')),
                              );
                              return;
                            }

                            if (widget.initialNote == null) {
                              context.read<NoteCubit>().addNote(
                                    title: title,
                                    content: content,
                                    folder: _selectedFolder ?? 'Personal',
                                  );
                            } else {
                              context.read<NoteCubit>().updateNote(
                                    id: widget.initialNote!.id,
                                    title: title,
                                    content: content,
                                    folder: _selectedFolder ?? 'Personal',
                                  );
                            }
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : Text(
                            widget.initialNote == null
                                ? 'Save Note'
                                : 'Update Note',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTagChip(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: color.withValues(alpha: 0.5)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: TextStyle(color: color, fontWeight: FontWeight.w600),
          ),
          const SizedBox(width: 4),
          Icon(Icons.close, size: 16, color: color),
        ],
      ),
    );
  }

  Widget _buildAddTagButton() {
    return GestureDetector(
      onTap: () {
        // Add tag logic
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(30),
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.add, size: 18, color: Colors.grey),
            SizedBox(width: 4),
            Text(
              'Add Tag',
              style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }
}

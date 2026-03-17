import 'package:flutter/material.dart';
import 'package:task2/features/note/presentation/widgets/CustomAppbar.dart';

class AddEditNotePage extends StatefulWidget {
  const AddEditNotePage({super.key});

  @override
  State<AddEditNotePage> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddEditNotePage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  String? _selectedFolder = 'Personal';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Add New Note",
        firstIcon: (Icons.arrow_back),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title field
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                hintText: 'Title',
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: 8),
              ),
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),

            const Divider(height: 32),

            // Content field
            TextField(
              controller: _contentController,
              maxLines: 12,
              decoration: const InputDecoration(
                hintText: 'Start typing your note...',
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
              ),
              style: const TextStyle(fontSize: 16, height: 1.5),
            ),

            const SizedBox(height: 16),

            // Toolbar
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
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
                  IconButton(icon: const Icon(Icons.link), onPressed: () {}),
                  IconButton(icon: const Icon(Icons.draw), onPressed: () {}),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Folder / Boler section
            const Text(
              'Folder:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),

            DropdownButtonFormField<String>(
              value: _selectedFolder,
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
              items: const [
                DropdownMenuItem(value: 'Personal', child: Text('Personal')),
                DropdownMenuItem(value: 'Work', child: Text('Work')),
                DropdownMenuItem(value: 'Ideas', child: Text('Ideas')),
              ],
              onChanged: (value) {
                setState(() => _selectedFolder = value);
              },
            ),

            const SizedBox(height: 24),

            // Tags section
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

            const SizedBox(height: 40),

            // Save button
            SizedBox(
              width: double.infinity,
              height: 54,
              child: ElevatedButton(
                onPressed: () {
                  // Save logic here
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Save Note',
                  style: TextStyle(
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
  }

  Widget _buildTagChip(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: color.withOpacity(0.5)),
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

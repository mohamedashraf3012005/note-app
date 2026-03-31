import 'package:flutter/material.dart';
import 'package:task2/features/note/presentation/screens/diary_page.dart';
import 'package:task2/features/note/data/models/note_model.dart';

class CardDiary extends StatelessWidget {
  final NoteModel note;
  final Color color;

  const CardDiary({
    super.key,
    required this.note,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DiaryPage(note: note)),
        );
      },
      child: Card(
        color: const Color(0xFFFEFEFE),
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: ListTile(
          contentPadding: const EdgeInsets.all(0),
          leading: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.all(0),
                width: 7,
                height: 45,
                decoration: BoxDecoration(color: color),
              ),
            ],
          ),
          title: Text(
            note.title,
            style: const TextStyle(
              fontSize: 22,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                note.folder,
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const Spacer(),
              Text(
                "${note.createdAt.day}/${note.createdAt.month}/${note.createdAt.year}",
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          trailing: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert),
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}

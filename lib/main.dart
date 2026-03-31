import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:task2/features/note/data/datasources/note_remote_data_source.dart';
import 'package:task2/features/note/data/repositories/note_repository_impl.dart';
import 'package:task2/features/note/presentation/cubit/note_cubit.dart';
import 'package:task2/features/on_boarding/presentation/screens/onboarding_screen.dart';
import 'package:task2/features/note/presentation/screens/my_folders_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: "https://vmwmmweuxhneputthgem.supabase.co",
    anonKey:
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InZtd21td2V1eGhuZXB1dHRoZ2VtIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzE4MjE4MjYsImV4cCI6MjA4NzM5NzgyNn0.ArKTo4rvY_b4fkN66bXoXsXXHi47cmlc_cMugW19KBQ",
  );

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => NoteCubit(
            repository: NoteRepositoryImpl(
              remoteDataSource: NoteRemoteDataSourceImpl(
                client: Supabase.instance.client,
              ),
            ),
          )..getNotes(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Supabase.instance.client.auth.currentSession == null
            ? const OnboardingScreen()
            : const MyFoldersPage(),
      ),
    );
  }
}

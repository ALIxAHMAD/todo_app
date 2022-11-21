import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:todo_app/features/todo/data/datasources/hive/data_base.dart';
import 'package:todo_app/features/todo/data/models/todo_model.dart';
import 'package:todo_app/features/todo/data/repositories/todo_repository_imp.dart';
import 'features/todo/domain/repositories/todo_repository.dart';
import 'features/todo/presentation/pages/todo_page.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final applicationDocumentsDirectory =
      await path_provider.getApplicationDocumentsDirectory();
  Hive.init(applicationDocumentsDirectory.path);
  Hive.registerAdapter(ToDoModelAdapter());
  await Hive.openBox<ToDoModel>('ToDo');
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final localDataBase = HiveDataBase();

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<ToDoRepository>(
      create: (context) {
        return ToDoRepositoryImp(
          dataSource: localDataBase,
        );
      },
      child: MaterialApp(
        home: const HomePage(),
        theme: ThemeData(primarySwatch: Colors.green),
      ),
    );
  }
}

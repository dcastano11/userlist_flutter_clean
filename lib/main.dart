import 'package:flutter/material.dart';
import 'package:userlist_flutter_clean/constants.dart';
import 'package:userlist_flutter_clean/data/models/user_model.dart';
import 'package:userlist_flutter_clean/data/source/user_local_data_source.dart';
import 'package:userlist_flutter_clean/data/source/user_remote_data_source.dart';
import 'package:userlist_flutter_clean/data/repositories/user_repository.dart';
import 'package:userlist_flutter_clean/presentation/views/main_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';

final UserLocalDataSource localDataSource = UserLocalDataSourceImpl();
final UserRemoteDataSource remoteDataSource = UserRemoteDataSourceImpl();
final UserRepositoryImpl dataRepository = UserRepositoryImpl(
    localDataSource: localDataSource, remoteDataSource: remoteDataSource);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(UserAdapter());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Prueba de Ingreso',
      theme: ThemeData(
        primaryColor: Constants.mainGreen,
        primarySwatch: Constants.mainGreenSwatch,
        iconTheme: IconThemeData(
          color: Constants.mainGreen,
        ),
      ),
      home: MainScreen(
        userRepository: dataRepository,
      ),
    );
  }
}

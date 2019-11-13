import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:toads_and_frogs/backend/score.dart';

class SaveData {
  SaveData();
  void go() async {
    final Future<Database> database = openDatabase(
      join(await getDatabasesPath(), 'score.db'),
    );
  }
}

class SaveScore{

  SaveScore({this.score});
  final Score score;

  String scoreStringyfy() {
    return '${score.frogHop} ${score.toadHop}';
  }
  
}

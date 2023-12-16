import 'dart:io' as io;
import 'package:d_quotes/models/favorite_quote.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';

class DBHelper{
  static Database? _db;
  
  Future<Database?> get db async{
    if(_db != null){
      return _db;
    }
    _db = await initDB();
    return null;
  }

  initDB() async{
    io.Directory  documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path,"Todo.db");
    var db = await openDatabase(
      path,
      version: 1,
      onCreate: _createDatabase 
    );
    return db;
  }

  _createDatabase(Database db,int version) async{
    await db.execute(
      "CREATE TABLE myfavorites(id TEXT PRIMARY KEY, content TEXT, author TEXT, isFavorite INTEGER)"
    );
  }

  // Inserting favorite quote with its id and author
  Future<FavoriteQuote> insert(FavoriteQuote favoriteQuote) async{
    var dbClient = await db;
    await dbClient?.insert('myfavorites',favoriteQuote.toMap());
    return favoriteQuote;
  }

  // Retrieving favorites from database

  Future<List<FavoriteQuote>> getDataList() async{
    await db;

    final List<Map<String,Object?>> QueryResult = await _db!.rawQuery('SELECT * FROM myfavorites');
    return QueryResult.map((e) => FavoriteQuote.fromMap(e)).toList();

  }

  // Retrieving specific quote from database
  Future<int> checkFavorite(String id) async{
    await db;

    final List<Map<String,Object?>> result= await _db!.rawQuery('SELECT * FROM myfavorites WHERE id = ?',[id]);
    return result.length;
  }

  // Deleting from the database

  Future<int> delete(String id) async{
    var dbClient = await db;
    return await dbClient!.delete('myfavorites',where: 'id = ?',whereArgs: [id]);
  }

}
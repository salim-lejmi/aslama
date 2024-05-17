import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._instance();
  static Database? _database;

  DatabaseHelper._instance();

  String userTable = 'user_table';
  String colId = 'id';
  String colUsername = 'username';
  String colEmail = 'email';
  String colPassword = 'password';

  String bookingsTable = 'bookings_table';
  String colHotelName = 'hotel_name';
  String colLocation = 'location';
  String colStartDate = 'start_date';
  String colEndDate = 'end_date';
  String colAdults = 'adults';
  String colChildren = 'children';
  String colTotalPrice = 'total_price';

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await _initDB();
    return _database;
  }

  Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'aslama.db');

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
    CREATE TABLE $userTable (
      $colId INTEGER PRIMARY KEY AUTOINCREMENT,
      $colUsername TEXT NOT NULL,
      $colEmail TEXT NOT NULL,
      $colPassword TEXT NOT NULL
    )
  ''');
   await db.insert(
    userTable,
    {
      colUsername: 'admin',
      colEmail: 'admin@gmail.com',
      colPassword: 'admin',
    },
  );

    await db.execute('''
    CREATE TABLE $bookingsTable (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      user_id INTEGER NOT NULL,
      hotel_name TEXT NOT NULL,
      location TEXT NOT NULL,
      start_date TEXT NOT NULL,
      end_date TEXT NOT NULL,
      adults INTEGER NOT NULL,
      children INTEGER NOT NULL,
      total_price REAL NOT NULL,
      image_asset TEXT NOT NULL,  
      FOREIGN KEY (user_id) REFERENCES $userTable($colId)
    )
  ''');
  await db.execute('''
CREATE TABLE restaurant_orders (
id INTEGER PRIMARY KEY AUTOINCREMENT,
user_id INTEGER NOT NULL,
restaurant_name TEXT NOT NULL,
location TEXT NOT NULL,
order_details TEXT NOT NULL,
total_price REAL NOT NULL,
FOREIGN KEY (user_id) REFERENCES $userTable($colId)
)
''');
  }

  Future<int> insertUser(Map<String, dynamic> row) async {
    Database? db = await instance.database;
    return await db!.insert(userTable, row);
  }

  Future<List<Map<String, dynamic>>> queryAllUsers() async {
    Database? db = await instance.database;
    return await db!.query(userTable);
  }

  Future<Map<String, dynamic>?> getUserByUsername(String username) async {
    Database? db = await instance.database;
    List<Map<String, dynamic>> result = await db!
        .query(userTable, where: '$colUsername =?', whereArgs: [username]);
    return result.isNotEmpty ? result.first : null;
  }

  Future<int?> getUserIDByUsername(String username) async {
    Database? db = await instance.database;
    List<Map<String, dynamic>> result = await db!
        .query(userTable, where: '$colUsername =?', whereArgs: [username]);
    return result.isNotEmpty ? result.first[colId] : null;
  }

  Future<int> insertBooking(Map<String, dynamic> row) async {
    Database? db = await instance.database;
    row['image_asset'] = row['image_asset'] ?? '';  
    return await db!.insert(bookingsTable, row);
  }

  Future<List<Map<String, dynamic>>> getBookedHotels() async {
    Database? db = await instance.database;
    return await db!.query(bookingsTable);
  }

  Future<int> deleteBooking(int id) async {
    Database? db = await instance.database;
    return await db!
        .delete(bookingsTable, where: '$colId = ?', whereArgs: [id]);
  }

  Future<List<Map<String, dynamic>>> getBookedHotelsForUser(int userId) async {
    Database? db = await instance.database;
    return await db!.query(
      bookingsTable,
      where: 'user_id = ?',
      whereArgs: [userId],
    );
  }
  Future<int> insertOrder(Map<String, dynamic> row) async {
  Database? db = await instance.database;
  return await db!.insert('restaurant_orders', row);
}
Future<List<Map<String, dynamic>>> getOrdersForUser(int userId) async {
  Database? db = await instance.database;
  return await db!.query(
    'restaurant_orders',
    where: 'user_id = ?',
    whereArgs: [userId],
  );
}
Future<int> deleteUser(int id) async {
  Database? db = await instance.database;
  return await db!.delete(userTable, where: '$colId = ?', whereArgs: [id]);
}
Future<int> deleteOrder(int orderId) async {
  Database? db = await instance.database;
  return await db!.delete('restaurant_orders', where: 'id = ?', whereArgs: [orderId]);
}
}

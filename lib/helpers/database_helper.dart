import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:mobilesoftware/models/user.dart';
import 'package:bcrypt/bcrypt.dart';

class DatabaseException implements Exception {
  final String message;
  DatabaseException(this.message);
  @override
  String toString() => "DatabaseException: $message";
}

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static const String dbName = 'usman_mobile_shop_ffcl.db';
  static const int dbVersion = 1;

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final String path = join(await getDatabasesPath(), dbName);
    return await openDatabase(
      path,
      version: dbVersion,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
      onDowngrade: _onDowngrade,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await _createTables(db);
  }

  Future<void> _createTables(Database db) async {
    try {
      await db.execute(_createTableSQL('customers'));
      await db.execute(_createTableSQL('payment_methods'));
      await db.execute(_createTableSQL('items'));
      await db.execute(_createTableSQL('item_categories'));
      await db.execute(_createTableSQL('orders'));
      await db.execute(_createTableSQL('order_items'));
      await db.execute(_createTableSQL('vendors'));
      await db.execute(_createTableSQL('vendor_types'));
      await db.execute(_createTableSQL('vendor_supplies'));
      await db.execute(_createTableSQL('purchase_items'));
      await db.execute(_createTableSQL('invoices'));
      await db.execute(_createTableSQL('invoice_items'));
      await db.execute(_createTableSQL('payments'));
      await db.execute(_createTableSQL('audit_logs'));
      await db.execute(_createTableSQL('users'));
    } catch (e) {
      throw DatabaseException('Error creating tables: $e');
    }
  }

  String _createTableSQL(String tableName) {
    switch (tableName) {
      case 'customers':
        return '''
            CREATE TABLE customers (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                customer_code TEXT UNIQUE NOT NULL,
                name TEXT NOT NULL,
                contact_1 TEXT NOT NULL,
                contact_2 TEXT,
                email TEXT,
                address TEXT,
                city TEXT,
                category TEXT NOT NULL,
                sub_category TEXT,
                status TEXT DEFAULT 'Active',
                created_at DATETIME DEFAULT CURRENT_TIMESTAMP
            )
        ''';
      case 'payment_methods':
        return '''
            CREATE TABLE payment_methods (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                method_name TEXT NOT NULL,
                is_partial_allowed BOOLEAN NOT NULL,
                created_at DATETIME DEFAULT CURRENT_TIMESTAMP
            )
        ''';
      case 'items':
        return '''
            CREATE TABLE items (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                item_code TEXT UNIQUE NOT NULL,
                description TEXT NOT NULL,
                price REAL NOT NULL,
                stock_quantity INTEGER NOT NULL,
                barcode TEXT,
                qr_code TEXT,
                category_id INTEGER,
                created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
                FOREIGN KEY (category_id) REFERENCES item_categories(id)
            )
        ''';
      case 'item_categories':
        return '''
            CREATE TABLE item_categories (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                category_name TEXT NOT NULL,
                subcategory_name TEXT NOT NULL,
                created_at DATETIME DEFAULT CURRENT_TIMESTAMP
            )
        ''';
      case 'orders':
        return '''
            CREATE TABLE orders (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                order_code TEXT UNIQUE NOT NULL,
                customer_id INTEGER,
                order_date DATETIME DEFAULT CURRENT_TIMESTAMP,
                status TEXT DEFAULT 'Pending',
                total_amount REAL NOT NULL,
                created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
                FOREIGN KEY (customer_id) REFERENCES customers(id)
            )
        ''';
      case 'order_items':
        return '''
            CREATE TABLE order_items (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                order_id INTEGER NOT NULL,
                item_id INTEGER NOT NULL,
                quantity INTEGER NOT NULL,
                unit_price REAL NOT NULL,
                total_price REAL NOT NULL,
                created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
                FOREIGN KEY (order_id) REFERENCES orders(id),
                FOREIGN KEY (item_id) REFERENCES items(id)
            )
        ''';
      case 'vendors':
        return '''
            CREATE TABLE vendors (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                vendor_code TEXT UNIQUE NOT NULL,
                name TEXT NOT NULL,
                contact_1 TEXT NOT NULL,
                contact_2 TEXT,
                email TEXT,
                city TEXT,
                address TEXT,
                status TEXT DEFAULT 'Active',
                type_id INTEGER,
                created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
                FOREIGN KEY (type_id) REFERENCES vendor_types(id)
            )
        ''';
      case 'vendor_types':
        return '''
            CREATE TABLE vendor_types (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                type_name TEXT NOT NULL,
                created_at DATETIME DEFAULT CURRENT_TIMESTAMP
            )
        ''';
      case 'vendor_supplies':
        return '''
            CREATE TABLE vendor_supplies (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                vendor_id INTEGER NOT NULL,
                item_id INTEGER NOT NULL,
                created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
                FOREIGN KEY (vendor_id) REFERENCES vendors(id),
                FOREIGN KEY (item_id) REFERENCES items(id)
            )
        ''';
      case 'purchase_items':
        return '''
            CREATE TABLE purchase_items (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                purchase_id INTEGER NOT NULL,
                item_id INTEGER NOT NULL,
                quantity INTEGER NOT NULL,
                unit_price REAL NOT NULL,
                total_price REAL NOT NULL,
                created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
                FOREIGN KEY (purchase_id) REFERENCES purchases(id),
                FOREIGN KEY (item_id) REFERENCES items(id)
            )
        ''';
      case 'invoices':
        return '''
            CREATE TABLE invoices (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                customer_id INTEGER NOT NULL,
                invoice_date DATETIME DEFAULT CURRENT_TIMESTAMP,
                total_amount REAL NOT NULL,
                paid_amount REAL DEFAULT 0,
                due_date DATETIME,
                payment_status TEXT DEFAULT 'Unpaid',
                created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
                FOREIGN KEY (customer_id) REFERENCES customers(id)
            )
        ''';
      case 'invoice_items':
        return '''
            CREATE TABLE invoice_items (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                invoice_id INTEGER NOT NULL,
                item_id INTEGER NOT NULL,
                quantity INTEGER NOT NULL,
                unit_price REAL NOT NULL,
                total_price REAL NOT NULL,
                created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
                FOREIGN KEY (invoice_id) REFERENCES invoices(id),
                FOREIGN KEY (item_id) REFERENCES items(id)
            )
        ''';
      case 'payments':
        return '''
            CREATE TABLE payments (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                invoice_id INTEGER,
                customer_id INTEGER NOT NULL,
                payment_date DATETIME DEFAULT CURRENT_TIMESTAMP,
                payment_method TEXT NOT NULL,
                transaction_id TEXT,
                amount_paid REAL NOT NULL,
                created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
                 FOREIGN KEY (invoice_id) REFERENCES invoices(id),
                FOREIGN KEY (customer_id) REFERENCES customers(id)
            )
        ''';
      case 'audit_logs':
        return '''
            CREATE TABLE audit_logs (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                user_id INTEGER NOT NULL,
                action_type TEXT NOT NULL,
                table_name TEXT NOT NULL,
                record_id INTEGER NOT NULL,
                action_details TEXT,
                action_timestamp DATETIME DEFAULT CURRENT_TIMESTAMP
            )
        ''';
      case 'users':
        return '''
            CREATE TABLE users (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                username TEXT NOT NULL UNIQUE,
                password_hash TEXT NOT NULL,
                role TEXT NOT NULL,
                created_at DATETIME DEFAULT CURRENT_TIMESTAMP
            )
        ''';
      default:
        throw ArgumentError('Unknown table name: $tableName');
    }
  }
  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      try {
        await db.execute("ALTER TABLE customers ADD COLUMN new_column TEXT;");
      } catch (e) {
        throw DatabaseException('Error during database upgrade: $e');
      }
    }
  }
  Future<void> _onDowngrade(Database db, int oldVersion, int newVersion) async {
    throw DatabaseException('Database downgrade is not supported.');
  }
// new implemention added
  Future<void> initializeDatabase() async {
    try {
      final db = await database;
      final users =  await db.query('users');
      if(users.isEmpty){
        final hashedPassword = await _hashPassword("admin123");
        await db.insert('users',{
          'username':'admin',
          'password_hash': hashedPassword,
          'role': 'administrator'
        });
      }
    } catch(e){
      throw  DatabaseException("Failed To add Admin User or check User Database");
    }
  }


  Future<String> _hashPassword(String password) async {
    final salt = BCrypt.gensalt();
    return BCrypt.hashpw(password,salt);
  }
  Future<List<User>> getUsersByName(String username) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'users',
      where: 'username = ?',
      whereArgs: [username],
    );
    return maps.map((map) => User.fromMap(map)).toList();
  }
  Future<int> insertRecord(String tableName, Map<String, dynamic> values) async {
    final db = await database;
    try{
      return await db.insert(tableName, {
        ...values, // Insert original values
        'created_at': DateTime.now().toIso8601String(), // Insert timestamp
      });
    } catch (e)
    {
      throw DatabaseException('Error inserting record: $e');
    }
  }
  Future<List<Map<String,dynamic>>> getAllRecords(String tableName) async {
    final db = await database;
    try{
      return await db.query(tableName);
    }catch(e)
    {
      throw  DatabaseException("failed to query from $tableName exception error : $e ");
    }
  }
  Future<List<Map<String,dynamic>>> getRecordById(String tableName, int id) async {
    final db = await database;
    try {
      return  await db.query(
        tableName,
        where: 'id = ?',
        whereArgs: [id],
      );

    } catch(e)
    {

      throw   DatabaseException("failed to get record with $id with exception  $e");

    }
  }
  Future<int> updateRecord(String tableName, Map<String, dynamic> values, int id) async {
    final db = await database;
    try {

      return await db.update(tableName,values ,  where: 'id = ?', whereArgs: [id],);
    } catch(e) {
      throw  DatabaseException("fail to update with  id $id from table  $tableName, error:  $e" );
    }
  }

  Future<int> deleteRecord(String tableName, int id) async {
    final db = await database;
    try{

      return await db.delete(tableName, where: 'id = ?', whereArgs: [id]);
    } catch(e) {

      throw DatabaseException('Error deleting record with id: $id, $e');
    }

  }
}
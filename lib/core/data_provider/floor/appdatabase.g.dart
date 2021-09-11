// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appdatabase.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  UserEntityDao? _userDaoInstance;

  ImageEntityDao? _imageEntityDaoInstance;

  PropertyEntityDao? _propertyEntityDaoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback? callback]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 7,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `users` (`id` TEXT NOT NULL, `profileImage` TEXT NOT NULL, `name` TEXT NOT NULL, `email` TEXT NOT NULL, `isAdmin` INTEGER NOT NULL, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `images` (`id` TEXT NOT NULL, `isFromUser` INTEGER NOT NULL, `imageUrl` TEXT NOT NULL, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `properties` (`id` TEXT NOT NULL, `ownerid` TEXT NOT NULL, `createdAt` TEXT NOT NULL, `updatedAt` TEXT NOT NULL, `title` TEXT NOT NULL, `description` TEXT NOT NULL, `category` TEXT NOT NULL, `bill` REAL NOT NULL, `per` TEXT NOT NULL, `status` TEXT NOT NULL, `rating` REAL NOT NULL, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  UserEntityDao get userDao {
    return _userDaoInstance ??= _$UserEntityDao(database, changeListener);
  }

  @override
  ImageEntityDao get imageEntityDao {
    return _imageEntityDaoInstance ??=
        _$ImageEntityDao(database, changeListener);
  }

  @override
  PropertyEntityDao get propertyEntityDao {
    return _propertyEntityDaoInstance ??=
        _$PropertyEntityDao(database, changeListener);
  }
}

class _$UserEntityDao extends UserEntityDao {
  _$UserEntityDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database, changeListener),
        _userEntityInsertionAdapter = InsertionAdapter(
            database,
            'users',
            (UserEntity item) => <String, Object?>{
                  'id': item.id,
                  'profileImage': item.profileImage,
                  'name': item.name,
                  'email': item.email,
                  'isAdmin': item.isAdmin ? 1 : 0
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<UserEntity> _userEntityInsertionAdapter;

  @override
  Future<List<UserEntity>> findAllUsers() async {
    return _queryAdapter.queryList('SELECT * FROM users',
        mapper: (Map<String, Object?> row) => UserEntity(
            id: row['id'] as String,
            email: row['email'] as String,
            name: row['name'] as String,
            profileImage: row['profileImage'] as String,
            isAdmin: (row['isAdmin'] as int) != 0));
  }

  @override
  Stream<UserEntity?> findUser(String id) {
    return _queryAdapter.queryStream('SELECT * FROM users WHERE id = ?1',
        mapper: (Map<String, Object?> row) => UserEntity(
            id: row['id'] as String,
            email: row['email'] as String,
            name: row['name'] as String,
            profileImage: row['profileImage'] as String,
            isAdmin: (row['isAdmin'] as int) != 0),
        arguments: [id],
        queryableName: 'users',
        isView: false);
  }

  @override
  Future<void> insertUser(UserEntity user) async {
    await _userEntityInsertionAdapter.insert(user, OnConflictStrategy.abort);
  }
}

class _$ImageEntityDao extends ImageEntityDao {
  _$ImageEntityDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _imageEntityInsertionAdapter = InsertionAdapter(
            database,
            'images',
            (ImageEntity item) => <String, Object?>{
                  'id': item.id,
                  'isFromUser': item.isFromUser,
                  'imageUrl': item.imageUrl
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<ImageEntity> _imageEntityInsertionAdapter;

  @override
  Future<List<ImageEntity>> fetchAllProperties() async {
    return _queryAdapter.queryList('SELECT * FROM images',
        mapper: (Map<String, Object?> row) => ImageEntity(
            id: row['id'] as String,
            isFromUser: row['isFromUser'] as int,
            imageUrl: row['imageUrl'] as String));
  }

  @override
  Future<List<ImageEntity>> findImage(String id) async {
    return _queryAdapter.queryList('SELECT * FROM images WHERE id = ?1',
        mapper: (Map<String, Object?> row) => ImageEntity(
            id: row['id'] as String,
            isFromUser: row['isFromUser'] as int,
            imageUrl: row['imageUrl'] as String),
        arguments: [id]);
  }

  @override
  Future<void> insertImage(ImageEntity propertyEntity) async {
    await _imageEntityInsertionAdapter.insert(
        propertyEntity, OnConflictStrategy.abort);
  }
}

class _$PropertyEntityDao extends PropertyEntityDao {
  _$PropertyEntityDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _propertyEntityInsertionAdapter = InsertionAdapter(
            database,
            'properties',
            (PropertyEntity item) => <String, Object?>{
                  'id': item.id,
                  'ownerid': item.ownerid,
                  'createdAt': item.createdAt,
                  'updatedAt': item.updatedAt,
                  'title': item.title,
                  'description': item.description,
                  'category': item.category,
                  'bill': item.bill,
                  'per': item.per,
                  'status': item.status,
                  'rating': item.rating
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<PropertyEntity> _propertyEntityInsertionAdapter;

  @override
  Future<List<PropertyEntity>> fetchAllProperties() async {
    return _queryAdapter.queryList('SELECT * FROM properties',
        mapper: (Map<String, Object?> row) => PropertyEntity(
            id: row['id'] as String,
            ownerid: row['ownerid'] as String,
            title: row['title'] as String,
            description: row['description'] as String,
            category: row['category'] as String,
            bill: row['bill'] as double,
            per: row['per'] as String,
            status: row['status'] as String,
            rating: row['rating'] as double,
            createdAt: row['createdAt'] as String,
            updatedAt: row['updatedAt'] as String));
  }

  @override
  Future<PropertyEntity?> findProperty(String id) async {
    return _queryAdapter.query('SELECT * FROM properties WHERE id = ?1',
        mapper: (Map<String, Object?> row) => PropertyEntity(
            id: row['id'] as String,
            ownerid: row['ownerid'] as String,
            title: row['title'] as String,
            description: row['description'] as String,
            category: row['category'] as String,
            bill: row['bill'] as double,
            per: row['per'] as String,
            status: row['status'] as String,
            rating: row['rating'] as double,
            createdAt: row['createdAt'] as String,
            updatedAt: row['updatedAt'] as String),
        arguments: [id]);
  }

  @override
  Future<void> deleteProperty(String id) async {
    await _queryAdapter
        .queryNoReturn('DELETE FROM properties WHERE id = ?1', arguments: [id]);
  }

  @override
  Future<void> deleteAllProperty() async {
    await _queryAdapter.queryNoReturn('DELETE FROM properties');
  }

  @override
  Future<void> insertProperty(PropertyEntity propertyEntity) async {
    await _propertyEntityInsertionAdapter.insert(
        propertyEntity, OnConflictStrategy.abort);
  }

  @override
  Future<void> insertManyProperty(List<PropertyEntity> propertyEntities) async {
    await _propertyEntityInsertionAdapter.insertList(
        propertyEntities, OnConflictStrategy.abort);
  }
}

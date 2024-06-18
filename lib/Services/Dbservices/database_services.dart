import 'package:assignment/Services/Dbservices/sample_posts.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:assignment/DTO/post_dto.dart';
import 'dart:convert';

class DBservice {
  static Database? _database;
  static final DBservice db = DBservice._();

  DBservice._();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDB();
    return _database!;
  }

  Future<Database> initDB() async {
    String path = join(await getDatabasesPath(), 'new_posts.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE new_posts (
            id TEXT PRIMARY KEY,
            userId TEXT,
            description TEXT,
            title TEXT,
            image TEXT,
            tags TEXT,
            likedUsers TEXT,
            eventCategory TEXT,
            eventStartAt TEXT,
            eventEndAt TEXT,
            eventId TEXT,
            registrationRequired INTEGER,
            registration TEXT,
            eventDescription TEXT,
            likes INTEGER,
            comments TEXT,
            createdAt TEXT,
            eventLocation TEXT
          )
        ''');
      },
    );
  }

  Future<void> insertPost(PostDTO post) async {
    final db = await database;
    await db.insert(
      'new_posts',
      {
        'id': post.id,
        'userId': post.userId,
        'description': post.description,
        'title': post.title,
        'image': json.encode(post.image),
        'tags': json.encode(post.tags),
        'likedUsers': json.encode(post.likedUsers),
        'eventCategory': post.eventCategory,
        'eventStartAt': post.eventStartAt,
        'eventEndAt': post.eventEndAt,
        'eventId': post.eventId,
        'registrationRequired': post.registrationRequired ? 1 : 0,
        'registration': json.encode(post.registration),
        'eventDescription': post.eventDescription,
        'likes': post.likes,
        'comments': json.encode(post.comments),
        'createdAt': post.createdAt,
        'eventLocation': json.encode(post.eventLocation ?? {}),
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<PostDTO>> getPostsfromapi() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('new_posts');

    return List.generate(maps.length, (i) {
      return PostDTO(
        id: maps[i]['id'],
        userId: maps[i]['userId'],
        description: maps[i]['description'],
        title: maps[i]['title'],
        image: List<String>.from(json.decode(maps[i]['image'])),
        tags: List<String>.from(json.decode(maps[i]['tags'])),
        likedUsers: List<String>.from(json.decode(maps[i]['likedUsers'])),
        eventCategory: maps[i]['eventCategory'],
        eventStartAt: maps[i]['eventStartAt'],
        eventEndAt: maps[i]['eventEndAt'],
        eventId: maps[i]['eventId'],
        registrationRequired: maps[i]['registrationRequired'] == 1,
        registration: List<String>.from(json.decode(maps[i]['registration'])),
        eventDescription: maps[i]['eventDescription'],
        likes: maps[i]['likes'],
        comments: List<String>.from(json.decode(maps[i]['comments'])),
        createdAt: maps[i]['createdAt'],
        eventLocation: Map<String, dynamic>.from(json.decode(maps[i]['eventLocation'])),
      );
    });
  }


  Future<List<PostDTO>> getPostsfromdb() async {
    final db = await database;
    try {
      final List<Map<String, dynamic>> maps = await db.query('new_posts');
      print('Fetched ${maps.length} posts from the database');

      List<PostDTO> posts = List.generate(maps.length, (i) {
        try {
          return PostDTO(
            id: maps[i]['id'],
            userId: maps[i]['userId'],
            description: maps[i]['description'],
            title: maps[i]['title'],
            image: List<String>.from(json.decode(maps[i]['image'])),
            tags: List<String>.from(json.decode(maps[i]['tags'])),
            likedUsers: List<String>.from(json.decode(maps[i]['likedUsers'])),
            eventCategory: maps[i]['eventCategory'],
            eventStartAt: maps[i]['eventStartAt'],
            eventEndAt: maps[i]['eventEndAt'],
            eventId: maps[i]['eventId'],
            registrationRequired: maps[i]['registrationRequired'] == 1,
            registration: List<String>.from(json.decode(maps[i]['registration'])),
            eventDescription: maps[i]['eventDescription'],
            likes: maps[i]['likes'],
            comments: List<String>.from(json.decode(maps[i]['comments'])),
            createdAt: maps[i]['createdAt'],
            eventLocation: maps[i]['eventLocation'] != null
                ? Map<String, dynamic>.from(json.decode(maps[i]['eventLocation']))
                : {},
          );
        } catch (e) {
          print('Error decoding post at index $i: $e');
          throw e;
        }
      });
      print('Successfully decoded all posts');
      return posts;
    } catch (e) {
      print('Error fetching posts from the database: $e');
      throw e;
    }
  }

  Future<void> insertSamplePosts() async {
    final db = await database;
    try {
      for (var post in samplePosts) {
        await db.insert(
          'second_posts',
          {
            'id': post['id'],
            'userId': post['userId'],
            'description': post['description'],
            'title': post['title'],
            'image': json.encode(post['image']),
            'tags': json.encode(post['tags']),
            'likedUsers': json.encode(post['likedUsers']),
            'eventCategory': post['eventCategory'],
            'eventStartAt': post['eventStartAt'],
            'eventEndAt': post['eventEndAt'],
            'eventId': post['eventId'],
            'registrationRequired': post['registrationRequired'] ? 1 : 0,
            'registration': json.encode(post['registration']),
            'eventDescription': post['eventDescription'],
            'likes': post['likes'],
            'comments': json.encode(post['comments']),
            'createdAt': post['createdAt'],
            'eventLocation': json.encode(post['eventLocation'] ?? {}),
          },
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
    } catch (e) {
      print('Failed to insert sample posts: $e');
      rethrow;
    }
  }


}

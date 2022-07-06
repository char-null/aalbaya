import 'dart:io';
import 'package:aalbaya/src/model/job.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

final String tablename = 'job';

class DatabaseHelper {
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;
  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'job.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE job(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        jobtype TEXT,
        jobdetail TEXT,
        jobname TEXT,
        hourlywage INTEGER,
        firstday TEXT,
        workday TEXT,
        attendance TEXT,
        closing TEXT,
        closeday TEXT,
        totalday INTEGER,
        totalwage INTEGER,
        ing TEXT
        )''');
  }

  Future<List<Job>> getJob() async {
    Database db = await instance.database;
    var job = await db.query(tablename);
    List<Job> jobList =
        job.isNotEmpty ? job.map((c) => Job.fromMap(c)).toList() : [];
    return jobList;
  }

  Future<List<Job>> getJobofDay(DateTime day) async {
    Database db = await instance.database;
    var job = await db.query(tablename,
        where: 'uploaddate=?',
        whereArgs: [DateFormat.yMMMMd('ko').format(day)]);
    List<Job> jobList =
        job.isNotEmpty ? job.map((e) => Job.fromMap(e)).toList() : [];
    return jobList;
  }

  Future<int> addJob(Job job) async {
    Database db = await instance.database;
    return await db.insert('job', job.toMap());
  }

  Future<int> deleteJob(DateTime day) async {
    Database db = await instance.database;
    return await db.delete('job',
        where: 'uploaddate=?',
        whereArgs: [DateFormat.yMMMMd('ko').format(day)]);
  }

  Future<int> updateJob(Job job, int index) async {
    Database db = await instance.database;
    return await db
        .update('job', job.toMap(), where: 'id=?', whereArgs: [index]);
  }

  Future<int> updatecloseJob(Job job, int? index) async {
    Database db = await instance.database;
    return await db
        .update('job', job.toMap(), where: 'id=?', whereArgs: [index]);
  }
}

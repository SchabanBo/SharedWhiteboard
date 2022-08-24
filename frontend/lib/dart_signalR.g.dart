// File generated at 8/22/2022 2:00:47 PM
import 'package:flutter/foundation.dart';
import 'package:signalr_core/signalr_core.dart';

class WhiteboardHub{
   final HubConnection connection;
   const WhiteboardHub({ required this.connection});

   void AddBoard(String name) => 
      connection.send(methodName: 'AddBoard'  ,args: [name]);

   void RemoveBoard(String id) => 
      connection.send(methodName: 'RemoveBoard'  ,args: [id]);

   Future<List<Board>> GetBoards() async  => 
      List<Board>.from((await connection.invoke('GetBoards' )).map((x)=> Board.fromJson(x as Map<String,dynamic>)) as  Iterable);

   Future<Board> GetBoard(String id) async  => 
      Board.fromJson(await connection.invoke('GetBoard'  ,args: [id]) as Map<String,dynamic>);

   Future<String> AddPath(Path path) async  => 
      await connection.invoke('AddPath'  ,args: [path]) as String;

   void AddPoint(Point point) => 
      connection.send(methodName: 'AddPoint'  ,args: [point]);

   void UserUpdate(String boardId, bool isEnter) => 
      connection.send(methodName: 'UserUpdate'  ,args: [boardId, isEnter]);



}

class Board{
   String? id;
   String? name;
   DateTime? createdAt;
   int? users;
   bool? isDeleted;
   List<Path> paths;

   Board({this.id, this.name, this.createdAt, this.users, this.isDeleted, this.paths = const []});

   Board.fromJson(Map<String, dynamic> json):
       id = json['id'] == null ? null : json['id'] as String,
       name = json['name'] == null ? null : json['name'] as String,
       createdAt = json['createdAt'] == null ? null : DateTime.parse(json['createdAt'].toString()).toLocal(),
       users = json['users'] == null ? null : json['users'] as int,
       isDeleted = json['isDeleted'] == null ? null : json['isDeleted'] as bool,
       paths = json['paths'] == null ? <Path>[] : List<Path>.from(json['paths'].map((x) =>Path.fromJson(x as Map<String, dynamic>)) as Iterable);


   Map<String, dynamic> toJson() => {
      'id': id,
      'name': name,
      'createdAt': createdAt?.toUtc().toIso8601String(),
      'users': users,
      'isDeleted': isDeleted,
      'paths': List<dynamic>.from(paths.map((x) => x.toJson()))
   };

}

enum WhiteboardHubChannels{
   BoardUpdated,
   PathAdded,
   PointAdded,
   UserUpdated,
}

class Path{
   final String? id;
   final String? boardId;
   final String? color;
   final double? stroke;
   final List<Point> points;

   const Path({this.id, this.boardId, this.color, this.stroke, this.points = const []});

   Path.fromJson(Map<String, dynamic> json):
       id = json['id'] == null ? null : json['id'] as String,
       boardId = json['boardId'] == null ? null : json['boardId'] as String,
       color = json['color'] == null ? null : json['color'] as String,
       stroke = json['stroke'] == null ? null : double.parse(json['stroke'].toString()),
       points = json['points'] == null ? <Point>[] : List<Point>.from(json['points'].map((x) =>Point.fromJson(x as Map<String, dynamic>)) as Iterable);


   Map<String, dynamic> toJson() => {
      'id': id,
      'boardId': boardId,
      'color': color,
      'stroke': stroke,
      'points': List<dynamic>.from(points.map((x) => x.toJson()))
   };

}

class Point{
   final String? pathId;
   final String? boardId;
   final double? x;
   final double? y;

   const Point({this.pathId, this.boardId, this.x, this.y});

   Point.fromJson(Map<String, dynamic> json):
       pathId = json['pathId'] == null ? null : json['pathId'] as String,
       boardId = json['boardId'] == null ? null : json['boardId'] as String,
       x = json['x'] == null ? null : double.parse(json['x'].toString()),
       y = json['y'] == null ? null : double.parse(json['y'].toString());


   Map<String, dynamic> toJson() => {
      'pathId': pathId,
      'boardId': boardId,
      'x': x,
      'y': y
   };

}


Duration parseDuration(String s) {
    var hours = 0;
    var minutes = 0;
    var micros = 0;
    List<String> parts = s.split(':');
    if (parts.length > 2) {
        hours = int.parse(parts[parts.length - 3]);
    }
    if (parts.length > 1) {
        minutes = int.parse(parts[parts.length - 2]);
    }
    micros = (double.parse(parts[parts.length - 1]) * 1000000).round();
    return Duration(hours: hours, minutes: minutes, microseconds: micros);
}

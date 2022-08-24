import 'package:flutter/material.dart';
import 'package:frontend/dart_signalR.g.dart';
import 'package:frontend/helpers/constant.dart';
import 'package:reactable/reactable.dart';

class BoardViewModel {
  final Board board;
  final paths = <Path>[].asReactable;
  final _hub = signalRHub!;

  Color color = Colors.black;
  double stroke = 1.0;
  String? _currentPath;

  BoardViewModel(this.board) {
    paths.addAll(board.paths);
    _setListeners();
  }

  void onPanEnd() {
    _currentPath = null;
  }

  void onPanUpdate(Offset localPosition) {
    _hub.AddPoint(Point(
      boardId: board.id!,
      pathId: _currentPath!,
      x: localPosition.dx,
      y: localPosition.dy,
    ));
  }

  Future onPanStart(Offset localPosition) async {
    _currentPath = await _hub.AddPath(Path(
      boardId: board.id!,
      color: color.value.toString(),
      stroke: stroke,
      points: [
        Point(
          x: localPosition.dx,
          y: localPosition.dy,
        )
      ],
    ));
  }

  void _setListeners() {
    _hub.connection.on(WhiteboardHubChannels.PathAdded.name, _pathAdded);
    _hub.connection.on(WhiteboardHubChannels.PointAdded.name, _pointAdded);
  }

  void _pathAdded(List? arguments) {
    final path = Path.fromJson(arguments![0] as Map<String, dynamic>);
    paths.add(path);
  }

  void _pointAdded(List? arguments) {
    final point = Point.fromJson(arguments![0] as Map<String, dynamic>);
    paths.firstWhere((element) => element.id == point.pathId).points.add(point);
    paths.refresh();
  }

  void backPressed() {
    _hub.UserUpdate(board.id!, false);
    _hub.connection.off(WhiteboardHubChannels.PathAdded.name);
    _hub.connection.off(WhiteboardHubChannels.PointAdded.name);
  }
}

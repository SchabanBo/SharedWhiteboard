import 'package:frontend/helpers/constant.dart';
import 'package:reactable/reactable.dart';

import '../../dart_signalR.g.dart';

class BoardsViewModel {
  final boards = <Board>[].asReactable;
  final _hub = signalRHub!;

  BoardsViewModel() {
    _setListeners();
    _hub.GetBoards().then((value) => boards.addAll(value));
  }

  void _setListeners() {
    _hub.connection.on(WhiteboardHubChannels.BoardUpdated.name, _boardUpdated);
    _hub.connection.on(WhiteboardHubChannels.UserUpdated.name, _userUpdated);
  }

  void _boardUpdated(List? arguments) {
    final board = Board.fromJson(arguments!.first as Map<String, dynamic>);
    if (board.isDeleted!) {
      boards.removeWhere((element) => element.id == board.id);
      return;
    }

    boards.add(board);
  }

  void _userUpdated(List? arguments) {
    final boardId = arguments?.first as String;
    final board = boards.firstWhere((element) => element.id == boardId);

    if (arguments?[1] as bool) {
      board.users = board.users! + 1;
    } else {
      board.users = board.users! - 1;
    }

    boards.refresh();
  }

  void add(String name) {
    _hub.AddBoard(name);
  }

  void delete(String id) {
    _hub.RemoveBoard(id);
  }

  Future<Board> getBoard(String id) {
    return _hub.GetBoard(id);
  }

  void addUser(String id) {
    _hub.UserUpdate(id, true);
  }
}

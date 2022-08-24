import 'package:flutter/material.dart';
import 'package:frontend/pages/board/view.dart';
import 'package:frontend/pages/board/view_model.dart';
import 'package:frontend/pages/boards/view_model.dart';
import 'package:reactable/reactable.dart';

class BoardsView extends StatelessWidget {
  final vm = BoardsViewModel();
  BoardsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Boards'),
        centerTitle: true,
      ),
      body: Scope(
        builder: (_) => ListView.builder(
          itemCount: vm.boards.length,
          itemBuilder: (_, index) {
            final board = vm.boards[index];
            return Card(
              elevation: 5,
              child: ListTile(
                title: Text(board.name!),
                subtitle: Text(
                  'Created: ${board.createdAt.toString().split('.')[0]}',
                ),
                leading: Text(
                  board.users.toString(),
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.indigo,
                  ),
                ),
                trailing: IconButton(
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                  onPressed: () {
                    vm.delete(board.id!);
                  },
                ),
                onTap: () {
                  _goToBoard(context, board.id!);
                },
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => _getName(context),
      ),
    );
  }

  Future _getName(BuildContext context) async {
    var name = '';

    await showDialog(
      context: context,
      builder: (c) => AlertDialog(
        title: const Text('New Board'),
        content: TextField(
          onChanged: (value) => name = value,
          decoration: const InputDecoration(
            label: Text('Name'),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              name = '';
              Navigator.pop(c);
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(c);
            },
            child: const Text('Create'),
          ),
        ],
      ),
    );

    if (name != '') {
      vm.add(name);
    }
  }

  void _goToBoard(BuildContext context, String id) {
    vm.addUser(id);
    vm.getBoard(id).then((board) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (c) => BoardView(BoardViewModel(board)),
        ),
      );
    });
  }
}

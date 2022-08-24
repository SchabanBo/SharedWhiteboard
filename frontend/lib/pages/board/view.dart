import 'package:flutter/material.dart';
import 'package:frontend/pages/board/painter.dart';
import 'package:frontend/pages/board/view_model.dart';
import 'package:reactable/reactable.dart';

part 'view.tools.dart';

class BoardView extends StatelessWidget {
  final BoardViewModel vm;
  const BoardView(this.vm, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(vm.board.name!),
        centerTitle: true,
        leading: BackButton(
          onPressed: () {
            vm.backPressed();
            Navigator.pop(context);
          },
        ),
      ),
      body: GestureDetector(
        onPanStart: (details) {
          vm.onPanStart(details.localPosition);
        },
        onPanUpdate: (details) {
          vm.onPanUpdate(details.localPosition);
        },
        onPanEnd: (details) {
          vm.onPanEnd();
        },
        child: Scope(
          builder: (_) => CustomPaint(
            painter: BoardPainter(vm.paths.value),
            child: const SizedBox.expand(),
          ),
        ),
      ),
      floatingActionButton: _SettingsWidget(vm: vm),
    );
  }
}

class _SettingsWidget extends StatelessWidget {
  const _SettingsWidget({
    Key? key,
    required this.vm,
  }) : super(key: key);

  final BoardViewModel vm;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: const Padding(
        padding: EdgeInsets.all(4.0),
        child: Icon(Icons.settings),
      ),
      onPressed: () {
        showBottomSheet(
          context: context,
          builder: (_) => _BoardTools(vm),
        );
      },
    );
  }
}

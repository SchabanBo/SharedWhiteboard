part of 'view.dart';

class _BoardTools extends StatelessWidget {
  final BoardViewModel vm;
  final Reactable<double> green;
  final Reactable<double> red;
  final Reactable<double> blue;
  final Reactable<double> stroke;
  _BoardTools(this.vm, {Key? key})
      : blue = Reactable(vm.color.blue.toDouble()),
        green = Reactable(vm.color.green.toDouble()),
        red = Reactable(vm.color.red.toDouble()),
        stroke = Reactable(vm.stroke),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 8,
            color: Colors.black.withOpacity(0.2),
          )
        ],
      ),
      child: Scope(
        builder: (_) => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                const Text(
                  'Color',
                  style: TextStyle(fontSize: 20),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Container(
                    height: 25,
                    color: Color.fromARGB(
                      255,
                      red.value.toInt(),
                      green.value.toInt(),
                      blue.value.toInt(),
                    ),
                  ),
                ),
                const Spacer(),
              ],
            ),
            _ColorSlider(name: 'Red', reactable: red),
            _ColorSlider(name: 'Blue', reactable: blue),
            _ColorSlider(name: 'Green', reactable: green),
            const Divider(),
            Row(
              children: [
                const Text(
                  'Stroke',
                  style: TextStyle(fontSize: 20),
                ),
                const SizedBox(width: 8),
                Text(
                  stroke.value.toString(),
                  style: const TextStyle(fontSize: 20),
                )
              ],
            ),
            Slider(
              value: stroke.value,
              onChanged: (value) => stroke.value = value,
              max: 15,
              divisions: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () => _setEraserColor(context),
                  child: Text('Eraser'),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('Cancel'),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    vm.color = Color.fromARGB(
                      255,
                      red.value.toInt(),
                      green.value.toInt(),
                      blue.value.toInt(),
                    );
                    vm.stroke = stroke.value;
                    Navigator.pop(context);
                  },
                  child: Text('Save'),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  _setEraserColor(BuildContext context) {
    final background = Theme.of(context).backgroundColor;
    blue.value = background.blue.toDouble();
    red.value = background.red.toDouble();
    green.value = background.green.toDouble();
    stroke.value = 15;
  }
}

class _ColorSlider extends StatelessWidget {
  final String name;
  final Reactable<double> reactable;
  const _ColorSlider({
    required this.name,
    required this.reactable,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(name),
        const SizedBox(width: 8),
        Text(reactable.value.toInt().toString()),
        Expanded(
          child: Slider(
            onChanged: (value) => reactable.value = value,
            value: reactable.value,
            max: 255,
          ),
        )
      ],
    );
  }
}

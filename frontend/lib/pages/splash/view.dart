import 'package:flutter/material.dart';
import 'package:frontend/pages/boards/view.dart';
import 'package:frontend/pages/splash/view_model.dart';

class SplashView extends StatelessWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vm = SplashViewModel();
    return Scaffold(
      body: FutureBuilder<void>(
        future: vm.loadApp(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return _SplashWidget(
              text: snapshot.error.toString(),
              icon: const Icon(Icons.error, color: Colors.red),
            );
          }

          if (snapshot.connectionState == ConnectionState.done) {
            Future.delayed(const Duration(seconds: 1), () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => BoardsView()),
              );
            });

            return const _SplashWidget(
              text: 'Connected',
              icon: Icon(
                Icons.done,
                color: Colors.green,
              ),
            );
          }

          return const _SplashWidget(
            text: 'Loading ...',
            icon: Icon(Icons.screenshot_monitor, color: Colors.indigo),
          );
        },
      ),
    );
  }
}

class _SplashWidget extends StatelessWidget {
  final String text;
  final Widget icon;
  const _SplashWidget({
    required this.text,
    required this.icon,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon,
          const SizedBox(height: 20),
          Text(text, style: const TextStyle(fontSize: 20)),
        ],
      ),
    );
  }
}

import 'package:board/provider/router_provider.dart';
import 'package:board/screen/board/list_screen.dart';
import 'package:board/screen/board/read_screen.dart';
import 'package:board/screen/board/update_screen.dart';
import 'package:flutter/material.dart';
import 'package:board/main_screen.dart';
import 'package:board/screen/board/insert_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       initialRoute: '/main',
//       routes: {
//         '/main' : (context) => MainScreen(),
//         '/board/list' : (context) => ListScreen(),
//         '/board/read' : (context) => ReadScreen(),
//         '/board/insert' : (context) => InsertScreen(),
//         '/board/update' : (context) => UpdateScreen(),
//       },
//     );
//   }
// }

void main() {
  runApp(
    ProviderScope(
      child: _App(),
    ),
  );
}

class _App extends ConsumerWidget {
  const _App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      theme: ThemeData(
        fontFamily: 'NotoSans',
      ),
      debugShowCheckedModeBanner: false,
      routerDelegate: router.routerDelegate,
      routeInformationParser: router.routeInformationParser,
      routeInformationProvider: router.routeInformationProvider,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:personal_diary/screens/add_entry_screen.dart';
import 'package:personal_diary/screens/details_screen.dart';
import 'package:personal_diary/screens/homePage.dart';
import 'package:personal_diary/widgets/date_widget.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          colorScheme: const ColorScheme.light(
              primary: Colors.teal, background: Colors.black)),
      home: const HomePage(),
      routes: {
        RenderedListWidget.routeName: (context) => const AddEntry(),
        DateTellerWidget.routeName: (context) => const DetailsScreen(),
      },
    );
  }
}

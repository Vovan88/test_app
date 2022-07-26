import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test_application/bloc/bloc.dart';
import 'package:flutter_test_application/models/user.dart';
import 'package:flutter_test_application/ui/userinfo_screen.dart';
import 'package:flutter_test_application/widgets/user_card.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const FirstScreen(title: 'Users'),
    );
  }
}

class FirstScreen extends StatefulWidget {
  const FirstScreen({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  @override
  void initState() {
    getUsers();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: StreamBuilder<List<User>>(
          stream: streamUsers,
          builder: (BuildContext context, AsyncSnapshot<List<User>> snapshot) {
            if (snapshot.hasError) {
              Text(snapshot.error.toString());
            }

            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return UserCardWidget(
                      userCard: snapshot.data![index],
                      onTap: (user) {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(builder: (context) {
                            return UserInfoScreen(snapshot.data![index]);
                          }),
                        );
                      },
                    );
                  });
            }

            return const Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.amber,
                color: Colors.yellow,
              ),
            );
          }),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_test_application/bloc/bloc.dart';
import 'package:flutter_test_application/models/comment.dart';
import 'package:flutter_test_application/models/post.dart';
import 'package:flutter_test_application/widgets/comment_card%20.dart';

class PostDetailScreen extends StatefulWidget {
  final Post postCard;

  const PostDetailScreen(
    this.postCard, {
    Key? key,
  }) : super(key: key);

  @override
  PostDetailScreenState createState() => PostDetailScreenState();
}

class PostDetailScreenState extends State<PostDetailScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final bodyController = TextEditingController();

  @override
  void initState() {
    getComments(widget.postCard.id);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Stack(children: [
          Column(
            children: [
              Container(
                color: Colors.blue,
                height: 150,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Spacer(flex: 1),
                      Text("${widget.postCard.title} "),
                      const Spacer(flex: 1),
                      Text("${widget.postCard.body} "),
                      const Spacer(flex: 1),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Align(
                  alignment: Alignment.centerLeft, child: Text("Comments:")),
              Flexible(
                child: StreamBuilder<List<Comment>>(
                    stream: streamComments,
                    builder: (BuildContext context,
                        AsyncSnapshot<List<Comment>> snapshot) {
                      if (snapshot.hasError) {
                        Text(snapshot.error.toString());
                      }

                      if (snapshot.hasData) {
                        return ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (BuildContext context, int index) {
                              return CommentCardWidget(
                                commentCard: snapshot.data![index],
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
              ),
              TextButton(
                onPressed: (() {
                  showModalBottomSheet<void>(
                    isScrollControlled: true,
                    context: context,
                    builder: (BuildContext context) {
                      return Padding(
                        padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom,
                        ),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          height: 250,
                          color: Colors.amber,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                const Text('Add comment'),
                                TextField(
                                    controller: nameController,
                                    keyboardType: TextInputType.text,
                                    textCapitalization:
                                        TextCapitalization.sentences,
                                    maxLines: 1,
                                    decoration: const InputDecoration(
                                        filled: true,
                                        counterText: '',
                                        counterStyle: TextStyle(fontSize: 0),
                                        border: InputBorder.none,
                                        contentPadding:
                                            EdgeInsets.fromLTRB(5, 0, 0, 0),
                                        fillColor:
                                            Color.fromARGB(255, 243, 196, 196),
                                        focusColor: Colors.amber,
                                        hintText: "You name",
                                        hintStyle: TextStyle(
                                          color: Colors.purple,
                                          fontStyle: FontStyle.italic,
                                        ))),
                                const SizedBox(
                                  height: 10,
                                ),
                                TextField(
                                    controller: emailController,
                                    keyboardType: TextInputType.text,
                                    textCapitalization:
                                        TextCapitalization.sentences,
                                    maxLines: 1,
                                    decoration: const InputDecoration(
                                        filled: true,
                                        counterText: '',
                                        counterStyle: TextStyle(fontSize: 0),
                                        border: InputBorder.none,
                                        contentPadding:
                                            EdgeInsets.fromLTRB(5, 0, 0, 0),
                                        fillColor:
                                            Color.fromARGB(255, 243, 196, 196),
                                        focusColor: Colors.amber,
                                        hintText: "Your email",
                                        hintStyle: TextStyle(
                                          color: Colors.purple,
                                          fontStyle: FontStyle.italic,
                                        ))),
                                const SizedBox(
                                  height: 10,
                                ),
                                TextField(
                                    controller: bodyController,
                                    keyboardType: TextInputType.text,
                                    textCapitalization:
                                        TextCapitalization.sentences,
                                    maxLines: 1,
                                    decoration: const InputDecoration(
                                        filled: true,
                                        counterText: '',
                                        counterStyle: TextStyle(fontSize: 0),
                                        border: InputBorder.none,
                                        contentPadding:
                                            EdgeInsets.fromLTRB(5, 0, 0, 0),
                                        fillColor:
                                            Color.fromARGB(255, 243, 196, 196),
                                        focusColor: Colors.amber,
                                        hintText: "You name",
                                        hintStyle: TextStyle(
                                          color: Colors.purple,
                                          fontStyle: FontStyle.italic,
                                        ))),
                                ElevatedButton(
                                  child: const Text('Send'),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }),
                child: Container(
                  width: 100,
                  height: 40,
                  color: Colors.blue,
                  child: const Center(
                      child: Text("Add comment",
                          style: TextStyle(color: Colors.white))),
                ),
              ),
            ],
          ),
        ]),
      ),
    );
  }
}

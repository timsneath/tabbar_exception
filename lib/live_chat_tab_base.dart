import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:math';
import 'dart:convert';
// import 'package:cloud_firestore/cloud_firestore.dart';

const jsonCodec = const JsonCodec();

class LiveChatTabBase extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new ChatScreen(),
    );
  }
}

class ChatScreen extends StatefulWidget {
  @override
  State createState() => new ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin {
  final List<ChatMessage> _messages = <ChatMessage>[];
  final TextEditingController _textController = new TextEditingController();
  bool _isComposing = false;

  @override
  void dispose() {
    for (ChatMessage message in _messages)
      message.animationController.dispose();
    super.dispose();
  }

  Widget _buildTextComposer() {
    return new IconTheme(
      data: new IconThemeData(
        color: Theme.of(context).accentColor,
      ),
      child: new Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          new Row(
            children: <Widget>[
              new Container(
                margin: new EdgeInsets.only(
                  left: 5.0,
                ),
                child: new IconButton(
                  icon: new Icon(
                    Icons.add_circle,
                    color: Colors.black87,
                    size: 28.0,
                  ),
                  onPressed: () => _handleAddContent(),
                ),
              ),
              new Flexible(
                child: Padding(
                  padding: new EdgeInsets.only(
                    left: 5.0,
                  ),
                  child: new TextField(
                    controller: _textController,
                    maxLines: null,
//                    maxLength: 2000,
                    onChanged: (String text) {
                      setState(() {
                        _isComposing = text.replaceAll(" ", "").length > 0;
                      });
                    },
                    decoration: new InputDecoration.collapsed(
                      hintText: "Write a message",
                      hintStyle: new TextStyle(
                        color: Colors.black87,
                      ),
                    ),
                    style: new TextStyle(
                      color: Colors.black87,
                      fontSize: 17.0,
                    ),
//                    onChanged: () => _valueChanged(_textController.text),
                  ),
                ),
              ),
              new Container(
                margin: new EdgeInsets.only(
                  right: 5.0,
                ),
                child: _isComposing
                    ? Theme.of(context).platform == TargetPlatform.android
                        ? new IconButton(
                            icon: new Icon(
                              Icons.send,
                              color: Colors.black87,
                              size: 28.0,
                            ),
                            onPressed: () =>
                                _handleSubmitted(_textController.text),
                          )
                        : new CupertinoButton(
                            child: new Text('Send'),
                            onPressed: () =>
                                _handleSubmitted(_textController.text),
                          )
                    : new IconButton(
                        icon: new Icon(
                          Icons.keyboard_voice,
                          color: Colors.black87,
                          size: 28.0,
                        ),
                        onPressed: () => _handleVoiceInput(),
                      ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: new AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: new Text(
          'Live chat',
          style: new TextStyle(color: Theme.of(context).hintColor),
        ),
        elevation:
            Theme.of(context).platform == TargetPlatform.android ? 4.0 : 0.0,
      ),
      body: new Container(
          child: new Column(
            children: <Widget>[
              new Flexible(
                child:
               new ListView.builder(
                 padding: new EdgeInsets.all(8.0),
                 reverse: true,
                 itemBuilder: (_, int index) => _messages[index],
                 itemCount: _messages.length,
               ),

                //     new StreamBuilder(
                //   stream:
                //       Firestore.instance.collection('live_chat').snapshots(),
                //   builder: (context, snapshot) {
                //     if (!snapshot.hasData) return const Text('Loading...');

                //     return new ListView.builder(
                //       itemCount: snapshot.data.documents.length,
                //       padding: const EdgeInsets.all(8.0),
                //       reverse: true,
                //       itemExtent: 55.0,
                //       itemBuilder: (context, index) {
                //         DocumentSnapshot ds = snapshot.data.documents[index];
                //         return new Text(
                //           " ${ds['message']}",
                //           style: TextStyle(color: Colors.white70),
                //         );
                //       },
                //     );
                //   },
                // ),
              ),
              new Divider(
                height: 1.0,
              ),
              new Container(
                decoration: new BoxDecoration(
                  color: Theme.of(context).cardColor, //Colors.white70,
                ),
                child: _buildTextComposer(),
              ),
            ],
          ),
          decoration: Theme.of(context).platform == TargetPlatform.iOS
              ? new BoxDecoration(
                  border: new Border(
                    top: new BorderSide(color: Colors.grey[200]),
                  ),
                )
              : null),
    );
  }

  void _handleSubmitted(String text) {
    _textController.clear();
    setState(() {
      _isComposing = false;
    });

    // TODO: Change color to a color based on email id so that every person's color remains constant
    final String username = "sahilwad";
    List<int> ints = username.codeUnits;
    var range = new Random();

    ChatMessage message = new ChatMessage(
      text,
      ints[5] + ints[6],
      ints[2],
      ints[1] + ints[0],
      ints[3] + ints[4],
      new AnimationController(
        duration: new Duration(milliseconds: 400),
        vsync: this,
      ),
    );
    setState(() {
      _messages.insert(0, message);
    });
    message.animationController.forward();
  }

  _handleVoiceInput() {
    print('Voice input method');
  }

  _handleAddContent() {
    print('Add content clicked');
  }
}

class ChatMessage extends StatelessWidget {
  final String text;
  final int colorA;
  final int colorR;
  final int colorG;
  final int colorB;
  final AnimationController animationController;

  ChatMessage(this.text, this.colorA, this.colorR, this.colorG, this.colorB,
      this.animationController);

  @override
  Widget build(BuildContext context) {
    return new SizeTransition(
      sizeFactor: new CurvedAnimation(
        parent: animationController,
        curve: Curves.easeOut,
      ),
      axisAlignment: 0.0,
      child: new Container(
        margin: const EdgeInsets.symmetric(vertical: 7.0),
        child: new Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Container(
              margin: const EdgeInsets.only(
                right: 10.0,
              ),
              child: new Padding(
                padding: new EdgeInsets.only(top: 12.0),
                child: new CircleAvatar(
                  maxRadius: 13.0,
                  backgroundColor:
                      Color.fromARGB(colorA, colorR, colorG, colorB),
                ),
              ),
            ),
            new Expanded(
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Padding(
                        padding: new EdgeInsets.only(
                          bottom: 4.0,
                          right: 35.0,
                        ),
                        child: new Text(
                          '25 June 2018, 4:11 am',
                          style: new TextStyle(
                            color: Theme.of(context).platform ==
                                    TargetPlatform.android
                                ? Colors.white70
                                : Colors.black54,
                            fontSize: 12.0,
                            letterSpacing: 0.6,
                          ),
                        ),
                      ),
                    ],
                  ),
                  new Container(
                    width: 300.0,
                    child: new Text(
                      text,
                      style: new TextStyle(
                        color:
                            Theme.of(context).platform == TargetPlatform.android
                                ? Colors.white
                                : Colors.black87,
                        letterSpacing: 0.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
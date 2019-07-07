import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:vinyl/services/tdlib/platform-linker.dart';

class SearchForm extends StatefulWidget {
  SearchForm({Key key}) : super(key: key);

  _SearchFormState createState() => _SearchFormState();
}

class _SearchFormState extends State<SearchForm> {
  var _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Visibility(
      child: Container(
        child: Row(
          children: <Widget>[
            Container(
              width: 250,
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: TextField(
                controller: _controller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    //  border: InputBorder.none,
                    labelText: 'Search'),
              ),
            ),
            RaisedButton(
                child: Text('Search'),
                onPressed: () async {

                  var filter = {'@type': 'searchMessagesFilterAudio'};

                  var request = {
                    "@type": "searchChatMessages",
                    "chat_id": -1001130520198,
                    "query": _controller.text,
                    "sender_user": 0,
                    "from_message_id": 0,
                    "offset": 0,
                    "limit": 50,
                    "filter": filter
                  };

                  // var request = {
                  //   "@type": "searchPublicChat",
                  //   "username": "Rockmusicbest"
                  // };
                  print(jsonEncode(request));

                  await TdLibJSON.send(request: jsonEncode(request));

                  setState(() {
                    _controller.text = '';
                  });
                })
          ],
        ),
      ),
    );
  }
}

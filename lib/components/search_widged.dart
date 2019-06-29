import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:vinyl/services/platform/tdlibjson.dart';

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
                  var request = {
                    "@type": "searchMessages",
                    "query": _controller.text,
                    "offset_date": 1561029797,
                    "offset_chat_id": 0,
                    "offset_message_id": 0,
                    "limit": 5
                  };

                  print(jsonEncode(request));

                  await TdLibJSON.send(request: jsonEncode(request));

                  request = {
                    "@type": "checkAuthenticationCode",
                    "code": _controller.text
                  };

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

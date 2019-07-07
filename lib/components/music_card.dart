import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:vinyl/services/tdlib/platform-linker.dart';

class MusicCard extends StatefulWidget {
  bool isPlaying = false;
  String title;
  int size;
  int id;
  String file_name;
  MusicCard({Key key, this.title, this.id, this.size, this.file_name}) : super(key: key);

  _MusicCardState createState() => _MusicCardState();
}

class _MusicCardState extends State<MusicCard> {


  @override
  Widget build(BuildContext context) {
    bool isPlaying = false;
    return Container(
        child: Row(
          children: <Widget>[
            Container(
              width: 180,
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                widget.title
              ),
            ),
            RaisedButton(
                child: Text('Load'),
                onPressed: () async {
                   var request = {
                    "@type": "downloadFile",
                    "priority": 1,
                    "file_id": widget.id,
                    "offset": 0,
                    "limit": widget.size,
                    "synchronous": true
                  };

                  var string = jsonEncode(request);
                  print(string);

                  await TdLibJSON.send(request: string);
                }),
            RaisedButton(
                child: Text('Play'),
                onPressed: () async {
                  if(!isPlaying){
                    TdLibJSON.play(title: widget.file_name);
                    isPlaying = true;
                  }else{
                    TdLibJSON.pause();
                    isPlaying = false;
                  }
                  
                })
          ],
        ),
    );
  }
}

class _title {
}

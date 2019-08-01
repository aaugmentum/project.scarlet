import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vinyl/components/animated_play_button.dart';
import 'package:vinyl/utils/constants.dart';
import 'package:vinyl/styles.dart';

final albums = [
  'Homework',
  'Discovery',
  'Human After All',
  'Random Access Memories',
];

class HomeScreen extends StatelessWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Container(
        padding: EdgeInsets.only(top: 16, left: 8, right: 8),
        color: backgroundColor,
        child: Stack(
          overflow: Overflow.clip,
          children: [
            CustomScrollView(
              physics: BouncingScrollPhysics(),
              primary: false,
              slivers: [
                SliverPadding(
                  sliver: SliverGrid.count(
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    crossAxisCount: 2,
                    children: List.generate(
                      12,
                      (index) => _buildAlbumTile(context, index),
                    ),
                  ),
                  padding: EdgeInsets.all(10),
                ),
              ],
            ),
            Positioned(
              height: 80,
              bottom: 0,
              left: 0,
              right: 0,
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                    side: BorderSide(color: Colors.white30, width: 0.5)),
                color: appBarColor,
                child: Hero(
                  tag: 'cover',
                  child: Material(
                    color: appBarColor,
                    child: ListTile(
                      onTap: () =>
                          Navigator.pushNamed(context, playerRoute),
                      leading: Image.asset('assets/covers/4.jpg'),
                      title: Text(
                        'Get Lucky',
                        style: TextStyle(color: Colors.white),
                      ),
                      subtitle: Text(
                        'Daft Punk',
                        style: TextStyle(color: Colors.white54),
                      ),
                      trailing: AnimatedPlayButton(size: 40),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Container _buildAlbumTile(BuildContext context, int index) => Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white30),
        ),
        // margin: EdgeInsets.only(left: 8, right: 8, bottom: 16, top: 0),
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(context, albumRoute);
          },
          child: GridTile(
            child: Image.asset(
              'assets/covers/${index % 4 + 1}.jpg',
              fit: BoxFit.cover,
            ),
            footer: GridTileBar(
              title: Text(albums[index % 4]),
              subtitle: Text('Daft Punk'),
            ),
          ),
        ),
      );

  AppBar _buildAppBar() => AppBar(
        title: Text(
          'Library',
          style: TextStyle(color: textColor),
        ),
        backgroundColor: appBarColor,
        actions: [
          LayoutBuilder(
            builder: (context, constraints) => IconButton(
              icon: Icon(
                FontAwesomeIcons.search,
                size: 16,
                color: Colors.white70,
              ),
              onPressed: () {
                final snackbar = SnackBar(
                  backgroundColor: appBarColor,
                  content: Text(
                    'To be implemented...',
                    style: TextStyle(color: textColor),
                  ),
                );
                Scaffold.of(context).showSnackBar(snackbar);
              },
            ),
          ),
        ],
      );
}

import 'package:dsc_project/home.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage>
    with SingleTickerProviderStateMixin {
  int flag;
  AnimationController _animationController;
  Animation _animation;
  @override
  void initState() {
    super.initState();
    flag = 0;
    _animationController =
        AnimationController(duration: Duration(seconds: 3), vsync: this)
          ..repeat(period: Duration(seconds: 3), reverse: true);
    _animation = ColorTween(begin: Colors.blue, end: Colors.deepPurple).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeIn))
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: _animation.value,
      ),
      drawer: Drawer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              flex: 6,
              child: Container(
                  height: MediaQuery.of(context).size.height * 0.3,
                  color: _animation.value,
                  child: Stack(children: [
                    Positioned(
                        bottom: 10.0,
                        left: 10.0,
                        child: Text(
                          "Demo app DSC",
                          style: TextStyle(color: Colors.white, fontSize: 20.0),
                        )),
                  ])),
            ),
            Expanded(
                flex: 2,
                child: ListTile(
                    leading: Icon(Icons.home),
                    title: Text("Home"),
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => HomePage()))))),
            Expanded(
              flex: 2,
              child: ListTile(
                  focusColor: Colors.white,
                  hoverColor: Colors.white,
                  title: Text("About"),
                  leading: Icon(Icons.info),
                  onTap: () => Navigator.pop(context)),
            ),
            Expanded(
              flex: 12,
              child: Container(
                color: Colors.white,
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                height: 30.0,
                color: _animation.value,
                child: Center(
                    child: Text(
                  "Powered by google developers",
                  style: TextStyle(color: Colors.white),
                )),
              ),
            )
          ],
        ),
      ),
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 28.0),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.height * 0.2,
                  child: Image.asset("Images/DSCLogoColor.png"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 28.0, bottom: 50),
                child: Container(
                  child: Text(
                    'Developer Student Clubs is a community where everyone \nis welcome. We help students bridge the gap between \ntheory and practice and grow their knowledge by \nproviding a peer-to-peer learning environment, by \nconducting workshops, study jams and building solutions \nfor local businesses. Developer Student Clubs is a \nprogram supported by Google Developers.',
                    style: TextStyle(
                      fontFamily: 'Open Sans',
                      fontSize: 11,
                      color: const Color(0xff0a0a0a),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              GestureDetector(
                onTapDown: (details) {
                  _launchUrl();
                  setState(() {
                    flag = 1;
                  });
                },
                onTapUp: (details) {
                  setState(() {
                    flag = 0;
                  });
                },
                child: Container(
                    width: MediaQuery.of(context).size.width * 0.86,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color:
                          (flag == 0) ? Colors.white : const Color(0xff8484ff),
                      border: Border.all(
                          width: 1.0, color: const Color(0xff8484ff)),
                    ),
                    child: Center(
                      child: Text(
                        'Visit dscsastra.com',
                        style: TextStyle(
                          fontFamily: 'Helvetica',
                          fontSize: 15,
                          color: const Color(0xff8484ff),
                        ),
                        textAlign: TextAlign.left,
                      ),
                    )),
              )
            ],
          )),
    );
  }

  _launchUrl() async {
    const url = "https://dscsastra.com";
    if (await canLaunch(url)) {
      await launch(url, forceWebView: true, enableJavaScript: true);
    } else {
      throw 'Could not lanuch $url';
    }
  }
}

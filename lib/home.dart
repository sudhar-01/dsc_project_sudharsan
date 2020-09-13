import 'package:dsc_project/About.dart';
import 'package:dsc_project/Network.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  Future events;
  String url = "https://wayhike.com/dsc/demo_app_api.php";
  AnimationController _animationController;
  Animation _animation;
  @override
  void initState() {
    super.initState();
    events = Network(url).getData();
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
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: FutureBuilder(
            future: events,
            builder: (context, AsyncSnapshot<dynamic> snapshot) {
              if (!snapshot.hasData)
                return Center(
                    child: Container(child: CircularProgressIndicator()));
              else {
                List<dynamic> eventList = snapshot.data["event_titles"];
                return ListView.builder(
                    itemCount: eventList.length,
                    itemBuilder: (context, int index) => Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          child: Container(
                            width: 377.0,
                            height: 65.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: const Color(0xffffffff),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0x29000000),
                                  offset: Offset(0, 3),
                                  blurRadius: 6,
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                  child: Text(
                                eventList[index].toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15.0),
                              )),
                            ),
                          ),
                        ));
              }
            }),
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
                  onTap: () => Navigator.pop(context)
            ),
            ),
             Expanded(
              flex: 2,
              child: ListTile(
                  focusColor: Colors.white,
                  hoverColor: Colors.white,
                  title: Text("About"),
                  leading: Icon(Icons.info),
                  onTap: () => Navigator.push(context,
                      MaterialPageRoute(builder: ((context) => AboutPage())))),
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
    );
  }
}

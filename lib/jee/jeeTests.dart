import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';


class JeeTests extends StatefulWidget {
  const JeeTests({Key? key}) : super(key: key);

  @override
  _JeeTestsState createState() => _JeeTestsState();
}

class _JeeTestsState extends State<JeeTests> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Column(
            children: [
              SizedBox(height:50),
              Align(
                alignment: Alignment.topLeft,
                child: Text("Tests", style: TextStyle(fontSize: 30, color: Colors.white),),
              ),
              SizedBox(height:10),
              Align(
                alignment: Alignment.topLeft,
                child: Text("Take JEE Tests anytime, anywhere", style: TextStyle(color: Colors.white, fontSize: 13),)
              ),
            ],
          ),
          backgroundColor: Colors.purple,
          toolbarHeight: 120,
        ),
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Align(
                child: Text("JEE Mains", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                alignment: Alignment.topLeft,
              ),
            ),
            SingleChildScrollView(
              child: Row(children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: IconButton(
                    onPressed: () {},
                    icon:  Image.asset("assets/images/allindiatest.png"),
                    iconSize: 200
                  )
              ),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    child: IconButton(
                        onPressed: () {print("HEY!");},
                        icon:  Image.asset("assets/images/allindiatest.png"),
                        iconSize: 200
                    )
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    child: IconButton(
                        onPressed: () {print("HEY!");},
                        icon:  Image.asset("assets/images/allindiatest.png"),
                        iconSize: 200
                    )
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    child: IconButton(
                        onPressed: () {print("HEY!");},
                        icon:  Image.asset("assets/images/allindiatest.png"),
                        iconSize: 200
                    )
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    child: IconButton(
                        onPressed: () {print("HEY!");},
                        icon:  Image.asset("assets/images/allindiatest.png"),
                        iconSize: 200
                    )
                ),
              ],),
              scrollDirection: Axis.horizontal,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Align(
                child: Text("JEE Advanced", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                alignment: Alignment.topLeft,
              ),
            ),
            SingleChildScrollView(
              child: Row(children: [
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    child: IconButton(
                        onPressed: () {print("HEY!");},
                        icon:  Image.asset("assets/images/allindiatest.png"),
                        iconSize: 200
                    )
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    child: IconButton(
                        onPressed: () {print("HEY!");},
                        icon:  Image.asset("assets/images/allindiatest.png"),
                        iconSize: 200
                    )
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    child: IconButton(
                        onPressed: () {print("HEY!");},
                        icon:  Image.asset("assets/images/allindiatest.png"),
                        iconSize: 200
                    )
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    child: IconButton(
                        onPressed: () {print("HEY!");},
                        icon:  Image.asset("assets/images/allindiatest.png"),
                        iconSize: 200
                    )
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    child: IconButton(
                        onPressed: () {print("HEY!");},
                        icon:  Image.asset("assets/images/allindiatest.png"),
                        iconSize: 200
                    )
                ),
              ],),
              scrollDirection: Axis.horizontal,
            ),
          ],
        ),
      )
    );
  }
}

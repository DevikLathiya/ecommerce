import 'package:hindustane_ecommerce/AppConfig/app_config.dart';
import 'package:hindustane_ecommerce/utils/styles.dart';
import 'package:hindustane_ecommerce/view/MainNavigation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supercharged/supercharged.dart';

class Introscreen extends StatefulWidget {

  @override
  State<Introscreen> createState() => _IntroscreenState();
}

class _IntroscreenState extends State<Introscreen> {
  // final _introKey = GlobalKey<IntroductionScreenState>();
  int currentPage = 0;
  List myText = [
    "We provide high\n quality products\n just for you.",
    "Your satisfaction is\n our number one\n priority.",
    "Let's fulfill your daily\n need with Meghalayan Age\n right now!"
  ];

  List splashData = ["assets/first.jpg", "assets/second.jpg", "assets/third.jpg"];
  PageController controller = PageController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller=PageController(
        initialPage: currentPage
    );
  }
  @override
  Widget build(BuildContext context) {
    var hight = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: PageView.builder(
        controller: controller,
        physics: ScrollPhysics(),
        onPageChanged: (value) {
          setState(() {
            currentPage = value;
          });
        },
        itemCount: splashData.length,
        itemBuilder: (context, index) =>
            Stack(
                children:[
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(splashData[index]),
                        fit: BoxFit.cover,
                        colorFilter:
                        const ColorFilter.mode(Color(0xff7A7A7A), BlendMode.modulate),
                      ),
                    ),
                    child: Container(
                      // margin: EdgeInsets.only(bottom: kDefaultPadding.h * 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [

                          index<2 ? InkWell(onTap: () async {
                            SharedPreferences prefs = await SharedPreferences.getInstance();
                            await prefs.setBool('seen', true);
                            Navigator.of(context).pushReplacement(
                                new MaterialPageRoute(builder: (context) =>  MainNavigation(navIndex: 0,)));
                          },
                            child:  Container(
                              padding: EdgeInsets.only(top:50,right: 20),
                              alignment: Alignment.topRight,
                              child: Text("Skip",style:  TextStyle(
                                  color: Colors.white,
                                  fontSize: 18
                              )),
                            ),) : SizedBox(),
                          Spacer(),
                          Text(
                            myText[index],
                            textAlign: TextAlign.center,
                            style:  TextStyle(
                                color: Colors.white,fontWeight: FontWeight.w500,
                                fontSize: 24
                            ),
                          ),
                          SizedBox(height:  30,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                              splashData.length,
                                  (index) => buildDot(index: index),
                            ),
                          ),

                          SizedBox(height: 50,),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: SizedBox(
                              height: 45,
                              width: double.infinity,
                              child:  ElevatedButton(
                                style: ButtonStyle(
                                    shape: MaterialStatePropertyAll(
                                        RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0),)),
                                    tapTargetSize: MaterialTapTargetSize.padded, backgroundColor: MaterialStatePropertyAll(Colors.red)),

                                onPressed: () {
                                  if (index < splashData.length - 1) {
                                    controller.nextPage(
                                      duration: Duration(milliseconds: 500),
                                      curve: Curves.ease,
                                    );
                                  } else {
                                    // Last page, navigate to the desired screen
                                    // For example, navigate to the home screen
                                    Navigator.push(context as BuildContext, MaterialPageRoute(builder: (context){
                                      return MainNavigation(navIndex: 0,);
                                    }));
                                  }
                                },
                                child: Text(index < splashData.length - 1 ? 'Next' : 'Get Started'),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ]
            ),
      ),
    );
  }
  AnimatedContainer buildDot({int index}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 900),
      margin: const EdgeInsets.only(right: 5),
      height: 6,
      width: currentPage == index ? 20 : 6,
      decoration: BoxDecoration(
        color: currentPage == index
            ?  Colors.white
            : Colors.grey,
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}

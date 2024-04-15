import 'package:flutter/material.dart';
import 'package:trading_app_flutter/View/NavBar.dart';
 class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    return SafeArea(child: 
    Scaffold(body: Container(
      height: myHeight,
      width: myWidth,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Image.asset('assets/images/1.gif'),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text("The Flutter", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
              Text("Learn about cryptocurency, look to", style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal, color: Colors.grey),),
              Text("the future in IO Crypto", style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal, color: Colors.grey),),
           ],
          ),
           Padding(
            padding:  EdgeInsets.symmetric(horizontal: myWidth * 0.14),
            child: GestureDetector(
              onTap: () => {
                Navigator.push(context, MaterialPageRoute(builder:  (context) => NavBar()))
              },
              child: Container(
              decoration: BoxDecoration(
                color: Colors.yellow,
                borderRadius: BorderRadius.circular(45.0)
                
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Create Your Portfolito', style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal),),
                    RotationTransition(turns: AlwaysStoppedAnimation(310 / 360),
                    child: Icon(Icons.arrow_forward_rounded),
                    )
                  ],
                ),
              ),
              ),
            ),
          ),
          
        ],
      ),
    ),
    ),
    );
  }
}

import 'package:flutter/material.dart';
import '../../home/page/home_page.dart';
class InitialPage extends StatefulWidget {
  const InitialPage({super.key});
  @override
  State<InitialPage> createState() => _InitialPageState();
}
class _InitialPageState extends State<InitialPage> with SingleTickerProviderStateMixin {
  late final AnimationController animation;
  @override
  void initState() {
    super.initState();
    animation = AnimationController(vsync:this, duration:const Duration(milliseconds:900))..forward();
    Future.delayed(const Duration(milliseconds:1300), () { if (mounted) Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const HomePage())); });
  }
  @override
  void dispose() { animation.dispose(); super.dispose(); }
  @override
  Widget build(BuildContext context) => Scaffold(body: Center(child: FadeTransition(opacity:animation, child: const Column(mainAxisSize:MainAxisSize.min, children:[Icon(Icons.location_on,size:90,color:Colors.indigo),SizedBox(height:12),Text('FastLocation',style:TextStyle(fontSize:30,fontWeight:FontWeight.bold))]))));
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:realestatemanager/controller/apt_controller.dart';
import 'package:realestatemanager/view/add_apt.dart';

import 'db/db_helper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DBHelper.initDb();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        // if it's a RTL language
      ],
      supportedLocales: [
        const Locale('ko', 'KR'),
        // include country code too
      ],
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _aptController = Get.put(AptController());



  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    _aptController.getData();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text('부동산 매니저'),
        ),
        body: Padding(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 2.0),
          child: Container(
            child: Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  child:Text('부동산 중도금 현황', style: TextStyle(fontSize: 20, color: Colors.blue),),
                ),
                Expanded(child: Obx((){
                  return ListView.builder(

                      itemCount: _aptController.aptList.length,
                      itemBuilder: (_,index) {
                    return Container(
                      width: 100,
                      height: 100,

                      margin: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.white70,),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              _aptController.aptList[index].owner!, style: TextStyle(color: Colors.grey),
                          ),
                          Text(
                            _aptController.aptList[index].apt!, style: TextStyle(fontSize: 19),
                          ),
                          Text(
                            _aptController.aptList[index].price.toString(),
                          ),
                        ],
                      ),
                    );
                  });
                }
                ))
              ],
            ),
          )
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            var result = await Get.to(AddAptPage());
            _aptController.getData();
          },
          tooltip: 'Increment',
          child: Icon(Icons.add),
        ), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:foodex/items/resto_list.dart';
import 'package:foodex/pages/home_page.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'models/Cart.dart';
import 'models/Orders.dart';
import 'models/Product.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ProductDataProvider>(
          create: (context) => ProductDataProvider(),
        ),
        ChangeNotifierProvider<CartDataProvider>(
          create: (context) => CartDataProvider(),
        ),
        ChangeNotifierProvider<Orders>(
          create: (context) => Orders(),
        ),
        ChangeNotifierProvider<Orders>(
          create: (context) => Orders(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Demo App',
        theme: ThemeData(
          primarySwatch: Colors.green,
          backgroundColor: Colors.white,
          textTheme: GoogleFonts.robotoTextTheme(
            Theme.of(context).textTheme,
          ),
        ),
        // home: ListinItems(),
        home: RestoList(),
        // home: SplashScreen(),

        // home: HomePage(),
        // home: HiPage(),
      ),
    );
  }
}

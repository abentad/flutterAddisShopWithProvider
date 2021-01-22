import 'package:ShoppingAppWithProvider/controllers/homePageProvider.dart';
import 'package:ShoppingAppWithProvider/services/apiHelper.dart';
import 'package:ShoppingAppWithProvider/view/details.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  //methods
  _showSnackBar(String message, {Color bgColor}) {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: bgColor ?? Colors.red,
        duration: Duration(seconds: 5),
      ),
    );
  }

  // _hideSnackBar() {
  //   _scaffoldKey.currentState.hideCurrentSnackBar();
  // }

  _getDiscoveryProduct() async {
    var provider = Provider.of<HomePageProvider>(context, listen: false);
    var httpResponse = await ApiHelper.getProducts();
    if (httpResponse.isSuccessful) {
      provider.setProducts(httpResponse.data);
    } else {
      _showSnackBar(httpResponse.message);
    }
    provider.setIsProcessing(false);
    provider.products.shuffle();
  }

  void navigateToDetailsScreen() {
    Navigator.of(context)
        .push(CupertinoPageRoute(builder: (context) => Details()));
  }

  @override
  void initState() {
    super.initState();
    _getDiscoveryProduct();
  }

  @override
  Widget build(BuildContext context) {
    //vars
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {},
          icon: FaIcon(FontAwesomeIcons.hamburger, color: Colors.black),
        ),
        title: Text('Addis Shop', style: TextStyle(color: Colors.black)),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: FaIcon(FontAwesomeIcons.search, color: Colors.black),
          ),
          IconButton(
            onPressed: () {},
            icon: FaIcon(FontAwesomeIcons.cartPlus, color: Colors.black),
          )
        ],
      ),
      body: Container(
        // padding: EdgeInsets.symmetric(horizontal: 15.0),
        height: deviceHeight,
        width: deviceWidth,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0),
              child: Text("Discover",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24.0,
                    fontWeight: FontWeight.w700,
                  )),
            ),
            //discovery
            SizedBox(height: 10.0),
            Consumer<HomePageProvider>(
              builder: (context, provider, widget) {
                return provider.isProcessing
                    ? Container(
                        height: deviceHeight * 0.4,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      )
                    : Container(
                        height: deviceHeight * 0.4,
                        child: ListView.builder(
                          physics: BouncingScrollPhysics(),
                          padding: EdgeInsets.symmetric(horizontal: 15.0),
                          scrollDirection: Axis.horizontal,
                          itemCount: provider.products.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                provider.setSelectedIndex(index);
                                navigateToDetailsScreen();
                              },
                              child: Container(
                                margin: EdgeInsets.only(
                                    right: 20.0, bottom: 30.0, top: 15.0),
                                width: deviceWidth * 0.4,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: CachedNetworkImageProvider(
                                      provider.products[index].image,
                                    ),
                                    fit: BoxFit.fill,
                                  ),
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(10.0),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      blurRadius: 10.0,
                                      offset: Offset(-2, 9),
                                    ),
                                  ],
                                ),
                                //TODO: child
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    gradient: LinearGradient(
                                      colors: [
                                        Colors.white.withOpacity(0.1),
                                        Colors.black.withOpacity(0.9)
                                      ],
                                      stops: [0.5, 0.9],
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                    ),
                                  ),
                                  child: Column(
                                    children: [
                                      Spacer(),
                                      Text(
                                        provider.products[index].title,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14.0,
                                        ),
                                      ),
                                      SizedBox(height: 10.0),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      );
              },
            ),
          ],
        ),
      ),
    );
  }
}

//   //https://fakestoreapi.com/products/categories
//   //https://fakestoreapi.com/products/category/electronics
//   //https://fakestoreapi.com/products
//   //https://fakestoreapi.com/products?limit=5

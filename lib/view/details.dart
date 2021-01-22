import 'package:ShoppingAppWithProvider/controllers/homePageProvider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class Details extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<HomePageProvider>(context);

    var product = provider.getProductByIndex(provider.selectedIndex);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: FaIcon(FontAwesomeIcons.arrowLeft, color: Colors.black),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: FaIcon(FontAwesomeIcons.cartPlus, color: Colors.black),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: ListView(
            physics: BouncingScrollPhysics(),
            // crossAxisAlignment: CrossAxisAlignment.start,
            // shrinkWrap: true,
            children: [
              // SizedBox(height: 50.0),
              CachedNetworkImage(
                imageUrl: product.image,
                height: 200.0,
                width: double.infinity,
                fit: BoxFit.contain,
              ),
              SizedBox(height: 20.0),
              Text(
                product.title,
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20.0),
              Text(
                "Description",
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 5.0),
              Text(
                product.description,
                style: TextStyle(
                  fontSize: 12.0,
                ),
              ),
              SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Category',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    product.category,
                    style: TextStyle(
                      fontSize: 14.0,
                    ),
                  )
                ],
              ),
              SizedBox(height: 5.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Price',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "\$${product.price}",
                    style: TextStyle(
                      fontSize: 14.0,
                    ),
                  )
                ],
              ),
              SizedBox(height: 30.0),
              MaterialButton(
                height: 50.0,
                onPressed: () {},
                color: Colors.teal,
                child: Row(
                  children: [
                    FaIcon(FontAwesomeIcons.cartPlus, color: Colors.white),
                    SizedBox(width: 20.0),
                    Text(
                      "Add To Card",
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 10.0),
            ],
          ),
        ),
      ),
    );
  }
}

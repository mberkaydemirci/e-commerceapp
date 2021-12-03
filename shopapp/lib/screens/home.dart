import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/provider/product.dart';
import 'package:shopapp/helpers/common.dart';
// my own import
import 'package:shopapp/screens/cart.dart';
import 'package:shopapp/provider/user.dart';
import 'package:shopapp/screens/product_search.dart';
import 'package:shopapp/widgets/custom_app_bar.dart';
import 'package:shopapp/widgets/custom_text.dart';
import 'package:shopapp/widgets/featured_products.dart';
import 'package:shopapp/widgets/product_card.dart';
import 'package:shopapp/widgets/search.dart';
import 'cart.dart';
import 'order.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _searchController = TextEditingController();
  final key = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    final userProvider = Provider.of<UserProvider>(context);

    /* Widget image_carousel = new Container(
      height: 200,
      child: CarouselSlider(
          options: CarouselOptions(
            autoPlay: true,
            autoPlayCurve: Curves.fastOutSlowIn,
            autoPlayAnimationDuration: Duration(seconds: 2),
          ),
          items: imageList.map((e) {
            BoxFit.cover;
            return Image.asset(e);
          }).toList()),
    );*/
    return Scaffold(
        key: key,
        backgroundColor: white,
        drawer: Drawer(
          child: ListView(
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountName: CustomText(
                  text: userProvider.userModel?.name ?? "username loading...",
                  color: white,
                  weight: FontWeight.bold,
                  size: 18,
                ),
                accountEmail: CustomText(
                    text: userProvider.userModel?.email! ??
                        "email is loadingggg...",
                    color: white),
                decoration: BoxDecoration(color: white),
              ),
              ListTile(
                onTap: () async {
                  await userProvider.getOrders();
                  changeScreen(context, OrdersScreen());
                },
                leading: Icon(Icons.bookmark_border),
                title: CustomText(text: "My orders"),
              ),
              ListTile(
                onTap: () {
//                userProvider.signOut();
                },
                leading: Icon(Icons.exit_to_app),
                title: CustomText(text: "Log out"),
              ),
            ],
          ),
        ),
        body: SafeArea(
            child: ListView(
          children: [
            Stack(children: [
              Positioned(
                  top: 10,
                  right: 20,
                  child: Align(
                    alignment: Alignment.topRight,
                    child: GestureDetector(
                      onTap: () {
                        key.currentState!.openEndDrawer();
                      },
                      child: Icon(Icons.menu),
                    ),
                  )),
              Positioned(
                top: 10,
                right: 60,
                child: Align(
                  alignment: Alignment.topRight,
                  child: Icon(Icons.shopping_cart),
                ),
              ),
              Positioned(
                top: 10,
                right: 100,
                child: Align(
                    alignment: Alignment.topRight,
                    child: GestureDetector(
                        onTap: () {
                          key.currentState!.showSnackBar(
                              SnackBar(content: Text("User profile")));
                        },
                        child: Icon(Icons.person))),
              ),
              Container(
                decoration: BoxDecoration(
                    color: white,
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(20),
                        bottomLeft: Radius.circular(20))),
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 8, left: 8, right: 8, bottom: 10),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: ListTile(
                      leading: Icon(
                        Icons.search,
                        color: black,
                      ),
                      title: TextField(
                        textInputAction: TextInputAction.search,
                        onSubmitted: (pattern) async {
                          await productProvider.search(productName: pattern);
                          changeScreen(context, ProductSearchScreen());
                        },
                        decoration: InputDecoration(
                          hintText: "blazer, dress...",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ]),
            //CustomAppBar(),
            //Search(),
            //image_carousel,
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(14),
                  child: Container(
                    child: Text("Featured products"),
                    alignment: Alignment.centerLeft,
                  ),
                ),
              ],
            ),
            FeaturedProducts(),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(14),
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: Text("Recent Products"),
                  ),
                ),
              ],
            ),
            //grid view
            Column(
              children: productProvider.products
                  .map((item) => GestureDetector(
                          child: ProductCard(
                        product: item,
                      )))
                  .toList(),
            )
            //Flexible(child: Products()),
          ],
        )));
  }
}

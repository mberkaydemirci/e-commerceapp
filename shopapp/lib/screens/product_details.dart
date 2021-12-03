import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/helpers/common.dart';
import 'package:shopapp/main.dart';
import 'package:shopapp/models/product.dart';
import 'package:shopapp/provider/app.dart';
import 'package:shopapp/provider/user.dart';
import 'package:shopapp/screens/cart.dart';
import 'package:shopapp/screens/home.dart';
import 'package:shopapp/widgets/custom_text.dart';
import 'package:shopapp/widgets/loading.dart';
import 'package:transparent_image/transparent_image.dart';

class ProductDetails extends StatefulWidget {
  final ProductModel product;

  const ProductDetails({Key? key, required this.product}) : super(key: key);

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  final _key = GlobalKey<ScaffoldState>();
  late String _color = widget.product.colors[0];
  late String _size = widget.product.size[0];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _color = widget.product.colors[0];
    _size = widget.product.size[0];
    print(_color);
    print(_size);
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final appProvider = Provider.of<AppProvider>(context);

    return Scaffold(
      key: _key,
      body: SafeArea(
          child: Container(
        color: Colors.black.withOpacity(0.9),
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Positioned.fill(
                    child: Align(
                  alignment: Alignment.center,
                  child: Loading(),
                )),
                Center(
                  child: FadeInImage.memoryNetwork(
                    placeholder: kTransparentImage,
                    image: widget.product.picture,
                    fit: BoxFit.fill,
                    height: 400,
                    width: double.infinity,
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                      height: 100,
                      decoration: BoxDecoration(
                        // Box decoration takes a gradient
                        gradient: LinearGradient(
                          // Where the linear gradient begins and ends
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          // Add one stop for each color. Stops should increase from 0 to 1
                          colors: [
                            // Colors are easy thanks to Flutter's Colors class.
                            Colors.black.withOpacity(0.7),
                            Colors.black.withOpacity(0.5),
                            Colors.black.withOpacity(0.07),
                            Colors.black.withOpacity(0.05),
                            Colors.black.withOpacity(0.025),
                          ],
                        ),
                      ),
                      child: Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Container())),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                      height: 352,
                      decoration: BoxDecoration(
                        // Box decoration takes a gradient
                        gradient: LinearGradient(
                          // Where the linear gradient begins and ends
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          // Add one stop for each color. Stops should increase from 0 to 1
                          colors: [
                            // Colors are easy thanks to Flutter's Colors class.
                            Colors.black.withOpacity(0.8),
                            Colors.black.withOpacity(0.6),
                            Colors.black.withOpacity(0.6),
                            Colors.black.withOpacity(0.4),
                            Colors.black.withOpacity(0.07),
                            Colors.black.withOpacity(0.05),
                            Colors.black.withOpacity(0.025),
                          ],
                        ),
                      ),
                      child: Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Container())),
                ),
                Positioned(
                    bottom: 0,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              //'Product Blazer',
                              widget.product.name,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w300,
                                  fontSize: 20),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              '' + widget.product.price.toString(),
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    )),
                Positioned(
                  right: 0,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: InkWell(
                      onTap: () {
                        changeScreen(context, CartScreen());
                      },
                      child: Padding(
                          padding: const EdgeInsets.all(4),
                          child: Card(
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(Icons.shopping_cart),
                            ),
                          )),
                    ),
                  ),
                ),
                Positioned(
                  top: 120,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: InkWell(
                      onTap: () {
                        print("CLICKED");
                        Navigator.pop(context);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(35))),
                        child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Icon(
                                Icons.close,
                                color: Colors.white,
                              ),
                            )),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black,
                          offset: Offset(2, 5),
                          blurRadius: 10)
                    ]),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(0),
                      child: Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: CustomText(
                              text: "Select a Color",
                              size: 16,
                              color: Colors.white,
                              weight: FontWeight.normal,
                            ),
                            /*Text(
                                "Select a Color",
                                style: TextStyle(color: Colors.white),
                              )*/
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: DropdownButton<String>(
                                value: _color,
                                style: TextStyle(color: Colors.blue),
                                items: widget.product.colors
                                    .map<DropdownMenuItem<String>>(
                                        (value) => DropdownMenuItem(
                                            value: value,
                                            child: CustomText(
                                              text: value.toString(),
                                              size: 16,
                                              color: Colors.red,
                                              weight: FontWeight.bold,
                                            )))
                                    .toList(),
                                onChanged: (value) {
                                  setState(() {
                                    _color = value!;
                                  });
                                }),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(0),
                      child: Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: CustomText(
                              text: "Select a Size",
                              size: 16,
                              color: Colors.white,
                              weight: FontWeight.normal,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: DropdownButton<String>(
                                value: _size,
                                style: TextStyle(color: Colors.blue),
                                items: widget.product.size
                                    .map<DropdownMenuItem<String>>(
                                        (value) => DropdownMenuItem(
                                            value: value,
                                            child: CustomText(
                                              text: value.toString(),
                                              size: 16,
                                              color: Colors.red,
                                              weight: FontWeight.bold,
                                            )))
                                    .toList(),
                                onChanged: (value) {
                                  setState(() {
                                    _size = value!;
                                    print(value);
                                  });
                                }),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                            'Description:\nLorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry standard dummy text ever since the 1500s  Lorem Ipsum has been the industry standard dummy text ever since the 1500s ',
                            style: TextStyle(color: Colors.white)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(9),
                      child: Material(
                          borderRadius: BorderRadius.circular(15.0),
                          color: Colors.white,
                          elevation: 0.0,
                          child: MaterialButton(
                            onPressed: () async {
                              appProvider.changeIsLoading();
                              bool success = await userProvider.addToCart(
                                  product: widget.product,
                                  color: _color,
                                  size: _size);
                              if (success) {
                                _key.currentState!.showSnackBar(
                                    SnackBar(content: Text("Added to Cart!")));
                                userProvider.reloadUserModel();
                                appProvider.changeIsLoading();
                                return;
                              } else {
                                _key.currentState!.showSnackBar(SnackBar(
                                    content: Text("Not added to Cart!")));
                                appProvider.changeIsLoading();
                                return;
                              }
                            },
                            minWidth: MediaQuery.of(context).size.width,
                            child: appProvider.isLoading
                                ? Loading()
                                : Text(
                                    "Add to cart",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.0),
                                  ),
                          )),
                    ),
                    SizedBox(
                      height: 20,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}
/*
class ProductDetails extends StatefulWidget {
  final product_detail_name;
  final product_detail_picture;
  final product_detail_new_price;
  final product_detail_old_price;

  ProductDetails(
      {this.product_detail_name,
      this.product_detail_new_price,
      this.product_detail_old_price,
      this.product_detail_picture});

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: InkWell(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => HomePage()));
            },
            child: Text("FashApp")),
        backgroundColor: Colors.red,
        actions: <Widget>[
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.search,
                color: Colors.white,
              )),
        ],
      ),
      body: ListView(
        children: <Widget>[
          Container(
            height: 300,
            child: GridTile(
              child: Container(
                color: Colors.white,
                child: Image.asset(widget.product_detail_picture),
              ),
              footer: Container(
                color: Colors.white70,
                child: ListTile(
                  leading: Text(
                    widget.product_detail_name,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  title: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          "\$${widget.product_detail_old_price}",
                          style: TextStyle(
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "\$${widget.product_detail_new_price}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.red),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),

          // the FIRST buttons
          Row(
            children: <Widget>[
              // the size button
              Expanded(
                child: MaterialButton(
                  elevation: 0.2,
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text("Size"),
                            content: Text("Choose the size"),
                            actions: <Widget>[
                              MaterialButton(
                                onPressed: () {
                                  Navigator.of(context).pop(context);
                                },
                                child: Text("close"),
                              )
                            ],
                          );
                        });
                  },
                  color: Colors.white,
                  child: Row(
                    children: <Widget>[
                      Expanded(child: Text("Size")),
                      Expanded(child: Icon(Icons.arrow_drop_down)),
                    ],
                  ),
                ),
              ),
              // the color button
              Expanded(
                child: MaterialButton(
                  elevation: 0.2,
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text("Color"),
                            content: Text("Choose the color"),
                            actions: <Widget>[
                              MaterialButton(
                                onPressed: () {
                                  Navigator.of(context).pop(context);
                                },
                                child: Text("close"),
                              )
                            ],
                          );
                        });
                  },
                  color: Colors.white,
                  child: Row(
                    children: <Widget>[
                      Expanded(child: Text("Color")),
                      Expanded(child: Icon(Icons.arrow_drop_down)),
                    ],
                  ),
                ),
              ),
              // the quantity button
              Expanded(
                child: MaterialButton(
                  elevation: 0.2,
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text("Quantity"),
                            content: Text("Choose the quantity"),
                            actions: <Widget>[
                              MaterialButton(
                                onPressed: () {
                                  Navigator.of(context).pop(context);
                                },
                                child: Text("close"),
                              )
                            ],
                          );
                        });
                  },
                  color: Colors.white,
                  child: Row(
                    children: <Widget>[
                      Expanded(child: Text("Qty")),
                      Expanded(child: Icon(Icons.arrow_drop_down)),
                    ],
                  ),
                ),
              )
            ],
          ),

          // the SECOND buttons
          Row(
            children: <Widget>[
              // the size button
              Expanded(
                child: MaterialButton(
                  elevation: 0.2,
                  onPressed: () {},
                  color: Colors.red,
                  textColor: Colors.white,
                  child: Text("Buy Now"),
                ),
              ),
              IconButton(
                icon: Icon(Icons.add_shopping_cart, color: Colors.red),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.favorite_border, color: Colors.red),
                onPressed: () {},
              )
            ],
          ),
          Divider(),
          ListTile(
            title: Text("Product details"),
            subtitle: Text(
                "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset"),
          ),

          // the SECOND divider
          Divider(),
          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 5, 5, 5),
                child: Text(
                  "Product Name",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(5),
                child: Text(widget.product_detail_name),
              )
            ],
          ),
          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 5, 5, 5),
                child: Text(
                  "Product brand",
                  style: TextStyle(color: Colors.grey),
                ),
              ),

              // REMEMBER TO CREATE THE PRODUCT BRAND
              Padding(
                padding: EdgeInsets.all(5),
                child: Text("Brand X"),
              )
            ],
          ),

          // ADD THE PRODUCT CONDITION
          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 5, 5, 5),
                child: Text(
                  "Product condition",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(5),
                child: Text("NEW"),
              )
            ],
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Similar Products"),
          ),
          //SIMILAR PRODUCT SECTION
          Container(
            height: 340,
            child: Similar_products(),
          )
        ],
      ),
    );
  }
}

class Similar_products extends StatefulWidget {
  const Similar_products({Key? key}) : super(key: key);

  @override
  _Similar_productsState createState() => _Similar_productsState();
}

class _Similar_productsState extends State<Similar_products> {
  var product_list = [
    {
      "name": "Blazer",
      "picture": "images/products/blazer1.jpeg",
      "old_price": 120,
      "price": 85,
    },
    {
      "name": "Red Dress",
      "picture": "images/products/hills1.jpeg",
      "old_price": 100,
      "price": 50,
    },
    {
      "name": "Red Dress",
      "picture": "images/products/skt1.jpeg",
      "old_price": 100,
      "price": 50,
    },
  ];
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: product_list.length,
      gridDelegate:
          new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (BuildContext context, int index) {
        return Similar_single_prod(
          prod_name: product_list[index]['name'],
          prod_picture: product_list[index]['picture'],
          prod_old_price: product_list[index]['old_price'],
          prod_price: product_list[index]['price'],
        );
      },
    );
  }
}

class Similar_single_prod extends StatelessWidget {
  final prod_name;
  final prod_picture;
  final prod_old_price;
  final prod_price;

  Similar_single_prod(
      {this.prod_name,
      this.prod_picture,
      this.prod_old_price,
      this.prod_price});
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Hero(
          tag: Text("hero 1"),
          child: Material(
            child: InkWell(
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  //here we are passing the values of the product to the product details page
                  builder: (context) => ProductDetails(
                        product_detail_name: prod_name,
                        product_detail_new_price: prod_price,
                        product_detail_old_price: prod_old_price,
                        product_detail_picture: prod_picture,
                      ))),
              child: GridTile(
                footer: Container(
                    color: Colors.white70,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            prod_name,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ),
                        Text(
                          "\$${prod_price}",
                          style: TextStyle(
                              color: Colors.red, fontWeight: FontWeight.bold),
                        ),
                      ],
                    )),
                child: Image.asset(
                  prod_picture,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          )),
    );
  }
}*/

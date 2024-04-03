import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

List<String> productIds = ["bobprep_lms_50_dollar","ACJ100","100002"];

class _HomeWidgetState extends State<HomeWidget> {

  final InAppPurchase _inAppPurchase = InAppPurchase.instance;
  bool _isAvailable = false;
  String? _notice;
  List<ProductDetails> _products = [];

  @override
  void initState(){
    super.initState();
    initStoreInfo();
  }

  Future<void> initStoreInfo() async {
    final bool isAvailable = await _inAppPurchase.isAvailable();
    setState(() {
      _isAvailable = isAvailable;
    });

    if(!_isAvailable){
      setState(() {
        _notice = "There are no upgrade at this time";
      });
      return;
    }

    setState(() {
      _notice = "There is a connection to the store";
    });

    ProductDetailsResponse productDetailsResponse = await _inAppPurchase.queryProductDetails(productIds.toSet());
    setState(() {
      _products = productDetailsResponse.productDetails;
      print(_products);
      print("Not fount products : ${productDetailsResponse.notFoundIDs}");
    });

    if(productDetailsResponse.error != null){
      setState(() {
        _notice = "There was a problem connecting to the store";
      });
    }else if(productDetailsResponse.productDetails.isEmpty){
      setState(() {
        _notice = "There are no upgrade at this time";
      });
    }


  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("In-app-purchase"),
      ),

      body: SafeArea(
        child: Column(
          children: [
            if(_notice != null)
              Padding(
                padding: EdgeInsets.all(10),
                child: Text(_notice!),
              ),

            Expanded(
              child: ListView.builder(
                  itemCount: _products.length,
                  itemBuilder: (_,index){
                     ProductDetails productDetails = _products[index];

                     return ListTile(
                       title: Text(productDetails.title),
                       subtitle: Text(productDetails.description),
                       trailing: Text(productDetails.price),
                     );

                  },

              ),
            )


          ],
        ),
      ),
    );
  }
}

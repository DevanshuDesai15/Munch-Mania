import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_recommendation/foodDetailPgae/detailPage2.dart';

class pagination extends StatefulWidget {
  @override
  _paginationState createState() => _paginationState();
}

class _paginationState extends State<pagination> {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<DocumentSnapshot> _products = [];
  bool _loadingProducts = true;
  int _per_page = 20;
  DocumentSnapshot? _lastDocument;
  ScrollController _scrollController = ScrollController();
  bool _gettingMoreProducts = false;
  bool _moreProductsAvailable = true;

  _getProducts() async {
    Query q = _firestore
        .collection("recipes")
        .doc("food")
        .collection("allFood")
        .orderBy("name")
        .limit(_per_page);
    setState(() {
      _loadingProducts = true;
    });
    QuerySnapshot querySnapshot = await q.get();
    _products = querySnapshot.docs;
    _lastDocument = querySnapshot.docs[querySnapshot.docs.length - 1];
    setState(() {
      _loadingProducts = false;
    });
  }

  _getMoreProducts() async {
    print("more called");
    if (_moreProductsAvailable == false) {
      print("no more products");
      return;
    }
    if (_gettingMoreProducts == true) {
      return;
    }
    _gettingMoreProducts = true;
    final lastData = _lastDocument!.data() as Map<String, dynamic>;
    Query q = _firestore
        .collection("recipes")
        .doc("food")
        .collection("allFood")
        .orderBy("name")
        .startAfter([lastData["name"]]).limit(_per_page);
    QuerySnapshot querySnapshot = await q.get();
    if (querySnapshot.docs.length < _per_page) {
      _moreProductsAvailable = false;
    }
    _lastDocument = querySnapshot.docs[querySnapshot.docs.length - 1];
    _products.addAll(querySnapshot.docs);
    setState(() {
      _gettingMoreProducts = false;
    });
  }

  navigateToDetail(DocumentSnapshot post) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => detailPage2(post: post)));
  }

  @override
  void initState() {
    _scrollController.addListener(() {
      double maxScroll = _scrollController.position.maxScrollExtent;
      double currentScroll = _scrollController.position.pixels;
      double delta = MediaQuery.of(context).size.height * 0.25;
      if (maxScroll - currentScroll <= delta) {
        _getMoreProducts();
      }
    });
    _getProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("pagination"),
      ),
      body: _loadingProducts == true
          ? Container(
              child: Text("loading...."),
            )
          : Container(
              child: _products.length == 0
                  ? Center(
                      child: Text("No Products to show"),
                    )
                  : ListView.builder(
                      controller: _scrollController,
                      itemCount: _products.length,
                      itemBuilder: (BuildContext ctx, int index) {
                        final data =
                            _products[index].data() as Map<String, dynamic>;
                        return ListTile(
                          title: Text(data["name"]),
                        );
                      })),
    );
  }
}

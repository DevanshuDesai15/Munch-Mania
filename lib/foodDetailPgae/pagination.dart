import 'package:flutter/material.dart';
import 'package:food_recommendation/main.dart';
import 'package:food_recommendation/foodDetailPgae/detailPage2.dart';

class pagination extends StatefulWidget {
  @override
  _paginationState createState() => _paginationState();
}

class _paginationState extends State<pagination> {
  List<Map<String, dynamic>> _products = [];
  bool _loadingProducts = true;
  int _per_page = 20;
  int _offset = 0;
  ScrollController _scrollController = ScrollController();
  bool _gettingMoreProducts = false;
  bool _moreProductsAvailable = true;

  _getProducts() async {
    setState(() {
      _loadingProducts = true;
    });
    final data = await supabase
        .from('recipes')
        .select()
        .eq('category', 'food')
        .order('name')
        .range(0, _per_page - 1);
    _products = List<Map<String, dynamic>>.from(data);
    _offset = _products.length;
    if (_products.length < _per_page) {
      _moreProductsAvailable = false;
    }
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
    final data = await supabase
        .from('recipes')
        .select()
        .eq('category', 'food')
        .order('name')
        .range(_offset, _offset + _per_page - 1);
    final newProducts = List<Map<String, dynamic>>.from(data);
    if (newProducts.length < _per_page) {
      _moreProductsAvailable = false;
    }
    _offset += newProducts.length;
    _products.addAll(newProducts);
    setState(() {
      _gettingMoreProducts = false;
    });
  }

  navigateToDetail(Map<String, dynamic> post) {
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
                        final data = _products[index];
                        return ListTile(
                          title: Text(data["name"]),
                        );
                      })),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_app/model/product_model.dart';
import 'package:store_app/services/api_handler.dart';
import 'package:store_app/widget/feeds_grid.dart';

import '../widget/feeds_widget.dart';

class FeedsScreen extends StatefulWidget {

  const FeedsScreen({Key? key}) : super(key: key);

  @override
  State<FeedsScreen> createState() => _FeedsScreenState();
}

class _FeedsScreenState extends State<FeedsScreen> {
  final ScrollController _scrollController = ScrollController();
  List<ProductsModel> productsList = [];
  int limit = 10;
  // bool _isLoading = false;
  bool _isLimit = false;
  @override
  void initState() {
    getProducts();
    super.initState();
  }

  Future<void> getProducts() async {
    productsList = await APIHandler.getAllProduct(limit: limit.toString());
    setState(() {

    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _scrollController.addListener(() async{
        if(_scrollController.position.pixels
            == _scrollController.position.maxScrollExtent) {
          // _isLoading = true;
          limit += 10;
          print("limit $limit");
          if(limit == 200) {
            _isLimit = true;
            setState(() {

            });
            return;
          }
          await getProducts();
          // _isLoading = false;
        }
    });
  }

  @override
  void dispose() {
      _scrollController.dispose();
      super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Product'),
      ),
      body:
      productsList.isEmpty ? Center(child: CircularProgressIndicator()) :
      SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: productsList.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 0.0,
                    mainAxisSpacing: 0.0,
                    childAspectRatio: 0.75
                ),
                itemBuilder: (ctx, index) {
                  return ChangeNotifierProvider.value(
                      value: productsList[index],
                      child: FeedsWidget());
                }),
                if(!_isLimit) Center(
                  child: CircularProgressIndicator(),
                )
          ],
        ),
      ),
    );
  }
}

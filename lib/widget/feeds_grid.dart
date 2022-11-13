import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_app/model/product_model.dart';

import 'feeds_widget.dart';

class FeedsGridWidget extends StatelessWidget {
  final List<ProductsModel> productList;
  FeedsGridWidget({Key? key, required this.productList}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 6,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 0.0,
            mainAxisSpacing: 0.0,
            childAspectRatio: 0.75),
        itemBuilder: (ctx, index) {
          return  ChangeNotifierProvider.value(
              value: productList[index],
              child: FeedsWidget()
          );
        });
  }
}
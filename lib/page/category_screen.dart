import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_app/model/categories_model.dart';
import 'package:store_app/widget/category_widget.dart';

import '../services/api_handler.dart';

class Category_Screen extends StatelessWidget {
  const Category_Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Category'),

      ),
      body:
      FutureBuilder<List<CategoriesModel>>(
          future: APIHandler.getAllCategories(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState
                .waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            else if (snapshot.hasError) {
              Center(
                  child: Text(' An error occured ${snapshot.error}')
              );
            } else if (snapshot.data == null) {
              const Center(
                child: Text('No Product'),
              );
            }
            return GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: 4,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 0.0,
                  mainAxisSpacing: 0.0,
                  childAspectRatio: 1.2
              ), itemBuilder: (BuildContext context, int index) {
              return ChangeNotifierProvider.value(
                  value: snapshot.data![index],
                  child: Category_Widget());
            },
            );
          })
    );
  }
}

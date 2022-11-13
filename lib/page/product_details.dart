
import 'dart:math';

import 'package:card_swiper/card_swiper.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:store_app/consts/global_colors.dart';
import 'package:store_app/model/product_model.dart';
import 'package:store_app/services/api_handler.dart';

class ProductDetails extends StatefulWidget {

  const ProductDetails({Key? key,required this.id}) : super(key: key);
  final String id;
  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  ProductsModel? productsModel;
  bool isError = false;
  String errorStr = "";
  Future<void> getProductInfo() async {
    try {
      productsModel = await APIHandler.getProductbyID(id: widget.id);
    }
    catch (e) {
        isError = true;
        errorStr = e.toString();

    }

    setState(() {

    });
  }
  @override
  void didChangeDependencies() {
    getProductInfo();
    super.didChangeDependencies();
  }
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: SafeArea(

          child: isError ?  Center(
            child: Text('An error ocured $errorStr'),
          )
              : productsModel == null ? const Center(
            child: CircularProgressIndicator(),)
          : SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 18,
                ),
                const BackButton(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                       productsModel!.category!.name.toString(),
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700
                        ),
                      ),
                      const SizedBox(height: 18,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            flex:3,
                            child: Text(
                            productsModel!.title.toString(),
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 28
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 1,
                            child: RichText(
                                text: TextSpan(text: "\$",
                                  style: const TextStyle(
                                    fontSize: 25,
                                    color: Color.fromRGBO(33, 150, 243, 1)),
                                  children: [
                                    TextSpan(text: productsModel!.price.toString(), style: TextStyle(
                                      color: lightTextColor,
                                      fontWeight: FontWeight.bold))
                                  ])
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 18,)
                    ],
                  ),
                ),
                SizedBox(
                  height: size.height * 0.4,
                  child: Swiper(
                    itemBuilder: (BuildContext context, int index) {
                      return FancyShimmerImage(
                        width: double.infinity,
                        imageUrl: productsModel!.images![index].toString(),
                        boxFit: BoxFit.cover,
                      );
                    },
                    autoplay: true,
                    itemCount: 3,
                    pagination: const SwiperPagination(
                      alignment: Alignment.bottomCenter,
                      builder: DotSwiperPaginationBuilder(
                        color: Colors.white,
                        activeColor: Colors.red
                      )
                    ),
                  ),
                ),
                SizedBox(
                  height: 18,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Desciption',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24
                        ),),
                      const SizedBox(
                        height: 18,
                      ),
                      Text(productsModel!.description.toString(), style: TextStyle(fontSize: 22,)
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),

    );
  }
}

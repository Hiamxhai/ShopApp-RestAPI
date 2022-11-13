import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:page_transition/page_transition.dart';
import 'package:store_app/consts/global_colors.dart';
import 'package:store_app/model/product_model.dart';
import 'package:store_app/page/category_screen.dart';
import 'package:store_app/page/feeds_screen.dart';
import 'package:store_app/page/users_screen.dart';
import 'package:store_app/services/api_handler.dart';
import 'package:store_app/widget/appbar_icons.dart';
import 'package:store_app/widget/category_widget.dart';
import 'package:store_app/widget/feeds_grid.dart';
import 'package:store_app/widget/feeds_widget.dart';
import 'package:store_app/widget/sale_widget.dart';
import 'package:store_app/widget/text_field_input.dart';
import 'package:store_app/widget/user_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
 late TextEditingController _textEditingController = TextEditingController();
  //List<ProductsModel> productsList = [];
  @override
  void initState() {
    _textEditingController;
    super.initState();
  }
  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }
  // @override
  // void didChangeDependencies() {
  //   getProducts();
  //   super.didChangeDependencies();
  // }
  //
  // Future<void> getProducts () async {
  //   productsList = await APIHandler.getAllProduct();
  //   setState(() {
  //
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child:  Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
          leading: AppBarIcons(
              function: (){
                Navigator.push(context, PageTransition(
                  child: Category_Screen(),
                  type: PageTransitionType.fade
                ));
              },
              icon: IconlyBold.category),
          actions: [
            AppBarIcons(
                function: (){
                  Navigator.push(context, PageTransition(
                      child: UsersScreen(),
                      type: PageTransitionType.fade
                  ));
                },
                icon: IconlyBold.user2
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              SizedBox(height: 18,),
              TextFieldInput(
                  hintText: 'Search',
                  textInputType: TextInputType.text,
                  textEditingController: _textEditingController,
                  isPass: false,
                  icon: IconlyLight.search,
                  colorIcon: lightIconsColor,
                  colorForcus: Theme.of(context).colorScheme.secondary,
                  colorEnble: Theme.of(context).cardColor,

              ),
                SizedBox(height: 18,),

                Expanded(child:
                SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: size.height * 0.25,
                        child: Swiper(
                          // so luong anh
                          itemCount: 3,
                          itemBuilder: (ctx, index) {
                            return const SaleWidget();
                          },
                          autoplay: true,
                          pagination: const SwiperPagination(
                            //animation duoi
                              alignment: Alignment.bottomCenter,
                              builder: DotSwiperPaginationBuilder(
                                  color: Colors.white,
                                  activeColor: Colors.red)),
                          // control: const SwiperControl(),
                        ),
                      ),
                      Padding(padding: const EdgeInsets.all(8),
                        child: Row(
                          children: [
                            const Text(
                              "Products",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18
                              ),
                            ),
                            const Spacer(),
                            AppBarIcons(function: (){
                              Navigator.push(
                                context,
                                PageTransition(
                                    child: FeedsScreen(),
                                    type: PageTransitionType.fade
                                )
                              );
                            },
                                icon: IconlyBold.arrowRight2)
                          ],
                        ),
                      ),
                      FutureBuilder<List<ProductsModel>>(
                          future: APIHandler.getAllProduct(limit: 6.toString()),
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
                            return FeedsGridWidget(
                                productList: snapshot.data!
                            );
                          })

                      ],
                    ),
                  )
                )

            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sezinsoft_demo/constants.dart';
import 'package:sezinsoft_demo/core/providers/general_provider.dart';
import 'package:sezinsoft_demo/core/utilities/color_utils.dart';
import 'package:sezinsoft_demo/core/utilities/font_style_utils.dart';
import 'package:sezinsoft_demo/size_config.dart';
import 'package:sezinsoft_demo/view/common_widgets/product_card.dart';
import 'package:sezinsoft_demo/view/screens/home/model/product/category_model.dart';
import 'package:sezinsoft_demo/view/screens/home/model/product/product_model.dart';
import 'package:sezinsoft_demo/view/screens/home/view_model/home_view_model.dart';
import 'package:sezinsoft_demo/view/screens/shopping_bag/view/shopping_bag.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  SharedPreferences? prefs;
  List<CategoryData> categoryList = [];

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<GeneralProvider>(context);
    return ViewModelBuilder<HomeViewModel>.reactive(
        viewModelBuilder: () => HomeViewModel(context),
        onModelReady: (model) async {
          prefs = await SharedPreferences.getInstance();
          String? token = prefs!.getString("token")!;

          if (token != null) {
            model.getUser(token: token);
            await model.getCategories(token: token);
            model.category!.data.forEach((element) {
              categoryList.add(element);
            });
            model.getProducts(
                token: token, id: model.category!.data.first.categoryId);
          }
        },
        builder: ((context, model, child) {
          return Scaffold(
              backgroundColor: ColorUtilities.light_700,
              appBar: AppBar(
                backgroundColor: Colors.white,
                elevation: 0,
                actions: [
                  buildBagButton(provider),
                ],
              ),
              body: Column(
                children: [
                  buildTopView(model),
                  SizedBox(
                    height: getProportionateScreenHeight(8),
                  ),
                  model.busy
                      ? CircularProgressIndicator()
                      : Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: getProportionateScreenWidth(15)),
                          child: SingleChildScrollView(
                            child: Column(
                                children: model.products == null
                                    ? []
                                    : model.products!.data
                                        .map((e) => ProductCard(
                                              title: e.productName,
                                              image: e.productPhoto,
                                              description:
                                                  e.productPrice.toString() +
                                                      e.productCurrency,
                                              itemCount: provider.shoppingList!
                                                      .where((element) =>
                                                          element.productId ==
                                                          e.productId)
                                                      .isNotEmpty
                                                  ? provider.shoppingList!
                                                      .where((element) =>
                                                          element.productId ==
                                                          e.productId)
                                                      .first
                                                      .count
                                                  : 0,
                                              onAdd: () {
                                                setState(() {
                                                  e.count = 1;
                                                  provider.addShoppingList(
                                                      Datum(
                                                          productId:
                                                              e.productId,
                                                          productName:
                                                              e.productName,
                                                          productPrice:
                                                              e.productPrice,
                                                          productCurrency:
                                                              e.productCurrency,
                                                          productPhoto:
                                                              e.productPhoto,
                                                          categoryId:
                                                              e.categoryId,
                                                          categoryName:
                                                              e.categoryName,
                                                          count: 1));
                                                });
                                              },
                                              onMinusTap: () {
                                                provider.minusCount(e);
                                              },
                                              onPlusTap: () {
                                                provider.plusCount(e);
                                              },
                                            ))
                                        .toList()),
                          ),
                        )
                ],
              ));
        }));
  }

  Widget buildTopView(HomeViewModel model) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(15)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              model.user == null ? "" : model.user!.data.name,
              style: FontStyleUtilities.h2(fontColor: kPrimaryTextColor),
            ),
            SizedBox(
              height: getProportionateScreenHeight(16),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: categoryList
                    .map((e) => InkWell(
                          onTap: () {
                            setState(() {
                              categoryList.forEach((element) {
                                element.isSelected = false;
                              });
                              e.isSelected = true;
                            });
                            model.getProducts(
                                token: prefs!.getString("token")!,
                                id: e.categoryId);
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                  color: e.isSelected
                                      ? Colors.black
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(
                                      getProportionateScreenWidth(12))),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: getProportionateScreenWidth(12),
                                    vertical: getProportionateScreenHeight(8)),
                                child: Text(
                                  e.categoryName,
                                  style: TextStyle(
                                      color: e.isSelected
                                          ? Colors.white
                                          : Colors.black),
                                ),
                              )),
                        ))
                    .toList(),
              ),
            ),
            SizedBox(
              height: getProportionateScreenHeight(16),
            )
          ],
        ),
      ),
    );
  }

  double calculateSum(GeneralProvider provider) {
    double a = 0;
    provider.shoppingList!.forEach((element) {
      a = a + (element.productPrice * element.count);
    });
    return a;
  }

  Padding buildBagButton(GeneralProvider provider) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.black,
            borderRadius:
                BorderRadius.circular(getProportionateScreenWidth(24))),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(4),
          ),
          child: TextButton.icon(
              clipBehavior: Clip.none,
              onPressed: () {
                Get.to(ShoppingBag());
              },
              icon: const Icon(
                Icons.shopping_bag,
                color: Colors.white,
              ),
              label: Text(
                calculateSum(provider).toStringAsFixed(2).toString() + "₺",
                style: FontStyleUtilities.t1(fontColor: Colors.white),
              )),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sezinsoft_demo/constants.dart';
import 'package:sezinsoft_demo/core/providers/general_provider.dart';
import 'package:sezinsoft_demo/core/utilities/color_utils.dart';
import 'package:sezinsoft_demo/core/utilities/font_style_utils.dart';
import 'package:sezinsoft_demo/size_config.dart';
import 'package:sezinsoft_demo/view/common_widgets/product_card.dart';
import 'package:sezinsoft_demo/view/screens/home/model/product/category_model.dart';
import 'package:sezinsoft_demo/view/screens/home/view_model/home_view_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  SharedPreferences? prefs;
  List<Datum> categoryList = [];

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
                  buildBagButton(),
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
                                              itemCount: provider
                                                      .shoppingList!.isEmpty
                                                  ? e.count
                                                  : provider.shoppingList!
                                                          .where((element) =>
                                                              element
                                                                  .productId ==
                                                              e.productId)
                                                          .isNotEmpty
                                                      ? provider.shoppingList!
                                                          .where((element) =>
                                                              element
                                                                  .productId ==
                                                              e.productId)
                                                          .first
                                                          .count
                                                      : e.count,
                                              onAdd: () {
                                                setState(() {
                                                  e.count = 1;
                                                  provider.addShoppingList(e);
                                                });
                                              },
                                              onMinusTap: () {
                                                setState(() {
                                                  if (e.count == 1) {
                                                    provider.shoppingList!
                                                        .remove(e);
                                                  } else {
                                                    int a = provider
                                                        .shoppingList!
                                                        .lastIndexOf(provider
                                                            .shoppingList!
                                                            .where((element) =>
                                                                element == e)
                                                            .first);
                                                    print(a.toString());
                                                  }
                                                  e.count--;
                                                });
                                                print("current list: " +
                                                    provider
                                                        .shoppingList!.length
                                                        .toString());
                                              },
                                              onPlusTap: () {
                                                setState(() {
                                                  provider.shoppingList!
                                                          .where((element) =>
                                                              element == e)
                                                          .first
                                                          .count +
                                                      1;
                                                  e.count++;
                                                });
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

  Padding buildBagButton() {
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
              onPressed: () {},
              icon: const Icon(
                Icons.shopping_bag,
                color: Colors.white,
              ),
              label: Text(
                "45,65 ₺",
                style: FontStyleUtilities.t1(fontColor: Colors.white),
              )),
        ),
      ),
    );
  }
}

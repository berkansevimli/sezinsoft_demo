import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';

import '../../../../constants.dart';
import '../../../../core/providers/general_provider.dart';
import '../../../../core/utilities/color_utils.dart';
import '../../../../core/utilities/font_style_utils.dart';
import '../../../../size_config.dart';
import '../../../common_widgets/product_card.dart';
import '../../home/model/product/product_model.dart';
import '../../home/view_model/home_view_model.dart';

class ShoppingBag extends StatefulWidget {
  const ShoppingBag({super.key});

  @override
  State<ShoppingBag> createState() => _ShoppingBagState();
}

class _ShoppingBagState extends State<ShoppingBag> {
  SharedPreferences? prefs;

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
          }
        },
        builder: ((context, model, child) {
          return Scaffold(
              backgroundColor: ColorUtilities.light_700,
              appBar: AppBar(
                backgroundColor: Colors.white,
                elevation: 0,
                leading: BackButton(
                  color: kPrimaryTextColor,
                ),
                actions: [
                  buildBagButton(provider),
                ],
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    buildTopView(model, provider),
                    SizedBox(
                      height: getProportionateScreenHeight(8),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: getProportionateScreenWidth(15)),
                      child: Column(
                          children: provider.shoppingList == null
                              ? []
                              : provider.shoppingList!
                                  .map((e) => ProductCard(
                                        title: e.productName,
                                        image: e.productPhoto,
                                        description: e.productPrice.toString() +
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
                                            provider.addShoppingList(Datum(
                                                productId: e.productId,
                                                productName: e.productName,
                                                productPrice: e.productPrice,
                                                productCurrency:
                                                    e.productCurrency,
                                                productPhoto: e.productPhoto,
                                                categoryId: e.categoryId,
                                                categoryName: e.categoryName,
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
                    SizedBox(
                      height: getProportionateScreenHeight(40),
                    )
                  ],
                ),
              ));
        }));
  }

  Widget buildTopView(HomeViewModel model, GeneralProvider provider) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(35)),
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
            Text(
              "Sepetim",
              style: FontStyleUtilities.h3(
                  fontColor: kPrimaryTextColor, fontWeight: FWT.light),
            ),
            Text(
              "Tutar: ${calculateSum(provider).toStringAsFixed(2)}₺",
              style: FontStyleUtilities.h3(
                  fontColor: kPrimaryTextColor, fontWeight: FWT.light),
            ),
            SizedBox(
              height: getProportionateScreenHeight(16),
            ),
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
              onPressed: () {},
              icon: const Icon(
                Icons.shopping_bag,
                color: Colors.white,
              ),
              label: Text(
                "${calculateSum(provider).toStringAsFixed(2)}₺",
                style: FontStyleUtilities.t1(fontColor: Colors.white),
              )),
        ),
      ),
    );
  }
}

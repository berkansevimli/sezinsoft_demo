import 'package:flutter/material.dart';
import 'package:sezinsoft_demo/constants.dart';
import 'package:sezinsoft_demo/core/utilities/color_utils.dart';
import 'package:sezinsoft_demo/core/utilities/font_style_utils.dart';
import 'package:sezinsoft_demo/size_config.dart';
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
        viewModelBuilder: () => HomeViewModel(context),
        onModelReady: (model) async {
          prefs = await SharedPreferences.getInstance();
          model.getUser(token: prefs!.getString("token")!);
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
                  Container(
                    height: getProportionateScreenHeight(250),
                    width: double.infinity,
                    color: Colors.white,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: getProportionateScreenWidth(15)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            model.user!.data.name,
                            style: FontStyleUtilities.h2(
                                fontColor: kPrimaryTextColor),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ));
        }));
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

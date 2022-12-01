import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';
import '../../../../../../constants.dart';
import '../../../../../../core/utilities/asset_utils.dart';
import '../../../../../../core/utilities/color_utils.dart';
import '../../../../../../core/utilities/font_style_utils.dart';
import '../../../../../../size_config.dart';
import '../../../../../core/providers/general_provider.dart';
import '../../../../common_widgets/custom_button.dart';
import '../../../../common_widgets/custom_text_field.dart';
import '../view_model/login_view_model.dart';

/// ignore: must_be_immutable
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String? username;
  String? password;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final provider = Provider.of<GeneralProvider>(context);

    return ViewModelBuilder<LoginViewModel>.reactive(
        viewModelBuilder: () => LoginViewModel(context),
        builder: ((context, model, child) => Scaffold(
              body: Form(
                key: _formKey,
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: getProportionateScreenWidth(35)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: getProportionateScreenHeight(80)),
                        Text(
                          "Giriş Yap",
                          style: FontStyleUtilities.h3(
                            fontColor: kPrimaryTextColor,
                            fontWeight: FWT.bold,
                          ),
                        ),
                        SizedBox(height: getProportionateScreenHeight(15)),
                        buildUsername(),
                        SizedBox(height: getProportionateScreenHeight(15)),
                        buildPassword(),
                        SizedBox(height: getProportionateScreenHeight(15)),
                        buildButton(provider, model),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
            )));
  }

  CustomButton buildButton(GeneralProvider provider, LoginViewModel model) {
    return CustomButton(
      // buttonColor:
      //     const Color(0xFF411c41), //color_utils den çek
      height: 50,
      width: SizeConfig.screenWidth,
      title: "Giriş Yap",
      isLoading: provider.isLoading,
      onButtonTap: () async {
        if (_formKey.currentState!.validate()) {
          model.login(username: username!, password: password!);
        }
      },
    );
  }

  CustomTextField buildPassword() {
    return CustomTextField(
      icon: AssetUtilities.lockStrokeSvg,
      hint: "Şifre",
      maxLines: 1,
      obsecure: true,
      onChange: (value) {
        password = value;
      },
      onSaved: (newValue) => password = newValue,
      validator: (value) {
        if (value!.isEmpty) {
          return "Şifre girilmesi zorunludur";
        } else if (value.length < 6) {
          return "Lütfen minimum 6 karakter giriniz!";
        }
        return null;
      },
    );
  }

  CustomTextField buildUsername() {
    return CustomTextField(
      icon: AssetUtilities.mailStrokeSvg,
      hint: "Kullanıcı Adı",
      keyboardType: TextInputType.text,
      onSaved: (newValue) => username = newValue,
      onChange: (value) {
        username = value;
      },
      validator: (value) {
        if (value!.isEmpty) {
          return "Kullanıcı adı girilmesi zorunludur!";
        }
        return null;
      },
    );
  }
}

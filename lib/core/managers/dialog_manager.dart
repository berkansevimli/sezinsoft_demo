import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../locator.dart';
import '../services/dialog_service.dart';
import '../services/models/dialog_models.dart';

class DialogManager extends StatefulWidget {
  final Widget? child;
  DialogManager({Key? key, this.child}) : super(key: key);

  @override
  _DialogManagerState createState() => _DialogManagerState();
}

class _DialogManagerState extends State<DialogManager> {
  DialogService? _dialogService = locator<DialogService>();

  @override
  void initState() {
    super.initState();
    _dialogService!.registerDialogListener(_showDialog);
  }

  @override
  Widget build(BuildContext context) {
    return widget.child!;
  }

  void _showDialog(DialogRequest request) {
    var isConfirmationDialog = request.cancelTitle != null;
    showDialog(
        barrierDismissible: request.barrierDismissible != null
            ? request.barrierDismissible!
            : true,
        context: context,
        builder: (context) => CupertinoAlertDialog(
              title: Text(request.title!),
              content: Text(request.description!),
              actions: [
                CupertinoDialogAction(
                  child: Text(request.buttonTitle),
                  onPressed: () {
                    isConfirmationDialog
                        ? _dialogService!
                            .dialogComplete(DialogResponse(confirmed: true))
                        : Navigator.pop(context);
                  },
                )
              ],
            )

        // AlertDialog(
        //     backgroundColor: request.title == "unlem1" ||
        //             request.title == "siyahx" ||
        //             request.title == "beyazx" ||
        //             request.title == "olumlu"
        //         ? Colors.transparent
        //         : null,
        //     shape: const RoundedRectangleBorder(
        //         borderRadius: BorderRadius.all(Radius.circular(20.0))),
        //     insetPadding: EdgeInsets.zero,
        //     contentPadding: EdgeInsets.zero,
        //     clipBehavior: Clip.antiAliasWithSaveLayer,

        //     // title: request.customWidget!=null ? Container():request.title == "unlem" ? Image.asset("asset/image/unlem1.png",height: 75,)
        //     //     : request.title == "warning" ? Image.asset("asset/image/warning1.png",height: 75,)
        //     //     : request.title =="check" ? Image.asset("asset/image/check.png",height: 75,)
        //     //     : request.title =="close" ? Image.asset("asset/image/close.png",height: 75,)
        //     //     : Image.asset("asset/image/info1.png",height: 75,),
        //     title: request.title == "unlem1" ||
        //             request.title == "siyahx" ||
        //             request.title == "beyazx" ||
        //             request.title == "olumlu"
        //         ? Container(
        //             height: 50,
        //           )
        //         : null,
        //     content: Container(
        //       width: request.width != null
        //           ? request.width
        //           : request.customWidget != null ||
        //                   request.customWidget2 != null
        //               ? MediaQuery.of(context).size.width * 0.95
        //               : MediaQuery.of(context).size.width * 0.80,
        //       padding: const EdgeInsets.all(10),
        //       // height: request.title == "unlem" ? MediaQuery.of(context).size.height * 0.90 : null,
        //       decoration: new BoxDecoration(
        //         shape: BoxShape.rectangle,
        //         color: const Color(0xFFFFFF),
        //         borderRadius: new BorderRadius.all(new Radius.circular(32.0)),
        //       ),
        //       child: request.customWidget != null
        //           ? ListView(
        //               shrinkWrap: true,
        //               children: <Widget>[request.customWidget!])
        //           : request.customWidget2 != null
        //               ? ListView(
        //                   shrinkWrap: true,
        //                   children: <Widget>[
        //                     transparentModal(
        //                         context: context,
        //                         icon:
        //                             "asset/svg/${request.title == "siyahx" || request.title == "beyazx" ? "carpi" : request.title == "olumlu" ? "Asci" : "unlem"}.svg",
        //                         iconBackgroundColor: request.title == "siyahx"
        //                             ? Colors.black
        //                             : null,
        //                         customWidget: Container(
        //                           constraints:
        //                               const BoxConstraints(minWidth: 200),
        //                           // height: 100,
        //                           // width: 100,
        //                           // decoration: BoxDecoration(
        //                           //   color: Colors.white,
        //                           //   borderRadius: BorderRadius.circular(15)
        //                           // ),
        //                           child: Column(
        //                             children: [
        //                               const SizedBox(
        //                                 height: 65,
        //                               ),
        //                               Text(
        //                                 request.description != null
        //                                     ? request.description!
        //                                     : " ",
        //                                 style: const TextStyle(
        //                                     color: Color(0xFF666666),
        //                                     fontSize: 15),
        //                                 textAlign: TextAlign.center,
        //                               ),
        //                               const SizedBox(
        //                                 height: 25,
        //                               ),
        //                               Row(
        //                                 mainAxisAlignment:
        //                                     MainAxisAlignment.center,
        //                                 children: [
        //                                   InkWell(
        //                                     onTap: () {
        //                                       _dialogService!.dialogComplete(
        //                                           DialogResponse(
        //                                               confirmed: true));
        //                                     },
        //                                     child: Container(
        //                                       // width: MediaQuery.of(context).size.width * 0.20,
        //                                       constraints: const BoxConstraints(
        //                                           minWidth: 100),
        //                                       padding: const EdgeInsets.all(7),
        //                                       decoration: const BoxDecoration(
        //                                         // border: Border.all(
        //                                         //     color: Colors.orange,
        //                                         //     width: 1.0
        //                                         // ),
        //                                         borderRadius: BorderRadius.all(
        //                                           Radius.circular(60.0),
        //                                         ),
        //                                         color: Color(0xff000000),
        //                                       ),
        //                                       child: Column(
        //                                         children: [
        //                                           Text(
        //                                             request.buttonTitle,
        //                                             style: const TextStyle(
        //                                                 fontSize: 12,
        //                                                 color: Colors.white),
        //                                           ),
        //                                         ],
        //                                       ),
        //                                     ),
        //                                   ),
        //                                   isConfirmationDialog
        //                                       ? InkWell(
        //                                           onTap: () {
        //                                             _dialogService!
        //                                                 .dialogComplete(
        //                                                     DialogResponse(
        //                                                         confirmed:
        //                                                             false));
        //                                           },
        //                                           child: Container(
        //                                             margin:
        //                                                 const EdgeInsets.only(
        //                                                     left: 20),
        //                                             // width: MediaQuery.of(context).size.width * 0.20,
        //                                             constraints:
        //                                                 const BoxConstraints(
        //                                                     minWidth: 100),
        //                                             padding:
        //                                                 const EdgeInsets.all(7),
        //                                             decoration:
        //                                                 const BoxDecoration(
        //                                               // border: Border.all(
        //                                               //     color: Color,
        //                                               //     width: 1.0
        //                                               // ),
        //                                               borderRadius:
        //                                                   BorderRadius.all(
        //                                                 Radius.circular(60.0),
        //                                               ),
        //                                               color: Color(0xff000000),
        //                                             ),
        //                                             child: Column(
        //                                               children: [
        //                                                 Text(
        //                                                   request.cancelTitle!,
        //                                                   style:
        //                                                       const TextStyle(
        //                                                           fontSize: 12,
        //                                                           color: Colors
        //                                                               .white),
        //                                                 ),
        //                                               ],
        //                                             ),
        //                                           ),
        //                                         )
        //                                       : Container(),
        //                                 ],
        //                               ),
        //                               const SizedBox(
        //                                 height: 25,
        //                               ),
        //                             ],
        //                           ),
        //                         ))
        //                   ],
        //                 )
        //               : ListView(
        //                   shrinkWrap: true,
        //                   children: <Widget>[
        //                     request.image != null
        //                         ? Image.network(request.image!)
        //                         : const SizedBox(
        //                             height: 25,
        //                           ),
        //                     const SizedBox(
        //                       height: 10,
        //                     ),
        //                     Text(
        //                       request.description != null
        //                           ? request.description!
        //                           : " ",
        //                       style: const TextStyle(
        //                           color: Color(0xFF666666), fontSize: 15),
        //                       textAlign: TextAlign.center,
        //                     ),
        //                     const SizedBox(
        //                       height: 25,
        //                     ),
        //                     Row(
        //                       mainAxisAlignment: MainAxisAlignment.center,
        //                       children: [
        //                         TextButton(
        //                           child: Container(
        //                             // width: MediaQuery.of(context).size.width * 0.20,
        //                             constraints:
        //                                 const BoxConstraints(minWidth: 100),
        //                             padding: const EdgeInsets.all(7),
        //                             decoration: const BoxDecoration(
        //                               // border: Border.all(
        //                               //     color: Colors.orange,
        //                               //     width: 1.0
        //                               // ),
        //                               borderRadius: BorderRadius.all(
        //                                 Radius.circular(60.0),
        //                               ),
        //                               color: Color(0xff000000),
        //                             ),
        //                             child: Column(
        //                               children: [
        //                                 Text(
        //                                   request.buttonTitle,
        //                                   style: const TextStyle(
        //                                       fontSize: 12,
        //                                       color: Colors.white),
        //                                 ),
        //                               ],
        //                             ),
        //                           ),
        //                           onPressed: () {
        //                             _dialogService!.dialogComplete(
        //                                 DialogResponse(confirmed: true));
        //                           },
        //                         ),
        //                         isConfirmationDialog
        //                             ? TextButton(
        //                                 child: Container(
        //                                   // width: MediaQuery.of(context).size.width * 0.20,
        //                                   constraints: const BoxConstraints(
        //                                       minWidth: 50),
        //                                   padding: const EdgeInsets.all(7),
        //                                   decoration: const BoxDecoration(
        //                                     // border: Border.all(
        //                                     //     color: Color,
        //                                     //     width: 1.0
        //                                     // ),
        //                                     borderRadius: BorderRadius.all(
        //                                       Radius.circular(60.0),
        //                                     ),
        //                                     color: Color(0xff000000),
        //                                   ),
        //                                   child: Column(
        //                                     children: [
        //                                       Text(
        //                                         request.cancelTitle!,
        //                                         style: const TextStyle(
        //                                             fontSize: 12,
        //                                             color: Colors.white),
        //                                       ),
        //                                     ],
        //                                   ),
        //                                 ),
        //                                 onPressed: () {
        //                                   _dialogService!.dialogComplete(
        //                                       DialogResponse(confirmed: false));
        //                                 },
        //                               )
        //                             : Container(),
        //                       ],
        //                     ),
        //                     const SizedBox(
        //                       height: 25,
        //                     ),
        //                   ],
        //                 ),
        //       // title: Text(request.title !=null ? request.title : " "),
        //       // content: Text(request.description !=null ? request.description : " "),
        //       // actions: <Widget>[
        //       //   if (isConfirmationDialog)
        //       //     TextButton(
        //       //       child: Text(request.cancelTitle),
        //       //       onPressed: () {
        //       //         _dialogService
        //       //             .dialogComplete(DialogResponse(confirmed: false));
        //       //       },
        //       //     ),
        //       //   TextButton(
        //       //     child: Text(request.buttonTitle),
        //       //     onPressed: () {
        //       //       _dialogService
        //       //           .dialogComplete(DialogResponse(confirmed: true));
        //       //     },
        //       //   ),
        //       // ],
        //     )

        //     )

        );
  }
}

Widget transparentModal(
    {required context, customWidget, icon, iconBackgroundColor}) {
  return Stack(
    clipBehavior: Clip.none,
    alignment: Alignment.center,
    children: [
      Container(
          margin: EdgeInsets.only(top: 25),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(25)),
          padding: EdgeInsets.only(left: 25, right: 25),
          width: MediaQuery.of(context).size.width * 0.85,
          child: customWidget),
      Positioned(
        top: -30,
        child: Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
                color: iconBackgroundColor != null
                    ? iconBackgroundColor
                    : Color(0xffe84c4f),
                borderRadius: BorderRadius.circular(50)),
            padding: EdgeInsets.all(10),
            child: Container(
              width: 50,
              height: 50,
              padding: icon != null ? EdgeInsets.all(15) : null,
              child: icon != null
                  ? SvgPicture.asset(
                      "$icon",
                      height: 10,
                      width: 10,
                      color: Colors.white,
                    )
                  : SvgPicture.asset(
                      "asset/svg/Asci.svg",
                      height: 55,
                      color: Colors.white,
                    ),
            )),
      ),
    ],
  );
}

import 'package:universal_html/html.dart' as html;
import 'dart:ui_web' as ui;


import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../model/KnowledgebaseModel/knowledgebase_model.dart';

class KnowledgebaseController extends GetxController {
  RxList<KnowledgebaseModel> knowledgebaseList = RxList([]);
  RxBool isSearch = false.obs;
  late BuildContext context;

  KnowledgebaseController(){
    getKnowledgebaseList();
  }

  void getKnowledgebaseList() {
    Map<String,dynamic> response = {
      "data": [

          {
            "url": "https://youtu.be/7mG_sW40tsw?si=kPNPrPgBBPR9uqyy",
            "title": "Building multiplatform games with Flutter",
            "description":
            "Learn how to build your next game with Flutter. Flutter is used in more than 1M apps from small studios to large companies building beautiful, natively compiled, multi-platform applications from a single codebase. Casual games have become a big part of the Flutter ecosystem with the Casual Games Toolkit, a collection of free and open source tools, templates, and resources to make game development more productive with Flutter."
          },
          {
            "url": "https://youtu.be/HTlK6IzMOTc?si=Sqkv5fU5Od6SCaD6",
            "title": "Create starter flutter UI for free with ChatGPT 4o",
            "description":
            "Discover the power of ChatGPT 4o! Dive into our latest tutorial where we walk you through crafting a Flutter UI for free with latest and greatest ChatGPT 4o. Perfect for beginners and pros alike."
          },
      ]
    };
    knowledgebaseList.addAll(KnowledgebaseBaseModel.fromJson(response).data);
  }

  String getImage(url){
    // Create the image element
    final html.ImageElement imageElement = html.ImageElement(src: url)
      ..style.width = '100%'
      ..style.height = '100%'
      ..alt = 'Network image';

    // Create a unique viewType identifier for this element
    final String viewType = 'network-image-${url.hashCode}';

    // Register the element in the platform views
    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(
      viewType,
          (int viewId) => imageElement,
    );


    return viewType;
    return "";
  }
}

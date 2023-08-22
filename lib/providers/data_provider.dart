import 'package:flutter/foundation.dart';
import 'package:saanvi/models/slider_model.dart';


class DataProvider with ChangeNotifier {
  List<SliderModel>? _slide;

  List<SliderModel>? get slide => _slide;

  void setSlider(List<SliderModel> slide) {
    _slide = slide;
    notifyListeners();
  }

}
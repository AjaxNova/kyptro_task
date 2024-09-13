import 'package:flutter/material.dart';
import 'package:flutter_task/Server/unsplash_services.dart';

class HomeScreenProvider extends ChangeNotifier {
  List<dynamic> images = [];

  bool isLoadingHome = false;
  bool isLoadingMore = false;

  changeIsLoadingTrue() {
    isLoadingHome = true;
    notifyListeners();
  }

  changeIsLoadingFalse() {
    isLoadingHome = false;
    notifyListeners();
  }

  changeIsLoadingMoreFalse() {
    isLoadingMore = false;
    notifyListeners();
  }

  changeIsLoadingMoreTrue() {
    isLoadingMore = true;
    notifyListeners();
  }

  addImageToList({required List<dynamic> fetchDimages}) {
    images.addAll(fetchDimages);
    notifyListeners();
  }

  int pageNum = 1;
  changePageNum() {
    pageNum++;
    notifyListeners();
  }

  fetchImage({bool isLoadingMore = false}) async {
    if (isLoadingMore) {
      changeIsLoadingMoreTrue();
      final data = await UnsplashService().fetchImages(pageNum);
      images.addAll(data);
      notifyListeners();

      changeIsLoadingMoreFalse();
      changePageNum();
    } else {
      final data = await UnsplashService().fetchImages(pageNum);

      images.addAll(data);
      changeIsLoadingFalse();
      changePageNum();
      notifyListeners();
    }
  }
}

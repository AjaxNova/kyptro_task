import 'package:flutter/material.dart';
import 'package:flutter_task/Server/unsplash_services.dart';

class SearchDataProvider extends ChangeNotifier {
  bool isSearchLoading = false;
  List<dynamic> searchResults = [];
  bool isSearchLoadingMore = false;
  int pageNum = 1;
  String? currentQuery;

  changeCurrentQuery(String query) {
    currentQuery = query;
    notifyListeners();
  }

  increasePageNum() {
    pageNum++;
    notifyListeners();
  }

  changeSearchingMoreOn() {
    isSearchLoadingMore = true;
    notifyListeners();
  }

  changeSearchingMoreOff() {
    isSearchLoadingMore = false;
    notifyListeners();
  }

  changeSearchLoadingOn() {
    isSearchLoading = true;
    notifyListeners();
  }

  changeSearchLoadingOff() {
    isSearchLoading = false;
    notifyListeners();
  }

  clearSearch() {
    searchResults = [];
    pageNum = 1;
    currentQuery = null;
    notifyListeners();
  }

  searchImages({String? query, bool isSearchMore = false}) async {
    if (isSearchMore) {
      changeSearchingMoreOn();
      final data =
          await UnsplashService().searchUnsplash(currentQuery!, pageNum);
      searchResults.addAll(data);
      notifyListeners();
      increasePageNum();
      changeSearchingMoreOff();
    } else {
      clearSearch();

      changeCurrentQuery(query!);
      changeSearchLoadingOn();

      final data = await UnsplashService().searchUnsplash(query, pageNum);
      addToSearchResult(images: data);
      increasePageNum();
      changeSearchLoadingOff();
    }
  }

  addToSearchResult({required List<dynamic> images}) {
    searchResults.addAll(images);
    notifyListeners();
  }
}

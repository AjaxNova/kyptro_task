import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_task/pages/image_detail_screen.dart';
import 'package:flutter_task/provider/search_data_provider.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  SearchPageState createState() => SearchPageState();
}

class SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();

    super.dispose();
  }

  void _scrollListener() {
    final provider = Provider.of<SearchDataProvider>(context, listen: false);
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      if (!provider.isSearchLoadingMore) {
        provider.searchImages(isSearchMore: true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvoked: (didPop) {
        Provider.of<SearchDataProvider>(context, listen: false).clearSearch();
      },
      child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  Provider.of<SearchDataProvider>(context, listen: false)
                      .clearSearch();
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back)),
            title: const Text('Search'),
          ),
          body: Consumer<SearchDataProvider>(
            builder: (context, value, child) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: 'Search',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(color: Colors.grey),
                        ),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.search),
                          onPressed: () async {
                            if (_searchController.text != "") {
                              await value.searchImages(
                                  query: _searchController.text);
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                  value.isSearchLoading
                      ? const Expanded(
                          child: Center(
                            child: SizedBox(
                                height: 50,
                                width: 50,
                                child: CircularProgressIndicator()),
                          ),
                        )
                      : Expanded(
                          child: MasonryGridView.count(
                          controller: _scrollController,
                          crossAxisCount: 2,
                          mainAxisSpacing: 8,
                          crossAxisSpacing: 8,
                          itemCount: value.searchResults.length,
                          itemBuilder: (context, index) {
                            final image = value.searchResults[index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      ImageDetailScreen(image: image),
                                ));
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child: CachedNetworkImage(
                                  imageUrl: image.urls!.small!,
                                  progressIndicatorBuilder: (context, url,
                                          downloadProgress) =>
                                      SizedBox(
                                          height: 30,
                                          width: 30,
                                          child: Center(
                                            child: CircularProgressIndicator(
                                                color: Colors.white,
                                                value:
                                                    downloadProgress.progress),
                                          )),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                ),
                              ),
                            );
                          },
                        )),
                  if (value.isSearchLoadingMore)
                    const CircularProgressIndicator()
                ],
              );
            },
          )),
    );
  }
}

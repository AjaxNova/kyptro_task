import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_task/pages/image_detail_screen.dart';
import 'package:flutter_task/pages/search_page.dart';
import 'package:flutter_task/provider/home_screen_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
    super.dispose();
  }

  void _scrollListener() {
    final provider = Provider.of<HomeScreenProvider>(context, listen: false);
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      if (!provider.isLoadingMore) {
        provider.fetchImage(isLoadingMore: true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Images'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const SearchPage(),
              ));
            },
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: Consumer<HomeScreenProvider>(
        builder: (context, value, child) {
          if (value.isLoadingHome) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Expanded(
                    child: MasonryGridView.builder(
                      controller: _scrollController,
                      gridDelegate:
                          const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                      ),
                      mainAxisSpacing: 8.0,
                      crossAxisSpacing: 8.0,
                      itemCount: value.images.length,
                      itemBuilder: (context, index) {
                        final image = value.images[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  ImageDetailScreen(image: image),
                            ));
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: CachedNetworkImage(
                              imageUrl: image.urls!.small!,
                              progressIndicatorBuilder:
                                  (context, url, downloadProgress) => SizedBox(
                                height: 30,
                                width: 30,
                                child: Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    value: downloadProgress.progress,
                                  ),
                                ),
                              ),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  if (value.isLoadingMore)
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: CircularProgressIndicator(),
                    ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}





























        //  FutureBuilder<List<dynamic>>(
        //   future: _loadImages(),
        //   builder: (context, snapshot) {
        //     if (snapshot.connectionState == ConnectionState.waiting) {
        //       return const Center(child: CircularProgressIndicator());
        //     } else if (snapshot.hasError) {
        //       return Center(child: Text('Error: ${snapshot.error}'));
        //     } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
        //       return const Center(child: Text('No images found'));
        //     }

        //     final images = snapshot.data!;

        //     return Padding(
        //       padding: const EdgeInsets.all(8.0),
        //       child: MasonryGridView.builder(
        //         gridDelegate:
        //             const SliverSimpleGridDelegateWithFixedCrossAxisCount(
        //           crossAxisCount: 3,
        //         ),
        //         mainAxisSpacing: 8.0,
        //         crossAxisSpacing: 8.0,
        //         itemCount: images.length,
        //         itemBuilder: (context, index) {
        //           final image = images[index];
        //           return GestureDetector(
        //             onTap: () {
        //               Navigator.of(context).push(MaterialPageRoute(
        //                 builder: (context) => ImageDetailScreen(image: image),
        //               ));
        //             },
        //             child: ClipRRect(
        //               borderRadius: BorderRadius.circular(5),
        //               child: CachedNetworkImage(
        //                 imageUrl: image.urls!.small!,
        //                 progressIndicatorBuilder:
        //                     (context, url, downloadProgress) => SizedBox(
        //                         height: 30,
        //                         width: 30,
        //                         child: Center(
        //                           child: CircularProgressIndicator(
        //                               color: Colors.white,
        //                               value: downloadProgress.progress),
        //                         )),
        //                 errorWidget: (context, url, error) =>
        //                     const Icon(Icons.error),
        //               ),
        //             ),
        //           );
        //         },
        //       ),
        //     );
        //   },
        // ),
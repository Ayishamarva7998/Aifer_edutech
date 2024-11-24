import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper_app/constants/text_constants.dart';
import 'package:wallpaper_app/controllers/image_controller.dart';
import 'package:wallpaper_app/models/image_model.dart';
import 'package:wallpaper_app/views/widgets/image_card.dart';

class Homescreen extends StatefulWidget {
  Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  int crossAxisCount = 2;

  @override
  void initState() {
    super.initState();
    Provider.of<ImageController>(context, listen: false).fetchImages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              color: Colors.black,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundImage: const AssetImage('assets/pinprofile.png'),
                        backgroundColor: Colors.grey.shade300,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: const Text(
                          TextConstants.follow,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          TextConstants.activity,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          TextConstants.community,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        width: 80,
                        height: 30,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20)),
                        child: const Center(
                            child: Text(
                          TextConstants.shop,
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ))),
                    ],
                  ),
                ],
              ),
            ),
            const Text('All products',
            style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
            const SizedBox(height:  25,),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                child: RefreshIndicator(
                  onRefresh: () async {
                    await Provider.of<ImageController>(context, listen: false)
                        .fetchImages();
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(5, 10, 5, 0),
                    child: Center(
                      
                      child: Consumer<ImageController>(
                          builder: (context, imagePro, _) {
                        if (imagePro.isLoading) {
                          return const CircularProgressIndicator();
                        } else {
                          return MasonryGridView.count(
                            mainAxisSpacing: 5,
                            crossAxisSpacing: 5,
                            physics: const BouncingScrollPhysics(),
                            crossAxisCount: crossAxisCount,
                            itemCount: imagePro.imageList?.length,
                            itemBuilder: (context, index) {
                              final ImageModel image =
                                  imagePro.imageList![index];
                              log("ImageUrl = ${image.url?.raw}");
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ImageCard(
                                    imageUrl: image.url?.small ?? "",
                                    downloadUrl: image.url?.regular ?? "",
                                  ),
                                  const SizedBox(height: 5), // Add spacing between image and text
                                  const Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Ayisha marva", // Display description text
                                        style: TextStyle(
                                          fontSize: 14,
                                         
                                          color: Colors.black,
                                        ),
                                        maxLines: 2, // Limit text lines
                                        overflow: TextOverflow.ellipsis, // Add ellipsis for longer text
                                      ),
                                      SizedBox(width: 70), // Space between text and icon
                                      Icon(
                                        Icons.more_horiz, // Icon you want to display
                                        color: Colors.black, // Icon color
                                        size: 18, // Icon size
                                      ),
                                    ],
                                  ),
                                  const Row(
                                    children: [
                                      Text('Ayisha')
                                    ],
                                  )
                                ],
                              );
                            },
                          );
                        }
                      }),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

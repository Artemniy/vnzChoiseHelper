import 'dart:developer';

import 'package:dyplom/data/db/entity/university.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';

class MapPlacePreview extends StatelessWidget {
  final University? university;
  final VoidCallback onCloseTap;
  final VoidCallback onDetailsTap;

  const MapPlacePreview({Key? key, this.university, required this.onCloseTap, required this.onDetailsTap})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return university == null
        ? const SizedBox()
        : Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                            color: Colors.blue[400], shape: BoxShape.circle),
                        child: Center(
                          child: Text(
                            university!.rankingPosition.toString(),
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                          onPressed: onCloseTap,
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          icon: const Icon(Icons.close))
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    university!.name ?? '',
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      RatingBar.builder(
                        initialRating: university!.rating ?? 0,
                        minRating: 1,
                        ignoreGestures: true,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemSize: 25,
                        itemCount: 5,
                        itemPadding: const EdgeInsets.symmetric(horizontal: 1),
                        itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) {},
                      ),
                      Text('(${(university!.rating ?? 0).toString()})'),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(university!.fullAddress),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      SvgPicture.asset(
                        'assets/web.svg',
                        color: Colors.blue[400],
                        width: 15,
                        height: 15,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      GestureDetector(
                        onTap: () async {
                          try {
                            await launchUrl(Uri.parse(university!.site ?? ''));
                          } catch (e) {
                            log(e.toString());
                          }
                        },
                        child: Text(
                          university!.site ?? '',
                          style: TextStyle(color: Colors.blue[400]),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.phone,
                        size: 15,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      SelectableText(
                        university!.phone ?? '',
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.33,
                      child: TextButton(
                        onPressed: onDetailsTap,
                        child: Row(
                          children: [
                            const Text(
                              'Детальніше',
                              style: TextStyle(color: Colors.black),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Container(
                              padding: const EdgeInsets.all(3),
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.orange),
                              child: const Icon(
                                Icons.arrow_forward_ios,
                                size: 15,
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
  }
}

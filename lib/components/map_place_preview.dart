import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:dyplom/data/db/entity/university.dart';
import 'package:dyplom/util/hive_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';

class MapPlacePreview extends StatefulWidget {
  final University? university;
  final VoidCallback onCloseTap;
  final VoidCallback onDetailsTap;

  const MapPlacePreview(
      {Key? key,
      this.university,
      required this.onCloseTap,
      required this.onDetailsTap})
      : super(key: key);

  @override
  State<MapPlacePreview> createState() => _MapPlacePreviewState();
}

class _MapPlacePreviewState extends State<MapPlacePreview> {
 

  @override
  Widget build(BuildContext context) {
    return widget.university == null
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
                          child: AutoSizeText(
                            widget.university!.rankingPosition.toString(),
                            maxLines: 1,
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                          onPressed: widget.onCloseTap,
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          icon: const Icon(Icons.close))
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    widget.university!.name ?? '',
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      RatingBar.builder(
                        initialRating: widget.university!.rating ?? 0,
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
                      Text('(${(widget.university!.rating ?? 0).toString()})'),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(widget.university!.fullAddress),
                  const SizedBox(
                    height: 7,
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
                            await launchUrl(
                                Uri.parse(widget.university!.site ?? ''));
                          } catch (e) {
                            log(e.toString());
                          }
                        },
                        child: Text(
                          widget.university!.site ?? '',
                          style: TextStyle(color: Colors.blue[400]),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() {
                            widget.university!.favourite =
                                !(widget.university!.favourite ?? false);
                            if (widget.university!.id == null) return;

                            if (widget.university!.favourite ?? false) {
                              HiveUtil.setFavouriteUniversity(
                                  widget.university!.id!);
                            } else {
                              HiveUtil.removeFavouriteUniversity(
                                  widget.university!.id!);
                            }
                          });
                        },
                        icon: Icon(
                          widget.university!.favourite ?? false
                              ? Icons.star
                              : Icons.star_border,
                          color: widget.university!.favourite ?? false
                              ? Colors.amber
                              : Colors.black26,
                        ),
                      ),
                      const Spacer(),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.36,
                        child: TextButton(
                          onPressed: widget.onDetailsTap,
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
                                    shape: BoxShape.circle,
                                    color: Colors.orange),
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
                    ],
                  )
                ],
              ),
            ),
          );
  }
}

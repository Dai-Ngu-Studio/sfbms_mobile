import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:sfbms_mobile/data/models/field.dart';

class FieldInfoBox extends StatelessWidget {
  const FieldInfoBox({Key? key, required this.field}) : super(key: key);

  final Field field;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Hero(
          tag: field.id!,
          child: ExtendedImage.network(
            field.imageUrl!,
            fit: BoxFit.cover,
            cache: true,
            enableLoadState: true,
            height: 220,
            width: double.infinity,
            loadStateChanged: (ExtendedImageState state) {
              if (state.extendedImageLoadState == LoadState.failed) {
                return Image.network(
                  'https://inantemnhan.com.vn/wp-content/uploads/2017/10/no-image.png',
                  fit: BoxFit.cover,
                );
              }

              return null;
            },
          ),
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),
              Text(
                field.name!,
                style: Theme.of(context).textTheme.headline4!.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 8),
              RatingBar.builder(
                initialRating: field.totalRating!,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemSize: 24,
                itemPadding: const EdgeInsets.symmetric(horizontal: 0.0),
                itemBuilder: (context, _) => const Icon(Icons.star, color: Colors.amber),
                ignoreGestures: true,
                onRatingUpdate: (double value) {},
              ),
              const SizedBox(height: 24),
              Text(field.description!, style: Theme.of(context).textTheme.bodyText1),
            ],
          ),
        )
      ],
    );
  }
}

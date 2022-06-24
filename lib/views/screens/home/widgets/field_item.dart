import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class FieldItem extends StatelessWidget {
  const FieldItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 9),
      child: Container(
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 10,
              spreadRadius: 5,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: ExtendedImage.network(
                'https://picsum.photos/id/1/2000/2000',
                fit: BoxFit.cover,
                cache: true,
                enableLoadState: true,
                height: 300,
                width: double.infinity,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              "Soccer Field",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              "Available: Morning, Afternoon, Evening",
              style: TextStyle(fontSize: 18, color: Colors.black54),
            )
          ],
        ),
      ),
    );
  }
}

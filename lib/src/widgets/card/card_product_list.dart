import 'package:flutter_siap_nikah/src/commons/spaces.dart';
import 'package:flutter_siap_nikah/src/styles/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class CardProductList extends StatelessWidget {
  const CardProductList({
    Key? key,
    this.title,
    this.subTitle,
    this.description,
    this.price,
    this.rating = 5,
    this.ratingCount,
    this.isFavorite = false,
    this.image,
    this.onTap,
    this.onTapFavorite,
  }) : super(key: key);

  final String? title;
  final String? subTitle;
  final String? description;
  final int? price;
  final int rating;
  final int? ratingCount;
  final bool isFavorite;
  final String? image;
  final Function()? onTap;
  final Function()? onTapFavorite;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: ratingCount != null ? 280 : 200,
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8), color: MyColors.background),
        child: Column(
          children: [
            GestureDetector(
              onTap: onTapFavorite,
              child: Container(
                alignment: Alignment.topRight,
                child: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_outline,
                  color: Colors.red,
                ),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: MyColors.background,
                ),
              ),
            ),
            Image.network(image ?? ''),
            if (ratingCount == null)
              _rating(rating, price)
            else
              _ratingRow(rating, price, ratingCount),
          ],
        ),
      ),
    );
  }

  Widget _rating(rating, price) {
    return Column(
      children: [
        Text(title ?? '', style: TextStyle(fontWeight: FontWeight.bold)),
        Spaces.smallVertical(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (var i = 1; i <= 5; i++)
              Icon(
                i <= rating ? Icons.star : Icons.star_outline,
                color: Colors.yellow,
              ),
          ],
        ),
        Spaces.normalVertical(),
        Text('\$ ${price}', style: TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _ratingRow(rating, price, ratingCount) {
    return Column(
      children: [
        Spaces.smallVertical(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title ?? '', style: TextStyle(fontWeight: FontWeight.bold)),
            Text('\$ ${price}', style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
        Spaces.smallVertical(),
        Row(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                for (var i = 1; i <= 5; i++)
                  Icon(
                    i <= rating ? Icons.star : Icons.star_outline,
                    color: Colors.yellow,
                  ),
              ],
            ),
            Spaces.smallHorizontal(),
            Text('(${ratingCount}) Ratings', style: TextStyle(color: MyColors.grey)),
          ],
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:test_task_web/generated/l10n.dart';
import 'package:test_task_web/models/card.dart';
import 'package:test_task_web/widgets/products_hit.dart';

class ProductBest extends StatefulWidget {
  const ProductBest({Key? key, required this.products}) : super(key: key);

  final List<ProductCard> products;

  @override
  State<ProductBest> createState() => _ProductBestState();
}

class _ProductBestState extends State<ProductBest> {
  int _currentIndex = 0;
  final CarouselController _carouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    final isWideScreen = MediaQuery.of(context).size.width > 600;
    final double aspectRatio = isWideScreen ? 3.2 : 1.0;

    return Column(
      children: [
        SectionTitle(
          title: S.of(context).best,
          onNext: () {
            _carouselController.nextPage();
          },
          onPrev: () {
            _carouselController.previousPage();
          },
        ),
        CarouselSlider(
          items: widget.products.map((product) {
            return Container(
              width: isWideScreen ? 900 : double.infinity,
              margin: const EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.white,
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                child: SalesItem(
                  product: product,
                ),
              ),
            );
          }).toList(),
          carouselController: _carouselController,
          options: CarouselOptions(
            autoPlay: true,
            enlargeCenterPage: true,
            aspectRatio: aspectRatio,
            onPageChanged: (index, reason) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: widget.products.asMap().entries.map((entry) {
            return GestureDetector(
              onTap: () => _carouselController.animateToPage(entry.key),
              child: Container(
                width: 12.0,
                height: 12.0,
                margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: (Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black)
                      .withOpacity(_currentIndex == entry.key ? 0.9 : 0.4),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;
  final VoidCallback onNext;
  final VoidCallback onPrev;

  const SectionTitle({
    required this.title,
    required this.onNext,
    required this.onPrev,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isWideScreen = MediaQuery.of(context).size.width > 600;
    final double fontSize = isWideScreen ? 28.0 : 22.0;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: GoogleFonts.montserrat(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: onPrev,
              ),
              IconButton(
                icon: const Icon(Icons.arrow_forward),
                onPressed: onNext,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

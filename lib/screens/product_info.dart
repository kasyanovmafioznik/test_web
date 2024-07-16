import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_task_web/generated/l10n.dart';
import 'package:test_task_web/models/card.dart';
import 'package:test_task_web/widgets/app_bar.dart';
import 'package:carousel_slider/carousel_slider.dart';

class DressScreen extends StatelessWidget {
  const DressScreen({super.key, required this.product});

  final ProductCard product;

  @override
  Widget build(BuildContext context) {
    List<String> imageUrls = [
      product.imageUrl,
      product.imageUrl2 ?? '',
      product.imageUrl3 ?? ''
    ];

    return Scaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${S.of(context).catalog} — ${product.category} — ${product.name}',
                style: GoogleFonts.montserrat(
                  fontSize: 14.0,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 16.0),
              LayoutBuilder(
                builder: (context, constraints) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (constraints.maxWidth > 600)
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 3,
                              child: _buildImageGallery(context, imageUrls),
                            ),
                            const SizedBox(width: 16.0),
                            Expanded(
                              flex: 2,
                              child: _buildProductDetails(context),
                            ),
                          ],
                        )
                      else
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildImageGallery(context, imageUrls),
                            const SizedBox(height: 16.0),
                            _buildProductDetails(context),
                          ],
                        ),
                      const SizedBox(height: 16.0),
                      Text(
                        'Описание товара',
                        style: GoogleFonts.montserrat(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        product.description,
                        style: GoogleFonts.montserrat(
                          fontSize: 16.0,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      Row(
                        children: [
                          Text(
                            'Общий рейтинг',
                            style: GoogleFonts.montserrat(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(width: 8.0),
                          const Icon(Icons.info_outline, color: Colors.grey),
                          const Spacer(),
                          Text(
                            '${product.rating}',
                            style: GoogleFonts.montserrat(
                              fontSize: 32.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(width: 8.0),
                          Row(
                            children: List.generate(5, (index) {
                              IconData icon;
                              if (index < product.rating.floor()) {
                                icon = Icons.star;
                              } else if (index < product.rating &&
                                  product.rating % 1 != 0) {
                                icon = Icons.star_half;
                              } else {
                                icon = Icons.star_border;
                              }
                              return Icon(
                                icon,
                                color: Colors.black,
                              );
                            }),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16.0),
                      Text(
                        'Детали продукта',
                        style: GoogleFonts.montserrat(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Table(
                          columnWidths: const {
                            0: FlexColumnWidth(2),
                            1: FlexColumnWidth(3),
                          },
                          border: TableBorder.all(color: Colors.grey),
                          children: [
                            _buildTableRow('Состав, %', product.composition),
                            _buildTableRow('Сезон', product.season),
                            _buildTableRow('Цвет', product.color),
                            _buildTableRow(
                                'Страна производства', product.countryOfOrigin),
                            _buildTableRow('Артикул', product.articleNumber),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImageGallery(BuildContext context, List<String> imageUrls) {
    return Column(
      children: [
        CarouselSlider(
          items: imageUrls.map((url) {
            return GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => FullscreenImageDialog(
                    imageUrls: imageUrls,
                    initialIndex: imageUrls.indexOf(url),
                  ),
                );
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 5.0),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  image: DecorationImage(
                    image: NetworkImage(url),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            );
          }).toList(),
          options: CarouselOptions(
            height: 300.0,
            enlargeCenterPage: true,
            autoPlay: true,
            aspectRatio: 16 / 9,
            autoPlayCurve: Curves.fastOutSlowIn,
            enableInfiniteScroll: true,
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            viewportFraction: 0.8,
          ),
        ),
        const SizedBox(height: 16.0),
        Row(
          children: List.generate(imageUrls.length, (index) {
            return Expanded(
              child: GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => FullscreenImageDialog(
                      imageUrls: imageUrls,
                      initialIndex: index,
                    ),
                  );
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4.0),
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    image: DecorationImage(
                      image: NetworkImage(imageUrls[index]),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget _buildProductDetails(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          product.name,
          style: GoogleFonts.montserrat(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 4.0),
        Text(
          product.category,
          style: GoogleFonts.montserrat(
            fontSize: 16.0,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 16.0),
        Row(
          children: [
            ElevatedButton(
              onPressed: () {},
              child: const Text('Добавить в Желаемое'),
            ),
            const SizedBox(width: 16.0),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
              ),
              child: Text('Купить ${product.price} ₽'),
            ),
          ],
        ),
        const SizedBox(height: 16.0),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.grey[300],
          ),
          child: const Text('Подробнее'),
        ),
      ],
    );
  }

  TableRow _buildTableRow(String property, String value) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            property,
            style: GoogleFonts.montserrat(fontSize: 14.0, color: Colors.black),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            value,
            style: GoogleFonts.montserrat(fontSize: 14.0, color: Colors.black),
          ),
        ),
      ],
    );
  }
}

class FullscreenImageDialog extends StatelessWidget {
  const FullscreenImageDialog({
    super.key,
    required this.imageUrls,
    required this.initialIndex,
  });

  final List<String> imageUrls;
  final int initialIndex;

  @override
  Widget build(BuildContext context) {
    PageController pageController = PageController(initialPage: initialIndex);

    return Dialog(
      backgroundColor: Colors.white.withOpacity(0.8),
      child: Stack(
        children: [
          PageView.builder(
            controller: pageController,
            itemCount: imageUrls.length,
            itemBuilder: (context, index) {
              return InteractiveViewer(
                child: Center(
                  child: Image.network(imageUrls[index], fit: BoxFit.contain),
                ),
              );
            },
          ),
          Positioned(
            top: 10.0,
            right: 10.0,
            child: IconButton(
              icon: const Icon(Icons.close, color: Colors.white, size: 30.0),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        ],
      ),
    );
  }
}

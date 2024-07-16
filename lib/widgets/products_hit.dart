import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_task_web/generated/l10n.dart';
import 'package:test_task_web/models/card.dart';
import 'package:test_task_web/screens/product_info.dart';
import 'package:test_task_web/widgets/product_best.dart';

class SalesHitsSection extends StatefulWidget {
  const SalesHitsSection({
    super.key,
    required this.products,
    required this.searchQuery,
  });

  final List<ProductCard> products;
  final String searchQuery;

  @override
  _SalesSectionState createState() => _SalesSectionState();
}

class _SalesSectionState extends State<SalesHitsSection> {
  bool _showAll = false;

  @override
  Widget build(BuildContext context) {
    List<ProductCard> filteredProducts = widget.products
        .where((product) =>
            product.name.toLowerCase().contains(widget.searchQuery.toLowerCase()) ||
            product.category.toLowerCase().contains(widget.searchQuery.toLowerCase()))
        .toList();

    List<ProductCard> productsToShow =
        _showAll ? filteredProducts : filteredProducts.take(3).toList();

    final isWideScreen = MediaQuery.of(context).size.width > 600;

    return SingleChildScrollView(
      child: Container(
        color: Colors.grey[200],
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SectionTitle(
                title: S.of(context).hit,
                onViewAll: () {
                  setState(() {
                    _showAll = !_showAll;
                  });
                },
                showAll: _showAll,
              ),
              const SizedBox(height: 12.0),
              GridView.count(
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: isWideScreen ? 3 : 2,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
                shrinkWrap: true,
                children: List.generate(productsToShow.length, (index) {
                  return SalesItem(
                    product: productsToShow[index],
                  );
                }),
              ),
              ProductBest(
                products: widget.products,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;
  final VoidCallback onViewAll;
  final bool showAll;

  const SectionTitle({
    super.key,
    required this.title,
    required this.onViewAll,
    required this.showAll,
  });

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
          TextButton(
            onPressed: onViewAll,
            child: Text(
              showAll ? S.of(context).hide : S.of(context).allsee,
              style: GoogleFonts.montserrat(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SalesItem extends StatelessWidget {
  final ProductCard product;

  const SalesItem({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    final isWideScreen = MediaQuery.of(context).size.width > 600;

    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              _showFullScreenImage(context);
            },
            child: Container(
              height: isWideScreen ? 200.0 : 150.0,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(10.0)),
                image: DecorationImage(
                  image: NetworkImage(product.imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(10.0)),
                  color: Colors.black54,
                ),
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                child: Row(
                  children: [
                    const Icon(
                      Icons.star,
                      color: Colors.yellow,
                      size: 16.0,
                    ),
                    const SizedBox(width: 4.0),
                    Text(
                      '${product.rating}',
                      style: GoogleFonts.montserrat(
                        fontSize: 14.0,
                        color: Colors.white,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      product.name,
                      style: GoogleFonts.montserrat(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DressScreen(product: product,)),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.category,
                    style: GoogleFonts.montserrat(
                      fontSize: 14.0,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    '${product.price} ₽',
                    style: GoogleFonts.montserrat(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    product.description,
                    style: GoogleFonts.montserrat(
                      fontSize: 14.0,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showFullScreenImage(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.all(10),
          child: Stack(
            children: [
              Center(
                child: InteractiveViewer(
                  child: Image.network(
                    product.imageUrl,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Positioned(
                top: 10.0,
                right: 10.0,
                child: IconButton(
                  icon: const Icon(
                    Icons.close,
                    color: Colors.white,
                    size: 30.0,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

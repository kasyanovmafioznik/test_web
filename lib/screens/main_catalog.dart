import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test_task_web/models/card.dart';
import 'package:test_task_web/widgets/app_bar.dart';
import 'package:test_task_web/widgets/main_drawer.dart';
import 'package:test_task_web/widgets/products_hit.dart';

class MainCatalog extends StatefulWidget {
  const MainCatalog({
    super.key,
    required this.onSelectedLanguages,
    required this.currentLang,
  });

  final void Function(String lang) onSelectedLanguages;
  final String currentLang;

  @override
  State<MainCatalog> createState() => _MainCatalogState();
}

class _MainCatalogState extends State<MainCatalog> {
  String lang = '';
  List<ProductCard> cartItems = [];
  String searchQuery = '';

  void _changeLanguage(String lang) {
    widget.onSelectedLanguages(lang);
  }

  void _updateSearchQuery(String query) {
    setState(() {
      searchQuery = query;
    });
  }

  Future<List<ProductCard>> loadProducts() async {
    final String response = await rootBundle.loadString('assets/mock_data.json');
    final data = await json.decode(response) as List;
    return data.map((json) => ProductCard.fromJson(json)).toList();
  }

  Stream<List<ProductCard>> getProductsStream() async* {
    while (true) {
      await Future.delayed(const Duration(seconds: 1));
      yield await loadProducts();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        onSelectedLanguages: widget.onSelectedLanguages,
        currentLang: widget.currentLang,
        onSearch: _updateSearchQuery,
      ),
      body: StreamBuilder<List<ProductCard>>(
        stream: getProductsStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Ошибка: ${snapshot.error}'));
          } else {
            final products = snapshot.data!;
            return SalesHitsSection(
              products: products,
              searchQuery: searchQuery,
            );
          }
        },
      ),
      drawer: const MainDrawer(),
    );
  }
}

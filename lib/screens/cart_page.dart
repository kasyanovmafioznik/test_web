import 'package:flutter/material.dart';
import 'package:test_task_web/models/card.dart';

class CartScreen extends StatelessWidget {
  final List<ProductCard>? cart;

  const CartScreen({super.key, this.cart});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Корзина'),
      ),
      body: const Center(child: Text("Ваша корзина пока пуста",)) ,
    );
  }
}

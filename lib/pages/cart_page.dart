import 'package:flutter/material.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key, required this.cartCount});
  final int cartCount;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '购物车',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          const Text(
            '确认商品后即可进入结算流程',
            style: TextStyle(color: Color(0xFF69645D)),
          ),
          const SizedBox(height: 12),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Container(
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF1B8),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.shopping_cart, color: Colors.red),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          '购物车商品',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          cartCount == 0 ? '还没有添加商品' : '共 $cartCount 件商品',
                          style: const TextStyle(color: Color(0xFF69645D)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          const Spacer(),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: cartCount == 0
                  ? null
                  : () {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(const SnackBar(content: Text('结算成功！')));
                    },
              child: Text(cartCount == 0 ? '购物车为空' : '去结算'),
            ),
          ),
        ],
      ),
    );
  }
}

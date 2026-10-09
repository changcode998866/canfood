import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ocosa/app/app.dart';

void main() {
  testWidgets('shiguang shell shows home and orders tabs', (tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('食光'), findsOneWidget);
    expect(find.text('首页'), findsWidgets);
    expect(find.text('附近的好味道'), findsOneWidget);
    expect(find.text('松间小馆 · 家常菜'), findsOneWidget);

    await tester.tap(find.text('松间小馆 · 家常菜'));
    await tester.pumpAndSettle();

    expect(find.text('招牌三杯鸡'), findsOneWidget);
    expect(find.text('去结算'), findsOneWidget);
    expect(find.text('¥70'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.arrow_back_ios_new_rounded));
    await tester.pumpAndSettle();

    await tester.tap(find.text('发现'));
    await tester.pumpAndSettle();

    expect(find.text('探索专题、笔记与城市里的隐藏美味'), findsOneWidget);
    expect(find.text('冬日暖锅地图'), findsOneWidget);
    expect(find.text('面食星人集合'), findsOneWidget);

    await tester.tap(find.text('订单'));
    await tester.pumpAndSettle();

    expect(find.text('查看支付、配送进度与历史记录'), findsOneWidget);
    expect(find.text('配送中'), findsOneWidget);
    expect(find.text('实付 '), findsWidgets);

    await tester.tap(find.text('我的'));
    await tester.pumpAndSettle();

    expect(find.text('小食光'), findsOneWidget);
    expect(find.text('我的订单'), findsOneWidget);
    expect(find.text('食光会员'), findsOneWidget);

    await tester.tap(find.text('待支付'));
    await tester.pumpAndSettle();

    expect(find.text('待支付'), findsWidgets);
  });
}

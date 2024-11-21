import 'package:auto_route/auto_route.dart';
import 'package:flow_zero_waste/core/common/presentation/widgets/components/app_bar_styled.dart';
import 'package:flutter/material.dart';

@RoutePage()
class OrdersPage extends StatelessWidget {
  final List<OrderItem> orders = [
    OrderItem(
      name: "Ekologiczne jabłka",
      date: "2024-11-05",
      status: "Zrealizowane",
    ),
    OrderItem(
      name: "Kompostowalne naczynia",
      date: "2024-11-03",
      status: "W trakcie",
    ),
    OrderItem(
      name: "Naturalne mydło",
      date: "2024-10-28",
      status: "Anulowane",
    ),
    OrderItem(
      name: "Bambusowa szczoteczka do zębów",
      date: "2024-10-22",
      status: "Zrealizowane",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarStyled(
        title: 'Zamówienia',
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: orders.isEmpty
            ? Center(
                child: Text(
                  "Brak zamówień",
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
              )
            : ListView.builder(
                itemCount: orders.length,
                itemBuilder: (context, index) {
                  return OrderTile(order: orders[index]);
                },
              ),
      ),
    );
  }
}

class OrderItem {
  final String name;
  final String date;
  final String status;

  OrderItem({
    required this.name,
    required this.date,
    required this.status,
  });
}

class OrderTile extends StatelessWidget {
  final OrderItem order;

  OrderTile({required this.order});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        title: Text(order.name),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Data zamówienia: ${order.date}"),
            Text("Status: ${order.status}"),
          ],
        ),
        trailing: Icon(
          order.status == "Zrealizowane"
              ? Icons.check_circle
              : order.status == "W trakcie"
                  ? Icons.hourglass_bottom
                  : Icons.cancel,
          color: order.status == "Zrealizowane"
              ? Colors.green
              : order.status == "W trakcie"
                  ? Colors.orange
                  : Colors.red,
        ),
      ),
    );
  }
}

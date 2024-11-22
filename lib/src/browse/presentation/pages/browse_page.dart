import 'package:auto_route/auto_route.dart';
import 'package:flow_zero_waste/core/common/presentation/widgets/components/app_bar_styled.dart';
import 'package:flutter/material.dart';

@RoutePage()
class BrowsePage extends StatelessWidget {
  final List<String> categories = [
    "Żywność",
    "AGD",
    "Książki",
    "Odzież",
    "Elektronika",
    "Hobby",
    "Sport",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarStyled(
        title: 'Przeglądaj',
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: categories.length,
          itemBuilder: (context, index) {
            return CategoryTile(category: categories[index]);
          },
        ),
      ),
    );
  }
}

class CategoryTile extends StatelessWidget {
  final String category;

  CategoryTile({required this.category});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        title: Text(category),
        trailing: Icon(Icons.arrow_forward_ios),
        onTap: () {
        },
      ),
    );
  }
}

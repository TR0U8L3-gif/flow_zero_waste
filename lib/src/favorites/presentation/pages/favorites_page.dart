import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class FavoritesPage extends StatelessWidget {
  final List<String> favoriteItems = [
    "Ekologiczne jabłka",
    "Kompostowalne naczynia",
    "Książka o zrównoważonym życiu",
    "Naturalne mydło",
    "Bambusowa szczoteczka do zębów",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ulubione'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: favoriteItems.isEmpty
            ? Center(
                child: Text(
                  "Brak ulubionych przedmiotów",
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
              )
            : ListView.builder(
                itemCount: favoriteItems.length,
                itemBuilder: (context, index) {
                  return FavoriteTile(
                    itemName: favoriteItems[index],
                    onRemove: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('${favoriteItems[index]} usunięto z ulubionych')),
                      );
                    },
                  );
                },
              ),
      ),
    );
  }
}

class FavoriteTile extends StatelessWidget {
  final String itemName;
  final VoidCallback onRemove;

  FavoriteTile({required this.itemName, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        title: Text(itemName),
        trailing: IconButton(
          icon: Icon(Icons.delete, color: Colors.red),
          onPressed: onRemove,
        ),
      ),
    );
  }
}

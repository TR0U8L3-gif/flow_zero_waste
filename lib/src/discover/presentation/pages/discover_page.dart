import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class DiscoverPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Odkrywaj'),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LocationSelector(),
            PromotionSection(),
            NearbyOffersSection(),
            RecommendedSection(),
            CategoryListSection(),
            PopularShopsSection(),
          ],
        ),
      ),
    );
  }
}

// Widget wyboru lokalizacji
class LocationSelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Row(
        children: [
          Icon(Icons.location_on, color: Colors.green),
          SizedBox(width: 8),
          Text("Wybierz lokalizację", style: TextStyle(fontSize: 18)),
          Spacer(),
          TextButton(
            onPressed: () {},
            child: Text("Zmień"),
          ),
        ],
      ),
    );
  }
}

// Sekcja promocyjna (Bannery)
class PromotionSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5, // przykładowa liczba banerów
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.all(8.0),
            width: 300,
            decoration: BoxDecoration(
              color: Colors.lightGreen,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text("Promocja ${index + 1}", style: TextStyle(fontSize: 20, color: Colors.white)),
            ),
          );
        },
      ),
    );
  }
}

// Oferty w Twojej Okolicy
class NearbyOffersSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Section(
      title: "Oferty w Twojej Okolicy",
      child: ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: 5,
        itemBuilder: (context, index) {
          return OfferTile(
            title: "Oferta lokalna ${index + 1}",
            description: "Opis oferty lokalnej",
            distance: "${index + 1} km",
          );
        },
      ),
    );
  }
}

// Sekcja Polecane
class RecommendedSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Section(
      title: "Polecane",
      child: ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: 5,
        itemBuilder: (context, index) {
          return OfferTile(
            title: "Polecana Oferta ${index + 1}",
            description: "Opis polecanej oferty",
          );
        },
      ),
    );
  }
}

// Lista Popularnych Kategorii
class CategoryListSection extends StatelessWidget {
  final categories = ["Żywność", "AGD", "Książki", "Odzież", "Elektronika"];

  @override
  Widget build(BuildContext context) {
    return Section(
      title: "Popularne Kategorie",
      child: Container(
        height: 100,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: categories.length,
          itemBuilder: (context, index) {
            return CategoryTile(category: categories[index]);
          },
        ),
      ),
    );
  }
}

// Popularne Sklepy
class PopularShopsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Section(
      title: "Popularne Sklepy",
      child: ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: 5,
        itemBuilder: (context, index) {
          return ShopTile(
            name: "Sklep ${index + 1}",
            rating: 4.5,
          );
        },
      ),
    );
  }
}

// Komponenty dla różnych elementów sekcji
class OfferTile extends StatelessWidget {
  final String title;
  final String description;
  final String? distance;

  OfferTile({required this.title, required this.description, this.distance});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      subtitle: Text(description),
      trailing: distance != null ? Text(distance!) : null,
    );
  }
}

class CategoryTile extends StatelessWidget {
  final String category;

  CategoryTile({required this.category});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      margin: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.greenAccent,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Text(
          category,
          style: TextStyle(color: Colors.white, fontSize: 16),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class ShopTile extends StatelessWidget {
  final String name;
  final double rating;

  ShopTile({required this.name, required this.rating});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(name),
      subtitle: Row(
        children: [
          Icon(Icons.star, color: Colors.amber, size: 16),
          SizedBox(width: 4),
          Text(rating.toString()),
        ],
      ),
    );
  }
}

// Sekcja nagłówkowa do użycia w każdym komponencie
class Section extends StatelessWidget {
  final String title;
  final Widget child;

  Section({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          child,
        ],
      ),
    );
  }
}

import 'package:auto_route/auto_route.dart';
import 'package:flow_zero_waste/core/common/presentation/logics/providers/responsive_ui/page_provider.dart';
import 'package:flow_zero_waste/core/common/presentation/widgets/components/location_section.dart';
import 'package:flow_zero_waste/core/common/presentation/widgets/components/nav_bar.dart';
import 'package:flow_zero_waste/core/extensions/l10n_extension.dart';
import 'package:flow_zero_waste/src/discover/presentation/widgets/banner_section.dart';
import 'package:flow_zero_waste/src/discover/presentation/widgets/offers_section.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Page for discovering new offers, shops and more
@RoutePage()
class DiscoverPage extends StatelessWidget implements AutoRouteWrapper {
  /// Default constructor
  const DiscoverPage({super.key});

  @override
  Widget build(BuildContext context) {
    final page = context.watch<PageProvider>();
    return Scaffold(
      appBar: NavBar(
        text: context.l10n.discover,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: page.spacing,
                vertical: page.spacingHalf,
              ),
              child: LocationSection(
                // localization: null,
                localization: "Stanisława Moniuszki 1, 31-530 Kraków",
                onLocationChange: () {},
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: page.spacing, vertical: page.spacing),
              child: BannersSection(
                banners: [
                  BanerData(
                    title: 'Baner 1',
                    imageUrl: null,
                  ),
                  BanerData(
                    title: 'Baner 2',
                    imageUrl: 'https://picsum.photos/301/201',
                  ),
                  BanerData(
                    title: 'Baner 3',
                    imageUrl: 'https://picsum.photos/302/202',
                  ),
                  BanerData(
                    title: 'Baner 4',
                    imageUrl: 'https://picsum.photos/303/203',
                  ),
                  BanerData(
                    title: 'Baner 5',
                    imageUrl: 'https://picsum.photos/304/204',
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: page.spacing,
                vertical: page.spacing,
              ),
              child: OffersSection(
                offers: [
                  OfferData(
                    id: 'sdfghjk',
                    title: 'Offers 1',
                    description: 'najlepsza Offerta 1',
                    distance: 1200,
                    localization: 'Kraków generala maczka',
                    imageUrl: 'https://picsum.photos/307/207',
                    startDate: DateTime.now(),
                    endDate: DateTime.now().add(Duration(hours: 5)),
                    isLiked: false,
                  ),
                  OfferData(
                    id: 'sdfghjk',
                    title: 'Offers 2',
                    description: 'najlepsza Offerta 2',
                    distance: 200,
                    localization:
                        'Kraków generala maczka PRZY ULICY CIASNEJ OSIEM JEST SUERPANCKO',
                    imageUrl: 'https://picsum.photos/308/208',
                    startDate: DateTime.now(),
                    endDate: DateTime.now().add(Duration(hours: 4)),
                    isLiked: false,
                  ),
                  OfferData(
                    id: 'sdfghjk',
                    title: 'Offers 3',
                    description: 'najlepsza Offerta 3',
                    distance: 12000,
                    localization: 'Kraków generala maczka',
                    imageUrl: 'https://picsum.photos/309/209',
                    startDate: DateTime.now(),
                    endDate: DateTime.now().add(Duration(hours: 3)),
                    isLiked: true,
                  ),
                  OfferData(
                    id: 'sdfghjk',
                    title: 'Offers 4',
                    description: 'najlepsza Offerta 4',
                    distance: 100,
                    localization: 'Kraków generala maczka',
                    imageUrl: 'https://picsum.photos/310/210',
                    endDate: DateTime.now().add(Duration(hours: 2)),
                    startDate: DateTime.now().subtract(Duration(hours: 2)),
                    isLiked: true,
                  ),
                  OfferData(
                    id: 'sdfghjk',
                    title: 'Offers 5',
                    distance: 812000,
                    description: 'Opis oferty 5 ble ble',
                    localization: 'Kraków generala maczka',
                    imageUrl: 'https://picsum.photos/311/211',
                    startDate: DateTime.now().subtract(Duration(hours: 4)),
                    endDate: DateTime.now().add(Duration(hours: 1)),
                    isLiked: false,
                  ),
                ],
              ),
            ),
            // CategoriesSection(),
            // RecommendedShopsSection(),
          ],
        ),
      ),
    );
  }

  @override
  Widget wrappedRoute(BuildContext context) {
    // TODO: implement wrappedRoute
    return this;
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
          Text(title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          child,
        ],
      ),
    );
  }
}

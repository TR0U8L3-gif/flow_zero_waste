import 'package:auto_route/auto_route.dart';
import 'package:flow_zero_waste/core/common/presentation/logics/providers/responsive_ui/page_provider.dart';
import 'package:flow_zero_waste/src/location/presentation/widgets/location_section.dart';
import 'package:flow_zero_waste/core/common/presentation/widgets/components/nav_bar.dart';
import 'package:flow_zero_waste/core/extensions/l10n_extension.dart';
import 'package:flow_zero_waste/src/discover/presentation/widgets/banner_section.dart';
import 'package:flow_zero_waste/src/discover/presentation/widgets/categories_section.dart';
import 'package:flow_zero_waste/src/discover/presentation/widgets/offers_section.dart';
import 'package:flow_zero_waste/src/discover/presentation/widgets/recommended_shops_section.dart';
import 'package:flow_zero_waste/src/location/presentation/widgets/select_location_popup.dart';
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
                localization: 'Stanisława Moniuszki 1, 31-530 Kraków',
                onLocationChange: () =>
                    SelectLocationPopup.showBottomSheet<void>(context),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: page.spacing,
                vertical: page.spacing,
              ),
              child: BannersSection(
                onBannerTap: debugPrint,
                banners: [
                  BannerData(
                    title: 'Baner 1',
                  ),
                  BannerData(
                    title: 'Baner 2',
                    description: 'Opis banera 2',
                    imageUrl: 'https://picsum.photos/301/201',
                  ),
                  BannerData(
                    title: 'Baner 3 tutaj długi opis',
                    imageUrl: 'https://picsum.photos/302/202',
                  ),
                  BannerData(
                    title: 'Baner 4',
                    description: 'bardzo długi opis bannera oj tak coś tam coś',
                    imageUrl: 'https://picsum.photos/303/203',
                  ),
                  BannerData(
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
                onOfferLikeTap: (id) => debugPrint('Liked offer with id: $id'),
                onOfferTap: debugPrint,
                offers: [
                  OfferData(
                    id: '5675767-234234-345',
                    title: 'Offers 1',
                    description: 'najlepsza Oferta 1',
                    distance: 1200,
                    localization: 'Kraków generała maczka',
                    imageUrl: 'https://picsum.photos/307/207',
                    startDate: DateTime.now(),
                    endDate: DateTime.now().add(const Duration(hours: 5)),
                    isLiked: false,
                    newOffers: 15,
                  ),
                  OfferData(
                    id: '909-234234-345',
                    title: 'Offers 2',
                    description: 'najlepsza oferta 2',
                    distance: 200,
                    localization:
                        'Kraków generała maczka PRZY ULICY CIASNEJ OSIEM JEST',
                    imageUrl: 'https://picsum.photos/308/208',
                    startDate: DateTime.now(),
                    endDate: DateTime.now().add(const Duration(hours: 4)),
                    isLiked: false,
                    newOffers: 11,
                  ),
                  OfferData(
                    id: '789878-234234-345',
                    title: 'Offers 3',
                    description: 'najlepsza oferta 3',
                    distance: 12000,
                    localization: 'Kraków generała maczka',
                    imageUrl: 'https://picsum.photos/309/209',
                    startDate: DateTime.now(),
                    endDate: DateTime.now().add(const Duration(hours: 3)),
                    isLiked: true,
                    newOffers: 1,
                  ),
                  OfferData(
                    id: '456-076-23',
                    title: 'Offers 4',
                    description: 'najlepsza oferta 4',
                    distance: 100,
                    localization: 'Kraków generała maczka',
                    imageUrl: 'https://picsum.photos/310/210',
                    endDate: DateTime.now().add(const Duration(hours: 2)),
                    startDate:
                        DateTime.now().subtract(const Duration(hours: 2)),
                    isLiked: true,
                    newOffers: 2,
                  ),
                  OfferData(
                    id: '45-876-324',
                    title: 'Offers 5',
                    distance: 812000,
                    description: 'Opis oferty 5 ble ble',
                    localization: 'Kraków generała maczka',
                    imageUrl: 'https://picsum.photos/311/211',
                    startDate:
                        DateTime.now().subtract(const Duration(hours: 4)),
                    endDate: DateTime.now().add(const Duration(hours: 1)),
                    isLiked: false,
                    newOffers: 5,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: page.spacing,
                vertical: page.spacing,
              ),
              child: CategoriesSection(
                onCategoryTap: print,
                categories: [
                  CategoryData(
                    title: 'Fruits',
                    imageUrl: 'https://picsum.photos/128',
                  ),
                  CategoryData(
                    title: 'Vegetables',
                    imageUrl: 'https://picsum.photos/124',
                  ),
                  CategoryData(title: 'Meat'),
                  CategoryData(title: 'Fish'),
                  CategoryData(title: 'Chips'),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: page.spacing,
                vertical: page.spacing,
              ),
              child: RecommendedShopsSection(
                shops: [
                  ShopData(
                    id: '1',
                    title: 'Green Grocers',
                    localization: 'Downtown, NY',
                    startDate:
                        DateTime.now().subtract(const Duration(hours: 6)),
                    endDate: DateTime.now().add(const Duration(hours: 4)),
                    description:
                        'A local grocery store offering fresh organic produce.',
                    imageUrl: 'https://picsum.photos/300',
                    isLiked: true,
                  ),
                  ShopData(
                    id: '2',
                    title: 'Eco Boutique',
                    localization: 'Greenwich, London',
                    startDate:
                        DateTime.now().subtract(const Duration(hours: 12)),
                    endDate: DateTime.now().add(const Duration(hours: 6)),
                    description: 'Eco-friendly clothing and accessories.',
                    imageUrl: 'https://picsum.photos/301',
                    isLiked: false,
                  ),
                  ShopData(
                    id: '3',
                    title: 'Farm Fresh Market',
                    localization: 'San Francisco, CA',
                    startDate:
                        DateTime.now().subtract(const Duration(hours: 8)),
                    endDate: DateTime.now().add(const Duration(hours: 2)),
                    description: 'Farm-to-table organic market.',
                    imageUrl: 'https://picsum.photos/302',
                    isLiked: false,
                  ),
                  ShopData(
                    id: '4',
                    title: 'Sustainable Living Store',
                    localization: 'Berlin, Germany',
                    startDate:
                        DateTime.now().subtract(const Duration(hours: 10)),
                    endDate: DateTime.now().add(const Duration(hours: 5)),
                    description:
                        'Products to help you live a more sustainable lifestyle.',
                    imageUrl: 'https://picsum.photos/303',
                    isLiked: true,
                  ),
                  ShopData(
                    id: '5',
                    title: 'Nature’s Basket',
                    localization: 'Toronto, Canada',
                    startDate:
                        DateTime.now().subtract(const Duration(hours: 7)),
                    endDate: DateTime.now().add(const Duration(hours: 3)),
                    description: 'A variety of eco-friendly and organic goods.',
                    imageUrl: 'https://picsum.photos/304',
                    isLiked: false,
                  ),
                  ShopData(
                    id: '6',
                    title: 'Zero Waste Market',
                    localization: 'Paris, France',
                    startDate:
                        DateTime.now().subtract(const Duration(hours: 9)),
                    endDate: DateTime.now().add(const Duration(hours: 6)),
                    description:
                        'Zero waste products and tips for a greener life.',
                    imageUrl: 'https://picsum.photos/305',
                    isLiked: false,
                  ),
                  ShopData(
                    id: '7',
                    title: 'The Vegan Hub',
                    localization: 'Austin, TX',
                    startDate:
                        DateTime.now().subtract(const Duration(hours: 4)),
                    endDate: DateTime.now().add(const Duration(hours: 8)),
                    description:
                        'A store dedicated to vegan and cruelty-free products.',
                    imageUrl: 'https://picsum.photos/306',
                    isLiked: true,
                  ),
                  ShopData(
                    id: '8',
                    title: 'Green Supply Co.',
                    localization: 'Tokyo, Japan',
                    startDate:
                        DateTime.now().subtract(const Duration(hours: 5)),
                    endDate: DateTime.now().add(const Duration(hours: 7)),
                    description: 'Eco-friendly household and personal items.',
                    imageUrl: 'https://picsum.photos/307',
                    isLiked: true,
                  ),
                  ShopData(
                    id: '9',
                    title: 'Organic Bliss',
                    localization: 'Sydney, Australia',
                    startDate:
                        DateTime.now().subtract(const Duration(hours: 6)),
                    endDate: DateTime.now().add(const Duration(hours: 4)),
                    description:
                        'Pure organic products for your health and home.',
                    imageUrl: 'https://picsum.photos/308',
                    isLiked: false,
                  ),
                  ShopData(
                    id: '10',
                    title: 'Earthly Goods',
                    localization: 'Cape Town, South Africa',
                    startDate:
                        DateTime.now().subtract(const Duration(hours: 7)),
                    endDate: DateTime.now().add(const Duration(hours: 5)),
                    description: 'Sustainable goods for everyday living.',
                    imageUrl: 'https://picsum.photos/309',
                    isLiked: false,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget wrappedRoute(BuildContext context) {
    return this;
  }
}

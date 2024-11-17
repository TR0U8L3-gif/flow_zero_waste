import 'package:auto_route/auto_route.dart';
import 'package:flow_zero_waste/core/common/presentation/logics/providers/responsive_ui/page_provider.dart';
import 'package:flow_zero_waste/core/common/presentation/widgets/components/nav_bar.dart';
import 'package:flow_zero_waste/core/extensions/l10n_extension.dart';
import 'package:flow_zero_waste/src/discover/presentation/widgets/banner_section.dart';
import 'package:flow_zero_waste/src/discover/presentation/widgets/categories_section.dart';
import 'package:flow_zero_waste/src/discover/presentation/widgets/offers_section.dart';
import 'package:flow_zero_waste/src/discover/presentation/widgets/recommended_shops_section.dart';
import 'package:flow_zero_waste/src/location/presentation/logics/location_provider.dart';
import 'package:flow_zero_waste/src/location/presentation/widgets/location_section.dart';
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
                localization:
                    context.watch<LocationProvider>().locationData?.address,
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
                    title: 'Fresh Deals',
                    description:
                        'Discover fresh and sustainable food at amazing prices!',
                    imageUrl: 'https://picsum.photos/600/300?image=1',
                  ),
                  BannerData(
                    title: 'Eco Pantry',
                    description:
                        'Zero waste pantry essentials for your green lifestyle.',
                    imageUrl: 'https://picsum.photos/600/300?image=2',
                  ),
                  BannerData(
                    title: 'Organic Treats',
                    description:
                        'Indulge in delicious organic and eco-friendly snacks.',
                    imageUrl: 'https://picsum.photos/600/300?image=3',
                  ),
                  BannerData(
                    title: 'Sustainable Living',
                    description:
                        'Products that support your commitment to the environment.',
                    imageUrl: 'https://picsum.photos/600/300?image=4',
                  ),
                  BannerData(
                    title: 'Local Favorites',
                    description:
                        'Explore the best zero waste options from local producers.',
                    imageUrl: 'https://picsum.photos/600/300?image=5',
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
                    id: 'offer1',
                    title: 'Eco Pantry',
                    distance: 1200,
                    localization: 'Lipowa Street, Białystok',
                    startDate: DateTime.now().copyWith(hour: 9, minute: 15),
                    endDate: DateTime.now().copyWith(hour: 19, minute: 30),
                    description:
                        'Discover a wide range of zero waste food products at Eco Pantry.',
                    imageUrl: 'https://picsum.photos/401/201',
                    isLiked: false,
                    newOffers: 5,
                  ),
                  OfferData(
                    id: 'offer2',
                    title: 'Zero Waste Market',
                    distance: 2500,
                    localization: 'Rynek Kościuszki, Białystok',
                    startDate: DateTime.now().copyWith(hour: 8, minute: 30),
                    endDate: DateTime.now().copyWith(hour: 19, minute: 30),
                    description:
                        'Your destination for unpackaged and sustainable groceries.',
                    imageUrl: 'https://picsum.photos/402/202',
                    isLiked: true,
                    newOffers: 3,
                  ),
                  OfferData(
                    id: 'offer3',
                    title: 'Green Groceries Hub',
                    distance: 800,
                    localization: 'Piłsudskiego Avenue, Białystok',
                    startDate: DateTime.now().copyWith(hour: 9, minute: 45),
                    endDate: DateTime.now().copyWith(hour: 19, minute: 30),
                    description:
                        'Fresh produce and pantry staples without wasteful packaging.',
                    imageUrl: 'https://picsum.photos/403/203',
                    isLiked: false,
                    newOffers: 7,
                  ),
                  OfferData(
                    id: 'offer4',
                    title: 'Sustainable Bites',
                    distance: 3000,
                    localization: 'Sienkiewicza Street, Białystok',
                    startDate: DateTime.now().copyWith(hour: 8, minute: 0),
                    endDate: DateTime.now().copyWith(hour: 19, minute: 30),
                    description:
                        'Tasty snacks and meals that care for the environment.',
                    imageUrl: 'https://picsum.photos/404/204',
                    isLiked: true,
                    newOffers: 2,
                  ),
                  OfferData(
                    id: 'offer5',
                    title: 'Refill & Feast',
                    distance: 1800,
                    localization: 'Zwierzyniecka Street, Białystok',
                    startDate: DateTime.now().copyWith(hour: 9, minute: 30),
                    endDate: DateTime.now().copyWith(hour: 19, minute: 30),
                    description:
                        'Refill your pantry and feast sustainably with zero waste options.',
                    imageUrl: 'https://picsum.photos/405/205',
                    isLiked: false,
                    newOffers: 9,
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
                    imageUrl: 'https://picsum.photos/124/64',
                  ),
                  CategoryData(
                    title: 'Vegetables',
                    imageUrl: 'https://picsum.photos/125/65',
                  ),
                  CategoryData(
                    title: 'Meat',
                    imageUrl: 'https://picsum.photos/126/66',
                  ),
                  CategoryData(
                    title: 'Fish',
                    imageUrl: 'https://picsum.photos/127/67',
                  ),
                  CategoryData(
                    title: 'Chips',
                    imageUrl: 'https://picsum.photos/128/68',
                  ),
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

// ignore_for_file: public_member_api_docs

import 'dart:convert';

import 'package:flow_zero_waste/core/services/hive/hive_manager.dart';
import 'package:flow_zero_waste/src/discover/data/models/banner_model.dart';
import 'package:flow_zero_waste/src/discover/data/models/category_model.dart';
import 'package:flow_zero_waste/src/discover/data/models/offer_model.dart';
import 'package:flow_zero_waste/src/discover/data/models/shop_model.dart';

const bannerBoxName = 'bannerBox';
const categoryBoxName = 'categoryBox';
const offerBoxName = 'offerBox';
const shopBoxName = 'shopBox';

const _banners = <BannerModel>[
  BannerModel(
    id: 'bb59624e-0d81-46ed-a9d5-83735a964d13',
    title: 'Fresh Deals',
    description: 'Discover fresh and sustainable food at amazing prices!',
    imageUrl: 'https://picsum.photos/600/300?image=1',
  ),
  BannerModel(
    id: 'b617ff6d-9a14-48a8-821d-91ce9fac4368',
    title: 'Eco Pantry',
    description: 'Zero waste pantry essentials for your green lifestyle.',
    imageUrl: 'https://picsum.photos/600/300?image=2',
  ),
  BannerModel(
    id: '86344152-84dc-4ba7-9a14-5f4774ccdc68',
    title: 'Organic Treats',
    description: 'Indulge in delicious organic and eco-friendly snacks.',
    imageUrl: 'https://picsum.photos/600/300?image=3',
  ),
  BannerModel(
    id: '64b17195-1269-4d53-bc95-79c263eaa67c',
    title: 'Sustainable Living',
    description: 'Products that support your commitment to the environment.',
    imageUrl: 'https://picsum.photos/600/300?image=4',
  ),
  BannerModel(
    id: '6f6c81a8-3bf0-48da-bfb4-cff7d6bbbf2a',
    title: 'Local Favorites',
    description: 'Explore the best zero waste options from local producers.',
    imageUrl: 'https://picsum.photos/600/300?image=5',
  ),
];

const _categories = <CategoryModel>[
  CategoryModel(
    id: '81358300-5baa-47ca-a58c-b42ecd7501df',
    name: 'Fruits',
    imageUrl: 'https://picsum.photos/124/64?image=1',
  ),
  CategoryModel(
    id: '71c2207e-cf2f-4be4-b79b-4daa8b324def',
    name: 'Vegetables',
    imageUrl: 'https://picsum.photos/124/64?image=2',
  ),
  CategoryModel(
    id: '32028068-9f05-450d-b5d4-1f7ef1de497f',
    name: 'Meat',
    imageUrl: 'https://picsum.photos/124/64?image=3',
  ),
  CategoryModel(
    id: 'e7d676f3-a3fd-4cf7-885f-45813e507815',
    name: 'Fish',
    imageUrl: 'https://picsum.photos/124/64?image=4',
  ),
  CategoryModel(
    id: 'b3352f56-ec47-4991-b60e-29a21213353a',
    name: 'Chips',
    imageUrl: 'https://picsum.photos/124/64?image=5',
  ),
];

final _shops = <ShopModel>[
  ShopModel(
    id: '17914dbd-a9be-4a6a-9290-c2a78f90de39',
    name: 'Eco Pantry',
    description: 'Zero waste pantry essentials for your green lifestyle.',
    localization: 'Zwierzyniecka Street, Białystok',
    imageUrl: 'https://picsum.photos/200/200?image=1',
    startDate: DateTime.now().copyWith(hour: 9, minute: 30).toIso8601String(),
    endDate: DateTime.now().copyWith(hour: 19, minute: 30).toIso8601String(),
    isLiked: true,
  ),
  ShopModel(
    id: '5b3bd1d0-be7e-4dde-8f40-30034124616e',
    name: 'Green Haven',
    description: 'Sustainable essentials for an eco-friendly home.',
    localization: 'Dubois Street, Białystok',
    imageUrl: 'https://picsum.photos/200/200?image=2',
    startDate: DateTime.now().copyWith(hour: 8, minute: 30).toIso8601String(),
    endDate: DateTime.now().copyWith(hour: 20, minute: 00).toIso8601String(),
    isLiked: false,
  ),
  ShopModel(
    id: 'b88bf023-1c51-48f4-accd-54c2a5ca7b6f',
    name: 'Nature Nook',
    description: 'Plastic-free pantry staples for conscious living.',
    localization: 'Lipowa Street, Białystok',
    imageUrl: 'https://picsum.photos/200/200?image=3',
    startDate: DateTime.now().copyWith(hour: 9, minute: 30).toIso8601String(),
    endDate: DateTime.now().copyWith(hour: 21, minute: 30).toIso8601String(),
    isLiked: false,
  ),
  ShopModel(
    id: '1dd15a15-ba7d-4cd1-b104-442c2c3ec646',
    name: 'Earthly Goods',
    description: 'Eco-friendly essentials for sustainable lifestyles.',
    localization: 'Sienkiewicz Street, Białystok',
    imageUrl: 'https://picsum.photos/200/200?image=4',
    startDate: DateTime.now().copyWith(hour: 7, minute: 30).toIso8601String(),
    endDate: DateTime.now().copyWith(hour: 19, minute: 30).toIso8601String(),
    isLiked: false,
  ),
  ShopModel(
    id: 'da02dd4b-68a2-4971-bb8a-a866e156a623',
    name: 'Zero Co.',
    description: 'Waste-free pantry and household products made simple.',
    localization: 'Produkcyjna Street, Białystok',
    imageUrl: 'https://picsum.photos/200/200?image=5',
    startDate: DateTime.now().copyWith(hour: 8, minute: 00).toIso8601String(),
    endDate: DateTime.now().copyWith(hour: 20, minute: 00).toIso8601String(),
    isLiked: true,
  ),
  ShopModel(
    id: '773d409b-5a04-4da7-a979-798cefe919b9',
    name: 'Eco Basics',
    description: 'Minimalist pantry essentials for greener choices.',
    localization: 'Hetmanska Street, Białystok',
    imageUrl: 'https://picsum.photos/200/200?image=6',
    startDate: DateTime.now().copyWith(hour: 9, minute: 00).toIso8601String(),
    endDate: DateTime.now().copyWith(hour: 21, minute: 00).toIso8601String(),
    isLiked: false,
  ),
  ShopModel(
    id: '82e7be47-90c2-4f29-ab8d-9e862f0e2a3f',
    name: 'Sustain Supply',
    description: 'Consciously curated essentials for a zero-waste journey.',
    localization: 'Piasta Street, Białystok',
    imageUrl: 'https://picsum.photos/200/200?image=7',
    startDate: DateTime.now().copyWith(hour: 8, minute: 00).toIso8601String(),
    endDate: DateTime.now().copyWith(hour: 21, minute: 00).toIso8601String(),
    isLiked: false,
  ),
];

final _offers = <OfferModel>[
  OfferModel(
    id: 'd93e2a5a-6f4d-404c-96d9-60379ae8a172', 
    rating: 10, 
    distance: 1800, 
    newOffers: 9, 
    shop: _shops[0],
  ),
  OfferModel(
    id: '5f697551-86d7-49f3-bd0b-4f38d88b8436', 
    rating: 9.5, 
    distance: 5000, 
    newOffers: 9, 
    shop: _shops[2],
  ),
  OfferModel(
    id: 'db84c618-e079-499a-92a7-3e9fd1da61b8', 
    rating: 8, 
    distance: 3000, 
    newOffers: 9, 
    shop: _shops[4],
  ),
  OfferModel(
    id: '96b5d36f-8c61-4dda-8882-3f9dacb900a0', 
    rating: 7.5, 
    distance: 2000, 
    newOffers: 9, 
    shop: _shops[6],
  ),
];

class BannerHiveStorage extends HiveManager<String> {
  BannerHiveStorage({required super.boxName}) {
    _banners.forEach((banner) async {
      await write(json.encode(banner.toJson()) , key: banner.id);
    });
  }
}

class CategoryHiveStorage extends HiveManager<String> {
  CategoryHiveStorage({required super.boxName}) {
    _categories.forEach((category) async {
      await write(json.encode(category.toJson()) , key: category.id);
    });
  }
}

class OfferHiveStorage extends HiveManager<String> {
  OfferHiveStorage({required super.boxName}) {
    _offers.forEach((offer) async {
      await write(json.encode(offer.toJson()) , key: offer.id);
    });
  }
}

class ShopHiveStorage extends HiveManager<String> {
  ShopHiveStorage({required super.boxName}) {
    _shops.forEach((shop) async {
      await write(json.encode(shop.toJson()) , key: shop.id);
    });
  }
}
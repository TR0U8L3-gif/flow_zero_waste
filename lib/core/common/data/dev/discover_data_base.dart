// ignore_for_file: public_member_api_docs

import 'dart:convert';

import 'package:flow_zero_waste/core/services/hive/hive_manager.dart';
import 'package:flow_zero_waste/src/discover/data/models/shop_model.dart';

const bannerBoxName = 'bannerBox';
const categoryBoxName = 'categoryBox';
const offerBoxName = 'offerBox';
const shopBoxName = 'shopBox';

const _banners = <Map<String, dynamic>>[
  {
    'languageCode': 'en',
    'id': 'bb59624e-0d81-46ed-a9d5-83735a964d13',
    'title': 'Fresh Deals',
    'description': 'Discover fresh and sustainable food at amazing prices!',
    'imageUrl': 'https://picsum.photos/600/300?image=11',
  },
  {
    'languageCode': 'en',
    'id': 'b617ff6d-9a14-48a8-821d-91ce9fac4368',
    'title': 'Eco Pantry',
    'description': 'Zero waste pantry essentials for your green lifestyle.',
    'imageUrl': 'https://picsum.photos/600/300?image=12',
  },
  {
    'languageCode': 'en',
    'id': '86344152-84dc-4ba7-9a14-5f4774ccdc68',
    'title': 'Organic Treats',
    'description': 'Indulge in delicious organic and eco-friendly snacks.',
    'imageUrl': 'https://picsum.photos/600/300?image=13',
  },
  {
    'languageCode': 'en',
    'id': '64b17195-1269-4d53-bc95-79c263eaa67c',
    'title': 'Sustainable Living',
    'description': 'Products that support your commitment to the environment.',
    'imageUrl': 'https://picsum.photos/600/300?image=14',
  },
  {
    'languageCode': 'en',
    'id': '6f6c81a8-3bf0-48da-bfb4-cff7d6bbbf2a',
    'title': 'Local Favorites',
    'description': 'Explore the best zero waste options from local producers.',
    'imageUrl': 'https://picsum.photos/600/300?image=15',
  },
  {
    'languageCode': 'pl',
    'id': 'bb59624e-0d81-46ed-a9d5-83735a964d13-pl',
    'title': 'Świeże Okazje',
    'description':
        'Odkryj świeżą i zrównoważoną żywność w niesamowitych cenach!',
    'imageUrl': 'https://picsum.photos/600/300?image=11',
  },
  {
    'languageCode': 'pl',
    'id': 'b617ff6d-9a14-48a8-821d-91ce9fac4368-pl',
    'title': 'Eko Spiżarnia',
    'description':
        'Niezbędniki do spiżarni zero waste dla Twojego ekologicznego stylu życia.',
    'imageUrl': 'https://picsum.photos/600/300?image=12',
  },
  {
    'languageCode': 'pl',
    'id': '86344152-84dc-4ba7-9a14-5f4774ccdc68-pl',
    'title': 'Organiczne Przysmaki',
    'description':
        'Rozkoszuj się pysznymi, ekologicznymi i przyjaznymi dla środowiska przekąskami.',
    'imageUrl': 'https://picsum.photos/600/300?image=13',
  },
  {
    'languageCode': 'pl',
    'id': '64b17195-1269-4d53-bc95-79c263eaa67c-pl',
    'title': 'Zrównoważone Życie',
    'description':
        'Produkty wspierające Twoje zaangażowanie w ochronę środowiska.',
    'imageUrl': 'https://picsum.photos/600/300?image=14',
  },
  {
    'languageCode': 'pl',
    'id': '6f6c81a8-3bf0-48da-bfb4-cff7d6bbbf2a-pl',
    'title': 'Lokalne Ulubieńce',
    'description':
        'Odkryj najlepsze opcje zero waste od lokalnych producentów.',
    'imageUrl': 'https://picsum.photos/600/300?image=15',
  },
];

const _categories = <Map<String, dynamic>>[
  {
    'languageCode': 'en',
    'id': '81358300-5baa-47ca-a58c-b42ecd7501df',
    'name': 'Fruits',
    'imageUrl': 'https://picsum.photos/124/64?image=51',
  },
  {
    'languageCode': 'en',
    'id': '71c2207e-cf2f-4be4-b79b-4daa8b324def',
    'name': 'Vegetables',
    'imageUrl': 'https://picsum.photos/124/64?image=52',
  },
  {
    'languageCode': 'en',
    'id': '32028068-9f05-450d-b5d4-1f7ef1de497f',
    'name': 'Meat',
    'imageUrl': 'https://picsum.photos/124/64?image=53',
  },
  {
    'languageCode': 'en',
    'id': 'e7d676f3-a3fd-4cf7-885f-45813e507815',
    'name': 'Fish',
    'imageUrl': 'https://picsum.photos/124/64?image=54',
  },
  {
    'languageCode': 'en',
    'id': 'b3352f56-ec47-4991-b60e-29a21213353a',
    'name': 'Chips',
    'imageUrl': 'https://picsum.photos/124/64?image=55',
  },
  {
    'languageCode': 'pl',
    'id': '81358300-5baa-47ca-a58c-b42ecd7501df-pl',
    'name': 'Owoce',
    'imageUrl': 'https://picsum.photos/124/64?image=51',
  },
  {
    'languageCode': 'pl',
    'id': '71c2207e-cf2f-4be4-b79b-4daa8b324def-pl',
    'name': 'Warzywa',
    'imageUrl': 'https://picsum.photos/124/64?image=52',
  },
  {
    'languageCode': 'pl',
    'id': '32028068-9f05-450d-b5d4-1f7ef1de497f-pl',
    'name': 'Mięso',
    'imageUrl': 'https://picsum.photos/124/64?image=53',
  },
  {
    'languageCode': 'pl',
    'id': 'e7d676f3-a3fd-4cf7-885f-45813e507815-pl',
    'name': 'Ryby',
    'imageUrl': 'https://picsum.photos/124/64?image=54',
  },
  {
    'languageCode': 'pl',
    'id': 'b3352f56-ec47-4991-b60e-29a21213353a-pl',
    'name': 'Chipsy',
    'imageUrl': 'https://picsum.photos/124/64?image=55',
  },
];

final _shops = <Map<String, dynamic>>[
  {
    'languageCode': 'en',
    'id': '17914dbd-a9be-4a6a-9290-c2a78f90de39',
    'name': 'Eco Pantry',
    'description': 'Zero waste pantry essentials for your green lifestyle.',
    'localization': 'Zwierzyniecka Street, Białystok',
    'imageUrl': 'https://picsum.photos/200/200?image=81',
    'startDate': DateTime.now().copyWith(hour: 9, minute: 30).toIso8601String(),
    'endDate': DateTime.now().copyWith(hour: 19, minute: 30).toIso8601String(),
    'isLiked': true,
  },
  {
    'languageCode': 'en',
    'id': '5b3bd1d0-be7e-4dde-8f40-30034124616e',
    'name': 'Green Haven',
    'description': 'Sustainable essentials for an eco-friendly home.',
    'localization': 'Dubois Street, Białystok',
    'imageUrl': 'https://picsum.photos/200/200?image=82',
    'startDate': DateTime.now().copyWith(hour: 8, minute: 30).toIso8601String(),
    'endDate': DateTime.now().copyWith(hour: 20, minute: 00).toIso8601String(),
    'isLiked': false,
  },
  {
    'languageCode': 'en',
    'id': 'b88bf023-1c51-48f4-accd-54c2a5ca7b6f',
    'name': 'Nature Nook',
    'description': 'Plastic-free pantry staples for conscious living.',
    'localization': 'Lipowa Street, Białystok',
    'imageUrl': 'https://picsum.photos/200/200?image=83',
    'startDate': DateTime.now().copyWith(hour: 9, minute: 30).toIso8601String(),
    'endDate': DateTime.now().copyWith(hour: 21, minute: 30).toIso8601String(),
    'isLiked': false,
  },
  {
    'languageCode': 'en',
    'id': '1dd15a15-ba7d-4cd1-b104-442c2c3ec646',
    'name': 'Earthly Goods',
    'description': 'Eco-friendly essentials for sustainable lifestyles.',
    'localization': 'Sienkiewicz Street, Białystok',
    'imageUrl': 'https://picsum.photos/200/200?image=84',
    'startDate': DateTime.now().copyWith(hour: 7, minute: 30).toIso8601String(),
    'endDate': DateTime.now().copyWith(hour: 19, minute: 30).toIso8601String(),
    'isLiked': false,
  },
  {
    'languageCode': 'en',
    'id': 'da02dd4b-68a2-4971-bb8a-a866e156a623',
    'name': 'Zero Co.',
    'description': 'Waste-free pantry and household products made simple.',
    'localization': 'Produkcyjna Street, Białystok',
    'imageUrl': 'https://picsum.photos/200/200?image=85',
    'startDate': DateTime.now().copyWith(hour: 8, minute: 00).toIso8601String(),
    'endDate': DateTime.now().copyWith(hour: 20, minute: 00).toIso8601String(),
    'isLiked': true,
  },
  {
    'languageCode': 'en',
    'id': '773d409b-5a04-4da7-a979-798cefe919b9',
    'name': 'Eco Basics',
    'description': 'Minimalist pantry essentials for greener choices.',
    'localization': 'Hetmanska Street, Białystok',
    'imageUrl': 'https://picsum.photos/200/200?image=86',
    'startDate': DateTime.now().copyWith(hour: 9, minute: 00).toIso8601String(),
    'endDate': DateTime.now().copyWith(hour: 21, minute: 00).toIso8601String(),
    'isLiked': false,
  },
  {
    'languageCode': 'en',
    'id': '82e7be47-90c2-4f29-ab8d-9e862f0e2a3f',
    'name': 'Sustain Supply',
    'description': 'Consciously curated essentials for a zero-waste journey.',
    'localization': 'Piasta Street, Białystok',
    'imageUrl': 'https://picsum.photos/200/200?image=87',
    'startDate': DateTime.now().copyWith(hour: 8, minute: 00).toIso8601String(),
    'endDate': DateTime.now().copyWith(hour: 21, minute: 00).toIso8601String(),
    'isLiked': false,
  },
  {
    'languageCode': 'pl',
    'id': '17914dbd-a9be-4a6a-9290-c2a78f90de39-pl',
    'name': 'Eko Spiżarnia',
    'description':
        'Niezbędniki do spiżarni zero waste dla Twojego ekologicznego stylu życia.',
    'localization': 'Ulica Zwierzyniecka, Białystok',
    'imageUrl': 'https://picsum.photos/200/200?image=81',
    'startDate': DateTime.now().copyWith(hour: 9, minute: 30).toIso8601String(),
    'endDate': DateTime.now().copyWith(hour: 19, minute: 30).toIso8601String(),
    'isLiked': true,
  },
  {
    'languageCode': 'pl',
    'id': '5b3bd1d0-be7e-4dde-8f40-30034124616e-pl',
    'name': 'Zielona Przystań',
    'description': 'Zrównoważone niezbędniki do ekologicznego domu.',
    'localization': 'Ulica Dubois, Białystok',
    'imageUrl': 'https://picsum.photos/200/200?image=82',
    'startDate': DateTime.now().copyWith(hour: 8, minute: 30).toIso8601String(),
    'endDate': DateTime.now().copyWith(hour: 20, minute: 00).toIso8601String(),
    'isLiked': false,
  },
  {
    'languageCode': 'pl',
    'id': 'b88bf023-1c51-48f4-accd-54c2a5ca7b6f-pl',
    'name': 'Naturalny Zakątek',
    'description': 'Produkty bez plastiku do świadomego życia.',
    'localization': 'Ulica Lipowa, Białystok',
    'imageUrl': 'https://picsum.photos/200/200?image=83',
    'startDate': DateTime.now().copyWith(hour: 9, minute: 30).toIso8601String(),
    'endDate': DateTime.now().copyWith(hour: 21, minute: 30).toIso8601String(),
    'isLiked': false,
  },
  {
    'languageCode': 'pl',
    'id': '1dd15a15-ba7d-4cd1-b104-442c2c3ec646-pl',
    'name': 'Ziemskie Produkty',
    'description': 'Ekologiczne niezbędniki dla zrównoważonego stylu życia.',
    'localization': 'Ulica Sienkiewicza, Białystok',
    'imageUrl': 'https://picsum.photos/200/200?image=84',
    'startDate': DateTime.now().copyWith(hour: 7, minute: 30).toIso8601String(),
    'endDate': DateTime.now().copyWith(hour: 19, minute: 30).toIso8601String(),
    'isLiked': false,
  },
  {
    'languageCode': 'pl',
    'id': 'da02dd4b-68a2-4971-bb8a-a866e156a623-pl',
    'name': 'Zero Co.',
    'description':
        'Proste produkty do spiżarni i gospodarstwa domowego bez odpadów.',
    'localization': 'Ulica Produkcyjna, Białystok',
    'imageUrl': 'https://picsum.photos/200/200?image=85',
    'startDate': DateTime.now().copyWith(hour: 8, minute: 00).toIso8601String(),
    'endDate': DateTime.now().copyWith(hour: 20, minute: 00).toIso8601String(),
    'isLiked': true,
  },
  {
    'languageCode': 'pl',
    'id': '773d409b-5a04-4da7-a979-798cefe919b9-pl',
    'name': 'Eko Podstawy',
    'description': 'Minimalistyczne niezbędniki do zielonych wyborów.',
    'localization': 'Ulica Hetmańska, Białystok',
    'imageUrl': 'https://picsum.photos/200/200?image=86',
    'startDate': DateTime.now().copyWith(hour: 9, minute: 00).toIso8601String(),
    'endDate': DateTime.now().copyWith(hour: 21, minute: 00).toIso8601String(),
    'isLiked': false,
  },
  {
    'languageCode': 'pl',
    'id': '82e7be47-90c2-4f29-ab8d-9e862f0e2a3f-pl',
    'name': 'Zrównoważone Zaopatrzenie',
    'description': 'Świadomie dobrane produkty do zero-waste podróży.',
    'localization': 'Ulica Piasta, Białystok',
    'imageUrl': 'https://picsum.photos/200/200?image=87',
    'startDate': DateTime.now().copyWith(hour: 8, minute: 00).toIso8601String(),
    'endDate': DateTime.now().copyWith(hour: 21, minute: 00).toIso8601String(),
    'isLiked': false,
  },
];

final _offers = <Map<String, dynamic>>[
  {
    'languageCode': 'en',
    'id': _shops[0]['id'] as String,
    'rating': 10.0,
    'distance': 1800.0,
    'newOffers': 1.0,
    'shop': ShopModel.fromJson(_shops[0]).toJson(),
  },
  {
    'languageCode': 'en',
    'id': _shops[2]['id'] as String,
    'rating': 9.5,
    'distance': 5000.0,
    'newOffers': 2.0,
    'shop': ShopModel.fromJson(_shops[2]).toJson(),
  },
  {
    'languageCode': 'en',
    'id': _shops[4]['id'] as String,
    'rating': 8.0,
    'distance': 3000.0,
    'newOffers': 3.0,
    'shop': ShopModel.fromJson(_shops[4]).toJson(),
  },
  {
    'languageCode': 'en',
    'id': _shops[6]['id'] as String,
    'rating': 7.5,
    'distance': 2000.0,
    'newOffers': 4.0,
    'shop': ShopModel.fromJson(_shops[6]).toJson(),
  },
  {
    'languageCode': 'pl',
    'id': _shops[7]['id'] as String,
    'rating': 10.0,
    'distance': 1800.0,
    'newOffers': 1.0,
    'shop': ShopModel.fromJson(_shops[7]).toJson(),
  },
  {
    'languageCode': 'pl',
    'id': _shops[9]['id'] as String,
    'rating': 9.5,
    'distance': 5000.0,
    'newOffers': 2.0,
    'shop': ShopModel.fromJson(_shops[9]).toJson(),
  },
  {
    'languageCode': 'pl',
    'id': _shops[11]['id'] as String,
    'rating': 8.0,
    'distance': 3000.0,
    'newOffers': 3.0,
    'shop': ShopModel.fromJson(_shops[11]).toJson(),
  },
  {
    'languageCode': 'pl',
    'id': _shops[13]['id'] as String,
    'rating': 7.5,
    'distance': 2000.0,
    'newOffers': 4.0,
    'shop': ShopModel.fromJson(_shops[13]).toJson(),
  },
];

class BannerHiveStorage extends HiveManager<String> {
  BannerHiveStorage({required super.boxName}) {
    deleteAll();
    _banners.forEach((banner) async {
      await write(json.encode(banner), key: banner['id'] as String);
    });
  }
}

class CategoryHiveStorage extends HiveManager<String> {
  CategoryHiveStorage({required super.boxName}) {
    deleteAll();
    _categories.forEach((category) async {
      await write(json.encode(category), key: category['id'] as String);
    });
  }
}

class OfferHiveStorage extends HiveManager<String> {
  OfferHiveStorage({required super.boxName}) {
    deleteAll();
    _offers.forEach((offer) async {
      await write(json.encode(offer), key: offer['id'] as String);
    });
  }
}

class ShopHiveStorage extends HiveManager<String> {
  ShopHiveStorage({required super.boxName}) {
    deleteAll();
    _shops.forEach((shop) async {
      await write(json.encode(shop), key: shop['id'] as String);
    });
  }
}

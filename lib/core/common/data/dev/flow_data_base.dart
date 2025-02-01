// ignore_for_file: public_member_api_docs
import 'dart:convert';

import 'package:flow_zero_waste/core/services/hive/hive_manager.dart';

const bannerBoxName = 'bannerBox';
const categoryBoxName = 'categoryBox';
const offerBoxName = 'offerBox';
const shopBoxName = 'shopBox';
const productsBoxName = 'productsBox';
const ordersBoxName = 'ordersBox';

// git
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
    'title': 'Lokalni Ulubieńcy',
    'description':
        'Odkryj najlepsze opcje zero waste od lokalnych producentów.',
    'imageUrl': 'https://picsum.photos/600/300?image=15',
  },
];

// git
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

// git
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
    'rating': 5.0,
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
    'rating': 4.5,
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
    'rating': 4.0,
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
    'rating': 3.5,
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
    'rating': 5.0,
  },
  {
    'languageCode': 'en',
    'id': '773d409b-5a04-4da7-a979-798cefe919b9',
    'name': 'Eco Basics',
    'description': 'Minimalist pantry essentials for greener choices.',
    'localization': 'Hetmanska Street, Białystok',
    'imageUrl': 'https://picsum.photos/200/200?image=89',
    'startDate': DateTime.now().copyWith(hour: 9, minute: 00).toIso8601String(),
    'endDate': DateTime.now().copyWith(hour: 21, minute: 00).toIso8601String(),
    'isLiked': false,
    'rating': 4.5,
  },
  {
    'languageCode': 'en',
    'id': '82e7be47-90c2-4f29-ab8d-9e862f0e2a3f',
    'name': 'Sustain Supply',
    'description': 'Consciously curated essentials for a zero-waste journey.',
    'localization': 'Piasta Street, Białystok',
    'imageUrl': 'https://picsum.photos/200/200?image=90',
    'startDate': DateTime.now().copyWith(hour: 8, minute: 00).toIso8601String(),
    'endDate': DateTime.now().copyWith(hour: 21, minute: 00).toIso8601String(),
    'isLiked': false,
    'rating': 4.0,
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
    'rating': 5.0,
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
    'rating': 4.5,
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
    'rating': 4.0,
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
    'rating': 3.5,
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
    'rating': 5.0,
  },
  {
    'languageCode': 'pl',
    'id': '773d409b-5a04-4da7-a979-798cefe919b9-pl',
    'name': 'Eko Podstawy',
    'description': 'Minimalistyczne niezbędniki do zielonych wyborów.',
    'localization': 'Ulica Hetmańska, Białystok',
    'imageUrl': 'https://picsum.photos/200/200?image=89',
    'startDate': DateTime.now().copyWith(hour: 9, minute: 00).toIso8601String(),
    'endDate': DateTime.now().copyWith(hour: 21, minute: 00).toIso8601String(),
    'isLiked': false,
    'rating': 4.5,
  },
  {
    'languageCode': 'pl',
    'id': '82e7be47-90c2-4f29-ab8d-9e862f0e2a3f-pl',
    'name': 'Zrównoważone Zaopatrzenie',
    'description': 'Świadomie dobrane produkty do zero-waste podróży.',
    'localization': 'Ulica Piasta, Białystok',
    'imageUrl': 'https://picsum.photos/200/200?image=90',
    'startDate': DateTime.now().copyWith(hour: 8, minute: 00).toIso8601String(),
    'endDate': DateTime.now().copyWith(hour: 21, minute: 00).toIso8601String(),
    'isLiked': false,
    'rating': 4.0,
  },
];

// git
final _offers = <Map<String, dynamic>>[
  {
    'languageCode': 'en',
    'id': _shops[0]['id'] as String,
    'rating': 5.0,
    'distance': 1800.0,
    'newOffers': 1.0,
    'shop': _shops[0],
  },
  {
    'languageCode': 'en',
    'id': _shops[2]['id'] as String,
    'rating': 4.5,
    'distance': 5000.0,
    'newOffers': 2.0,
    'shop': _shops[2],
  },
  {
    'languageCode': 'en',
    'id': _shops[4]['id'] as String,
    'rating': 4.0,
    'distance': 3000.0,
    'newOffers': 3.0,
    'shop': _shops[4],
  },
  {
    'languageCode': 'en',
    'id': _shops[6]['id'] as String,
    'rating': 3.5,
    'distance': 2000.0,
    'newOffers': 4.0,
    'shop': _shops[6],
  },
  {
    'languageCode': 'pl',
    'id': _shops[7]['id'] as String,
    'rating': 5.0,
    'distance': 1800.0,
    'newOffers': 1.0,
    'shop': _shops[7],
  },
  {
    'languageCode': 'pl',
    'id': _shops[9]['id'] as String,
    'rating': 4.5,
    'distance': 5000.0,
    'newOffers': 2.0,
    'shop': _shops[9],
  },
  {
    'languageCode': 'pl',
    'id': _shops[11]['id'] as String,
    'rating': 4.0,
    'distance': 3000.0,
    'newOffers': 3.0,
    'shop': _shops[11],
  },
  {
    'languageCode': 'pl',
    'id': _shops[13]['id'] as String,
    'rating': 3.5,
    'distance': 2000.0,
    'newOffers': 4.0,
    'shop': _shops[13],
  },
];

//git
const _products = <Map<String, dynamic>>[
  {
    'imageUrl': 'https://picsum.photos/600/300?image=75',
    'allergens': [], // en
    'languageCode': 'en',
    'name': 'Fresh Grapes',
    'description':
        'Juicy, ripe grapes perfect for snacking or adding to a fruit salad. Country of origin: Italy. Ingredients: Fresh grapes.',
    'quantity': 8,
    'price': 3.99,
    'id': 'df447f4c-8f4c-4176-9552-d8d3364c49en',
  },
  {
    'imageUrl': 'https://picsum.photos/600/300?image=75',
    'allergens': [], // pl
    'languageCode': 'pl',
    'name': 'Świeże Winogrona',
    'description':
        'Soczyste, dojrzałe winogrona idealne na przekąskę lub do sałatki owocowej. Kraj pochodzenia: Włochy. Składniki: Świeże winogrona.',
    'quantity': 8,
    'price': 3.99,
    'id': 'df447f4c-8f4c-4176-9552-d8d3364c4906',
  },
  {
    'imageUrl': 'https://picsum.photos/600/300?image=102',
    'allergens': ['Pollen traces'], // en
    'languageCode': 'en',
    'name': 'Fresh Raspberries',
    'description':
        'Delicious, fresh raspberries with a perfect balance of sweetness and tartness. Country of origin: Poland. Ingredients: Fresh raspberries.',
    'quantity': 10,
    'price': 2.49,
    'id': 'b7f3c37a-5f8b-4a4d-89db-6c7d6bca1a7f',
  },
  {
    'imageUrl': 'https://picsum.photos/600/300?image=102',
    'allergens': ['Śladowe ilości pyłków'], // pl
    'languageCode': 'pl',
    'name': 'Świeże Maliny',
    'description':
        'Pyszne, świeże maliny o idealnym balansie słodyczy i kwaskowatości. Kraj pochodzenia: Polska. Składniki: Świeże maliny.',
    'quantity': 10,
    'price': 2.49,
    'id': 'b7f3c37a-5f8b-4a4d-89db-6c7d6bca1en1',
  },
  {
    'imageUrl': 'https://picsum.photos/600/300?image=292',
    'allergens': ['May contain celery'], // en
    'languageCode': 'en',
    'name': 'Fresh Vegetables',
    'description':
        'A variety of fresh vegetables including parsley, carrots, and red onions. Perfect for soups and salads. Country of origin: Local farms. Ingredients: Mixed vegetables.',
    'quantity': 5,
    'price': 8.99,
    'id': 'c847fbf8-e6c5-4f84-b1dc-d9b0485fdd16',
  },
  {
    'imageUrl': 'https://picsum.photos/600/300?image=292',
    'allergens': ['Może zawierać seler'], // pl
    'languageCode': 'pl',
    'name': 'Świeże Warzywa',
    'description':
        'Różnorodność świeżych warzyw, w tym pietruszka, marchewki i czerwone cebule. Idealne do zup i sałatek. Kraj pochodzenia: Lokalni producenci. Składniki: Mieszanka warzyw.',
    'quantity': 5,
    'price': 8.99,
    'id': 'c847fbf8-e6c5-4f84-b1dc-d9b0485fj4jo',
  },
  {
    'imageUrl': 'https://picsum.photos/600/300?image=326',
    'allergens': ['May contain traces of citrus'], // en
    'languageCode': 'en',
    'name': 'Ginger Tea',
    'description':
        'A warm and soothing ginger tea with a hint of lemon. Perfect for relaxation and wellness. Ingredients: Ginger slices, lemon.',
    'quantity': 7,
    'price': 5.49,
    'id': 'a4bc2d2b-96f3-48b6-9dbf-5cbfb60c38b1',
  },
  {
    'imageUrl': 'https://picsum.photos/600/300?image=326',
    'allergens': ['Może zawierać śladowe ilości cytrusów'], // pl
    'languageCode': 'pl',
    'name': 'Herbata Imbirowa',
    'description':
        'Ciepła i kojąca herbata imbirowa z nutą cytryny. Idealna do relaksu i na poprawę samopoczucia. Składniki: Plasterki imbiru, cytryna.',
    'quantity': 7,
    'price': 5.49,
    'id': 'a4bc2d2b-96f3-48b6-9dbf-5cbfb60c39b2',
  },
  {
    'imageUrl': 'https://picsum.photos/600/300?image=627',
    'allergens': [],
    'languageCode': 'en',
    'name': 'Green Beans',
    'description':
        'Fresh and tender green beans, perfect as a side dish or addition to your favorite meals. Country of origin: Local farms. Ingredients: Green beans.',
    'quantity': 3,
    'price': 4.29,
    'id': 'ab01cdd4-7e73-4c1d-8a71-f28d9b6451b9',
  },
  {
    'imageUrl': 'https://picsum.photos/600/300?image=627',
    'allergens': [],
    'languageCode': 'pl',
    'name': 'Zielona Fasolka',
    'description':
        'Świeża i delikatna zielona fasolka, idealna jako dodatek do dań lub samodzielna przekąska. Kraj pochodzenia: Lokalni producenci. Składniki: Zielona fasolka.',
    'quantity': 3,
    'price': 4.29,
    'id': 'ab01cdd4-7e73-4c1d-8a71-f28d9b6451b8',
  }
];

// git
final _orders = <Map<String, dynamic>>[
  {
    'languageCode': 'en',
    'shop_id': _shops[0]['id'] as String,
    'status': 0,
    'date':
        DateTime.now().subtract(const Duration(minutes: 80)).toIso8601String(),
    'code': 'h34ws',
    'id': 'ab01cdd4-7e73-4c1d-8a71-f28d9b6451ba',
    'products_ids': [
      _products[0]['id'] as String,
      _products[2]['id'] as String,
      _products[4]['id'] as String,
    ],
  },
  {
    'languageCode': 'pl',
    'shop_id': _shops[7]['id'] as String,
    'status': 0,
    'date':
        DateTime.now().subtract(const Duration(minutes: 80)).toIso8601String(),
    'code': 'h34ws',
    'id': 'ab01cdd4-7e73-4c1d-8a71-f28d9b6451ba-pl',
    'products_ids': [
      _products[1]['id'] as String,
      _products[3]['id'] as String,
      _products[5]['id'] as String,
    ],
  },
  {
    'languageCode': 'en',
    'shop_id': _shops[1]['id'] as String,
    'status': 0,
    'date':
        DateTime.now().subtract(const Duration(minutes: 30)).toIso8601String(),
    'code': 'h34ws',
    'id': 'ab01cdd4-7e73-4c1d-8a71-f28d9b6451bc',
    'products_ids': [
      _products[0]['id'] as String,
      _products[2]['id'] as String,
      _products[4]['id'] as String,
    ],
  },
  {
    'languageCode': 'pl',
    'shop_id': _shops[8]['id'] as String,
    'status': 0,
    'date':
        DateTime.now().subtract(const Duration(minutes: 30)).toIso8601String(),
    'code': 'h34ws',
    'id': 'ab01cdd4-7e73-4c1d-8a71-f28d9b6451bc-pl',
    'products_ids': [
      _products[1]['id'] as String,
      _products[3]['id'] as String,
      _products[5]['id'] as String,
    ],
  },
  {
    'languageCode': 'en',
    'shop_id': _shops[2]['id'] as String,
    'status': -1,
    'date':
        DateTime.now().subtract(const Duration(minutes: 720)).toIso8601String(),
    'code': 'IJKL9101',
    'id': 'ab01cdd4-7e73-4c1d-8a71-f28d9b6451be',
    'products_ids': [
      _products[0]['id'] as String,
      _products[2]['id'] as String,
      _products[4]['id'] as String,
    ],
  },
  {
    'languageCode': 'pl',
    'shop_id': _shops[9]['id'] as String,
    'status': -1,
    'date':
        DateTime.now().subtract(const Duration(minutes: 720)).toIso8601String(),
    'code': 'IJKL9101',
    'id': 'ab01cdd4-7e73-4c1d-8a71-f28d9b6451be',
    'products_ids': [
      _products[1]['id'] as String,
      _products[3]['id'] as String,
      _products[5]['id'] as String,
    ],
  },
  {
    'languageCode': 'en',
    'shop_id': _shops[3]['id'] as String,
    'status': 1,
    'date': DateTime.now()
        .subtract(const Duration(minutes: 1440))
        .toIso8601String(),
    'code': 'MNOP2345',
    'id': 'ab01cdd4-7e73-4c1d-8a71-f28d9b6451bg',
    'products_ids': [
      _products[4]['id'] as String,
      _products[6]['id'] as String,
      _products[8]['id'] as String,
    ],
  },
  {
    'languageCode': 'pl',
    'shop_id': _shops[10]['id'] as String,
    'status': 1,
    'date': DateTime.now()
        .subtract(const Duration(minutes: 1440))
        .toIso8601String(),
    'code': 'MNOP2345',
    'id': 'ab01cdd4-7e73-4c1d-8a71-f28d9b6451bg-pl',
    'products_ids': [
      _products[5]['id'] as String,
      _products[7]['id'] as String,
      _products[9]['id'] as String,
    ],
  },
  {
    'languageCode': 'en',
    'shop_id': _shops[4]['id'] as String,
    'status': 1,
    'date': DateTime.now()
        .subtract(const Duration(minutes: 1800))
        .toIso8601String(),
    'code': 'QRST6789',
    'id': 'ab01cdd4-7e73-4c1d-8a71-f28d9b6451bi',
    'products_ids': [
      _products[4]['id'] as String,
      _products[6]['id'] as String,
      _products[8]['id'] as String,
    ],
  },
  {
    'languageCode': 'pl',
    'shop_id': _shops[11]['id'] as String,
    'status': 1,
    'date': DateTime.now()
        .subtract(const Duration(minutes: 1800))
        .toIso8601String(),
    'code': 'QRST6789',
    'id': 'ab01cdd4-7e73-4c1d-8a71-f28d9b6451bj-pl',
    'products_ids': [
      _products[5]['id'] as String,
      _products[7]['id'] as String,
      _products[9]['id'] as String,
    ],
  },
];

class BannerHiveStorage extends HiveManager<String> {
  factory BannerHiveStorage() => _instance;

  BannerHiveStorage._({required super.boxName}) {
    _initialize();
  }

  static final _instance = BannerHiveStorage._(boxName: bannerBoxName);

  bool isInitialized = false;

  Future<void> _initialize() async {
    if (isInitialized) return;
    isInitialized = true;
    await deleteAll();
    _banners.forEach((banner) async {
      await write(json.encode(banner), key: banner['id'] as String);
    });
  }
}

class CategoryHiveStorage extends HiveManager<String> {
  factory CategoryHiveStorage() => _instance;
  CategoryHiveStorage._({required super.boxName}) {
    _initialize();
  }

  static final _instance = CategoryHiveStorage._(boxName: categoryBoxName);

  bool isInitialized = false;

  Future<void> _initialize() async {
    if (isInitialized) return;
    isInitialized = true;
    await deleteAll();
    _categories.forEach((category) async {
      await write(json.encode(category), key: category['id'] as String);
    });
  }
}

class OfferHiveStorage extends HiveManager<String> {
  factory OfferHiveStorage() => _instance;

  OfferHiveStorage._({required super.boxName}) {
    _initialize();
  }

  static final _instance = OfferHiveStorage._(boxName: offerBoxName);

  bool isInitialized = false;

  Future<void> _initialize() async {
    if (isInitialized) return;
    isInitialized = true;
    await deleteAll();
    _offers.forEach((offer) async {
      await write(json.encode(offer), key: offer['id'] as String);
    });
  }
}

class ShopHiveStorage extends HiveManager<String> {
  factory ShopHiveStorage() => _instance;

  ShopHiveStorage._({required super.boxName}) {
    _initialize();
  }

  static final _instance = ShopHiveStorage._(boxName: shopBoxName);

  bool isInitialized = false;

  Future<void> _initialize() async {
    if (isInitialized) return;
    isInitialized = true;
    await deleteAll();
    _shops.forEach((shop) async {
      await write(json.encode(shop), key: shop['id'] as String);
    });
  }
}

class ProductsHiveStorage extends HiveManager<String> {
  factory ProductsHiveStorage() => _instance;

  ProductsHiveStorage._({required super.boxName}) {
    _initialize();
  }

  static final _instance = ProductsHiveStorage._(boxName: productsBoxName);

  bool isInitialized = false;

  Future<void> _initialize() async {
    if (isInitialized) return;
    isInitialized = true;
    await deleteAll();
    _products.forEach((products) async {
      await write(json.encode(products), key: products['id'] as String);
    });
  }
}

class OrdersHiveStorage extends HiveManager<String> {
  factory OrdersHiveStorage() => _instance;

  OrdersHiveStorage._({required super.boxName}) {
    _initialize();
  }

  static final _instance = OrdersHiveStorage._(boxName: ordersBoxName);

  bool isInitialized = false;

  Future<void> _initialize() async {
    if (isInitialized) return;
    isInitialized = true;
    await deleteAll();
    _orders.forEach((order) async {
      await write(json.encode(order), key: order['id'] as String);
    });
  }
}

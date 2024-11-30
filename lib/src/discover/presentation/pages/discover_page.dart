import 'package:auto_route/auto_route.dart';
import 'package:flow_zero_waste/config/injection/injection.dart';
import 'package:flow_zero_waste/core/common/presentation/logics/logic_state.dart';
import 'package:flow_zero_waste/core/common/presentation/logics/providers/responsive_ui/page_provider.dart';
import 'package:flow_zero_waste/core/common/presentation/widgets/components/app_bar_styled.dart';
import 'package:flow_zero_waste/core/extensions/l10n_extension.dart';
import 'package:flow_zero_waste/core/extensions/theme_extension.dart';
import 'package:flow_zero_waste/src/discover/domain/responses/discover_responses.dart';
import 'package:flow_zero_waste/src/discover/presentation/logics/cubit/discover_cubit.dart';
import 'package:flow_zero_waste/src/discover/presentation/widgets/banner_section.dart';
import 'package:flow_zero_waste/src/discover/presentation/widgets/categories_section.dart';
import 'package:flow_zero_waste/src/discover/presentation/widgets/offers_section.dart';
import 'package:flow_zero_waste/src/discover/presentation/widgets/recommended_shops_section.dart';
import 'package:flow_zero_waste/src/language/presentation/logics/language_provider.dart';
import 'package:flow_zero_waste/src/location/presentation/logics/location_provider.dart';
import 'package:flow_zero_waste/src/location/presentation/widgets/location_section.dart';
import 'package:flow_zero_waste/src/location/presentation/widgets/select_location_popup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

/// Page for discovering new offers, shops and more
@RoutePage()
class DiscoverPage extends StatelessWidget implements AutoRouteWrapper {
  /// Default constructor
  const DiscoverPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<LocationProvider, LanguageProvider>(
      builder: (context, location, language, child) {
        final page = context.watch<PageProvider>();
        final discoverCubit = context.read<DiscoverCubit>();
        if(location.isInitialized){
          discoverCubit.getDiscoverData(
            languageCode: language.currentLanguage.languageCode,
            latitude: location.locationData?.latitude,
            longitude: location.locationData?.longitude,
          );
        }
        return BlocConsumer<DiscoverCubit, DiscoverState>(
          bloc: discoverCubit,
          listener: (context, state) {
            if (!state.isListenable) return;

            if (state.isNavigatable) {
              (state as NavigatableLogicState).navigate(context);
            }

            if (state is DiscoverError) {
              var errorMessage = context.l10n.unexpectedError;

              if (state.failure is DiscoverFailure) {
                switch (state.failure.runtimeType) {
                  case UnableToGetBannerDataFailure:
                    errorMessage = context.l10n.unableToGetBannerData;
                  case UnableToGetCategoryDataFailure:
                    errorMessage = context.l10n.unableToGetCategoryData;
                  case UnableToGetOfferDataFailure:
                    errorMessage = context.l10n.unableToGetOfferData;
                  case UnableToGetShopDataFailure:
                    errorMessage = context.l10n.unableToGetShopData;
                  case UnableToLikeShopFailure:
                    errorMessage = context.l10n.unableToLikeShop;
                }
              }

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    errorMessage,
                    style: context.textTheme.bodyMedium
                        ?.copyWith(color: context.colorScheme.onErrorContainer),
                  ),
                  backgroundColor: context.colorScheme.errorContainer,
                ),
              );
            }
          },
          builder: (context, state) {
            return Scaffold(
              appBar: AppBarStyled(
                title: context.l10n.discover,
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
                        localization: location.locationData?.address,
                        onLocationChange: () =>
                            SelectLocationPopup.showBottomSheet<void>(
                          context,
                          initialLocationData: location.locationData,
                          onLocationSelected: (data) {
                            location.saveLocationData(data);
                            discoverCubit.getDiscoverData(
                              languageCode: context
                                  .read<LanguageProvider>()
                                  .currentLanguage
                                  .languageCode,
                              latitude: data?.latitude,
                              longitude: data?.longitude,
                            );
                          },
                        ),
                      ),
                    ),
                    if (state is DiscoverChooseLocation)
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: page.spacing,
                          vertical: page.spacing,
                        ),
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(page.spacing),
                            color: context.colorScheme.surfaceContainer,
                          ),
                          padding: EdgeInsets.all(page.spacingDouble),
                          child: Wrap(
                            // mainAxisAlignment: MainAxisAlignment.center,
                            // mainAxisSize: MainAxisSize.min,
                            alignment: WrapAlignment.center,
                            children: [
                              Icon(
                                Icons.arrow_upward_rounded,
                                color: context.colorScheme.secondary,
                                size: 32,
                              ),
                              SizedBox(width: page.spacing),
                              Text(
                                context.l10n.chooseLocationBeforeDiscover,
                                style: context.textTheme.titleLarge,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    if (state is DiscoverDataState) ...[
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: page.spacing,
                          vertical: page.spacing,
                        ),
                        child: BannersSection(
                          onBannerTap: debugPrint,
                          banners: state.banners.map((e) {
                            return BannerData(
                              title: e.title,
                              description: e.description,
                              imageUrl: e.imageUrl,
                            );
                          }).toList(),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: page.spacing,
                          vertical: page.spacing,
                        ),
                        child: OffersSection(
                          onOfferTap: debugPrint,
                          offers: state.offers.map((e) {
                            return OfferData(
                              id: e.id,
                              distance: e.distance,
                              newOffers: e.newOffers.toInt(),
                              description: e.shop.description,
                              imageUrl: e.shop.imageUrl,
                              startDate: e.shop.startDate,
                              endDate: e.shop.endDate,
                              isLiked: e.shop.isLiked,
                              localization: e.shop.localization,
                              title: e.shop.name,
                            );
                          }).toList(),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: page.spacing,
                          vertical: page.spacing,
                        ),
                        child: CategoriesSection(
                          onCategoryTap: print,
                          categories: state.categories.map((e) {
                            return CategoryData(
                              title: e.name,
                              imageUrl: e.imageUrl,
                            );
                          }).toList(),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: page.spacing,
                          vertical: page.spacing,
                        ),
                        child: RecommendedShopsSection(
                          onShopLikeTap: discoverCubit.likeShop,
                          shops: state.shops.map((e) {
                            return ShopData(
                              id: e.id,
                              title: e.name,
                              description: e.description,
                              imageUrl: e.imageUrl,
                              startDate: e.startDate,
                              endDate: e.endDate,
                              isLiked: e.isLiked,
                              localization: e.localization,
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) => locator<DiscoverCubit>()..initialize(),
      child: this,
    );
  }
}

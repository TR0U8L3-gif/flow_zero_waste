import 'package:auto_route/auto_route.dart';
import 'package:flow_zero_waste/config/injection/injection.dart';
import 'package:flow_zero_waste/core/common/presentation/logics/logic_state.dart';
import 'package:flow_zero_waste/core/common/presentation/logics/providers/responsive_ui/page_provider.dart';
import 'package:flow_zero_waste/core/common/presentation/widgets/components/app_bar_styled.dart';
import 'package:flow_zero_waste/core/extensions/l10n_extension.dart';
import 'package:flow_zero_waste/core/extensions/theme_extension.dart';
import 'package:flow_zero_waste/src/discover/presentation/widgets/recommended_shops_section.dart';
import 'package:flow_zero_waste/src/favorites/domain/response/favorites_response.dart';
import 'package:flow_zero_waste/src/favorites/presentation/logics/cubit/favorites_cubit.dart';
import 'package:flow_zero_waste/src/favorites/presentation/widgets/favorites_widget.dart';
import 'package:flow_zero_waste/src/language/presentation/logics/language_provider.dart';
import 'package:flow_zero_waste/src/location/presentation/logics/location_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

@RoutePage()
class FavoritesPage extends StatelessWidget implements AutoRouteWrapper {
  @override
  Widget build(BuildContext context) {
    return Consumer2<LocationProvider, LanguageProvider>(
      builder: (context, location, language, child) {
        final page = context.watch<PageProvider>();
        final favoritesCubit = context.read<FavoritesCubit>();
        if (location.isInitialized) {
          favoritesCubit.fetchFavorites(
            language.currentLanguage.languageCode,
          );
        }
        return RefreshIndicator(
          onRefresh: () async {
            await favoritesCubit.fetchFavorites(
              language.currentLanguage.languageCode,
            );
          },
          child: BlocConsumer<FavoritesCubit, FavoritesState>(
            bloc: favoritesCubit,
            listener: (context, state) {
              if (!state.isListenable) return;
          
              if (state.isNavigatable) {
                (state as NavigatableLogicState).navigate(context);
              }
          
              if (state is FavoritesError) {
                var errorMessage = context.l10n.unexpectedError;
          
                if (state.failure is FavoritesFailure) {
                  switch (state.failure) {
                    case GetFavoritesFailure():
                      errorMessage = context.l10n.unableToGetFavoritesData;
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
                  title: context.l10n.favorites,
                ),
                body: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (state is FavoritesDataState) ...[
                        if(state.favorites == null)
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: page.spacing,
                              vertical: page.spacing,
                            ),
                            child: Align(
                              child: Text(
                                context.l10n.noLikedShops,
                                style: context.textTheme.bodyLarge,
                              ),
                            ),
                          )
                        else 
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: page.spacing,
                            vertical: page.spacing,
                          ),
                          child: FavoritesWidget(
                            onShopLikeTap: favoritesCubit.likeShop,
                            shops: state.favorites?.map((e) {
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
          ),
        );
      },
    );
  }

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) => locator<FavoritesCubit>()..initialize(),
      child: this,
    );
  }
}

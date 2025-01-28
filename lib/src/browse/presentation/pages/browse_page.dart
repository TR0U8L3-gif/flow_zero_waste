import 'package:auto_route/auto_route.dart';
import 'package:flow_zero_waste/config/routes/navigation_router.gr.dart';
import 'package:flow_zero_waste/core/common/presentation/logics/providers/responsive_ui/page_provider.dart';
import 'package:flow_zero_waste/core/common/presentation/widgets/components/app_bar_styled.dart';
import 'package:flow_zero_waste/core/common/presentation/widgets/components/refresh_indicator_styled.dart';
import 'package:flow_zero_waste/core/extensions/l10n_extension.dart';
import 'package:flow_zero_waste/src/browse/presentation/logics/shops_cubit.dart';
import 'package:flow_zero_waste/src/browse/presentation/widgets/browse_widget.dart';
import 'package:flow_zero_waste/src/language/presentation/logics/language_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

@RoutePage()
class BrowsePage extends StatelessWidget {
  const BrowsePage({super.key});

  @override
  Widget build(BuildContext context) {
    final page = context.watch<PageProvider>();
    final shopCubit = context.read<ShopsCubit>();
    return Consumer<LanguageProvider>(
      builder: (context, language, child) {
        shopCubit.getShops(language.currentLanguage.languageCode);
        return Scaffold(
          appBar: AppBarStyled(
            title: context.l10n.browse,
          ),
          body: RefreshIndicatorStyled(
            onRefresh: () =>
                shopCubit.getShops(language.currentLanguage.languageCode),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: page.spacing),
              child: BlocConsumer<ShopsCubit, ShopsState>(
                bloc: shopCubit,
                listener: (context, state) {},
                builder: (context, state) {
                  if (state is ShopsIdle) {
                    return BrowseWidget(
                      shops: state.shops.isEmpty ? null : state.shops,
                      onShopTap: (id) {
                        context.router.push(ShopRoute(shopId: id));
                        },
                    );
                  } else {
                    return const BrowseWidget(
                      shops: [],
                    );
                  }
                },
              ),
            ),
          ),
        );
      },
    );
  }
}

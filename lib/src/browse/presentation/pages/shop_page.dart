import 'package:auto_route/auto_route.dart';
import 'package:flow_zero_waste/config/injection/injection.dart';
import 'package:flow_zero_waste/core/common/presentation/logics/providers/responsive_ui/page_provider.dart';
import 'package:flow_zero_waste/core/common/presentation/widgets/components/app_bar_styled.dart';
import 'package:flow_zero_waste/core/common/presentation/widgets/components/refresh_indicator_styled.dart';
import 'package:flow_zero_waste/core/extensions/l10n_extension.dart';
import 'package:flow_zero_waste/src/browse/presentation/logics/shop_cubit.dart';
import 'package:flow_zero_waste/src/browse/presentation/widgets/shop_widget.dart';
import 'package:flow_zero_waste/src/language/presentation/logics/language_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

@RoutePage()
class ShopPage extends StatefulWidget implements AutoRouteWrapper {
  const ShopPage({@PathParam('id') required this.shopId, super.key});

  final String shopId;

  @override
  State<ShopPage> createState() => _ShopPageState();

  @override
  Widget wrappedRoute(BuildContext context) {
    final language = context.read<LanguageProvider>();
    return BlocProvider(
      create: (context) => locator<ShopCubit>()
        ..getShop(shopId, language.currentLanguage.languageCode),
      child: this,
    );
  }
}

class _ShopPageState extends State<ShopPage> {
  @override
  void initState() {
    super.initState();
    final cubit = context.read<ShopCubit>();
    final language = context.read<LanguageProvider>();
    cubit.getShop(widget.shopId, language.currentLanguage.languageCode);
  }

  @override
  Widget build(BuildContext context) {
    final page = context.read<PageProvider>();
    final cubit = context.read<ShopCubit>();
    return Consumer<LanguageProvider>(
      builder: (context, language, child) {
        return Scaffold(
          appBar: AppBarStyled(
            title: context.l10n.shop,
          ),
          body: RefreshIndicatorStyled(
            onRefresh: () => cubit.getShop(
              widget.shopId,
              language.currentLanguage.languageCode,
            ),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: page.spacing),
                child: BlocBuilder<ShopCubit, ShopState>(
                  bloc: cubit,
                  builder: (context, state) {
                    if (state is ShopIdle && state.shop != null) {
                      return ShopWidget(
                        shop: state.shop!,
                        products: state.products
                            .where((p) => p.quantity > 0)
                            .toList(),
                        onShopLike: (id) =>
                            cubit.like(language.currentLanguage.languageCode),
                        onProductOrder: (product) =>
                            cubit.order(product, language.currentLanguage.languageCode),
                      );
                    } else {
                      return const Align(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

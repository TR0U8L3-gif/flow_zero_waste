import 'package:auto_route/auto_route.dart';
import 'package:flow_zero_waste/config/injection/injection.dart';
import 'package:flow_zero_waste/core/common/presentation/logics/logic_state.dart';
import 'package:flow_zero_waste/core/common/presentation/logics/providers/responsive_ui/page_provider.dart';
import 'package:flow_zero_waste/core/common/presentation/widgets/components/app_bar_styled.dart';
import 'package:flow_zero_waste/core/common/presentation/widgets/components/refresh_indicator_styled.dart';
import 'package:flow_zero_waste/core/common/presentation/widgets/components/scrollbar_styled.dart';
import 'package:flow_zero_waste/core/extensions/l10n_extension.dart';
import 'package:flow_zero_waste/core/extensions/theme_extension.dart';
import 'package:flow_zero_waste/src/language/presentation/logics/language_provider.dart';
import 'package:flow_zero_waste/src/orders/presentation/logics/orders_cubit.dart';
import 'package:flow_zero_waste/src/orders/presentation/widgets/orders_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

@RoutePage()
class OrdersPage extends StatelessWidget implements AutoRouteWrapper {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageProvider>(
      builder: (context, language, child) {
        final page = context.watch<PageProvider>();
        final ordersCubit = context.read<OrdersCubit>();
        return BlocConsumer<OrdersCubit, OrdersState>(
          bloc: ordersCubit,
          listener: (context, state) {
            if (!state.isListenable) return;

            if (state.isNavigatable) {
              (state as NavigatableLogicState).navigate(context);
            }

            if (state is OrdersError) {
              final errorMessage = context.l10n.unexpectedError;

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
                title: context.l10n.orders,
              ),
              body: RefreshIndicatorStyled(
                onRefresh: () async {
                  await ordersCubit.fetchOrders(
                    language.currentLanguage.languageCode,
                  );
                },
                child: ScrollbarStyled(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: page.spacing),
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (state is OrdersIdle) ...[
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: page.spacing,
                                vertical: page.spacing,
                              ),
                              child: OrdersWidget(
                                onOrderLocation: (lng, lat) => launchUrl(Uri.parse(
                                    'https://www.google.com/maps/search/?api=1&query=$lat,$lng',),),
                                onOrderAccept: (code) {
                                  showDialog<void>(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text(
                                          'BZ4P2',
                                          style: context.textTheme.titleLarge,
                                          textAlign: TextAlign.center,
                                        ),
                                        content: Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                                page.spacing,),
                                            color: Colors.white,
                                          ),
                                          width: page.size.width * 0.64,
                                          padding: EdgeInsets.all(4.0),
                                          child: AspectRatio(
                                            aspectRatio: 1,
                                            child: QrImageView(
                                              data: code,
                                              gapless: false,
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                                onOrderCancel: (id) async {
                                  final result = await showDialog<bool>(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text(
                                            context.l10n.confirmCancelOrder,),
                                        actions: <Widget>[
                                          TextButton(
                                            style: TextButton.styleFrom(
                                              textStyle: Theme.of(context)
                                                  .textTheme
                                                  .labelLarge,
                                            ),
                                            child: Text(context.l10n.no),
                                            onPressed: () {
                                              Navigator.of(context).pop(false);
                                            },
                                          ),
                                          TextButton(
                                            style: TextButton.styleFrom(
                                              textStyle: Theme.of(context)
                                                  .textTheme
                                                  .labelLarge,
                                            ),
                                            child: Text(context.l10n.yes),
                                            onPressed: () {
                                              Navigator.of(context).pop(true);
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                  if (result != true) return;
                                  await ordersCubit.cancelOrder(
                                    id,
                                    language.currentLanguage.languageCode,
                                  );
                                },
                                orders: state.orders
                                  ?..sort(
                                    (a, b) {
                                      return b.date.compareTo(a.date);
                                    },
                                  ),
                              ),
                            ),
                          ] else
                            const OrdersWidget(
                              orders: [],
                            ),
                        ],
                      ),
                    ),
                  ),
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
    final lang = context.read<LanguageProvider>().currentLanguage;
    return BlocProvider(
        create: (context) =>
            locator<OrdersCubit>()..fetchOrders(lang.languageCode),
        child: this,);
  }
}

import 'package:flow_zero_waste/core/common/presentation/logics/providers/responsive_ui/page_provider.dart';
import 'package:flow_zero_waste/core/common/presentation/widgets/shimmer/shimmer_rectangle.dart';
import 'package:flow_zero_waste/core/enums/page_layout_size.dart';
import 'package:flow_zero_waste/core/extensions/l10n_extension.dart';
import 'package:flow_zero_waste/src/orders/domain/entities/orders.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

const _ordersItemsEmpty = 4;

/// Orders widget
class OrdersWidget extends StatelessWidget {
  /// Default constructor
  const OrdersWidget({
    required this.orders,
    super.key,
    this.onOrderAccept,
    this.onOrderLocation,
    this.onOrderCancel,
  });

  /// List of orders
  final List<Orders>? orders;

  /// Callback for order tap
  final void Function(String code)? onOrderAccept;
  final void Function(double lng, double lat)? onOrderLocation;
  final void Function(String id)? onOrderCancel;

  @override
  Widget build(BuildContext context) {
    final page = context.watch<PageProvider>();
    final borderRadius = BorderRadius.circular(page.spacing);

    if (orders == null) {
      return const SizedBox.shrink();
    }

    return ClipRRect(
      borderRadius: borderRadius,
      child: GridView.builder(
        shrinkWrap: true,
        primary: false,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: orders!.isNotEmpty ? orders!.length : _ordersItemsEmpty,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: page.layoutSize >= PageLayoutSize.medium ? 2 : 1,
          childAspectRatio: 3,
          crossAxisSpacing: page.spacing,
          mainAxisSpacing: page.spacing,
        ),
        itemBuilder: (context, index) {
          if (orders!.isEmpty) {
            return Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                borderRadius: borderRadius,
                color: Theme.of(context).colorScheme.primaryContainer,
              ),
              child: ShimmerRectangle(
                borderRadius: borderRadius,
              ),
            );
          } else {
            final order = orders![index];
            return GestureDetector(
              onTap: () => onOrderLocation?.call(23.152574415, 53.1149982),
              child: OrderCard(
                order: order,
                borderRadius: borderRadius,
                onOrderAccept: onOrderAccept,
                onOrderCancel: onOrderCancel,
              ),
            );
          }
        },
      ),
    );
  }
}

/// Order card widget
class OrderCard extends StatelessWidget {
  /// Default constructor
  const OrderCard({
    required this.order,
    required this.borderRadius,
    this.onOrderAccept,
    this.onOrderCancel,
    super.key,
  });

  /// Order data
  final Orders order;

  /// Border radius
  final BorderRadius borderRadius;

  /// Callback for order tap
  final void Function(String code)? onOrderAccept;

  /// Callback for order tap
  final void Function(String id)? onOrderCancel;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.maxFinite,
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        color: Theme.of(context).colorScheme.surfaceContainer,
      ),
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              // Product image
              ClipRRect(
                borderRadius: borderRadius,
                child: Image.network(
                  order.product.imageUrl,
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => const Icon(
                    Icons.broken_image,
                    size: 80,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              // Order details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      order.product.name,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${context.l10n.shop}: ${order.shop.name}',
                      style: Theme.of(context).textTheme.bodyMedium,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${context.l10n.status}: ${_mapOrderStatus(order.status, context)}',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: _getStatusColor(order.status)),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${context.l10n.date}: ${_formatDate(order.date)}',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              if (order.status == OrderStatus.accepted)
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      onPressed: () => onOrderAccept?.call(order.code),
                      icon: const Icon(Icons.check_circle_outline),
                    ),
                    IconButton(
                      onPressed: () => onOrderCancel?.call(order.id),
                      icon: const Icon(Icons.cancel_outlined),
                    ),
                  ],
                ),
            ],
          ),
        ],
      ),
    );
  }

  String _mapOrderStatus(OrderStatus status, BuildContext context) {
    switch (status) {
      case OrderStatus.accepted:
        return context.l10n.accepted;
      case OrderStatus.completed:
        return context.l10n.completed;
      case OrderStatus.canceled:
        return context.l10n.canceled;
      case OrderStatus.pending:
      default:
        return context.l10n.pending;
    }
  }

  Color _getStatusColor(OrderStatus status) {
    switch (status) {
      case OrderStatus.pending:
        return Colors.orange;
      case OrderStatus.accepted:
        return Colors.blue;
      case OrderStatus.completed:
        return Colors.green;
      case OrderStatus.canceled:
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}

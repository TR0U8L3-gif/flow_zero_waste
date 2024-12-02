import 'package:flow_zero_waste/core/common/presentation/pages/responsive_ui/scaffold_page.dart';
import 'package:flow_zero_waste/core/extensions/l10n_extension.dart';
import 'package:flow_zero_waste/core/extensions/num_extension.dart';
import 'package:flow_zero_waste/core/extensions/theme_extension.dart';
import 'package:flow_zero_waste/core/services/stripe/stripe_service.dart';
import 'package:flow_zero_waste/src/orders/domain/entities/product.dart';
import 'package:flutter/material.dart';

/// Order card widget
class ProductWidget extends StatefulWidget {
  /// Default constructor
  const ProductWidget({
    required this.product,
    required this.borderRadius,
    super.key,
  });

  /// Product data
  final Product product;

  /// Border radius
  final BorderRadius borderRadius;

  @override
  State<ProductWidget> createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
  int _quantity = 1;
  int _maxQuantity = 0;
  double _initialPrice = 0;

  @override
  void initState() {
    super.initState();
    _maxQuantity = widget.product.quantity;
    _initialPrice = widget.product.price;
  }

  void _incrementQuantity() {
    if (_quantity < _maxQuantity) {
      setState(() {
        _quantity++;
      });
    }
  }

  void _decrementQuantity() {
    if (_quantity > 1) {
      setState(() {
        _quantity--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: widget.borderRadius,
        color: Theme.of(context).colorScheme.surfaceContainer,
      ),
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AspectRatio(
            aspectRatio: 16 / 9,
            child: ClipRRect(
              borderRadius: widget.borderRadius,
              child: Image.network(
                widget.product.imageUrl,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => const Icon(
                  Icons.broken_image,
                  size: 80,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Order details
          Text(
            softWrap: true,
            widget.product.name,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            softWrap: true,
            widget.product.description,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          if (widget.product.allergens.isNotEmpty)
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: widget.product.allergens
                    .map(
                      (allergen) => Padding(
                        padding: const EdgeInsets.only(right: 4),
                        child: Chip(
                          label: Text(allergen),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                '${context.l10n.price} ${(_initialPrice * _quantity).toStringAsFixed(2)} ${context.l10n.currency}',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(width: 8),
              Text(
                '${context.l10n.quantity}  ${_quantity} / ${widget.product.quantity}',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                icon: const Icon(Icons.remove),
                onPressed: _decrementQuantity,
              ),
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: _incrementQuantity,
              ),
            ],
          ),
          const SizedBox(height: 8),
          Wrap(
            children: [
              TextButton(
                onPressed: () async {
                  final languageCode =
                      Localizations.localeOf(context).languageCode;
                  final result = await StripeService().makePayment(
                    (_initialPrice * _quantity).roundToPlaces(2),
                    languageCode == 'en' ? 'usd' : 'pln',
                  );
                  if (result) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          context.l10n.paymentSuccess,
                          style: context.textTheme.bodyMedium?.copyWith(
                              color: context.colorScheme.onPrimaryContainer),
                        ),
                        backgroundColor: context.colorScheme.primaryContainer,
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          context.l10n.paymentError,
                          style: context.textTheme.bodyMedium?.copyWith(
                              color: context.colorScheme.onErrorContainer),
                        ),
                        backgroundColor: context.colorScheme.errorContainer,
                      ),
                    );
                  }
                  Navigator.of(context).pop(
                    widget.product.copyWith(
                      quantity: _quantity,
                    ),
                  );
                },
                child: Text(context.l10n.buyAndPayNow),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(
                  widget.product.copyWith(
                    quantity: _quantity,
                  ),
                ),
                child: Text(context.l10n.buyAndPayInStore),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

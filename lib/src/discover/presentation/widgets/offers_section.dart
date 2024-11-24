import 'package:flow_zero_waste/core/common/presentation/logics/providers/responsive_ui/page_provider.dart';
import 'package:flow_zero_waste/core/common/presentation/widgets/shimmer/shimmer_rectangle.dart';
import 'package:flow_zero_waste/core/enums/page_layout_size.dart';
import 'package:flow_zero_waste/core/extensions/date_time_extension.dart';
import 'package:flow_zero_waste/core/extensions/l10n_extension.dart';
import 'package:flow_zero_waste/core/extensions/theme_extension.dart';
import 'package:flow_zero_waste/core/helpers/images/image_builders.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

const _offersItemsEmpty = 4;

/// offers section
class OffersSection extends StatelessWidget {
  /// Default constructor
  const OffersSection({
    required this.offers,
    super.key,
    this.onOfferTap,
  });

  /// offers
  final List<OfferData>? offers;

  /// Callback for offer tap
  final void Function(String offerId)? onOfferTap;

  @override
  Widget build(BuildContext context) {
    final page = context.watch<PageProvider>();
    final borderRadius = BorderRadius.circular(page.spacing);

    if (offers == null) {
      return const SizedBox.shrink();
    }

    return ClipRRect(
      borderRadius: borderRadius,
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              context.l10n.offersNearby,
              style: context.textTheme.headlineSmall,
            ),
            SizedBox(height: page.spacing),
            GridView.builder(
              shrinkWrap: true,
              primary: false,
              physics: const NeverScrollableScrollPhysics(),
              itemCount:
                  offers!.isNotEmpty ? offers?.length : _offersItemsEmpty,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount:
                    page.layoutSize >= PageLayoutSize.medium ? 2 : 1,
                childAspectRatio: 2,
                crossAxisSpacing: page.spacing,
                mainAxisSpacing: page.spacing,
              ),
              itemBuilder: (context, index) {
                if (offers!.isEmpty) {
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
                  final offer = offers![index];
                  return GestureDetector(
                    onTap: () => onOfferTap?.call(offer.id),
                    child: OfferCard(
                      offerData: offer,
                      height: double.infinity,
                      borderRadius: borderRadius,
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

/// Offer card
class OfferCard extends StatelessWidget {
  /// Default constructor
  const OfferCard({
    required this.offerData,
    required this.height,
    required this.borderRadius,
    super.key,
  });

  /// Offer data
  final OfferData offerData;

  /// Offer height
  final double height;

  /// Offer border radius
  final BorderRadius borderRadius;

  @override
  Widget build(BuildContext context) {
    final page = context.watch<PageProvider>();
    return ClipRRect(
      borderRadius: borderRadius,
      child: Container(
        height: height,
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          color: context.colorScheme.surfaceContainer,
        ),
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  Image.network(
                    offerData.imageUrl,
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: errorBuilder,
                    loadingBuilder: loadingBuilder,
                    frameBuilder: frameBuilder,
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      decoration: BoxDecoration(
                        color: context.colorScheme.surfaceContainer,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(page.spacing),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(
                          right: page.spacing,
                          left: page.spacing,
                        ),
                        child: Text(
                          offerData.title,
                          style: context.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: page.spacingHalf,
                        vertical: page.spacingHalf,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: context.colorScheme.tertiaryContainer,
                          borderRadius: BorderRadius.circular(page.spacing),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: page.spacingHalf,
                          vertical: page.spacingQuarter,
                        ),
                        child: Text(
                          '+${offerData.newOffers} '
                          '${context.l10n.newOffers(offerData.newOffers)}',
                          style: context.textTheme.bodyLarge?.copyWith(
                            color: context.colorScheme.onTertiaryContainer,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: page.spacing,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: page.spacingHalf,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            offerData.description,
                            style: context.textTheme.bodyLarge,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                          Text(
                            offerData.localization,
                            style: context.textTheme.bodyMedium,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                          Text(
                            '${context.l10n.available}: '
                            '${offerData.startDate.ddMM} | '
                            '${offerData.startDate.HHmm} - '
                            '${offerData.endDate.HHmm}',
                            style: context.textTheme.bodyMedium,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: page.spacing),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.location_searching_rounded,
                        color: context.colorScheme.primary,
                      ),
                      SizedBox(height: page.spacingHalf),
                      Text(
                        '${(offerData.distance / 1000).toStringAsFixed(1)} km',
                        style: context.textTheme.bodyLarge?.copyWith(
                          color: context.colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Data class to hold the offer information.
class OfferData {
  /// Creates an offer data object.
  OfferData({
    required this.id,
    required this.title,
    required this.distance,
    required this.localization,
    required this.startDate,
    required this.endDate,
    required this.description,
    required this.imageUrl,
    required this.isLiked,
    required this.newOffers,
  });

  /// Offer id
  final String id;

  /// Offer image URL
  final String imageUrl;

  /// Offer title
  final String title;

  /// Offer description
  final String description;

  /// Offer localization
  final String localization;

  /// Offer distance
  final double distance;

  /// Offer start date
  final DateTime startDate;

  /// Offer end date
  final DateTime endDate;

  /// Offer is liked
  final bool isLiked;

  /// number of new offers
  final int newOffers;
}

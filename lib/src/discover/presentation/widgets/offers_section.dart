import 'package:flow_zero_waste/app.dart';
import 'package:flow_zero_waste/config/assets/size/app_size.dart';
import 'package:flow_zero_waste/core/common/presentation/logics/providers/responsive_ui/page_provider.dart';
import 'package:flow_zero_waste/core/common/presentation/pages/responsive_ui/scaffold_page.dart';
import 'package:flow_zero_waste/core/common/presentation/widgets/shimmer/shimmer_rectangle.dart';
import 'package:flow_zero_waste/core/common/presentation/widgets/text_outline.dart';
import 'package:flow_zero_waste/core/extensions/date_time_extension.dart';
import 'package:flow_zero_waste/core/extensions/l10n_extension.dart';
import 'package:flow_zero_waste/core/extensions/num_extension.dart';
import 'package:flow_zero_waste/core/extensions/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

const _offersCardHeight = 216.0;
const _offersItemsEmpty = 4;

/// offers section
class OffersSection extends StatelessWidget {
  /// Default constructor
  const OffersSection({
    required this.offers,
    super.key,
    this.onOfferTap,
    this.onOfferLikeTap,
  });

  /// offers
  final List<OfferData>? offers;

  /// Callback for offer tap
  final void Function(String offerId)? onOfferTap;

  /// Callback for offer like tap
  final void Function(String offerId)? onOfferLikeTap;

  @override
  Widget build(BuildContext context) {
    final page = context.watch<PageProvider>();
    final borderRadius = BorderRadius.circular(page.spacing);

    if (offers != null && offers!.isEmpty) {
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
              context.l10n.offers_nearby,
              style: context.textTheme.headlineSmall,
            ),
            SizedBox(height: page.spacing),
            ListView.separated(
              shrinkWrap: true,
              primary: false,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: offers?.length ?? _offersItemsEmpty,
              separatorBuilder: (context, index) =>
                  SizedBox(height: page.spacing),
              itemBuilder: (context, index) {
                if (offers == null) {
                  return Container(
                    width: double.infinity,
                    height: _offersCardHeight,
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
                  return OfferCard(
                    offerData: offer,
                    height: _offersCardHeight,
                    borderRadius: borderRadius,
                    onOfferTap: onOfferTap,
                    onOfferLikeTap: onOfferLikeTap,
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
    this.onOfferTap,
    this.onOfferLikeTap,
    super.key,
  });

  /// Offer data
  final OfferData offerData;

  /// Offer height
  final double height;

  /// Offer border radius
  final BorderRadius borderRadius;

  /// Callback for offer tap
  final void Function(String offerId)? onOfferTap;

  /// Callback for offer like tap
  final void Function(String offerId)? onOfferLikeTap;

  @override
  Widget build(BuildContext context) {
    final page = context.watch<PageProvider>();
    return ClipRRect(
      borderRadius: borderRadius,
      child: GestureDetector(
        onTap: () => onOfferTap?.call(offerData.id),
        child: Container(
          height: height,
          decoration: BoxDecoration(
            borderRadius: borderRadius,
            color: context.colorScheme.surfaceContainer,
          ),
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                height: height * 0.6,
                child: Stack(
                  children: [
                    Image.network(
                      offerData.imageUrl,
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: page.spacingHalf,
                          horizontal: page.spacing,
                        ),
                        child: TextOutline(
                          offerData.title,
                          style: context.textTheme.titleLarge,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        decoration: BoxDecoration(
                          color: context.colorScheme.primaryContainer,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(page.spacing),
                          ),
                        ),
                        child: IconButton(
                          icon: Icon(
                            offerData.isLiked
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: context.colorScheme.onPrimaryContainer,
                          ),
                          onPressed: () => onOfferLikeTap?.call(offerData.id),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Padding(
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
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                '${offerData.startDate.ddMMyyyy} | '
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
                        children: [
                          Icon(
                            Icons.location_searching_rounded,
                            color: context.colorScheme.onPrimaryContainer,
                          ),
                          SizedBox(height: page.spacingHalf),
                          Text(
                            '${(offerData.distance / 1000).toStringAsFixed(1)} km',
                            style: context.textTheme.bodyLarge?.copyWith(
                              color: context.colorScheme.onPrimaryContainer,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
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
}

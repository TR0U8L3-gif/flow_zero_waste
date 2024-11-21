import 'package:flow_zero_waste/core/common/presentation/logics/logic_state.dart';
import 'package:flow_zero_waste/core/common/presentation/logics/providers/responsive_ui/page_provider.dart';
import 'package:flow_zero_waste/core/extensions/l10n_extension.dart';
import 'package:flow_zero_waste/core/extensions/theme_extension.dart';
import 'package:flow_zero_waste/src/profile/domain/responses/profile_responses.dart';
import 'package:flow_zero_waste/src/profile/presentation/logics/cubit/profile_cubit.dart';
import 'package:flow_zero_waste/src/profile/presentation/widgets/components/stat_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Profile Badges
class ProfileBadges extends StatelessWidget {
  /// Default constructor
  const ProfileBadges({super.key});

  @override
  Widget build(BuildContext context) {
    final translations = context.l10n;
    final page = context.watch<PageProvider>();
    final profileCubit = context.read<ProfileCubit>();

    return BlocConsumer<ProfileCubit, ProfileState>(
      bloc: profileCubit,
      listener: (context, state) {
        if (!state.isListenable) return;

        if (state.isNavigatable) {
          (state as NavigatableLogicState).navigate(context);
        }

        if (state is! ProfileError) return;

        var errorMessage = translations.unexpectedError;

        if (state.failure is ProfileFailure) {
          switch (state.failure.runtimeType) {
            case FailedToGetProfileStatsFailure:
              errorMessage = translations.failedToGetProfileStats;
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
      },
      builder: (context, state) {
        String? avoidedCO2Emissions;
        String? moneySaved;
        String? orderCount;
        String? pointsCollected;
        String? treesPlanted;
        if (state is ProfileInitial) {
          avoidedCO2Emissions = '...';
          moneySaved = '...';
          orderCount = '...';
          pointsCollected = '...';
          treesPlanted = '...';
        } else if (state is ProfileStatsState) {
          avoidedCO2Emissions =
              state.profileStats.avoidedCO2eEmission?.toString() ??
                  (state is ProfileLoading ? '...' : null);
          moneySaved = state.profileStats.savedMoney?.toString() ??
              (state is ProfileLoading ? '...' : null);
          orderCount = state.profileStats.orderCount?.toStringAsFixed(0) ??
              (state is ProfileLoading ? '...' : null);
          pointsCollected = state.profileStats.points?.toStringAsFixed(0) ??
              (state is ProfileLoading ? '...' : null);
          treesPlanted = state.profileStats.plantedTrees?.toStringAsFixed(0) ??
              (state is ProfileLoading ? '...' : null);
        }

        return Padding(
          padding: EdgeInsets.symmetric(
            vertical: (avoidedCO2Emissions != null ||
                    moneySaved != null ||
                    orderCount != null ||
                    pointsCollected != null ||
                    treesPlanted != null)
                ? page.spacing
                : 0,
          ),
          child: Wrap(
            alignment: WrapAlignment.center,
            children: [
              if (avoidedCO2Emissions != null)
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: page.spacing),
                  child: StatRow(
                    title: translations.profileAvoidedCO2Emissions,
                    value: '$avoidedCO2Emissions ppmv',
                    icon: Icons.cloud_outlined,
                  ),
                ),
              if (moneySaved != null)
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: page.spacing),
                  child: StatRow(
                    title: translations.profileMoneySaved,
                    value: '$moneySaved zł',
                    icon: Icons.attach_money,
                  ),
                ),
              if (orderCount != null)
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: page.spacing),
                  child: StatRow(
                    title: translations.profileOrderCount,
                    value: orderCount,
                    icon: Icons.shopping_cart_outlined,
                  ),
                ),
              if (pointsCollected != null)
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: page.spacing),
                  child: StatRow(
                    title: translations.profilePointsCollected,
                    value: pointsCollected,
                    icon: Icons.star_outline,
                  ),
                ),
              if (treesPlanted != null)
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: page.spacing),
                  child: StatRow(
                    title: translations.profileTreesPlanted,
                    value: treesPlanted,
                    icon: Icons.park_outlined,
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}

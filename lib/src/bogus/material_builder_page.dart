import 'package:auto_route/auto_route.dart';
import 'package:flow_zero_waste/config/assets/color/app_colors.dart';
import 'package:flow_zero_waste/config/assets/size/app_size.dart';
import 'package:flow_zero_waste/core/enums/contrast_enum.dart';
import 'package:flutter/material.dart';

const double _width = 240;
const double _height = 120;

@RoutePage()
class MaterialBuilderPage extends StatefulWidget {
  const MaterialBuilderPage({Key? key}) : super(key: key);

  @override
  State<MaterialBuilderPage> createState() => _MaterialBuilderPageState();
}

class _MaterialBuilderPageState extends State<MaterialBuilderPage> {
  final ScrollController scrollController1 = ScrollController();
  final ScrollController scrollController2 = ScrollController();
  final ScrollController scrollController3 = ScrollController();
  final ScrollController scrollController4 = ScrollController();
  final ScrollController scrollController5 = ScrollController();
  final ScrollController scrollController6 = ScrollController();

  @override
  void dispose() {
    scrollController1.dispose();
    scrollController2.dispose();
    scrollController3.dispose();
    scrollController4.dispose();
    scrollController5.dispose();
    scrollController6.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Align(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSize.m),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: AppSize.m),
                    child: MaterialThemeWidget(
                      title: 'Light Standard',
                      mode: Contrast.standard,
                      brightness: Brightness.light,
                      scrollController: scrollController1,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: AppSize.m),
                    child: MaterialThemeWidget(
                      title: 'Light Medium',
                      mode: Contrast.medium,
                      brightness: Brightness.light,
                      scrollController: scrollController2,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: AppSize.m),
                    child: MaterialThemeWidget(
                      title: 'Light High',
                      mode: Contrast.high,
                      brightness: Brightness.light,
                      scrollController: scrollController3,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: AppSize.m),
                    child: MaterialThemeWidget(
                      title: 'Dark Standard',
                      mode: Contrast.standard,
                      brightness: Brightness.dark,
                      scrollController: scrollController4,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: AppSize.m),
                    child: MaterialThemeWidget(
                      title: 'Dark Medium',
                      mode: Contrast.medium,
                      brightness: Brightness.dark,
                      scrollController: scrollController5,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: AppSize.m),
                    child: MaterialThemeWidget(
                      title: 'Dark High',
                      mode: Contrast.high,
                      brightness: Brightness.dark,
                      scrollController: scrollController6,
                    ),
                  ),
                  const SizedBox(height: AppSize.xxl),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MaterialThemeWidget extends StatelessWidget {
  const MaterialThemeWidget({
    required this.title,
    required this.mode,
    required this.brightness,
    this.scrollController,
    super.key,
  });

  final String title;
  final Contrast mode;
  final Brightness brightness;
  final ScrollController? scrollController;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSize.s),
        color: brightness == Brightness.light ? Colors.white : Colors.black,
        border: Border.all(
          color: brightness == Brightness.light ? Colors.black : Colors.white,
          width: 2,
        ),
      ),
      padding: const EdgeInsets.all(AppSize.s),
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
              color:
                  brightness == Brightness.light ? Colors.black : Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SingleChildScrollView(
            controller: scrollController,
            scrollDirection: Axis.horizontal,
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    MaterialContainerWidget(
                      brightness: brightness,
                      text: 'Primary',
                      first: AppColors.primary(mode, brightness),
                      second: AppColors.onPrimary(mode, brightness),
                    ),
                    MaterialContainerWidget(
                      brightness: brightness,
                      text: 'Secondary',
                      first: AppColors.secondary(mode, brightness),
                      second: AppColors.onSecondary(mode, brightness),
                    ),
                    MaterialContainerWidget(
                      brightness: brightness,
                      text: 'Tertiary',
                      first: AppColors.tertiary(mode, brightness),
                      second: AppColors.onTertiary(mode, brightness),
                    ),
                    MaterialContainerWidget(
                      brightness: brightness,
                      text: 'Error',
                      first: AppColors.error(mode, brightness),
                      second: AppColors.onError(mode, brightness),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    MaterialContainerWidget(
                      brightness: brightness,
                      text: 'Primary Container',
                      first: AppColors.primaryContainer(mode, brightness),
                      second: AppColors.onPrimaryContainer(mode, brightness),
                    ),
                    MaterialContainerWidget(
                      brightness: brightness,
                      text: 'Secondary Container',
                      first: AppColors.secondaryContainer(mode, brightness),
                      second: AppColors.onSecondaryContainer(mode, brightness),
                    ),
                    MaterialContainerWidget(
                      brightness: brightness,
                      text: 'Tertiary Container',
                      first: AppColors.tertiaryContainer(mode, brightness),
                      second: AppColors.onTertiaryContainer(mode, brightness),
                    ),
                    MaterialContainerWidget(
                      brightness: brightness,
                      text: 'Error Container',
                      first: AppColors.errorContainer(mode, brightness),
                      second: AppColors.onErrorContainer(mode, brightness),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    MaterialContainerXWidget(
                      brightness: brightness,
                      texts: const [
                        'Primary Fixed',
                        'On Primary Fixed',
                        'Primary Fixed Dim',
                        'On Primary Fixed Variant',
                      ],
                      colors: [
                        AppColors.primaryFixed(mode, brightness),
                        AppColors.onPrimaryFixed(mode, brightness),
                        AppColors.primaryFixedDim(mode, brightness),
                        AppColors.onPrimaryFixedVariant(mode, brightness),
                      ],
                    ),
                    MaterialContainerXWidget(
                      brightness: brightness,
                      texts: const [
                        'Secondary Fixed',
                        'On Secondary Fixed',
                        'Secondary Fixed Dim',
                        'On Secondary Fixed Variant',
                      ],
                      colors: [
                        AppColors.secondaryFixed(mode, brightness),
                        AppColors.onSecondaryFixed(mode, brightness),
                        AppColors.secondaryFixedDim(mode, brightness),
                        AppColors.onSecondaryFixedVariant(mode, brightness),
                      ],
                    ),
                    MaterialContainerXWidget(
                      brightness: brightness,
                      texts: const [
                        'Tertiary Fixed',
                        'On Tertiary Fixed',
                        'Tertiary Fixed Dim',
                        'On Tertiary Fixed Variant',
                      ],
                      colors: [
                        AppColors.tertiaryFixed(mode, brightness),
                        AppColors.onTertiaryFixed(mode, brightness),
                        AppColors.tertiaryFixedDim(mode, brightness),
                        AppColors.onTertiaryFixedVariant(mode, brightness),
                      ],
                    ),
                    MaterialContainerXWidget(
                      brightness: brightness,
                      texts: const ['Outline', 'Outline Variant'],
                      colors: [
                        AppColors.inverseSurface(mode, brightness),
                        AppColors.inversePrimary(mode, brightness),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    MaterialContainerXWidget(
                      brightness: brightness,
                      texts: const [
                        'Shadow',
                        'Scrim',
                      ],
                      colors: [
                        AppColors.shadow(mode, brightness),
                        AppColors.scrim(mode, brightness),
                      ],
                    ),
                    MaterialContainerXWidget(
                      brightness: brightness,
                      texts: const [
                        'Surface',
                        'On Surface',
                        'On Surface Variant',
                      ],
                      colors: [
                        AppColors.surface(mode, brightness),
                        AppColors.onSurface(mode, brightness),
                        AppColors.onSurfaceVariant(mode, brightness),
                      ],
                    ),
                    MaterialContainerXWidget(
                      brightness: brightness,
                      texts: const [
                        'Surface Dim',
                        'Surface Tint',
                        'Surface Bright',
                      ],
                      colors: [
                        AppColors.surfaceDim(mode, brightness),
                        AppColors.surfaceTint(mode, brightness),
                        AppColors.surfaceBright(mode, brightness),
                      ],
                    ),
                    MaterialContainerXWidget(
                      brightness: brightness,
                      texts: const ['Inverse Surface', 'Inverse Primary'],
                      colors: [
                        AppColors.inverseSurface(mode, brightness),
                        AppColors.inversePrimary(mode, brightness),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    MaterialContainerXWidget(
                      brightness: brightness,
                      texts: const [
                        'Surface Container',
                      ],
                      colors: [
                        AppColors.surfaceContainer(mode, brightness),
                      ],
                    ),
                    MaterialContainerXWidget(
                      brightness: brightness,
                      texts: const [
                        'Surface Container',
                        'Surface Container Low',
                        'Surface Container Lowest',
                      ],
                      colors: [
                        AppColors.surfaceContainer(mode, brightness),
                        AppColors.surfaceContainerLow(mode, brightness),
                        AppColors.surfaceContainerLowest(mode, brightness),
                      ],
                    ),
                    MaterialContainerXWidget(
                      brightness: brightness,
                      texts: const [
                        'Surface Container ',
                        'Surface Container High',
                        'Surface Container Highest',
                      ],
                      colors: [
                        AppColors.surfaceContainer(mode, brightness),
                        AppColors.surfaceContainerHigh(mode, brightness),
                        AppColors.surfaceContainerHighest(mode, brightness),
                      ],
                    ),
                    MaterialContainerXWidget(
                      brightness: brightness,
                      texts: const [
                        'Surface Container Lowest',
                        'Surface Container Low',
                        'Surface Container ',
                        'Surface Container High',
                        'Surface Container Highest',
                      ],
                      colors: [
                        AppColors.surfaceContainerLowest(mode, brightness),
                        AppColors.surfaceContainerLow(mode, brightness),
                        AppColors.surfaceContainer(mode, brightness),
                        AppColors.surfaceContainerHigh(mode, brightness),
                        AppColors.surfaceContainerHighest(mode, brightness),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MaterialContainerWidget extends StatelessWidget {
  const MaterialContainerWidget({
    required this.text,
    required this.first,
    required this.second,
    required this.brightness,
    this.width = _width,
    this.height = _height,
    super.key,
  });

  final String text;
  final Color first;
  final Color second;
  final double width;
  final double height;
  final Brightness brightness;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSize.s4),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSize.s),
          border: Border.all(
            color: brightness == Brightness.light ? Colors.black : Colors.white,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppSize.s),
          child: Column(
            children: <Widget>[
              Flexible(
                flex: 2,
                child: ColoredBox(
                  color: first,
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: AppSize.s,
                        top: AppSize.s4,
                      ),
                      child: Text(
                        text,
                        style: TextStyle(color: second),
                      ),
                    ),
                  ),
                ),
              ),
              Flexible(
                child: ColoredBox(
                  color: second,
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: AppSize.s,
                        top: AppSize.s4,
                      ),
                      child: Text(
                        'On $text',
                        style: TextStyle(color: first),
                      ),
                    ),
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

class MaterialContainerXWidget extends StatelessWidget {
  const MaterialContainerXWidget({
    required this.texts,
    required this.colors,
    required this.brightness,
    this.width = _width,
    this.height = _height,
    super.key,
  });

  final List<String> texts;
  final List<Color> colors;
  final double width;
  final double height;
  final Brightness brightness;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSize.s4),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSize.s),
          border: Border.all(
            color: brightness == Brightness.light ? Colors.black : Colors.white,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppSize.s),
          child: Column(
            children: [
              for (int i = 0; i < colors.length; i++)
                Flexible(
                  child: ColoredBox(
                    color: colors[i],
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: AppSize.s,
                          top: AppSize.s4,
                        ),
                        child: Text(
                          texts.elementAtOrNull(i) ?? '',
                          style: TextStyle(
                            color: colors[i].computeLuminance() > 0.5
                                ? Colors.black
                                : Colors.white,
                          ),
                        ),
                      ),
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

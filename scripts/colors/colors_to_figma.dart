import 'dart:convert';

import 'package:flutter/material.dart';

void main() {
  final colors = <String, Color>{
    // Add your colors here
    'blueVeryLight': const Color(0xfff8fbff),
    'blueSky': const Color(0xffd1eaff),
    'bluePastel': const Color(0xffc8e6ff),
    'blueLightSteel': const Color(0xffaecfe8),
    'blueSoft': const Color(0xffaacbe4),
    'blueMisty': const Color(0xff7595ac),
    'blueSlate': const Color(0xff59788f),
    'blueCadet': const Color(0xff436278),
    'blueSkyDark': const Color(0xff406075),
    'blueSteel': const Color(0xff2a4a5f),
    'blueSteelDark': const Color(0xff26465b),
    'blueNavyLight': const Color(0xff18394e),
    'blueMidnightLight': const Color(0xff113447),
    'blueMidnight': const Color(0xff0c3044),
    'blueDeep': const Color(0xff002538),
    'blueDeepDark': const Color(0xff001e2e),
    'blueTwilight': const Color(0xff001827),
    'blueAbyss': const Color(0xff00131f),
    'redVeryLight': const Color(0xffffdad6),
    'redLight': const Color(0xffffb4ab),
    'redPastel': const Color(0xffffbab1),
    'redSoft': const Color(0xffff5449),
    'redBright': const Color(0xffda342e),
    'redDeep': const Color(0xffba1a1a),
    'redDark': const Color(0xff93000a),
    'redDarkCrimson': const Color(0xff8c0009),
    'redWine': const Color(0xff690005),
    'redMaroon': const Color(0xff4e0002),
    'redBurgundy': const Color(0xff410002),
    'redAuburn': const Color(0xff370001),
    'greenVeryLight': const Color(0xffd1ede4),
    'greenLight': const Color(0xffcde8df),
    'greenLightMint': const Color(0xffaafce7),
    'greenLightPale': const Color(0xffa5f7e2),
    'greenMint': const Color(0xffa0f2dd),
    'greenTeal': const Color(0xff89dac6),
    'greenSea': const Color(0xff84d6c2),
    'greenEmerald': const Color(0xff4d9f8c),
    'greenSlate': const Color(0xff2d8271),
    'greenForest': const Color(0xff076b5b),
    'greenDeep': const Color(0xff016858),
    'greenSoftDark': const Color(0xff005245),
    'greenDeepDark': const Color(0xff005144),
    'greenDarkForest': const Color(0xff004c40),
    'greenDarkEmerald': const Color(0xff003e34),
    'greenDarkTeal': const Color(0xff00382e),
    'greenCadet': const Color(0xff00332b),
    'greenDarkCadet': const Color(0xff003028),
    'greenMidnight': const Color(0xff002820),
    'greenDeepCadet': const Color(0xff0e2621),
    'greenDeepForest': const Color(0xff00201a),
    'greenBlack': const Color(0xff06201a),
    'greenDark': const Color(0xff021a15),
    'greenDeepMidnight': const Color(0xff001a15),
    'grayDeepDark': const Color(0xff001510),
    'greenAccentVeryLight': const Color(0xffbfc9c4),
    'greenAccentLight': const Color(0xffb5d1c8),
    'greenAccentGray': const Color(0xffb1ccc4),
    'grayAccentPale': const Color(0xff7c968e),
    'greenAccentMisty': const Color(0xff607a72),
    'greenAccent': const Color(0xff4b635c),
    'greenAccentForest': const Color(0xff48615a),
    'greenAccentDeepForest': const Color(0xff334b45),
    'greenAccentTeal': const Color(0xff2f4841),
    'grayAccentMidnight': const Color(0xff233b35),
    'greenAccentDark': const Color(0xff1d352f),
    'greenAccentDeepDark': const Color(0xff19312b),
    'grayWhite': const Color(0xffffffff),
    'grayLight': const Color(0xfffff9f9),
    'grayLightSoft': const Color(0xfff6fcf8),
    'grayLightPale': const Color(0xfff5fbf7),
    'graySoftPale': const Color(0xfff3fdf8),
    'graySoftMuted': const Color(0xffeff5f1),
    'graySoftBright': const Color(0xffecfff8),
    'graySoftDusty': const Color(0xffe9efec),
    'grayBright': const Color(0xffe3eae6),
    'grayPale': const Color(0xffdee4e0),
    'graySoft': const Color(0xffd5dbd8),
    'grayMuted': const Color(0xffc3cdc9),
    'graySlate': const Color(0xff9ba5a1),
    'graySlateLight': const Color(0xff89938f),
    'graySlateDark': const Color(0xff7b8581),
    'grayMisty': const Color(0xff737d79),
    'grayDarkSoft': const Color(0xff6f7976),
    'grayDarkMuted': const Color(0xff57615e),
    'grayDarkDusty': const Color(0xff3f4946),
    'grayDarkShade': const Color(0xff3b4542),
    'grayDark': const Color(0xff343b38),
    'grayShadow': const Color(0xff303634),
    'grayDeep': const Color(0xff2b3230),
    'grayDeepShade': const Color(0xff252b29),
    'grayDeepMuted': const Color(0xff1d2623),
    'grayDeepShadow': const Color(0xff1b211f),
    'grayDarker': const Color(0xff171d1b),
    'grayDarkest': const Color(0xff0e1513),
    'grayMoss': const Color(0xff090f0e),
    'grayAsh': const Color(0xff090c0b),
    'grayBlack': const Color(0xff000000),
  };

  for (var i = 0; i < colors.length; i++) {
    final data = colors.entries.toList()[i];
    final name = data.key;
    final color = data.value;
    final red = color.red / 255.0;
    final green = color.green / 255.0;
    final blue = color.blue / 255.0;
    final alpha = color.opacity;

    final id = 'VariableID:209:${64 + i}';
    final jsonData = {
      'id': id,
      'name': name,
      'description': '',
      'type': 'COLOR',
      'valuesByMode': {
        '209:1': {
          'r': red,
          'g': green,
          'b': blue,
          'a': alpha,
        },
      },
      'resolvedValuesByMode': {
        '209:1': {
          'resolvedValue': {
            'r': red,
            'g': green,
            'b': blue,
            'a': alpha,
          },
          'alias': null,
        },
      },
      'scopes': ['ALL_SCOPES'],
      'hiddenFromPublishing': false,
      'codeSyntax': <dynamic>{},
    };
    // ignore: avoid_print
    print('${json.encode(jsonData)},\n');
  }
}

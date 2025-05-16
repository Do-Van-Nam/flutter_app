import 'package:flutter_app/translations/la_la.dart';
import 'package:flutter_app/translations/vn_vn.dart';
import 'package:get/get.dart';
import 'package:flutter_app/translations/en_us.dart';
import 'package:flutter_app/translations/es_es.dart';
import 'package:flutter_app/translations/fr_fr.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'en': enUS,
    'es': esES,
    'fr': frFR,
    'vn': vnVN,
    'la': laLA,
  };
}

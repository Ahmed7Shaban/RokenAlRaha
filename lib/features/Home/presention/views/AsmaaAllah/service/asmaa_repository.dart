import 'dart:convert';
import 'package:flutter/services.dart';

import '../model/asmaa_name_model.dart';

class AsmaaRepository {
  Future<List<AsmaaAllahModel>> fetchAsmaaAllah() async {
    final jsonString = await rootBundle.loadString('assets/data/asmaa_allah.json');
    final List<dynamic> jsonList = json.decode(jsonString);

    return jsonList.map((e) => AsmaaAllahModel.fromJson(e)).toList();
  }
}


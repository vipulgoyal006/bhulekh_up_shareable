// To parse this JSON data, do
//
//     final village = villageFromJson(jsonString);

import 'dart:convert';

List<Village> villageFromJson(String str) =>
    List<Village>.from(json.decode(str).map((x) => Village.fromJson(x)));

String villageToJson(List<Village> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Village {
  String vname;
  String villageCodeCensus;
  String vnameEng;
  Pname? pname;
  Flg? flgChakbandi;
  Flg? flgSurvey;
  String? parganaCodeNew;

  Village({
    required this.vname,
    required this.villageCodeCensus,
    required this.vnameEng,
    this.pname,
    this.flgChakbandi,
    this.flgSurvey,
    this.parganaCodeNew,
  });

  factory Village.fromJson(Map<String, dynamic> json) => Village(
        vname: json["vname"],
        villageCodeCensus: json["village_code_census"],
        vnameEng: json["vname_eng"],
        pname: pnameValues.map[json["pname"]],
        flgChakbandi: flgValues.map[json["flg_chakbandi"]]!,
        flgSurvey: flgValues.map[json["flg_survey"]]!,
        parganaCodeNew: json["pargana_code_new"],
      );

  Map<String, dynamic> toJson() => {
        "vname": vname,
        "village_code_census": villageCodeCensus,
        "vname_eng": vnameEng,
        "pname": pnameValues.reverse[pname],
        "flg_chakbandi": flgValues.reverse[flgChakbandi],
        "flg_survey": flgValues.reverse[flgSurvey],
        "pargana_code_new": parganaCodeNew,
      };
}

enum Flg { N, Y }

final flgValues = EnumValues({"N": Flg.N, "Y": Flg.Y});

enum Pname { EMPTY }

final pnameValues = EnumValues({"अमरोहा": Pname.EMPTY});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}

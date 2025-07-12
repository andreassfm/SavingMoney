import 'dart:convert';

class SavingModel {
  final String id;
  final String namaTabungan;
  final int targetJumlah;
  final int waktuMenabung;
  final DateTime tanggalBuat;

  SavingModel({
    required this.id,
    required this.namaTabungan,
    required this.targetJumlah,
    required this.waktuMenabung,
    required this.tanggalBuat,
  });

  SavingModel copyWith({
    String? id,
    String? namaTabungan,
    int? targetJumlah,
    int? waktuMenabung,
    DateTime? tanggalBuat,
  }) => SavingModel(
    id: id ?? this.id,
    namaTabungan: namaTabungan ?? this.namaTabungan,
    targetJumlah: targetJumlah ?? this.targetJumlah,
    waktuMenabung: waktuMenabung ?? this.waktuMenabung,
    tanggalBuat: tanggalBuat ?? this.tanggalBuat,
  );

  factory SavingModel.fromRawJson(String str) =>
      SavingModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SavingModel.fromJson(Map<String, dynamic> json) => SavingModel(
    id: json["id"],
    namaTabungan: json["namaTabungan"],
    targetJumlah: json["targetJumlah"],
    waktuMenabung: json["waktuMenabung"],
    tanggalBuat: DateTime.parse(json["tanggalBuat"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "namaTabungan": namaTabungan,
    "targetJumlah": targetJumlah,
    "waktuMenabung": waktuMenabung,
    "tanggalBuat": tanggalBuat.toIso8601String(),
  };
}

// To parse this JSON data, do
//
//     final productoModels = productoModelsFromJson(jsonString);

import 'dart:convert';

ProductoModels productoModelsFromJson(String str) => ProductoModels.fromJson(json.decode(str));

String productoModelsToJson(ProductoModels data) => json.encode(data.toJson());

class ProductoModels {
    ProductoModels({
        this.id,
        this.titulo="",
        this.valor=0.0,
        this.disponible=false,
        this.fotoUrl,
    });

    String id;
    String titulo ;
    double valor;
    bool disponible = false;
    String fotoUrl;

    factory ProductoModels.fromJson(Map<String, dynamic> json) => ProductoModels(
        id        : json["id"],
        titulo    : json["titulo"],
        valor     : json["valor"] * 1.0,
        disponible: json["disponible"],
        fotoUrl   : json["fotoUrl"],
    );

    Map<String, dynamic> toJson() => {
       
        "titulo"    : titulo,
        "valor"     : valor,
        "disponible": disponible,
        "fotoUrl"   : fotoUrl,
    };
}


import 'dart:convert';
import 'dart:io';

import 'package:myapp/Constant/ConstantService.dart';
import 'package:myapp/dto/Analisis.dart';
import 'package:myapp/dto/Parcela.dart';
import 'package:http/http.dart' as http;

class ParcelaBll {
  final String api = ConstanstAplication.SERVER_API;

  Future<List<Parcela>> getParcelaByUsuarioId(String usuarioId) async{
    final url = '$api/parcelas/$usuarioId';  

    final response = await http.get(Uri.parse(url));

    if(response.statusCode == 200){
      var jsonResponse = jsonDecode(response.body);
      List<Parcela> parcelas = [];
      for(var item in jsonResponse){
        parcelas.add(Parcela.fromJson(item));
      }
      return parcelas;
    }else{
      throw HttpException('Failed to load parcelas',uri:  Uri.parse(url));
    }
  }

  Future<List<Analisis>> getAnalisisByParcela(String usuarioId, String parcela_id) async{
    final url = '$api/analisis/$usuarioId/$parcela_id';

    final response = await http.get(Uri.parse(url));

    if(response.statusCode == 200){
      var jsonResponse = jsonDecode(response.body);
      List<Analisis> analisis = [];
      for(var item in jsonResponse){
        analisis.add(Analisis.fromJson(item));
      }
      return analisis;
    }else{
      throw HttpException('Failed to load parcelas',uri:  Uri.parse(url));
    }
  }
}
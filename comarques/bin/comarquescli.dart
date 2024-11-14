// Importació de llibreries

import 'dart:io';
import 'package:comarquescli/comarques_service.dart';
import 'package:comarquescli/provincia.dart';
import 'package:comarquescli/comarca.dart';

void main(List<String> arguments) {
  // Comprovem el nombre d'arguments
  if (arguments.isEmpty) {
    print("\x1B[31m Nombre d'arguments incorrectes\x1B[0m");
    exit(-1);
  }

  // Parsegem la llista d'arguments
  List<String> llistaArgs = List.from(arguments);
  String? ordre;
  String? args;

  // Separem l'ordre (provincies, comarques, infocomarca) de la llista d'arguments
  ordre = llistaArgs[0];
  llistaArgs.removeAt(0);
  args = llistaArgs.join(" ");

  switch (ordre) {
    case "provincies":
      mostraProvincies(); // Implementació amb Future
      // mostraProvinciesSync(); // Implementació amb async/await
      break;

    case "comarques":
      if (arguments.length != 2) {
        print("\x1B[31m Nombre d'arguments incorrectes. Cal especificar la província.\x1B[0m");
        exit(-1);
      }
      mostraComarques(args);
      break;

    case "infocomarca":
      if (arguments.length < 2) {
        print("\x1B[31m Nombre d'arguments incorrectes. Cal especificar la comarca.\x1B[0m");
        exit(-1);
      }
      mostraInfoComarca(args);
      break;

    default:
      print("\x1B[31mOrdre desconeguda\x1B[0m");
  }
}

// Implementació de mostraProvincies fent ús del Future
void mostraProvincies() {
  // La llista de províncies vindrà en un Future
  Future<List<Provincia>> respostaFuture = ComarquesService.obtenirProvincies();

  // Preparem el callback
  respostaFuture.then((resposta) {
    if (resposta.isNotEmpty) {
      // Recorrem la llista per mostrar els resultats
      for (var provincia in resposta) {
        print(provincia.toString());
      }
    } else {
      print("\x1B[31mNo s'ha obtingut cap resposta\x1B[0m");
    }
  });
}

// Implementació de mostraProvincies amb async/await
void mostraProvinciesSync() async {
  // La llista de províncies s'obté directament
  List<Provincia> provincies = await ComarquesService.obtenirProvincies();

  if (provincies.isNotEmpty) {
    for (var provincia in provincies) {
      print(provincia.toString());
    }
  } else {
    print("\x1B[31mNo s'ha obtingut cap resposta\x1B[0m");
  }
}

// Implementació de mostraComarques per obtenir comarques segons la província
void mostraComarques(String provincia) async {
  // Cridem el servei per obtenir la llista de comarques segons la província
  List<dynamic> comarques = await ComarquesService.obtenirComarques(provincia);

  if (comarques.isNotEmpty) {
    print("\x1B[32mComarques de la província de $provincia:\x1B[0m");
    for (var comarca in comarques) {
      print("\x1B[34m- $comarca\x1B[0m");
    }
  } else {
    print("\x1B[31mNo s'han trobat comarques per a la província de $provincia\x1B[0m");
  }
}

// Implementació de mostraInfoComarca per obtenir informació sobre una comarca
void mostraInfoComarca(String comarca) async {
  // Cridem el servei per obtenir la informació d'una comarca
  Comarca? infoComarca = await ComarquesService.infoComarca(comarca);

  if (infoComarca != null) {
    print("\x1B[32mInformació de la comarca de $comarca:\x1B[0m");
    print(infoComarca.toString());
  } else {
    print("\x1B[31mNo s'ha trobat informació per a la comarca de $comarca\x1B[0m");
  }
}

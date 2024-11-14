import 'package:comarquesgui/models/provincia.dart';
import 'package:comarquesgui/repository/repository_exemple.dart';
import 'package:flutter/material.dart';

/* Pantalla ProvinciesScreen: mostra tres CircleAvatar amb les diferents províncies */

class ProvinciesScreen extends StatelessWidget {
  const ProvinciesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(                  // Estructura de la pantalla Material Design
      body: Center(                   // Centrem el contingut
        child: SingleChildScrollView( // Contenidor amb scroll per si ens n'eixim de l'espai disponible
          child: Column(              // Organitzem les provincies en forma de columna
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children:               // Obtindrem la llista de widgets amb les provincies amb la 
                                      // funció privada _creaLlistaProvincies.
                  _creaLlistaProvincies(RepositoryExemple.obtenirProvincies())),
        ),
      ),
    );
  }
}

List<Widget> _creaLlistaProvincies(List<Provincia> provincies) {
  // Retornarem una llista de widgets
  List<Widget> llista = [];

  // Recorrem la llista de províncies
  for (Provincia provincia in provincies) {
    llista.add( // I afegim a la llista un widget personalitzat de tipus ProvinciaRoundButton
        ProvinciaRoundButton(nom: provincia.nom, img: provincia.imatge ?? ""));
    llista.add(const SizedBox(height: 20)); // Afegim un espai després del widget amb la província
  }
  return llista;
}

class ProvinciaRoundButton extends StatelessWidget {
  const ProvinciaRoundButton({required this.img, required this.nom, super.key});

  final String img;
  final String nom;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 110, // Radio del CircleAvatar
      backgroundImage: NetworkImage(img), // Imagen de fondo obtenida de Internet
      child: Text(
        nom, // Texto con el nombre de la provincia
        style: Theme.of(context).textTheme.displayMedium?.copyWith(
          color: Colors.white, // Cambiamos el color para asegurar visibilidad sobre la imagen
        ),
        textAlign: TextAlign.center, // Alineación centrada
      ),
    );
  }
}

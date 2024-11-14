import 'package:comarquesgui/models/comarca.dart';
import 'package:comarquesgui/repository/repository_exemple.dart';
import 'package:flutter/material.dart';

class InfoComarcaGeneral extends StatelessWidget {
  const InfoComarcaGeneral({super.key});

  @override
  Widget build(BuildContext context) {

    // Obtener la comarca del repositorio
    Comarca comarca = RepositoryExemple.obtenirInfoComarca();

    return Scaffold(
      appBar: AppBar(
        title: Text(comarca.comarca), // Título con el nombre de la comarca
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Imagen de la comarca
              Image.network(comarca.img ?? '', fit: BoxFit.cover),

              const SizedBox(height: 16.0),

              // Nombre de la comarca
              Text(
                comarca.comarca,
                style: const TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 8.0),

              // Capital de la comarca
              Text(
                'Capital: ${comarca.capital ?? 'Desconeguda'}',
                style: const TextStyle(fontSize: 18.0),
              ),

              const SizedBox(height: 8.0),

              // Población de la comarca
              Text(
                'Població: ${comarca.poblacio ?? 'Desconeguda'}',
                style: const TextStyle(fontSize: 18.0),
              ),

              const SizedBox(height: 16.0),

              // Descripción de la comarca
              Text(
                comarca.desc ?? 'No hi ha informació disponible sobre la descripció de la comarca.',
                style: const TextStyle(fontSize: 16.0),
              ),

              const SizedBox(height: 16.0),

              // Coordenadas de la comarca
              Text(
                'Coordenades: Lat: ${comarca.latitud}, Long: ${comarca.longitud}',
                style: const TextStyle(fontSize: 16.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

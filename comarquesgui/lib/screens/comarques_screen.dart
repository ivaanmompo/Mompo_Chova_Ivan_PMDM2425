import 'package:comarquesgui/models/comarca.dart';
import 'package:comarquesgui/repository/repository_exemple.dart';
import 'package:flutter/material.dart';

class ComarquesScreen extends StatelessWidget {
  const ComarquesScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        // Proporciona a _creaLlistaComarques la llista de comarques d'Alacant
        child: _creaLlistaComarques(RepositoryExemple.obtenirComarques()),
      ),
    );
  }

  Widget _creaLlistaComarques(List<dynamic> comarques) {
    // Rebem la llista de JSON amb el nom i la imatge (img) de cada comarca

    // Usamos ListView.builder para crear una lista de ComarcaCard
    return ListView.builder(
      itemCount: comarques.length,
      itemBuilder: (context, index) {
        final comarca = comarques[index];
        return ComarcaCard(
          img: comarca['img'], // URL de la imagen
          comarca: comarca['nom'], // Nombre de la comarca
        );
      },
    );
  }
}

class ComarcaCard extends StatelessWidget {
  // Este widget recibe dos argumentos: img (URL de la imagen) y comarca (nombre de la comarca)
  const ComarcaCard({
    super.key,
    required this.img,
    required this.comarca,
  });

  final String img;
  final String comarca;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5, // Sombra para darle relieve a la tarjeta
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15), // Bordes redondeados
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            // Imagen de la comarca
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                img,
                width: 80,
                height: 80,
                fit: BoxFit.cover, // Ajusta la imagen para cubrir el contenedor
              ),
            ),
            const SizedBox(width: 20),
            // Nombre de la comarca
            Expanded(
              child: Text(
                comarca,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

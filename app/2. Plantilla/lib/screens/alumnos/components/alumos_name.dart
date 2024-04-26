import 'package:flutter/material.dart';
import 'package:shop_app/screens/favorite/favorite_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/models/AlumnosViewModel.dart';
import 'package:shop_app/components/componente1.dart';
import 'package:shop_app/screens/calificaciones/components/card.dart';

class WidgetAlumnos extends StatefulWidget {
  const WidgetAlumnos({Key? key});

  static String routeName = "/AlumnoScreen";
  @override
  State<WidgetAlumnos> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<WidgetAlumnos> {
  String url = ""; // Remover la inicialización aquí

  List<AlumnosViewModel> _alumnos = [];

  @override
  void initState() {
    super.initState();
    _getListado();
  }

  Future<void> _getListado() async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    int? useridd = sharedPreferences.getInt('IdUsuario');
    print(useridd);
    url = "http://www.reportecalificacionesalumno.somee.com/API/Dashboard/AlumnosPorPadre/$useridd"; // Construir la URL aquí
    final response = await http.get(Uri.parse(url));
    final Map<String, dynamic> responseData = json.decode(response.body);
    final List<dynamic> alumnosData = responseData['data'];
    final List<AlumnosViewModel> alumnos = alumnosData.map((alumno) {
      return AlumnosViewModel.fromJson(alumno);
    }).toList();
    setState(() {
      _alumnos = alumnos;
    });
  }

@override
Widget build(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SectionTitle(
          title: "Sus Hijos",
          press: () {},
        ),
      ),
      SizedBox(height: 10),
      ..._alumnos.map((alumno) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8.0),
                    bottomLeft: Radius.circular(8.0),
                    bottomRight: Radius.circular(8.0),
                    topRight: Radius.circular(68.0),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Material(
                  elevation: 6,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8.0),
                    bottomLeft: Radius.circular(8.0),
                    bottomRight: Radius.circular(8.0),
                    topRight: Radius.circular(68.0),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: FitnessAppTheme.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8.0),
                        bottomLeft: Radius.circular(8.0),
                        bottomRight: Radius.circular(8.0),
                        topRight: Radius.circular(68.0),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Column(
                              children: <Widget>[
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 4, bottom: 3),
                                          child: Text(
                                            alumno.nombre_Alumno.toString(),
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontFamily: FitnessAppTheme.fontName,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 25,
                                              color: FitnessAppTheme.nearlyDarkBlue,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 4, top: 2, bottom: 14),
                                      child: Text(
                                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: FitnessAppTheme.fontName,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 13,
                                          letterSpacing: 0.0,
                                          color: FitnessAppTheme.darkText,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 4, right: 4, top: 8, bottom: 16),
                                  child: Container(
                                    height: 2,
                                    decoration: BoxDecoration(
                                      color: FitnessAppTheme.background,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(4.0)),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 16),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.only(left: 4),
                                            child: Icon(
                                              Icons.school,
                                              color: FitnessAppTheme.grey
                                                  .withOpacity(0.5),
                                              size: 22,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 4.0),
                                            child: Text(
                                              'Grado escolar: '+alumno.curso.toString(),
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontFamily: FitnessAppTheme.fontName,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 18,
                                                letterSpacing: 0.0,
                                                color: FitnessAppTheme.grey
                                                    .withOpacity(0.5),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 100,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  decoration: BoxDecoration(
                                    color: FitnessAppTheme.nearlyWhite,
                                    shape: BoxShape.circle,
                                    boxShadow: <BoxShadow>[
                                      BoxShadow(
                                          color: FitnessAppTheme.nearlyDarkBlue
                                              .withOpacity(0.4),
                                          offset: const Offset(4.0, 4.0),
                                          blurRadius: 8.0),
                                    ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(6.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        print('Icono presionado');
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => DashboardScreen(alum_Id: alumno.alum_Id)));
                                      },
                                      child: Icon(
                                        Icons.insert_chart,
                                        color: FitnessAppTheme.nearlyDarkBlue,
                                        size: 32,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 28,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: FitnessAppTheme.nearlyWhite,
                                    shape: BoxShape.circle,
                                    boxShadow: <BoxShadow>[
                                      BoxShadow(
                                          color: FitnessAppTheme.nearlyDarkBlue
                                              .withOpacity(0.4),
                                          offset: const Offset(4.0, 4.0),
                                          blurRadius: 8.0),
                                    ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(6.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        print('Icono presionado');
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => RunningCScreen(alum_Id: alumno.alum_Id)));
                                      },
                                      child: Icon(
                                        Icons.assignment,
                                        color: FitnessAppTheme.nearlyDarkBlue,
                                        size: 32,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20), // Espacio entre las cartas
          ],
        );
      }).toList(),
    ],
  );
}
}

class SpecialOfferCard extends StatelessWidget {
  const SpecialOfferCard({
    Key? key,
    required this.category,
    required this.image,
    required this.description,
    required this.onPressed,
  }) : super(key: key);

  final String category, image, description;
  final GestureTapCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          width: double.infinity,
          height: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
              image: AssetImage(image),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.5),
                BlendMode.darken,
              ),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  category,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  description,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;
  final GestureTapCallback press;

  const SectionTitle({
    Key? key,
    required this.title,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            color: Colors.black,
          ),
        ),
        GestureDetector(
          onTap: press,
          child: Text(
            "",
            style: TextStyle(color: Color.fromARGB(255, 123, 68, 68)),
          ),
        ),
      ],
    );
  }
}

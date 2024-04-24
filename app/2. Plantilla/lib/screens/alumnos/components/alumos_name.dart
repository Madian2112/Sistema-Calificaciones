import 'package:flutter/material.dart';
import 'package:shop_app/screens/favorite/favorite_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/models/AlumnosViewModel.dart';

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
            title: "Tablas",
            press: () {},
          ),
        ),
        SizedBox(height: 10),
        ..._alumnos.map((alumno) {
          return SpecialOfferCard(
            image: "assets/images/alumnos.jpg",
            category: alumno.nombre_Alumno.toString(),
            description: "Vea los datos de su hijo en este apartado",
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => DashboardScreen(alum_Id: alumno.alum_Id)));
            },
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
            "Ver más",
            style: TextStyle(color: Color(0xFFBBBBBB)),
          ),
        ),
      ],
    );
  }
}

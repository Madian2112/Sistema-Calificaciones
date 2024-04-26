import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shop_app/components/componente1.dart';
import 'package:shop_app/models/CalificacionesViewModel.dart';
import 'package:shop_app/screens/calificaciones/components/banner.dart';

class RunningCScreen extends StatefulWidget {
  final bool login = true;
  final AnimationController? animationController;
  final Animation<double>? animation;
  final int? alum_Id;

  const RunningCScreen({Key? key, this.animationController, this.animation, this.alum_Id})
      : super(key: key);
  
  @override
  RunningView createState() => RunningView();
}

class RunningView extends State<RunningCScreen> {

  late List<String> subjects;
  late Map<String, int> gradesBySubject;

  String url = ""; // Remover la inicialización aquí

  @override
  void initState() {
    super.initState();
    fetchData();
  }
    List<CalificacionesViewModel> _calificaciones = [];
  String alumno = "";
  double? altura = 0;
  String name = "";

    Future<void> fetchData() async {
    setState(() {
    });

    url = "http://www.reportecalificacionesalumno.somee.com/API/Alumno/CaliparcialAlumno/${widget.alum_Id}"; // Construir la URL aquí
    final response = await http.get(Uri.parse(url));
    final Map<String, dynamic> responseData = json.decode(response.body);
    final List<dynamic> reportesData = responseData['data'];

    final List<CalificacionesViewModel> calificaciones = reportesData.map((calificaciones) {
      return CalificacionesViewModel.fromJson(calificaciones);
    }).toList();
    print(calificaciones);
    setState(() {
      _calificaciones = calificaciones;
    });
  }

  @override
  Widget build(BuildContext context) {
            return SingleChildScrollView(
              child: Column(
              children: <Widget>[
                              WorkoutView(
          animationController: widget.animationController,
          animation: widget.animation,
        ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 24, right: 24, top: 10, bottom: 0),
                  child: Stack(
                    clipBehavior: Clip.none,
                     children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 20, bottom: 16),
                        child: Container(
                          height: 250,
                          decoration: BoxDecoration(
                            color: FitnessAppTheme.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(8.0),
                                bottomLeft: Radius.circular(8.0),
                                bottomRight: Radius.circular(8.0),
                                topRight: Radius.circular(8.0)),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                  color: FitnessAppTheme.grey.withOpacity(0.4),
                                  offset: Offset(1.1, 1.1),
                                  blurRadius: 10.0),
                            ],
                          ),
                          child: Stack(
                            alignment: Alignment.topLeft,
                            children: <Widget>[
                              ClipRRect(
                                 borderRadius: BorderRadius.all(Radius.circular(8.0)),
                                  child: SizedBox(
                                   height: 180,
                                   child: AspectRatio(
                                     aspectRatio: 1.714,
                                    child: Image.asset(
                                    "assets/images/back.png",
                                     fit: BoxFit.cover, // Añadir esta línea para ajustar la imagen
                                       ),
                                    ),
                                  ),
                                ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          left: 130,
                                          right: 16,
                                          top: 16,
                                        ),
                                        child: Text(
                                          "Parcial 1",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            fontFamily:
                                                FitnessAppTheme.fontName,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 22,
                                            letterSpacing: 0.0,
                                            color:
                                                FitnessAppTheme.nearlyDarkBlue,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  ..._calificaciones.map((calificaciones){
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                      left: 75,
                                      bottom: 12,
                                      top: 2,
                                      right: 16,
                                    ),
                                    child: Text(
                                      calificaciones.materia.toString() + ": "+ calificaciones.parcial1.toString(),
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontFamily: FitnessAppTheme.fontName,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 17,
                                        letterSpacing: 0.0,
                                        color: const Color.fromARGB(255, 37, 41, 44)
                                            .withOpacity(0.5),
                                      ),
                                    ),
                                  );
                                  }).toList()
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: -18,
                        left: 27,
                        child: SizedBox(
                          width: 70,
                          height: 70,
                          child: Image.asset("assets/images/reporteimage.png"),
                        ),
                      )
                    ]
                  ),
                ),
                                Padding(
                  padding: const EdgeInsets.only(
                      left: 24, right: 24, top: 10, bottom: 0),
                  child: Stack(
                    clipBehavior: Clip.none,
                     children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 20, bottom: 16),
                        child: Container(
                          height: 250,
                          decoration: BoxDecoration(
                            color: FitnessAppTheme.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(8.0),
                                bottomLeft: Radius.circular(8.0),
                                bottomRight: Radius.circular(8.0),
                                topRight: Radius.circular(8.0)),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                  color: FitnessAppTheme.grey.withOpacity(0.4),
                                  offset: Offset(1.1, 1.1),
                                  blurRadius: 10.0),
                            ],
                          ),
                          child: Stack(
                            alignment: Alignment.topLeft,
                            children: <Widget>[
                              ClipRRect(
                                 borderRadius: BorderRadius.all(Radius.circular(8.0)),
                                  child: SizedBox(
                                   height: 170,
                                   child: AspectRatio(
                                     aspectRatio: 1.714,
                                    child: Image.asset(
                                    "assets/images/back.png",
                                     fit: BoxFit.cover, // Añadir esta línea para ajustar la imagen
                                       ),
                                    ),
                                  ),
                                ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          left: 130,
                                          right: 16,
                                          top: 16,
                                        ),
                                        child: Text(
                                          "Parcial 2",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            fontFamily:
                                                FitnessAppTheme.fontName,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 22,
                                            letterSpacing: 0.0,
                                            color:
                                                FitnessAppTheme.nearlyDarkBlue,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  ..._calificaciones.map((calificaciones){
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                      left: 75,
                                      bottom: 12,
                                      top: 2,
                                      right: 16,
                                    ),
                                    child: Text(
                                      calificaciones.materia.toString() + ": "+ calificaciones.parcial2.toString(),
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontFamily: FitnessAppTheme.fontName,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 17,
                                        letterSpacing: 0.0,
                                        color: const Color.fromARGB(255, 37, 41, 44)
                                            .withOpacity(0.5),
                                      ),
                                    ),
                                  );
                                  }).toList()
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: -18,
                        left: 27,
                        child: SizedBox(
                          width: 70,
                          height: 70,
                          child: Image.asset("assets/images/reporteimage.png"),
                        ),
                      )
                    ]
                  ),
                ),
                                Padding(
                  padding: const EdgeInsets.only(
                      left: 24, right: 24, top: 10, bottom: 0),
                  child: Stack(
                    clipBehavior: Clip.none,
                     children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 20, bottom: 16),
                        child: Container(
                          height: 250,
                          decoration: BoxDecoration(
                            color: FitnessAppTheme.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(8.0),
                                bottomLeft: Radius.circular(8.0),
                                bottomRight: Radius.circular(8.0),
                                topRight: Radius.circular(8.0)),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                  color: FitnessAppTheme.grey.withOpacity(0.4),
                                  offset: Offset(1.1, 1.1),
                                  blurRadius: 10.0),
                            ],
                          ),
                          child: Stack(
                            alignment: Alignment.topLeft,
                            children: <Widget>[
                              ClipRRect(
                                 borderRadius: BorderRadius.all(Radius.circular(8.0)),
                                  child: SizedBox(
                                   height: 170,
                                   child: AspectRatio(
                                     aspectRatio: 1.714,
                                    child: Image.asset(
                                    "assets/images/back.png",
                                     fit: BoxFit.cover, // Añadir esta línea para ajustar la imagen
                                       ),
                                    ),
                                  ),
                                ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          left: 130,
                                          right: 16,
                                          top: 16,
                                        ),
                                        child: Text(
                                          "Parcial 3",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            fontFamily:
                                                FitnessAppTheme.fontName,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 22,
                                            letterSpacing: 0.0,
                                            color:
                                                FitnessAppTheme.nearlyDarkBlue,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  ..._calificaciones.map((calificaciones){
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                      left: 75,
                                      bottom: 12,
                                      top: 2,
                                      right: 16,
                                    ),
                                    child: Text(
                                      calificaciones.materia.toString() + ": "+ calificaciones.parcial3.toString(),
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontFamily: FitnessAppTheme.fontName,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 17,
                                        letterSpacing: 0.0,
                                        color: const Color.fromARGB(255, 37, 41, 44)
                                            .withOpacity(0.5),
                                      ),
                                    ),
                                  );
                                  }).toList()
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: -18,
                        left: 27,
                        child: SizedBox(
                          width: 70,
                          height: 70,
                          child: Image.asset("assets/images/reporteimage.png"),
                        ),
                      )
                    ]
                  ),
                ),
              ],
            ),
            );
      }
  }
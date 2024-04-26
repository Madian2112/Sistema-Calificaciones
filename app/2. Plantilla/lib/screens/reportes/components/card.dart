import 'package:shop_app/components/componente1.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shop_app/models/ReportesViewModel.dart';
import 'package:shop_app/screens/reportes/components/banner.dart';

class RunningRScreen extends StatefulWidget {
  final bool login = true;
  final AnimationController? animationController;
  final Animation<double>? animation;
  final int? rema_Id;

  const RunningRScreen({Key? key, this.animationController, this.animation, this.rema_Id})
      : super(key: key);
  
  @override
  RunningView createState() => RunningView();
}

class RunningView extends State<RunningRScreen> {

  late List<String> subjects;
  late Map<String, int> gradesBySubject;

  String url = ""; // Remover la inicialización aquí

  @override
  void initState() {
    super.initState();
    fetchData();
  }
    List<ReportesViewModel> _reportes = [];
  String alumno = "";
  double? altura = 0;
  String name = "";

    Future<void> fetchData() async {
    setState(() {
    });

    url = "https://localhost:44348/API/Dashboard/ReportesFind/${widget.rema_Id}"; // Construir la URL aquí
    final response = await http.get(Uri.parse(url));
    final Map<String, dynamic> responseData = json.decode(response.body);
    final List<dynamic> reportesData = responseData['data'];

    final List<ReportesViewModel> reportes = reportesData.map((reporte) {
      return ReportesViewModel.fromJson(reporte);
    }).toList();
    print(reportes);
    setState(() {
      _reportes = reportes;
    });
  }

 @override
Widget build(BuildContext context) {
  return Column(
    children: <Widget>[
              WorkoutView(
          animationController: widget.animationController,
          animation: widget.animation,
        ),
      Padding(
        padding: const EdgeInsets.only(
          left: 24, right: 24, top: 0, bottom: 0),
        child: Stack(
          clipBehavior: Clip.none,
          children: _reportes.map((reporte) {
            return Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 16),
              child: Container(
                height: 190,
                decoration: BoxDecoration(
                  color: FitnessAppTheme.white,
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: [
                    BoxShadow(
                      color: FitnessAppTheme.grey.withOpacity(0.4),
                      offset: Offset(1.1, 1.1),
                      blurRadius: 10.0,
                    ),
                  ],
                ),
                child: Stack(
                  alignment: Alignment.topLeft,
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: SizedBox(
                        height: 180,
                        child: AspectRatio(
                          aspectRatio: 1.714,
                          child: Image.asset(
                            "assets/images/back.png",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 52,
                            right: 16,
                            top: 16,
                          ),
                          child: Text(
                            'Tipo de reporte: ${reporte.repo_Descripcion}',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontFamily: FitnessAppTheme.fontName,
                              fontWeight: FontWeight.w500,
                              fontSize: 20,
                              color: FitnessAppTheme.nearlyDarkBlue,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 55,
                            bottom: 12,
                            top: 5,
                            right: 16,
                          ),
                          child: Text(
                            'Reporte: ${reporte.repo_Causa}',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontFamily: FitnessAppTheme.fontName,
                              fontWeight: FontWeight.w500,
                              fontSize: 17,
                              color: const Color.fromARGB(255, 37, 41, 44).withOpacity(0.5),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
          
        ),
      ),
    ],
  );
}

  }


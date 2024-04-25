import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:fl_chart/fl_chart.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int aprobadas = 0;
  int reprobadas = 0;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    fetchDataFromApi();
  }

  Future<void> fetchDataFromApi() async {
    try {
      final response = await http.get(Uri.parse('http://www.reportecalificacionesalumno.somee.com/API/Dashboard/EstadocalificacionesAlumno/2'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data != null && data['data'] != null && data['data'].isNotEmpty) {
          final dataItem = data['data'][0];
          final String aprobadasStr = dataItem['aprobadas'];
          final String reprobadasStr = dataItem['reprobadas'];

          if (aprobadasStr != null && reprobadasStr != null) {
            setState(() {
              aprobadas = int.tryParse(aprobadasStr) ?? 0;
              reprobadas = int.tryParse(reprobadasStr) ?? 0;
              loading = false;
            });
          } else {
            print('Error: Datos de aprobadas o reprobadas faltantes en la respuesta de la API');
          }
        } else {
          print('Error: Respuesta de la API no válida');
        }
      } else {
        print('Error al cargar los datos: ${response.statusCode}');
      }
    } catch (error) {
      print('Error al cargar los datos: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard de Calificaciones'),
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Materias Aprobadas: $aprobadas',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Materias Reprobadas: $reprobadas',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  Card(
                    elevation: 3,
                    color: Color.fromARGB(255, 255, 255, 255),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text(
                            'Materias Aprobadas y Reprobadas',
                            style: Theme.of(context).textTheme.headline6?.copyWith(fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 24),
                          Container(
                            height: 300, // Altura fija para el gráfico de pastel
                            child: PieChart(
                              PieChartData(
                                sections: [
                                  PieChartSectionData(
                                    color: Colors.green,
                                    value: aprobadas.toDouble(),
                                    title: 'Aprobadas\n$aprobadas',
                                    radius: 80,
                                    titleStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
                                  ),
                                  PieChartSectionData(
                                    color: Colors.red,
                                    value: reprobadas.toDouble(),
                                    title: 'Reprobadas\n$reprobadas',
                                    radius: 80,
                                    titleStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
                                  ),
                                ],
                                centerSpaceRadius: 0,
                                sectionsSpace: 0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}


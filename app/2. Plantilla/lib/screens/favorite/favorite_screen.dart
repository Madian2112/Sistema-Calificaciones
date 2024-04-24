import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fl_chart/fl_chart.dart';
import 'package:shop_app/models/ReportesViewModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardScreen extends StatefulWidget {
  static String routeName = "/dashboard";
  final int alum_Id;

  const DashboardScreen({Key? key, required this.alum_Id}) : super(key: key);
  
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late List<String> subjects;
  late Map<String, int> gradesBySubject;
  int aprobadas = 0;
  int reprobadas = 0;
  late int leve;
  late int grave;
  late int muyGrave;
  late int expulsion;
  bool loading = true;
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  String url = ""; // Remover la inicialización aquí

  List<ReportesViewModel> _reportes = [];
  String alumno = "";
  double? altura = 0;
  String name = "";

  Future<void> fetchData() async {
    setState(() {
      loading = true;
    });

    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    int? useridd = sharedPreferences.getInt('IdUsuario');
    print(useridd);
    url = "http://www.reportecalificacionesalumno.somee.com/API/Dashboard/ReportesAlumno/${widget.alum_Id}"; // Construir la URL aquí
    final response = await http.get(Uri.parse(url));
    final Map<String, dynamic> responseData = json.decode(response.body);
    final List<dynamic> reportesData = responseData['data'];
    
    if (reportesData.isNotEmpty) {
      print('La API devolvió datos');
      altura = 160 ;
      // Aquí asigna el valor a la variable según tus necesidades
    } else {
      altura = 0;
      print('La API no devolvió datos');
      // Aquí asigna el valor alternativo a la variable si no hay datos
    }
    final List<ReportesViewModel> reportes = reportesData.map((reporte) {
      return ReportesViewModel.fromJson(reporte);
    }).toList();
    print(reportes);
    setState(() {
      _reportes = reportes;
    });

    try {
      final response1 = await http.get(Uri.parse('http://www.reportecalificacionesalumno.somee.com/API/Dashboard/CaliAlumno/${widget.alum_Id}'));
      final response2 = await http.get(Uri.parse('http://www.reportecalificacionesalumno.somee.com/API/Dashboard/EstadocalificacionesAlumno/${widget.alum_Id}'));
      final response3 = await http.get(Uri.parse('http://www.reportecalificacionesalumno.somee.com/API/Dashboard/EstadisticasReporte/${widget.alum_Id}'));
      
      final String calificaciones = 'http://www.reportecalificacionesalumno.somee.com/API/Dashboard/EstadocalificacionesAlumno/${widget.alum_Id}';
      final result = await http.get(Uri.parse(calificaciones));
      if(result.statusCode == 200){
      final json = jsonDecode(result.body);
            final userData = json['data'][0];
            name = userData['alumno'];
            print(name);
      }

      if (response1.statusCode == 200 && response2.statusCode == 200 && response3.statusCode == 200) {
        final data1 = json.decode(response1.body);
        final data2 = json.decode(response2.body);
        final data3 = json.decode(response3.body);

        // Procesamiento de los datos del primer endpoint
        final List<dynamic> subjectsData = data1['data'];
        subjects = subjectsData.map<String>((subjectData) => subjectData['materia'] as String).toList();
        gradesBySubject = Map.fromIterable(
          subjectsData,
          key: (subjectData) => subjectData['materia'] as String,
          value: (subjectData) => int.parse(subjectData['calificacion'] as String),
        );

        // Procesamiento de los datos del segundo endpoint
        final String aprobadasStr = data2['data'][0]['aprobadas'];
        final String reprobadasStr = data2['data'][0]['reprobadas'];
        aprobadas = int.tryParse(aprobadasStr) ?? 0;
        reprobadas = int.tryParse(reprobadasStr) ?? 0;

        // Procesamiento de los datos del tercer endpoint
        leve = int.tryParse(data3['data'][0]['leve'].toString()) ?? 0;
        grave = int.tryParse(data3['data'][0]['grave'].toString()) ?? 0;
        muyGrave = int.tryParse(data3['data'][0]['muyGrave'].toString()) ?? 0;
        expulsion = int.tryParse(data3['data'][0]['expulsion'].toString()) ?? 0;
        /* String alumno = data3['data'][0]['alumno'];
        print(alumno); */

        setState(() {
          loading = false;
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            appBar: AppBar(
              title: Text('Estadisticas Escolares - '+ name),
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: altura,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        SizedBox(width: 20),
                        ..._reportes.map((reporte){
                        return CustomCard(
                          title: 'Reporte: ' + reporte.repo_Descripcion.toString(),
                          subtitle: 'Materia: '+ reporte.mate_Descripcion.toString() + '\n'+
                                    'Causa: ' + reporte.repo_Causa.toString(),
                        );
                        }).toList(),
                        SizedBox(width: 20),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Card(
                    elevation: 4,
                    color: Color.fromARGB(255, 241, 241, 241),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Container(
                      height: 200,
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: <Widget>[
                          SizedBox(width: 20),
                          Expanded(
                            child: PieChart(
                              PieChartData(
                                sections: [
                                  PieChartSectionData(
                                    color: Color.fromARGB(255, 0, 139, 5),
                                    value: aprobadas.toDouble(),
                                    title: 'Aprobadas\n$aprobadas',
                                    radius: 80,
                                    titleStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
                                  ),
                                  PieChartSectionData(
                                    color: const Color.fromARGB(255, 146, 10, 0),
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
                  SizedBox(height: 20),
                  Expanded(
                    child: Card(
                      elevation: 3,
                      color: Color.fromARGB(255, 241, 241, 241),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              'Calificaciones por Materia',
                              style: Theme.of(context).textTheme.headline6?.copyWith(fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 24),
                            Expanded(
                              child: LineChart(
                                LineChartData(
                                  lineBarsData: [
                                    LineChartBarData(
                                      spots: subjects.asMap().entries.map((entry) {
                                        final index = entry.key;
                                        final String subject = entry.value;
                                        final double grade = gradesBySubject[subject]!.toDouble();
                                        return FlSpot(index.toDouble(), grade);
                                      }).toList(),
                                      isCurved: true,
                                      colors: [Color.fromARGB(255, 1, 52, 95)],
                                      barWidth: 4,
                                      belowBarData: BarAreaData(show: false),
                                      dotData: FlDotData(show: true),
                                    ),
                                  ],
                                  titlesData: FlTitlesData(
                                    leftTitles: SideTitles(
                                      showTitles: true,
                                      interval: 10, // Intervalo entre cada etiqueta
                                      getTextStyles: (context, value) => const TextStyle(
                                        color: Color.fromARGB(255, 5, 5, 5),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                      margin: 20,
                                      reservedSize: 28, // Espacio para mostrar la última etiqueta completamente
                                    ),
                                    bottomTitles: SideTitles(
                                      showTitles: true,
                                      getTextStyles: (context, value) => const TextStyle(
                                        color: Color.fromARGB(255, 5, 5, 5),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                      margin: 20,
                                      getTitles: (double value) {
                                        final int index = value.toInt();
                                        if (index >= 0 && index < subjects.length) {
                                          return subjects[index];
                                        }
                                        return '';
                                      },
                                    ),
                                  ),
                                  gridData: FlGridData(show: true),
                                  borderData: FlBorderData(show: true),
                                  minX: 0,
                                  maxX: subjects.length.toDouble() - 1,
                                  minY: 0,
                                  maxY: 100,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Expanded(
                    child: Card(
                      elevation: 3,
                      color: Color.fromARGB(255, 241, 241, 241),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            _buildBar(title: 'Leve', value: leve),
                            _buildBar(title: 'Grave', value: grave),
                            _buildBar(title: 'Muy Grave', value: muyGrave),
                            _buildBar(title: 'Expulsión', value: expulsion),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
  }

  Widget _buildBar({required String title, required int value}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(width: 10),
          Expanded(
            child: LinearProgressIndicator(
              backgroundColor: Colors.grey[300],
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
              value: value / 100, // Valor normalizado para el porcentaje
            ),
          ),
          SizedBox(width: 10),
          Text(
            '$value',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class CustomCard extends StatelessWidget {
  final String title;
  final String subtitle;

  CustomCard({required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 14,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: Container(
          width: 250, // Ancho fijo para las cartas en el carrusel
          padding: EdgeInsets.all(20.0),
          decoration: BoxDecoration (
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 2,
                blurRadius: 10,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 7),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
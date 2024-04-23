import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fl_chart/fl_chart.dart';

class DashboardScreen extends StatefulWidget {
  static String routeName = "/dashboard";
    const DashboardScreen({super.key});

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

  Future<void> fetchData() async {
    setState(() {
      loading = true;
    });

    try {
      final response1 = await http.get(Uri.parse('http://www.reportecalificacionesalumno.somee.com/API/Dashboard/CaliAlumno/1'));
      final response2 = await http.get(Uri.parse('http://www.reportecalificacionesalumno.somee.com/API/Dashboard/EstadocalificacionesAlumno/3'));
      final response3 = await http.get(Uri.parse('http://www.reportecalificacionesalumno.somee.com/API/Dashboard/EstadisticasReporte/2'));

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
              title: Text('Estadisticas Escolares'),
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
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

void main() {
  runApp(MaterialApp(
    home: DashboardScreen(),
  ));
}

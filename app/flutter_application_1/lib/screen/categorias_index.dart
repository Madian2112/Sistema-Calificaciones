import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyWidget extends StatefulWidget {
  const MyWidget({Key? key}) : super(key: key);

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  String url = 'https://localhost:44348/API/Usuario/ListadoUsuarios';

  late Future<List<dynamic>> _getListado;
  bool _isSortAsc = true;
  int _currentSortColumn = 0;

  @override
  void initState() {
    super.initState();
    _getListado = _fetchData();
  }

  Future<List<dynamic>> _fetchData() async {
    final result = await http.get(Uri.parse(url));
    final jsonData = jsonDecode(result.body);
    final dataList = jsonData['data']; // Extraer la lista de objetos JSON
    return dataList as List<dynamic>; // Devolver la lista de objetos JSON
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<dynamic>>(
        future: _getListado,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            return Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8, // Ancho del contenedor
                margin: EdgeInsets.all(20),
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration( // Fondo blanco crema para el contenedor
                  borderRadius: BorderRadius.circular(10), // Bordes redondeados
                ),
                child: SingleChildScrollView(
                  child: PaginatedDataTable(
                    header: Text('Listado API', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                    rowsPerPage: 5,
                    columns: [
                      DataColumn(
                        label: Text('ID'),
                        onSort: (columnIndex, _) {
                          setState(() {
                            _currentSortColumn = columnIndex;
                            if (_isSortAsc) {
                              snapshot.data!.sort((a, b) => b['usua_Id'].compareTo(a['usua_Id']));
                            } else {
                              snapshot.data!.sort((a, b) => a['usua_Id'].compareTo(b['usua_Id']));
                            }
                            _isSortAsc = !_isSortAsc;
                          });
                        },
                      ),
                                            DataColumn(
                        label: Text('Usuario'),
                        onSort: (columnIndex, _) {
                          setState(() {
                            _currentSortColumn = columnIndex;
                            if (_isSortAsc) {
                              snapshot.data!.sort((a, b) => b['usua_Usuario'].compareTo(a['usua_Usuario']));
                            } else {
                              snapshot.data!.sort((a, b) => a['usua_Usuario'].compareTo(b['usua_Usuario']));
                            }
                            _isSortAsc = !_isSortAsc;
                          });
                        },
                      ),
                                            DataColumn(
                        label: Text('Admin'),
                        onSort: (columnIndex, _) {
                          setState(() {
                            _currentSortColumn = columnIndex;
                            if (_isSortAsc) {
                              snapshot.data!.sort((a, b) => b['usua_EsAdmin'].compareTo(a['usua_EsAdmin']));
                            } else {
                              snapshot.data!.sort((a, b) => a['usua_EsAdmin'].compareTo(b['usua_EsAdmin']));
                            }
                            _isSortAsc = !_isSortAsc;
                          });
                        },
                      ),
                    ],
                    source: _DataSource(snapshot.data!),
                    showCheckboxColumn: false,
                    columnSpacing: 10, // Espacio entre las columnas
                  ),
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return Center(child: Text('No hay datos disponibles'));
          }
        },
      ),
    );
  }
}

class _DataSource extends DataTableSource {
  final List<dynamic> _data;

  _DataSource(this._data);

  @override
  DataRow? getRow(int index) {
    if (index >= _data.length) return null;
    final row = _data[index];
    return DataRow(
      color: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
        return index % 2 == 0 ? Colors.grey[200]! : Colors.transparent;
      }), // Color de fondo alternado para filas
      cells: [
        DataCell(Text(row["usua_Id"].toString())),
        DataCell(Text(row["usua_Usuario"])),
        DataCell(Text(row["usua_EsAdmin"].toString())),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _data.length;

  @override
  int get selectedRowCount => 0;
}


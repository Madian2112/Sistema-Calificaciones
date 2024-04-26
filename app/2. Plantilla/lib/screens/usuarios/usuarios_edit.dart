import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class EditarUsuarioView extends StatefulWidget {
  final int userId;

  const EditarUsuarioView({Key? key, required this.userId}) : super(key: key);

  @override
  _EditarUsuarioViewState createState() => _EditarUsuarioViewState();
}

class _EditarUsuarioViewState extends State<EditarUsuarioView> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _usuarioController = TextEditingController();
  TextEditingController _contrasenaController = TextEditingController();
  int? _selectedRoleId;
  bool _esAdministrador = false;
  List<Rol> _roles = [];
  String urlUsuario = "http://www.reportecalificacionesalumno.somee.com/API/Usuario/FillUsuarios";
  String urlActualizarUsuario = "http://www.reportecalificacionesalumno.somee.com/API/Usuario/UpdateUsuarios";
  String urlRoles = "http://www.reportecalificacionesalumno.somee.com/API/Usuario/ListadoRoles";

  @override
  void initState() {
    super.initState();
    _fetchUsuario();
    _fetchRoles(); 
  }

  Future<void> _fetchUsuario() async {
    try {
      final response = await http.get(Uri.parse('$urlUsuario?id=${widget.userId}'));
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        final userData = responseData['data'][0];
        setState(() {
          _usuarioController.text = userData['usua_Usuario'] ?? '';
          _contrasenaController.text = userData['usua_Clave'] ?? '';
          _selectedRoleId = userData['role_Id'];
          _esAdministrador = userData['usua_EsAdmin'] ?? false;
        });
      } else {
        throw Exception("Error al obtener información del usuario");
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  Future<void> _fetchRoles() async {
    try {
      final response = await http.get(Uri.parse(urlRoles));
      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body);
        setState(() {
          _roles = responseData.map((role) => Rol.fromJson(role)).toList();
        });
      } else {
        throw Exception("Error al obtener roles");
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  Future<void> _actualizarUsuario() async {
    if (_formKey.currentState!.validate()) {
      try {
        print("Enviando solicitud...");

        final response = await http.put(
          Uri.parse(urlActualizarUsuario),
          body: jsonEncode({
            'Usua_Id': widget.userId,
            'Usua_Usuario': _usuarioController.text,
            'Role_Id': _selectedRoleId,
            'Usua_EsAdmin': _esAdministrador,
          }),
          headers: {
            'Content-Type': 'application/json',
          },
        );

        print("Respuesta recibida: ${response.statusCode}");
        print("Cuerpo de la respuesta: ${response.body}");

        if (response.statusCode == 200) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Usuario actualizado exitosamente"),
              backgroundColor: Colors.green,
            ),
          );
        } else {
          String errorMessage = response.body;
          print("Error al actualizar usuario: $errorMessage");
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Error al actualizar usuario: $errorMessage"),
              backgroundColor: Colors.red,
            ),
          );
        }
      } catch (e) {
        print("Error: $e");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Error al actualizar usuario: $e"),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Editar Usuario"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                controller: _usuarioController,
                decoration: InputDecoration(labelText: 'Usuario'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa un usuario';
                  }
                  return null;
                },
              ),
           
              SizedBox(height: 16),
              DropdownButtonFormField<int>(
                value: _selectedRoleId,
                onChanged: (newValue) {
                  setState(() {
                    _selectedRoleId = newValue!;
                  });
                },
                items: _roles.map((rol) {
                  return DropdownMenuItem<int>(
                    value: rol.id,
                    child: Text(rol.descripcion),
                  );
                }).toList(),
                decoration: InputDecoration(labelText: 'Roles'),
                validator: (value) {
                  if (value == null || value == -1) {
                    return 'Por favor selecciona un rol';
                  }
                  return null;
                },
              ),
             
              SizedBox(height: 16),
              CheckboxListTile(
                title: Text('¿Es administrador?'),
                value: _esAdministrador,
                onChanged: (newValue) {
                  setState(() {
                    _esAdministrador = newValue ?? false;
                  });
                },
              ),
              SizedBox(height: 32),
              Center(
                child: ElevatedButton(
                  onPressed: _actualizarUsuario,
                  child: Text('Actualizar Usuario'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Rol {
  final int id;
  final String descripcion;

  Rol({
    required this.id,
    required this.descripcion,
  });

  factory Rol.fromJson(Map<String, dynamic> json) {
    return Rol(
      id: json['role_Id'],
      descripcion: json['role_Descripcion'],
    );
  }
}

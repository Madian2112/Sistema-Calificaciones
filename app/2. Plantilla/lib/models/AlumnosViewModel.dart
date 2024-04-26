class AlumnosViewModel {
  int? paAl_Id;
  int alum_Id;
  int? padr_Id;
  String? nombre_Padre;
  String? nombre_Alumno;
  String? curso;

  AlumnosViewModel({
     this.paAl_Id,
     this.padr_Id,
     this.nombre_Padre,
     this.nombre_Alumno,
     required this.alum_Id,
     this.curso,
    /*this.rolesDescripcion,*/
  });

  factory AlumnosViewModel.fromJson(Map<String, dynamic> json) {
    return AlumnosViewModel(
      paAl_Id: json['paAl_Id'],
      padr_Id: json['padr_Id'],
      nombre_Padre: json['nombre_Padre'],
      nombre_Alumno: json['nombre_Alumno'],
      alum_Id: json['alum_Id'],
      curso: json['curso'],
    );
  }
}
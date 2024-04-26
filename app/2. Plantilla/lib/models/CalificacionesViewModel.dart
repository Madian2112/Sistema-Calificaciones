class CalificacionesViewModel {
  int? parcial1;
  int? parcial2;
  int? parcial3;
  String? alumno;
  String? materia;

  CalificacionesViewModel({
     this.parcial1,
     this.parcial3,
     this.alumno,
     this.materia,
     this.parcial2,
    /*this.rolesDescripcion,*/
  });

  factory CalificacionesViewModel.fromJson(Map<String, dynamic> json) {
    return CalificacionesViewModel(
      parcial1: json['parcial1'],
      parcial3: json['parcial3'],
      alumno: json['alumno'],
      materia: json['materia'],
      parcial2: json['parcial2'],
    );
  }
}
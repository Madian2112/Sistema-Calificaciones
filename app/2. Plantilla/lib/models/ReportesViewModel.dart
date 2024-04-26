class ReportesViewModel {
  int? rema_Id;
  int? alum_Id;
  String? alumno;
  String? repo_Descripcion;
  String? repo_Causa;
  String? mate_Descripcion;
  


  ReportesViewModel({
    required this.rema_Id,
    required this.alum_Id,
    required this.alumno,
    required this.repo_Descripcion,
    required this.repo_Causa,
      required this.mate_Descripcion,
    /*this.rolesDescripcion,*/
  });

  factory ReportesViewModel.fromJson(Map<String, dynamic> json) {
    return ReportesViewModel(
      rema_Id: json['rema_Id'],
      alum_Id: json['alum_Id'],
      alumno: json['alumno'],
      repo_Descripcion: json['repo_Descripcion'],
      repo_Causa: json['repo_Causa'],
      mate_Descripcion: json['mate_Descripcion'],
    );
  }
}
class UsuariosViewModel{

   int? usua_Id;
   String? usua_Usuario;
   String? usua_EsAdmin;
   String? Usua_Clave;
   int? Role_Id;
   int? Usua_Creacion;
   DateTime? Usua_FechaCreacion;
   int? Usua_Modificacion;
   DateTime? Usua_FechaModificacion;
   String? Usua_Codigo;

   UsuariosViewModel({
     this.usua_Id,
     this.usua_Usuario, 
     this.usua_EsAdmin,
     this.Usua_Clave,
     this.Role_Id,
     this.Usua_Creacion,
     this.Usua_FechaCreacion,
     this.Usua_Modificacion,
     this.Usua_FechaModificacion,
     this.Usua_Codigo
  });

  factory UsuariosViewModel.fromJson(Map<String, dynamic> json) => UsuariosViewModel(
    usua_Id: json['usua_id'],
    usua_Usuario: json['usua_usuario'],
    usua_EsAdmin: json['usua_EsAdmin'],
    Usua_Clave: json['Usua_Clave'],
    Role_Id: json['Role_Id'],
      Usua_Creacion: json['Usua_Creacion'],
      Usua_FechaCreacion: json['Usua_FechaCreacion'] != null
          ? DateTime.parse(json['Usua_FechaCreacion'])
          : null,
      Usua_Modificacion: json['Usua_Modificacion'],
      Usua_FechaModificacion: json['Usua_FechaModificacion'] != null
          ? DateTime.parse(json['Usua_FechaModificacion'])
          : null,
    Usua_Codigo: json['Usua_Codigo'],
  );

  Map<String, dynamic> toJson() => {
    'usua_id': usua_Id,
    'usua_usuario': usua_Usuario,
    'usua_EsAdmin': usua_EsAdmin,
    'Usua_Clave': Usua_Clave,
    'Role_Id': Role_Id,
    'Usua_Creacion': Usua_Creacion,
    'Usua_FechaCreacion': Usua_FechaCreacion,
    'Usua_Modificacion': Usua_Modificacion,
    'Usua_FechaModificacion': Usua_FechaModificacion,
    'Usua_Codigo': Usua_Codigo,
  };

}
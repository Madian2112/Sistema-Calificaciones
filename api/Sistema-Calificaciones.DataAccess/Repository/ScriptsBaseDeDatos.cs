using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Sistema_Calificaciones.DataAccess.Repository
{
    public class ScriptsBaseDeDatos
    {

        #region Acceso
        #region Usuario
       
        public static string Usua_Listar = "Acce.sp_Usuarios_listar";
        public static string Usua_Login = "[Acce].[sp_Usuarios_iniciosesion]";
        public static string Usua_Insertar = "[Acce].[sp_Usuarios_insertar]";
        public static string Usua_Obtener = "[Acce].[sp_Usuarios_obtener]";
        public static string Usua_Eliminar = "[Acce].[sp_Usuarios_eliminar]";
        public static string Usua_Actualizar = "[Acce].[sp_Usuarios_editar]";



        #endregion
        #endregion


    }
}

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
        public static string Usua_Listar = "[Acce].[sp_Usuarios_listar]";
        public static string Usua_Login = "[Acce].[sp_Usuarios_iniciosesion]";
        public static string Usua_Insertar = "[Acce].[sp_Usuarios_insertar]";
        public static string Usua_Obtener = "[Acce].[sp_Usuarios_obtener]";
        public static string Usua_Eliminar = "[Acce].[sp_Usuarios_eliminar]";
        public static string Usua_Actualizar = "[Acce].[sp_Usuarios_editar]";
        public static string Usua_Restablecer = "[Acce].[sp_Usuarios_restablecer]";
        public static string Usua_Restablecer_EnviarCodigo = "[Acce].[sp_Usuarios_codigocontra]";
        public static string Usua_Restablecer_VeirificarCodigo = "[Acce].[sp_Usuarios_VerificarCodigo]";
        #endregion

        #region Rol
        public static string Role_Listar = "[Acce].[sp_Roles_listar]";
        #endregion
        #endregion

        #region Dashboar
        public static string ListadoAlumnosporpadre = "Repo.sp_InfoAlumnoporPadre";
        public static string calificaciones = "Repo.sp_CalificacionesAlumno2";
        public static string estadocalificaciones = "Repo.sp_CalificacionesAlumno1";
        public static string Reportes = "Repo.sp_ReportesPorAlumno";
        public static string EstadisticaReportes = "Repo.sp_ConteoReportesPorAlumno";
        #endregion

        #region Reportes
        public static string ReporteObtener = "[Repo].[sp_ReportesPorAlumno_obtener]";
        #endregion


    }
}

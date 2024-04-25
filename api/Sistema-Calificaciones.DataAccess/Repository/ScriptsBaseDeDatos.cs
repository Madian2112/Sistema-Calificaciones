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





        #region reportes
        public static string Listadoreportesprofe = "Repo.sp_Reportespormaestro_listar";
        public static string reporte_Insertar = "Repo.sp_ReportePorMaestro_insertar";
        public static string reporte_Obtener = "Repo.sp_ReportePorMaestro_obtener";
        public static string reporte_Eliminar = "Repo.sp_Reportepormaestro_eliminar";
        public static string reporte_Actualizar = "Repo.sp_ReportePorMaestro_editar";
        #endregion



        #region ddl

        public static string Listadorepo = "Repo.sp_Reportes_listar";
        public static string Listadoalumno = "Repo.sp_Alumnos_listar";
        public static string Listadomateria = "Repo.sp_Materias_listar";

        #endregion


        #region Alumno

        public static string calificacionesparciales = "Repo.sp_ListarnotasporparcialAlumno";

        #endregion
    }
}

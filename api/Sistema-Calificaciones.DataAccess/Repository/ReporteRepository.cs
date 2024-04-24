using Dapper;
using Microsoft.Data.SqlClient;
using Sistema_Calificaciones.Entities.Entities;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Sistema_Calificaciones.DataAccess.Repository
{
   public class ReporteRepository
    {


        public IEnumerable<tbCalificacionPorAlumno> List(int Alum_Id)
        {
            string sql = ScriptsBaseDeDatos.calificaciones;

            List<tbCalificacionPorAlumno> result = new List<tbCalificacionPorAlumno>();

            using (var db = new SqlConnection(Sistema_CalificacionesContex.ConnectionString))
            {
                var parameters = new { Alum_Id };
                result = db.Query<tbCalificacionPorAlumno>(sql, parameters, commandType: CommandType.StoredProcedure).ToList();
                return result;
            }
        }


        public IEnumerable<tbPadresPorAlumno> ListAlumnos(int Usua_Id)
        {
            string sql = ScriptsBaseDeDatos.ListadoAlumnosporpadre;

            List<tbPadresPorAlumno> result = new List<tbPadresPorAlumno>();

            using (var db = new SqlConnection(Sistema_CalificacionesContex.ConnectionString))
            {
                var parameters = new { Usua_Id };
                result = db.Query<tbPadresPorAlumno>(sql, parameters, commandType: CommandType.StoredProcedure).ToList();
                return result;
            }
        }




        public IEnumerable<tbCalificacionPorAlumno> EstadoCalificacion(int Alum_Id)
        {
            string sql = ScriptsBaseDeDatos.estadocalificaciones;

            List<tbCalificacionPorAlumno> result = new List<tbCalificacionPorAlumno>();

            using (var db = new SqlConnection(Sistema_CalificacionesContex.ConnectionString))
            {
                var parameters = new { Alum_Id };
                result = db.Query<tbCalificacionPorAlumno>(sql, parameters, commandType: CommandType.StoredProcedure).ToList();
                return result;
            }
        }







        public IEnumerable<tbReportesPorMaestros> Reporte(int Alum_Id)
        {
            string sql = ScriptsBaseDeDatos.Reportes;

            List<tbReportesPorMaestros> result = new List<tbReportesPorMaestros>();

            using (var db = new SqlConnection(Sistema_CalificacionesContex.ConnectionString))
            {
                var parameters = new { Alum_Id };
                result = db.Query<tbReportesPorMaestros>(sql, parameters, commandType: CommandType.StoredProcedure).ToList();
                return result;
            }
        }
        public IEnumerable<tbReportesPorMaestros> conteoreporte(int Alum_Id)
        {
            string sql = ScriptsBaseDeDatos.EstadisticaReportes;

            List<tbReportesPorMaestros> result = new List<tbReportesPorMaestros>();

            using (var db = new SqlConnection(Sistema_CalificacionesContex.ConnectionString))
            {
                var parameters = new { Alum_Id };
                result = db.Query<tbReportesPorMaestros>(sql, parameters, commandType: CommandType.StoredProcedure).ToList();
                return result;
            }
        }



    }
}

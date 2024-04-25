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







        public IEnumerable<vw_NotasPorParcial> Listparcial(int Alum_Id)
        {
            string sql = ScriptsBaseDeDatos.calificacionesparciales;

            List<vw_NotasPorParcial> result = new List<vw_NotasPorParcial>();

            using (var db = new SqlConnection(Sistema_CalificacionesContex.ConnectionString))
            {
                var parameters = new { Alum_Id };
                result = db.Query<vw_NotasPorParcial>(sql, parameters, commandType: CommandType.StoredProcedure).ToList();
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



        public IEnumerable<tbReportesPorMaestros> ListReportes(int Usua_Id)
        {
            string sql = ScriptsBaseDeDatos.Listadoreportesprofe;

            List<tbReportesPorMaestros> result = new List<tbReportesPorMaestros>();

            using (var db = new SqlConnection(Sistema_CalificacionesContex.ConnectionString))
            {
                var parameters = new { Usua_Id };
                result = db.Query<tbReportesPorMaestros>(sql, parameters, commandType: CommandType.StoredProcedure).ToList();
                return result;
            }
        }








        public RequestStatus Insert(tbReportesPorMaestros item)
        {

            string sql = ScriptsBaseDeDatos.reporte_Insertar;

            using (var db = new SqlConnection(Sistema_CalificacionesContex.ConnectionString))
            {
                var parameter = new DynamicParameters();
                parameter.Add("@Repo_Id", item.Repo_Id);
                parameter.Add("@Mate_Id", item.Mate_Id);
                parameter.Add("@Alum_Id", item.Alum_Id);
                 parameter.Add("@Repo_Causa", item.Repo_Causa);
                parameter.Add("@Rema_FechaCreacion", item.Rema_FechaCreacion);

                var result = db.Execute(sql, parameter, commandType: CommandType.StoredProcedure);
                string mensaje = (result == 1) ? "exito" : "error";
                return new RequestStatus { CodeStatus = result, MessageStatus = mensaje };

                //var result = db.QueryFirst(sql, parameter, commandType: CommandType.Text);

                //return result;
            }


        }




        public RequestStatus Update(tbReportesPorMaestros item)
        {
            string sql = ScriptsBaseDeDatos.reporte_Actualizar;

            using (var db = new SqlConnection(Sistema_CalificacionesContex.ConnectionString))
            {
                var parameter = new DynamicParameters();
                parameter.Add("@Repo_Id", item.Repo_Id);
                parameter.Add("@Mate_Id", item.Mate_Id);
                parameter.Add("@Alum_Id", item.Alum_Id);
                parameter.Add("@Rema_Modificacion", item.Rema_Modificacion);
                parameter.Add("@Rema_FechaModificacion", item.Rema_FechaModificacion);
                parameter.Add("@Rema_Id", item.Rema_Id);
                parameter.Add("@Repo_Causa", item.Repo_Causa);

                var result = db.Execute(sql, parameter, commandType: CommandType.StoredProcedure);
                string mensaje = (result == 1) ? "exito" : "error";
                return new RequestStatus { CodeStatus = result, MessageStatus = mensaje };

            }
        }








        public IEnumerable<tbReportesPorMaestros> Listr(int Rema_Id)
        {
            string sql = ScriptsBaseDeDatos.reporte_Obtener;

            List<tbReportesPorMaestros> result = new List<tbReportesPorMaestros>();

            using (var db = new SqlConnection(Sistema_CalificacionesContex.ConnectionString))
            {
                var parameters = new { Rema_Id };
                result = db.Query<tbReportesPorMaestros>(sql, parameters, commandType: CommandType.StoredProcedure).ToList();
                return result;
            }
        }


        public RequestStatus EliminarReporte(int Rema_Id, int usuario, DateTime fecha)
        {
            string sql = ScriptsBaseDeDatos.reporte_Eliminar;
            using (var db = new SqlConnection(Sistema_CalificacionesContex.ConnectionString))
            {
                var parametro = new DynamicParameters();
                parametro.Add("@Rema_Id", Rema_Id);
                parametro.Add("@Rema_Modificacion", usuario);
                parametro.Add("@Rema_FechaModificacion", fecha);


                var result = db.Execute(
                    sql, parametro,
                    commandType: CommandType.StoredProcedure
                );

                string mensaje = (result == 1) ? "exito" : "error";

                return new RequestStatus { CodeStatus = result, MessageStatus = mensaje };

            };
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


















        public IEnumerable<Materia> Listmate()
        {
            string sql = ScriptsBaseDeDatos.Listadomateria;

            List<Materia> result = new List<Materia>();

            using (var db = new SqlConnection(Sistema_CalificacionesContex.ConnectionString))
            {
                result = db.Query<Materia>(sql, commandType: CommandType.Text).ToList();

                return result;
            }
        }


        public IEnumerable<tbAlumnos> Listalumno()
        {
            string sql = ScriptsBaseDeDatos.Listadoalumno;

            List<tbAlumnos> result = new List<tbAlumnos>();

            using (var db = new SqlConnection(Sistema_CalificacionesContex.ConnectionString))
            {
                result = db.Query<tbAlumnos>(sql, commandType: CommandType.Text).ToList();

                return result;
            }
        }



        public IEnumerable<tbReportes> Listrepor()
        {
            string sql = ScriptsBaseDeDatos.Listadorepo;

            List<tbReportes> result = new List<tbReportes>();

            using (var db = new SqlConnection(Sistema_CalificacionesContex.ConnectionString))
            {
                result = db.Query<tbReportes>(sql, commandType: CommandType.Text).ToList();

                return result;
            }
        }






    }
}

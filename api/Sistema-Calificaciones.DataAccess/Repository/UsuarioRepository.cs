using Dapper;
using Microsoft.Data.SqlClient;
using Sistema_Calificaciones.DataAccess.Context;
using Sistema_Calificaciones.Entities.Entities;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Sistema_Calificaciones.DataAccess.Repository
{
    public class UsuarioRepository : IRepository<tbUsuarios>
    {
        public RequestStatus Delete(int? id)
        {
            throw new NotImplementedException();
        }

        public tbUsuarios Details(int? id)
        {
            throw new NotImplementedException();
        }

        public tbUsuarios find(int? id)
        {
            throw new NotImplementedException();
        }

        public RequestStatus Insert(tbUsuarios item)
        {

            string sql = ScriptsBaseDeDatos.Usua_Insertar;

            using (var db = new SqlConnection(Sistema_CalificacionesContex.ConnectionString))
            {
                var parameter = new DynamicParameters();
                parameter.Add("@Usua_Usuario", item.Usua_Usuario);
                parameter.Add("@Usua_Clave", item.Usua_Clave);
                parameter.Add("@Role_Id", item.Role_Id);
                parameter.Add("@Usua_EsAdmin", item.Usua_EsAdmin);
                parameter.Add("@Usua_Creacion", item.Usua_Creacion);
                parameter.Add("@Usua_FechaCreacion", item.Usua_FechaCreacion);

                var result = db.Execute(sql, parameter, commandType: CommandType.StoredProcedure);
                string mensaje = (result == 1) ? "exito" : "error";
                return new RequestStatus { CodeStatus = result, MessageStatus = mensaje };

                //var result = db.QueryFirst(sql, parameter, commandType: CommandType.Text);

                //return result;
            }


        }

        public IEnumerable<tbUsuarios> List()
        {
            string sql = ScriptsBaseDeDatos.Usua_Listar;

            List<tbUsuarios> result = new List<tbUsuarios>();

            using (var db = new SqlConnection(Sistema_CalificacionesContex.ConnectionString))
            {
                result = db.Query<tbUsuarios>(sql, commandType: CommandType.Text).ToList();

                return result;
            }
        }




        public IEnumerable<tbUsuarios> Login(string Usuario, string Contra)
        {
            string sql = ScriptsBaseDeDatos.Usua_Login;

            List<tbUsuarios> result = new List<tbUsuarios>();

            using (var db = new SqlConnection(Sistema_CalificacionesContex.ConnectionString))
            {
                var parameters = new { @Usua_Usuario = Usuario, @Usua_Clave = Contra };
                result = db.Query<tbUsuarios>(sql, parameters, commandType: CommandType.StoredProcedure).ToList();
                return result;
            }
        }







        public RequestStatus Update(tbUsuarios item) 
        {
            string sql = ScriptsBaseDeDatos.Usua_Actualizar;

            using (var db = new SqlConnection(Sistema_CalificacionesContex.ConnectionString))
            {
                var parameter = new DynamicParameters();
                parameter.Add("@Usua_Id", item.Usua_Id);
                parameter.Add("@Usua_Usuario", item.Usua_Usuario);
                parameter.Add("@Usua_EsAdmin", item.Usua_EsAdmin);
                parameter.Add("@Role_Id", item.Role_Id);
                parameter.Add("@Usua_Modificacion", item.Usua_Modificacion);
                parameter.Add("@Usua_FechaModificacion", item.Usua_FechaModificacion);

                var result = db.Execute(sql, parameter, commandType: CommandType.StoredProcedure);
                string mensaje = (result == 1) ? "exito" : "error";
                return new RequestStatus { CodeStatus = result, MessageStatus = mensaje };

            }
        }



        public IEnumerable<tbUsuarios> List(int Usua_Id)
        {
            string sql = ScriptsBaseDeDatos.Usua_Obtener;

            List<tbUsuarios> result = new List<tbUsuarios>();

            using (var db = new SqlConnection(Sistema_CalificacionesContex.ConnectionString))
            {
                var parameters = new { Usua_Id };
                result = db.Query<tbUsuarios>(sql, parameters, commandType: CommandType.StoredProcedure).ToList();
                return result;
            }
        }


        public RequestStatus EliminarUsuarios(int id, int usuario, DateTime fecha)
        {
            string sql = ScriptsBaseDeDatos.Usua_Eliminar;
            using (var db = new SqlConnection(Sistema_CalificacionesContex.ConnectionString))
            {
                var parametro = new DynamicParameters();
                parametro.Add("@Usua_Id", id);
                parametro.Add("@Usua_Modificacion", usuario);
                parametro.Add("@Usua_FechaModificacion", fecha);

                var result = db.Execute(
                    sql, parametro,
                    commandType: CommandType.StoredProcedure
                );

                string mensaje = (result == 1) ? "exito" : "error";

                return new RequestStatus { CodeStatus = result, MessageStatus = mensaje };

            };
        }


        public RequestStatus Restablecer(int Usua_Id, string Usua_Clave, int usuario, DateTime fecha)
        {
            string sql = ScriptsBaseDeDatos.Usua_Actualizar;

            using (var db = new SqlConnection(Sistema_CalificacionesContex.ConnectionString))
            {
                var parameter = new DynamicParameters();
                parameter.Add("@Usua_Id", Usua_Id);
                parameter.Add("@Usua_Clave", Usua_Clave);
                parameter.Add("@Usua_Modificacion", usuario);
                parameter.Add("@Usua_FechaModificacion", fecha);

                var result = db.Execute(sql, parameter, commandType: CommandType.StoredProcedure);
                string mensaje = (result == 1) ? "exito" : "error";
                return new RequestStatus { CodeStatus = result, MessageStatus = mensaje };

            }
        }


    }
}

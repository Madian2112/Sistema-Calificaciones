using Sistema_Calificaciones.DataAccess.Repository;
using Sistema_Calificaciones.Entities.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Sistema_Calificaciones.BusinessLogic.Services
{


  
    public class AccesoServices
    {
        private readonly UsuarioRepository _usuarioRepository;

        public AccesoServices(UsuarioRepository usuarioRepository)
        {
            _usuarioRepository = usuarioRepository;
        }


        #region Usuario
        public ServiceResult ListUsuarios()
        {
            var result = new ServiceResult();
            try
            {
                var lost = _usuarioRepository.List();
                return result.Ok(lost);
            }
            catch (Exception ex)
            {
                return result.Error(ex.Message);
            }
        }


        public ServiceResult Login(string Usuario, string Contra)
        {
            var result = new ServiceResult();
            try
            {
                var lost = _usuarioRepository.Login(Usuario, Contra);
                return result.Ok(lost);
            }
            catch (Exception ex)
            {
                return result.Error(ex.Message);
            }
        }




        public ServiceResult InsertarUsuarios(tbUsuarios item)
        {
            var result = new ServiceResult();
            try
            {
                var lost = _usuarioRepository.Insert(item);
                if (lost.CodeStatus > 0)
                {
                    return result.Ok(lost);
                }
                else
                {
                    return result.Error(lost);
                }
            }
            catch (Exception ex)
            {
                return result.Error(ex.Message);
            }
        }






        public ServiceResult ListUsuar(int id)
        {
            var result = new ServiceResult();
            try
            {
                var list = _usuarioRepository.List(id);

                return result.Ok(list);
            }
            catch (Exception ex)
            {
                return result.Error(ex);
            }
        }



        public ServiceResult EliminarUsuarios(int id, int usuario, DateTime fecha)
        {
            var result = new ServiceResult();
            try
            {
                var lost = _usuarioRepository.EliminarUsuarios(id, usuario, fecha);
                if (lost.CodeStatus > 0)
                {
                    return result.Ok(lost);
                }
                else
                {
                    return result.Error(lost);
                }
            }
            catch (Exception ex)
            {
                return result.Error(ex.Message);
            }
        }

        public ServiceResult ActualizarUsuarios(tbUsuarios item)
        {
            var result = new ServiceResult();
            try
            {
                var lost = _usuarioRepository.Update(item);
                if (lost.CodeStatus > 0)
                {
                    return result.Ok(lost);
                }
                else
                {
                    return result.Error(lost);
                }
            }
            catch (Exception ex)
            {
                return result.Error(ex.Message);
            }
        }



        public ServiceResult Restablecer(int Usua_Id, string Usua_Clave, int usuario, DateTime fecha)
        {
            var result = new ServiceResult();
            try
            {
                var lost = _usuarioRepository.Restablecer(Usua_Id, Usua_Clave, usuario, fecha);
                return result.Ok(lost);
            }
            catch (Exception ex)
            {
                return result.Error(ex.Message);
            }
        }



        #endregion

    }
}

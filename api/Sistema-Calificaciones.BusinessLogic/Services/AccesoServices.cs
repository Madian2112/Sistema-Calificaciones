using Sistema_Calificaciones.Common.Models;
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
        private readonly RolRepository _rolRepository;

        public AccesoServices(UsuarioRepository usuarioRepository, RolRepository rolRepository)
        {
            _usuarioRepository = usuarioRepository;
            _rolRepository = rolRepository;
        }


        #region Usuario
        public IEnumerable<UsuarioViewModel> ListUsuarios()
        {
            try
            {
                var usuarios = _usuarioRepository.List();
                return usuarios;
            }
            catch (Exception ex)
            {
                Console.WriteLine($"errorrr: {ex.Message}");

                throw;
            }
        }

        public IEnumerable<UsuarioViewModel> ListRoless()
        {
            try
            {
                var usuarios = _usuarioRepository.RolList();
                return usuarios;
            }
            catch (Exception ex)
            {
                Console.WriteLine($"errorrr: {ex.Message}");

                throw;
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

        public ServiceResult EnviarCodigo(string usuario)
        {
            var result = new ServiceResult();
            try
            {
                var list = _usuarioRepository.EnviarCodigo(usuario);

                return result.Ok(list);
            }
            catch (Exception ex)
            {
                return result.Error(ex);
            }
        }

        public ServiceResult VerificarCodigo(string usuario, string codigo)
        {
            var result = new ServiceResult();
            try
            {
                var list = _usuarioRepository.VerificarCodigo(usuario, codigo);

                return result.Ok(list);
            }
            catch (Exception ex)
            {
                return result.Error(ex);
            }
        }

        public ServiceResult EliminarUsuarios(int usua_Id, int usuario, DateTime fecha)
        {
            var result = new ServiceResult();
            try
            {
                var lost = _usuarioRepository.EliminarUsuarios(usua_Id, usuario, fecha);
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

        #region Roles
        public ServiceResult ListRoles()
        {
            var result = new ServiceResult();
            try
            {
                var lost = _rolRepository.List();
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

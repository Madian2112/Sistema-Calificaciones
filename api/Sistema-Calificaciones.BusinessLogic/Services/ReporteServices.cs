using Sistema_Calificaciones.DataAccess.Repository;
using Sistema_Calificaciones.Entities.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Sistema_Calificaciones.BusinessLogic.Services
{
   public class ReporteServices
    {


        private readonly ReporteRepository _reporteRepository;

        public ReporteServices(ReporteRepository reporteRepository )
        {
            _reporteRepository = reporteRepository;
        }


        #region Reportes
      

        public ServiceResult CafiAlumno(int id)
        {
            var result = new ServiceResult();
            try
            {
                var list = _reporteRepository.List(id);

                return result.Ok(list);
            }
            catch (Exception ex)
            {
                return result.Error(ex);
            }
        }









        public ServiceResult Cafiparcial(int id)
        {
            var result = new ServiceResult();
            try
            {
                var list = _reporteRepository.Listparcial(id);

                return result.Ok(list);
            }
            catch (Exception ex)
            {
                return result.Error(ex);
            }
        }






        public ServiceResult EStadoCalificacion(int id)
        {
            var result = new ServiceResult();
            try
            {
                var list = _reporteRepository.EstadoCalificacion(id);

                return result.Ok(list);
            }
            catch (Exception ex)
            {
                return result.Error(ex);
            }
        }




        public ServiceResult alumnoPadre(int id)
        {
            var result = new ServiceResult();
            try
            {
                var list = _reporteRepository.ListAlumnos(id);

                return result.Ok(list);
            }
            catch (Exception ex)
            {
                return result.Error(ex);
            }
        }






        public ServiceResult mestroreporte(int id)
        {
            var result = new ServiceResult();
            try
            {
                var list = _reporteRepository.ListAlumnos(id);

                return result.Ok(list);
            }
            catch (Exception ex)
            {
                return result.Error(ex);
            }
        }





        public ServiceResult ReportesProfe(int id)
        {
            var result = new ServiceResult();
            try
            {
                var list = _reporteRepository.Reporte(id);

                return result.Ok(list);
            }
            catch (Exception ex)
            {
                return result.Error(ex);
            }
        }

        public ServiceResult estadisticaReporte(int id)
        {
            var result = new ServiceResult();
            try
            {
                var list = _reporteRepository.conteoreporte(id);

                return result.Ok(list);
            }
            catch (Exception ex)
            {
                return result.Error(ex);
            }
        }











        public ServiceResult InsertarReporte(tbReportesPorMaestros item)
        {
            var result = new ServiceResult();
            try
            {
                var lost = _reporteRepository.Insert(item);
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






        public ServiceResult ListreporteM(int id)
        {
            var result = new ServiceResult();
            try
            {
                var list = _reporteRepository.Listr(id);

                return result.Ok(list);
            }
            catch (Exception ex)
            {
                return result.Error(ex);
            }
        }



        public ServiceResult EliminarReporte(int rema_Id, int usuario, DateTime fecha)
        {
            var result = new ServiceResult();
            try
            {
                var lost = _reporteRepository.EliminarReporte(rema_Id, usuario, fecha);
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

        public ServiceResult ActualizarReporte(tbReportesPorMaestros item)
        {
            var result = new ServiceResult();
            try
            {
                var lost = _reporteRepository.Update(item);
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






        #endregion





        #region ddl
        public ServiceResult Listmateria()
        {
            var result = new ServiceResult();
            try
            {
                var lost = _reporteRepository.Listmate();
                return result.Ok(lost);
            }
            catch (Exception ex)
            {
                return result.Error(ex.Message);
            }
        }





        public ServiceResult Listalumno()
        {
            var result = new ServiceResult();
            try
            {
                var lost = _reporteRepository.Listalumno();
                return result.Ok(lost);
            }
            catch (Exception ex)
            {
                return result.Error(ex.Message);
            }
        }





        public ServiceResult Listreporte()
        {
            var result = new ServiceResult();
            try
            {
                var lost = _reporteRepository.Listrepor();
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

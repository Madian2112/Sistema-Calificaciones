using Sistema_Calificaciones.DataAccess.Repository;
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





        #endregion
    }
}

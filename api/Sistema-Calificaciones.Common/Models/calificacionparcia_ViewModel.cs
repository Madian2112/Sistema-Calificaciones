using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Sistema_Calificaciones.Common.Models
{
   public class calificacionparcia_ViewModel
    {

        public int Alum_Id { get; set; }
        public string Alumno { get; set; }
        public string Materia { get; set; }
        public decimal? Parcial1 { get; set; }
        public decimal? Parcial2 { get; set; }
        public decimal? Parcial3 { get; set; }


    }
}

using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Sistema_Calificaciones.Common.Models
{
   public class CalificacionesAlumnoViewModel
    {
        public int CapA_Id { get; set; }
        public int? Alum_Id { get; set; }
        public int? Mate_Id { get; set; }
        public int? Maes_Id { get; set; }
        public decimal? CapA_Calficacion { get; set; }
        public int? CapA_Creacion { get; set; }
        public DateTime? CapA_FechaCreacion { get; set; }
        public int? CapA_Modificacion { get; set; }
        public DateTime? CapA_FechaModificacion { get; set; }
        public bool? CapA_Estado { get; set; }




        [NotMapped]
        public string Alumno { get; set; }
        [NotMapped]

        public string Materia { get; set; }
        [NotMapped]

        public string Calificacion { get; set; }
        [NotMapped]

        public string Estado { get; set; }
    }
}

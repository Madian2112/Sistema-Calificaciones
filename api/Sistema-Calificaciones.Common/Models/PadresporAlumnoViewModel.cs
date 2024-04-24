using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Sistema_Calificaciones.Common.Models
{
    public class PadresporAlumnoViewModel
    {
        public int PaAl_Id { get; set; }
        public int? Padr_Id { get; set; }
        public int? Alum_Id { get; set; }
        public int? PaAl_Creacion { get; set; }
        public DateTime? PaAl_FechaCreacion { get; set; }
        public int? PaAl_Modificacion { get; set; }
        public DateTime? PaAl_FechaModificacion { get; set; }
        public bool? PaAl_Estado { get; set; }
        [NotMapped]
        public string Nombre_Padre { get; set; }

        [NotMapped]
        public string Nombre_Alumno { get; set; }
        [NotMapped]
        public string Curso { get; set; }
    }
}

using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Sistema_Calificaciones.Common.Models
{
    public class RolViewModel
    {
        public int Role_Id { get; set; }
        public string Role_Descripcion { get; set; }
        public int? Role_Creacion { get; set; }
        public DateTime? Role_FechaCreacion { get; set; }
        public int? Role_Modificacion { get; set; }
        public DateTime? Role_FechaModificacion { get; set; }
        public bool? Role_Estado { get; set; }
    }
}

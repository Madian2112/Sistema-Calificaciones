using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Sistema_Calificaciones.Common.Models
{
   public class UsuarioViewModel
    {

        public int Usua_Id { get; set; }
        public string Usua_Usuario { get; set; }
        public string Usua_Clave { get; set; }
        public int? Role_Id { get; set; }
        public bool? Usua_EsAdmin { get; set; }
        public int? Usua_Creacion { get; set; }
        public DateTime? Usua_FechaCreacion { get; set; }
        public int? Usua_Modificacion { get; set; }
        public DateTime? Usua_FechaModificacion { get; set; }
        public bool? Usua_Estado { get; set; }

        [NotMapped]
        public string Role_Descripcion { get; set; }

        [NotMapped]
        public string usua_creac { get; set; }

        [NotMapped]
        public string usua_modi { get; set; }

    }
}

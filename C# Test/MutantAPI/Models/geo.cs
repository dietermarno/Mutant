using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace MutantAPI.Models
{
    /// <summary>
    /// Dados de geolocalização do endereço do usuário
    /// </summary>
    public class geo
    {
        /// <summary>
        /// Latitude
        /// </summary>
        public string lat { get; set; }
        /// <summary>
        /// Longitude
        /// </summary>
        public string lng { get; set; }
    }
}
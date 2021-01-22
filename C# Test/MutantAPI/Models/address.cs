using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace MutantAPI.Models
{
    /// <summary>
    /// Endereço de um usuário
    /// </summary>
    public class address
    {
        /// <summary>
        /// Nome do logradouro
        /// </summary>
        public string street { get; set; }
        /// <summary>
        /// Número da suíte
        /// </summary>
        public string suite { get; set; }
        /// <summary>
        /// Nome da cidade
        /// </summary>
        public string city { get; set; }
        /// <summary>
        /// Código postal
        /// </summary>
        public string zipcode { get; set; }
        /// <summary>
        /// Geolocalização
        /// </summary>
        public geo geo { get; set; }
        /// <summary>
        /// Construtor da classe
        /// </summary>
        public address()
        {
            geo = new geo();
        }
    }
}
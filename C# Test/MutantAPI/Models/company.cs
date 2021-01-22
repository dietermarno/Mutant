using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace MutantAPI.Models
{
    /// <summary>
    /// Dados da empresa de um usuário
    /// </summary>
    public class company
    {
        /// <summary>
        /// Nome da empresa
        /// </summary>
        public string name { get; set; }
        /// <summary>
        /// Frase de efeito
        /// </summary>
        public string catchPhrase { get; set; }
        /// <summary>
        /// Search keys
        /// </summary>
        public string bs { get; set; }
    }
}
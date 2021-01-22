using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace MutantAPI.Models
{
    /// <summary>
    /// Dados de resultado de gravação
    /// </summary>
    public class saveUsersDataResult
    {
        /// <summary>
        /// Qantidade total de registros gravados
        /// </summary>
        public int totalRecords { get; set; }
        /// <summary>
        /// Status geral da gravação
        /// </summary>
        public bool status { get; set; }
        /// <summary>
        /// Mensagem declarativa
        /// </summary>
        public string message { get; set; }
    }
}
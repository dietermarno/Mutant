using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace MutantAPI.Models
{
    /// <summary>
    /// Dados o usuário
    /// </summary>
    public class user
    {
        /// <summary>
        /// ID do usuário (chave primária)
        /// </summary>
        public int id { get; set; }
        /// <summary>
        /// Nome do usuário
        /// </summary>
        public string name { get; set; }
        /// <summary>
        /// Identificação para conexão
        /// </summary>
        public string username { get; set; }
        /// <summary>
        /// Endereço de e-mail
        /// </summary>
        public string email { get; set; }
        /// <summary>
        /// Número do telefone
        /// </summary>
        public string phone { get; set; }
        /// <summary>
        /// Endereço do website
        /// </summary>
        public string website { get; set; }
        /// <summary>
        /// Endereço do usuário
        /// </summary>
        public address address { get; set; }
        /// <summary>
        /// Dados da companhia/empresa
        /// </summary>
        public company company { get; set; }
        /// <summary>
        /// Construtor da classe
        /// </summary>
        public user()
        {
            address = new address();
            company = new company();
        }
    }
}
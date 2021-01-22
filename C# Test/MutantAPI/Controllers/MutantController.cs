using System.IO;
using System.Web.Http;
using System.Configuration;
using System.Linq;
using MutantAPI.Models;
using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;

namespace MutantAPI.Controllers
{
    /// <summary>
    /// Controller Desafio C# Mutant
    /// </summary>
    [Route("Mutant")]
    public class MutantController : ApiController
    {
        /// <summary>
        /// Salva registros JSON obtidos a partir da API em https://jsonplaceholder.typicode.com/users
        /// </summary>
        /// <param name="usersData"></param>
        /// <returns>saveUsersDataResult</returns>
        [HttpPost]
        [Route("Mutant/SaveUsersData")]
        public saveUsersDataResult SaveUsersData([FromBody] user[] usersData)
        {
            AppendToLog("Info", "Processo de gravação iniciado");
            try
            {
                //*** Recebeu dados?
                if (usersData == null || usersData?.Length == 0)
                {
                    AppendToLog("Error", "Não recebeu dados válidos");
                    return new saveUsersDataResult
                    {
                        message = "No data received. Verify JSON data.",
                        totalRecords = 0,
                        status = false,
                    };
                }

                //*** Filtra registros
                AppendToLog("Info", "Filtrando usuários (apenas suites)...");
                IEnumerable<user> usersDataFiltered = usersData.Where(u => u.address.suite.Contains("Suite"));

                //*** Restaram dados depois do filtro?
                if (!usersDataFiltered.Any())
                {
                    AppendToLog("Info", "Não há usuários acomodados em suites");
                    return new saveUsersDataResult
                    {
                        message = "After filter, no data left.",
                        totalRecords = 0,
                        status = false,
                    };
                }

                //*** Obtem string e realiza conexão
                AppendToLog("Info", "Conectando ao banco de dados...");
                string connectionString = ConfigurationManager.AppSettings["dbConnection"];
                MySqlConnection oConnection = new MySqlConnection(connectionString);
                oConnection.Open();

                //*** Cria comando SQL e parâmetros para usuáros
                MySqlCommand oCommandUserInfo = new MySqlCommand(string.Empty, oConnection);
                oCommandUserInfo.Parameters.Add(new MySqlParameter("id", MySqlDbType.Int32));
                oCommandUserInfo.Parameters.Add(new MySqlParameter("name", MySqlDbType.VarChar));
                oCommandUserInfo.Parameters.Add(new MySqlParameter("username", MySqlDbType.VarChar));

                //*** Cria comando SQL e parâmetros para endereços
                MySqlCommand oCommandUserAddress = new MySqlCommand(string.Empty, oConnection);
                oCommandUserAddress.Parameters.Add(new MySqlParameter("id", MySqlDbType.Int32));
                oCommandUserAddress.Parameters.Add(new MySqlParameter("userid", MySqlDbType.Int32));
                oCommandUserAddress.Parameters.Add(new MySqlParameter("street", MySqlDbType.VarChar));
                oCommandUserAddress.Parameters.Add(new MySqlParameter("suite", MySqlDbType.VarChar));
                oCommandUserAddress.Parameters.Add(new MySqlParameter("city", MySqlDbType.VarChar));
                oCommandUserAddress.Parameters.Add(new MySqlParameter("zipCode", MySqlDbType.VarChar));
                oCommandUserAddress.Parameters.Add(new MySqlParameter("geoLat", MySqlDbType.VarChar));
                oCommandUserAddress.Parameters.Add(new MySqlParameter("geoLng", MySqlDbType.VarChar));

                //*** Cria comando SQL e parâmetros para contatos
                MySqlCommand oCommandUserContact = new MySqlCommand(string.Empty, oConnection);
                oCommandUserContact.Parameters.Add(new MySqlParameter("id", MySqlDbType.Int32));
                oCommandUserContact.Parameters.Add(new MySqlParameter("userid", MySqlDbType.Int32));
                oCommandUserContact.Parameters.Add(new MySqlParameter("email", MySqlDbType.VarChar));
                oCommandUserContact.Parameters.Add(new MySqlParameter("phone", MySqlDbType.VarChar));
                oCommandUserContact.Parameters.Add(new MySqlParameter("website", MySqlDbType.VarChar));

                //*** Cria comando SQL e parâmetros para contatos
                MySqlCommand oCommandUserCompany = new MySqlCommand(string.Empty, oConnection);
                oCommandUserCompany.Parameters.Add(new MySqlParameter("id", MySqlDbType.Int32));
                oCommandUserCompany.Parameters.Add(new MySqlParameter("userid", MySqlDbType.Int32));
                oCommandUserCompany.Parameters.Add(new MySqlParameter("name", MySqlDbType.VarChar));
                oCommandUserCompany.Parameters.Add(new MySqlParameter("catchPhrase", MySqlDbType.VarChar));
                oCommandUserCompany.Parameters.Add(new MySqlParameter("bs", MySqlDbType.VarChar));

                //*** Anula registros anteriores
                oCommandUserAddress.CommandText = "DELETE FROM userAddress";
                oCommandUserAddress.ExecuteNonQuery();
                oCommandUserCompany.CommandText = "DELETE FROM userCompany";
                oCommandUserCompany.ExecuteNonQuery();
                oCommandUserContact.CommandText = "DELETE FROM userContact";
                oCommandUserContact.ExecuteNonQuery();
                oCommandUserInfo.CommandText = "DELETE FROM userInfo";
                oCommandUserInfo.ExecuteNonQuery();

                //*** Define comandos de inserção
                oCommandUserInfo.CommandText = "INSERT INTO userInfo (id, name, username) VALUES (@id, @name, @username)";
                oCommandUserAddress.CommandText = "INSERT INTO userAddress " +
                    "(id, userId, street, suite, city, zipCode, geoLat, geoLng) VALUES " +
                    "(@id, @userId, @street, @suite, @city, @zipCode, @geoLat, @geoLng)";
                oCommandUserContact.CommandText = "INSERT INTO userContact " +
                    "(id, userId, email, phone, website) VALUES (@id, @userId, @email, @phone, @website)";
                oCommandUserCompany.CommandText = "INSERT INTO userCompany " +
                    "(id, userId, name, catchPhrase, bs) VALUES (@id, @userId, @name, @catchPhrase, @bs)";

                //*** Realiza inserções
                foreach (user user in usersDataFiltered)
                {
                    //*** Insere usuario
                    AppendToLog("Info", $"Salvando registro de usuario: {user.name}");
                    oCommandUserInfo.Parameters["id"].Value = user.id;
                    oCommandUserInfo.Parameters["name"].Value = user.name;
                    oCommandUserInfo.Parameters["username"].Value = user.username;
                    oCommandUserInfo.ExecuteNonQuery();

                    //*** Insere endereço
                    AppendToLog("Info", $"Salvando registro de endereço: {user.name}");
                    oCommandUserAddress.Parameters["id"].Value = null;
                    oCommandUserAddress.Parameters["userid"].Value = Convert.ToInt32(user.id);
                    oCommandUserAddress.Parameters["street"].Value = user.address.street;
                    oCommandUserAddress.Parameters["suite"].Value = user.address.suite;
                    oCommandUserAddress.Parameters["city"].Value = user.address.city;
                    oCommandUserAddress.Parameters["zipCode"].Value = user.address.zipcode;
                    oCommandUserAddress.Parameters["geoLat"].Value = user.address.geo.lat;
                    oCommandUserAddress.Parameters["geoLng"].Value = user.address.geo.lng;
                    oCommandUserAddress.ExecuteNonQuery();

                    //*** Insere contato
                    AppendToLog("Info", $"Salvando registro de contato: {user.name}");
                    oCommandUserContact.Parameters["id"].Value = null;
                    oCommandUserContact.Parameters["userid"].Value = Convert.ToInt32(user.id);
                    oCommandUserContact.Parameters["email"].Value = user.email;
                    oCommandUserContact.Parameters["phone"].Value = user.phone;
                    oCommandUserContact.Parameters["website"].Value = user.website;
                    oCommandUserContact.ExecuteNonQuery();

                    //*** Insere companhia
                    AppendToLog("Info", $"Salvando registro de companhia: {user.name}");
                    oCommandUserCompany.Parameters["id"].Value = null;
                    oCommandUserCompany.Parameters["userid"].Value = Convert.ToInt32(user.id);
                    oCommandUserCompany.Parameters["name"].Value = user.company.name;
                    oCommandUserCompany.Parameters["catchPhrase"].Value = user.company.catchPhrase;
                    oCommandUserCompany.Parameters["bs"].Value = user.company.bs;
                    oCommandUserCompany.ExecuteNonQuery();
                }

                AppendToLog("Info", $"Processo de gravação encerrado: {usersDataFiltered.Count()} registros inseridos.");
                return new saveUsersDataResult
                {
                    message = "Records succefully inserted.",
                    totalRecords = usersDataFiltered.Count(),
                    status = true,
                };
            }
            catch(Exception oEx)
            {
                AppendToLog("Error", $"Um erro aconteceu durante o processo: {oEx.Message}");
                return new saveUsersDataResult
                {
                    message = $"An error occur during process: {oEx.Message}",
                    totalRecords = 0,
                    status = false,
                };
            }
        }
        /// <summary>
        /// Salva linhas de log em arquivo de log diário
        /// </summary>
        /// <param name="logType"></param>
        /// <param name="logText"></param>
        void AppendToLog(string logType, string logText)
        {
            try
            {
                //*** Escreve linha atual no LOG diário
                string filePath = Directory.GetParent(Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData)).FullName;
                filePath = Path.Combine(filePath, "MutantLog");
                if (!Directory.Exists(filePath))
                    Directory.CreateDirectory(filePath);
                filePath = Path.Combine(filePath, $"{DateTime.Now.ToString("yyyymmdd")}.log");
                string logData = $"[{DateTime.Now.ToString("dd/mm/yyyy HH:mm:ss")}] - {logType} - {logText}\r\n";
                File.AppendAllText(filePath, logData);
            } catch { }
        }
    }
}

using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using System.Web.Http.Results;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using MutantAPI.Controllers;
using MutantAPI.Models;

namespace UnitTestProject
{
    [TestClass]
    public class TestMutantController
    {
        [TestMethod]
        public void SaveOneUser()
        {
            //*** Inclusão de apenas um usuário
            var oUsersData = GetUsers();
            var oController = new MutantController();

            var result = oController.SaveUsersData(oUsersData);
            Assert.AreEqual(result.totalRecords, oUsersData.Length);
        }

        [TestMethod]
        public void SaveOneUserIncorrectSuite()
        {
            //*** Inclusão de apenas um usuário
            var oUsersData = GetUsers();
            var oController = new MutantController();

            oUsersData[0].address.suite = "Apartment";
            var result = oController.SaveUsersData(oUsersData);
            Assert.AreEqual(result.message, "After filter, no data left.");
        }

        [TestMethod]
        public void NoData()
        {
            //*** Inclusão de apenas um usuário
            user[] oUsersData = new user[0];
            var oController = new MutantController();

            var result = oController.SaveUsersData(oUsersData);
            Assert.AreEqual(result.message, "No data received. Verify JSON data.");
        }

        public user[] GetUsers()
        {
            user[] userArray = new user[]
            {
                new user()
                {
                    id = 1,
                    name  = "user 1",
                    username = "user1",
                    email = "email@address.com",
                    phone = "+5551999315862",
                    website = "http://www;customdev.com.br",
                    address = new address()
                    {
                        street  = "Nowhere street, 000",
                        city = "City name",
                        suite = "Suite 001",
                        zipcode = "90000-000",
                        geo = new geo()
                        {
                            lat = "23.2322",
                            lng = "-12.2211"
                        }
                    },
                    company = new company()
                    {
                        name = "Company name",
                        catchPhrase = "Hello world!",
                        bs = "developer, c#, web"
                    }
                }
            };
            return userArray;
        }
    }
}

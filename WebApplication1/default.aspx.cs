using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;
using Oracle.DataAccess.Client;

namespace WebApplication1
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        string fromTable;
        OracleConnection con;
        protected void Page_Load(object sender, EventArgs e)
        {
            string connectionString = "Data Source=localhost:1521/xe;User ID=bloodBank;Password=123;";
            con = new OracleConnection(connectionString);
            con.Open();
        }



        protected void signinButton_Click(object sender, EventArgs e)
        {
            fromTable = identification.SelectedValue;
            string uname = username.Text;
            string pw = password.Text;
            errorLabel.Visible = false;
            string query, IDquery, targetPage;

            switch (fromTable)
            {
                case "Organization":
                    query = "SELECT COUNT(*) FROM organization WHERE OrgUname = :uname AND OrgPw = :pw";
                    IDquery = "SELECT OrgID FROM organization WHERE OrgUname = :uname";
                    targetPage = "organization.aspx";
                    break;
                case "Receptionist":
                    query = "SELECT COUNT(*) FROM receptionist WHERE EmpUname = :uname AND EmpPw = :pw";
                    IDquery = "SELECT EmpID FROM receptionist WHERE EmpUname = :uname";
                    targetPage = "receptionist.aspx";
                    break;
                default: 
                    query = "SELECT COUNT(*) FROM physician WHERE DrUname = :uname AND DrPw = :pw";
                    IDquery = "SELECT DrID FROM physician WHERE DrUname = :uname";
                    targetPage = "physician.aspx";
                    break;
            }

            OracleCommand getId = new OracleCommand(IDquery, con);
            getId.Parameters.Add("uname", uname);
            var id = getId.ExecuteScalar();
            if (id != null)
            {
                Session["ID"] = id.ToString();
            }

            OracleCommand cmd = new OracleCommand(query, con);
            cmd.Parameters.Add(new OracleParameter("uname", uname));
            cmd.Parameters.Add (new OracleParameter("pw", pw));


            int count = Convert.ToInt32(cmd.ExecuteScalar());
            if (count >= 1)
            {
                Response.Redirect(targetPage);
            }
            else
            {
                errorLabel.Visible = true;
            }
        }
    }
}
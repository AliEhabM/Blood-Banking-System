using Oracle.DataAccess.Client;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication1
{
    public partial class organization : System.Web.UI.Page
    {
        string user;
        OracleConnection con;
        protected void Page_Load(object sender, EventArgs e)
        {
            
                string connectionString = "Data Source=localhost:1521/xe;User ID=org_user1;Password=123;";
                con = new OracleConnection(connectionString);
                con.Open();
                user = Session["ID"].ToString();
                loadDatabase();
                updateGrid();
            
        }




        private void updateGrid()
        {
            string gridQuery = "SELECT to_char(r.reqdate, 'Month DD, YYYY') AS \"Request Date\"," +
                "b.BtypeName AS \"Blood Type\", r.reqAmount AS \"Requested Amount\"," +
                "to_char(r.handleddate, 'Month DD, YYYY') AS \"Handled Date\"," +
                "r.reqid AS \"Request ID\" FROM bloodbank.requests r, bloodbank.bloodtype b WHERE r.reqby = :orgID AND r.reqbloodtype = b.btypeid AND r.HandledBy IS NULL ORDER BY r.reqdate";
            OracleCommand cmd = new OracleCommand(gridQuery, con);
            cmd.Parameters.Add(new OracleParameter("orgID", user));

            using(OracleDataReader reader = cmd.ExecuteReader())
            {
                DataTable dt = new DataTable();
                dt.Load(reader);
                requestGrid.DataSource = dt;
                requestGrid.DataBind();
            }
        }

        protected void submitRequest_Click(object sender, EventArgs e)
        {
            if (String.IsNullOrWhiteSpace(amount.Text)) amount.Text = 1.ToString();
            string insertQuery = "INSERT INTO bloodbank.Requests (ReqDate, ReqBloodType, ReqAmount, ReqBy) VALUES (TO_CHAR(CURRENT_DATE, 'DD-MON-YY'), :bloodType, :amount, :orgID)";
            OracleCommand cmd = new OracleCommand(insertQuery, con);
            cmd.Parameters.Add("bloodType", bloodTypeList.SelectedValue);
            cmd.Parameters.Add("amount", amount.Text.ToString());
            cmd.Parameters.Add("orgID", user);

            cmd.ExecuteNonQuery();
            updateGrid();
        }


        private void loadDatabase()
        {
            OracleCommand cmd = new OracleCommand("SELECT * FROM bloodbank.BLOODTYPE;", con);
            OracleDataAdapter da = new OracleDataAdapter(cmd);

            DataTable dt = new DataTable();
            da.Fill(dt);

            bloodTypeList.DataSource = dt;
            bloodTypeList.DataTextField = "BTypeName";
            bloodTypeList.DataValueField = "BTypeID";

            
            bloodTypeList.DataBind();
        }

        protected void CancelRequest_Click(object sender, EventArgs e)
        {

            int rowIndex = ((GridViewRow)(sender as Control).NamingContainer).RowIndex;
            int reqID = Convert.ToInt32(requestGrid.Rows[rowIndex].Cells[5].Text);

            OracleCommand delete = new OracleCommand("DELETE FROM bloodbank.requests WHERE reqid = "+reqID, con);

            delete.ExecuteNonQuery();
            updateGrid();
        }

        protected void logout_Click(object sender, EventArgs e)
        {
            Session["ID"] = "";
            Response.Redirect("default.aspx");
        }
    }
}
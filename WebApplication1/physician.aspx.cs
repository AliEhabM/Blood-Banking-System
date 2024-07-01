using Oracle.DataAccess.Client;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication1
{
    public partial class physician : System.Web.UI.Page
    {
        OracleConnection con;
        string user;
        protected void Page_Load(object sender, EventArgs e)
        {
            string connectionString = "Data Source=localhost:1521/xe;User ID=doctor;Password=123;";
            con = new OracleConnection(connectionString);
            con.Open();
            user = Session["ID"].ToString();
            updateGrid();
        }


        private void updateGrid()
        {
            string query = "SELECT distinct t.donorid AS ID, d.donorfirstname AS \"First Name\", d.donorlastname AS \"Last Name\" FROM bloodBank.testsfor t, bloodbank.donor d WHERE t.donorid = d.donorid AND t.drid IS NULL";
            OracleCommand cmd = new OracleCommand(query, con);
            

            using (OracleDataReader reader = cmd.ExecuteReader())
            {
                DataTable dt = new DataTable();
                dt.Load(reader);
                donorTable.DataSource = dt;
                donorTable.DataBind();
            }
        }

        protected void viewer_Click(object sender, EventArgs e)
        {
            ViewState["Allow"] = true;
            int rowIndex = ((GridViewRow)(sender as Control).NamingContainer).RowIndex;
            ViewState["DonorID"] = Convert.ToInt32(donorTable.Rows[rowIndex].Cells[1].Text);

            string donorQuery = "SELECT d.DonorFirstName ||' '|| d.DonorLastName AS Name, b.btypename AS \"Blood Type\", d.phonenumber AS \"Phone Number\" FROM bloodbank.donor d, bloodbank.bloodtype b WHERE d.bloodtype = b.btypeid AND donorid = " + ViewState["DonorID"];
            OracleCommand miniView = new OracleCommand(donorQuery, con);

            using (OracleDataReader reader = miniView.ExecuteReader())
            {
                DataTable dt = new DataTable();
                dt.Load(reader);
                DonorDetails.DataSource = dt;
                DonorDetails.DataBind();
            }


            resetTests();
        }

        private void resetTests() {
            string showQuery = "SELECT t.diseaseid AS ID, d.Diseasename AS Disease, TO_CHAR(t.TestDate, 'Month DD, YYYY') AS \"Test Date\" FROM bloodbank.TestsFor t, bloodbank.disease d WHERE t.drid IS NULL AND t.donorid = :donorid AND d.diseaseid = t.diseaseid ORDER BY d.diseaseID ASC";

            OracleCommand cmd = new OracleCommand(showQuery, con);
            cmd.Parameters.Add("donorid", ViewState["DonorID"]);

            using (OracleDataReader reader = cmd.ExecuteReader())
            {
                DataTable dt = new DataTable();
                dt.Load(reader);
                testTable.DataSource = dt;
                testTable.DataBind();
            }
            updateGrid();
        }

        protected void accept_Click(object sender, EventArgs e)
        {
            int rowIndex = ((GridViewRow)(sender as Control).NamingContainer).RowIndex;
            int diseaseID = Convert.ToInt32(testTable.Rows[rowIndex].Cells[1].Text);
            string date = testTable.Rows[rowIndex].Cells[3].Text;

            string handleQuery = "UPDATE bloodbank.testsfor SET drid = :drid, testresult = 'Y' WHERE diseaseID = :diseaseID AND donorID = :donorID AND testdate = TO_DATE('" + date + "', 'Month DD, YYYY')";
            OracleCommand cmd = new OracleCommand(handleQuery, con);

            cmd.Parameters.Add("drid", user);
            cmd.Parameters.Add("diseaseID", diseaseID);
            cmd.Parameters.Add("donorID", ViewState["DonorID"]);

            cmd.ExecuteNonQuery();

            string countQuery = "SELECT COUNT(*) FROM bloodbank.TestsFor WHERE donorID = :donor AND drid IS NULL";
            OracleCommand counter = new OracleCommand(countQuery, con);
            counter.Parameters.Add("donorid", ViewState["DonorID"]);
            int count = Convert.ToInt32(counter.ExecuteScalar());
            if (count < 1 && (bool)ViewState["Allow"])
            {
                string insertion = "INSERT INTO bloodbank.bloodbaginfo (donationdate, donorid) VALUES (TO_CHAR(CURRENT_DATE, 'DD-MON-YY'), :donorid)";
                OracleCommand insert = new OracleCommand(insertion, con);
                insert.Parameters.Add("donorid", ViewState["DonorID"]);
                insert.ExecuteNonQuery();
                updateGrid();
            }
            resetTests();
        }




        protected void deny_Click(object sender, EventArgs e)
        {
            ViewState["Allow"] = false;
            int rowIndex = ((GridViewRow)(sender as Control).NamingContainer).RowIndex;
            int diseaseID = Convert.ToInt32(testTable.Rows[rowIndex].Cells[1].Text);

            string handleQuery = "UPDATE bloodbank.testsfor SET drid = :drid, testresult = 'N' WHERE diseaseID = :diseaseID AND donorID = :donorID";
            OracleCommand cmd = new OracleCommand(handleQuery, con);

            cmd.Parameters.Add("drid", user);
            cmd.Parameters.Add("diseaseID", diseaseID);
            cmd.Parameters.Add("donorID", ViewState["DonorID"]);

            cmd.ExecuteNonQuery();
            resetTests();
        }

        private DataTable Pivot(DataTable tbl)
        {
            var tblPivot = new DataTable();
            tblPivot.Columns.Add(tbl.Columns[0].ColumnName);
            for (int i = 1; i < tbl.Rows.Count; i++)
            {
                tblPivot.Columns.Add(Convert.ToString(i));
            }
            for (int col = 0; col < tbl.Columns.Count; col++)
            {
                var r = tblPivot.NewRow();
                r[0] = tbl.Columns[col].ToString();
                for (int j = 1; j < tbl.Rows.Count; j++)
                    r[j] = tbl.Rows[j][col];

                tblPivot.Rows.Add(r);
            }
            return tblPivot;
        }


        protected void logout_Click(object sender, EventArgs e)
        {
            Session["ID"] = "";
            Response.Redirect("default.aspx");
        }
    }
}
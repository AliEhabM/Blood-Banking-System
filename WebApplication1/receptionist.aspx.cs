using System;
using System.Collections.Generic;
using System.Data;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using Oracle.DataAccess.Client;

namespace WebApplication1
{
    public partial class receptionist : System.Web.UI.Page
    {
        OracleConnection con;
        string user;

        protected void Page_Load(object sender, EventArgs e)
        {
            string connectionString = "Data Source=localhost:1521/xe;User ID=recept_user1;Password=123;";
            con = new OracleConnection(connectionString);
            con.Open();
            BloodType();
            BindGridView();
            user = Session["ID"].ToString();
        }

        protected void Make_Request_Click(object sender, EventArgs e)
        {

            string firstName = fName.Text;
            string lastName = lName.Text;
            string phoneNumber = phone.Text;
            string ssn = ssid.Text;
            string bloodType = ddlBloodType.SelectedValue;


            if (!String.IsNullOrEmpty(ssn))
            {

                string countQuery = "SELECT COUNT(*) FROM bloodbank.DONOR WHERE ssid = :ssn";
                OracleCommand counter = new OracleCommand(countQuery, con);
                counter.Parameters.Add("ssn", ssn);

                int count = Convert.ToInt32(counter.ExecuteScalar());

                if (count < 1)
                {

                    string insertQuery = "INSERT INTO bloodbank.donor (donorfirstname, donorlastname, phonenumber, ssid, bloodtype) VALUES (:firstName, :lastName, :phone, :ssn, :bloodTypeId)";


                    OracleCommand cmd = new OracleCommand(insertQuery, con);
                    cmd.Parameters.Add(":donorfirstName", OracleDbType.NVarchar2).Value = firstName;
                    cmd.Parameters.Add(":donorlastName", OracleDbType.NVarchar2).Value = lastName;
                    cmd.Parameters.Add(":phoneNumber", OracleDbType.NVarchar2).Value = phoneNumber;
                    cmd.Parameters.Add(":ssn", OracleDbType.NVarchar2).Value = ssn;
                    cmd.Parameters.Add(":bloodType", OracleDbType.Int32).Value = bloodType;
                    cmd.ExecuteNonQuery();
                    successLabel.Visible = true;
                }


                string donorID = GetID(ssn);
                counter = new OracleCommand("SELECT COUNT(*) FROM bloodbank.DISEASE", con);
                count = Convert.ToInt32(counter.ExecuteScalar());
                for (int i = 1; i <= count; i++)
                {
                    string insertQuery = "INSERT INTO bloodbank.testsfor (DonorID, TestDate, DiseaseID) VALUES ("+donorID+", TO_CHAR(CURRENT_DATE, 'DD-MON-YY'), :counter)";
                    OracleCommand cmd = new OracleCommand(insertQuery, con);
                    cmd.Parameters.Add("counter", i);
                    cmd.ExecuteNonQuery();
                }
            }
        }


        private string GetID(string ssn)
        {
            string query = "SELECT donorid FROM bloodbank.donor WHERE ssid = :ssn";
            OracleCommand cmd = new OracleCommand(query, con);
            cmd.Parameters.Add("ssn", ssn);
            return cmd.ExecuteScalar().ToString();
        }


        private void BindGridView()
        {
              if (con.State == ConnectionState.Open)
                {
                    string selectQuery = "SELECT r.REQID AS \"Request ID\", TO_CHAR(r.REQDATE, 'Month DD, YYYY') \"Request Date\", r.REQAMOUNT \"Requested Amount\", b.Btypename \"Blood Type\", o.orgname \"Requested by\" FROM bloodbank.requests r, bloodbank.bloodtype b, bloodbank.organization o WHERE HandledBy IS NULL AND r.ReqBloodType = b.BTypeID AND r.reqby = o.orgid ORDER BY r.ReqDate ASC";
                    using (OracleDataAdapter adapter = new OracleDataAdapter(selectQuery, con))
                    {
                        DataTable dt = new DataTable();
                        adapter.Fill(dt);
                        GridViewRequests.DataSource = dt;
                        GridViewRequests.DataBind();
                    }
                }
                else
                {
                    Response.Write("Connection to Oracle Database failed.");
                }

        }

        // Function to get blood type ID
        private void BloodType()
        {
            OracleCommand cmd = new OracleCommand("SELECT * FROM bloodbank.BLOODTYPE", con);
            OracleDataAdapter da = new OracleDataAdapter(cmd);

            DataTable dt = new DataTable();
            da.Fill(dt);

            ddlBloodType.DataSource = dt;
            ddlBloodType.DataTextField = "BTypeName";
            ddlBloodType.DataValueField = "BTypeID";


            ddlBloodType.DataBind();
        }



        protected void accept_Click(object sender, EventArgs e)
        {

            int rowIndex = ((GridViewRow)(sender as Control).NamingContainer).RowIndex;
            int reqID = Convert.ToInt32(GridViewRequests.Rows[rowIndex].Cells[1].Text);

            string acceptQuery = "UPDATE bloodbank.requests SET handledby = :empID, handleddate = TO_CHAR(CURRENT_DATE, 'DD-MON-YY') WHERE reqid = :reqid";
            OracleCommand cmd = new OracleCommand(acceptQuery, con);

            cmd.Parameters.Add("empID", user);
            cmd.Parameters.Add("reqID", reqID);

            cmd.ExecuteNonQuery();
            Accept(reqID);
            BindGridView();
        }

        protected void deny_Click(object sender, EventArgs e)
        {

            int rowIndex = ((GridViewRow)(sender as Control).NamingContainer).RowIndex;
            int reqID = Convert.ToInt32(GridViewRequests.Rows[rowIndex].Cells[1].Text);

            string denyQuery = "UPDATE bloodbank.requests SET handledby = :empID WHERE reqid = :reqid";
            OracleCommand cmd = new OracleCommand(denyQuery, con);

            cmd.Parameters.Add("empID", user);
            cmd.Parameters.Add("reqID", reqID);

            cmd.ExecuteNonQuery();
            BindGridView();
        }


        private void Accept(int reqID)
        {
            string TempQuery = "SELECT ReqAmount FROM bloodbank.REQUESTS WHERE reqID = " + reqID;
            OracleCommand cmd = new OracleCommand(TempQuery, con);
            int amount = Convert.ToInt32(cmd.ExecuteScalar());

            TempQuery = "SELECT ReqBloodType FROM bloodbank.REQUESTS WHERE reqID = " + reqID;
            OracleCommand cmd2 = new OracleCommand(TempQuery, con);
            int bloodType = Convert.ToInt32(cmd2.ExecuteScalar());

            TempQuery = "SELECT COUNT(*) FROM bloodbank.BloodBagInfo b, bloodbank.Donor D WHERE b.IssuedTo IS NULL AND b.donorid = D.donorID AND D.bloodtype = " + bloodType;
            OracleCommand cmd3 = new OracleCommand(TempQuery, con);
            int count = Convert.ToInt32(cmd3.ExecuteScalar());

            if (amount <= count)
            {
                string secondaryQuery = "SELECT DonorID FROM donor WHERE bloodtype = "+bloodType;
                TempQuery = "UPDATE bloodbank.bloodbaginfo SET IssuedTo = " + reqID + " WHERE ROWNUM <= " + amount + " AND IssuedTo IS NULL AND donorID IN (" + secondaryQuery + ")";
                OracleCommand final = new OracleCommand(TempQuery, con);

                final.ExecuteNonQuery();
            }
            else
            {
                Response.Write("<script>alert('Not enough bags of that blood type are in stock!')</script>");
            }
        }

        protected void logout_Click(object sender, EventArgs e)
        {
            Session["ID"] = "";
            Response.Redirect("default.aspx");
        }
    }
}

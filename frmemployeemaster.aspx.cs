using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Employee
{
    public partial class frmemployeemaster : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ShowGrid();
                txtempid.Focus();
                ViewState.Add("FoundFlag", false);
            }
        }

        protected void txtempid_TextChanged(object sender, EventArgs e)
        {
            /* if (txtempid.Text == "1")
                 txtempname.Text = "sejal";
             else if (txtempid.Text == "2")
                 txtempname.Text = "Monali";
             else if (txtempid.Text == "3")
                 txtempname.Text = "Nabila";
             txtgrossal.Focus();*/
            DAL d = new DAL();
            SqlDataReader rdr = d.GetReader("select *from employeemaster where empid=" 
                +Class2.CInt(txtempid.Text));
            if (rdr != null && rdr.HasRows)
            {
                // hdnfnd.Value = "true";
                ViewState["FoundFlag"] = true;
                rdr.Read();
                txtempname.Text = rdr["empname"].ToString();
                ddesignation.Text = rdr["designation"].ToString();
                txtgrossal.Text = rdr["grosssal"].ToString();
                txtdeduct.Text = rdr["deductions"].ToString();
                txtnetsal.Text = rdr["netsal"].ToString();
                if (rdr["isactive"].ToString() == "Y")
                    chckisactive.Checked = true;
                else
                    chckisactive.Checked = false;
            }
            else
            {
                // hdnfnd.Value="false";
                ViewState["FoundFlag"] = false;
                txtempname.Text = "";
                ddesignation.SelectedIndex = 0;
                txtgrossal.Text = "";
                txtdeduct.Text = "";
                txtnetsal.Text = "";
                chckisactive.Checked = false;

            }
            txtempid.Focus();
        }
        public void ShowGrid()
        {
            DAL d = new DAL();
            DataTable dt = d.GetTable("select * from employeemaster");
            grddata.DataSource = dt;
            grddata.DataBind();
        }

        protected void grddata_RowCreated(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                e.Row.Attributes.Add("onclick", "ShowRecords(this);");
                e.Row.Style.Add("cursor:pointer;cursor:hand", "");
                e.Row.Attributes.Add("onmouseover", "SetColors(this,'Yellow');");
                e.Row.Attributes.Add("onmouseout", "SetColors(this,'White');");
            }
        }

        protected void btnsave_Click(object sender, EventArgs e)
        {
            DAL d = new DAL();
            d.ClearParameters();
            d.AddParameters("empid", Class2.CInt(txtempid.Text).ToString());
            d.AddParameters("empname", txtempname.Text);
            d.AddParameters("designation", ddesignation.Text.ToString());
            d.AddParameters("grosssal", txtgrossal.Text);
            d.AddParameters("deductions",txtdeduct.Text);
            d.AddParameters("netsal", txtnetsal.Text);
            d.AddParameters("isactive", chckisactive.Checked ? "Y" : "N");
            d.isPROcall = true;
            if ((bool)ViewState["FoundFlag"])
            {
                d.AddParameters("action", "update");
            }
            else
            {
                d.AddParameters("action", "insert");
            }
            int res = d.ExecuteQuery("pr_empmaster");
            if(res > 0)
            {
                Response.Write("Record Saved Successfully");
            }
            else
            {
                Response.Write("Record Not Saved Successfully");
            }
            ShowGrid();
        }

        protected void btncancel_Click(object sender, EventArgs e)
        {
            hdnfnd.Value = "false";
        }

        protected void btndelete_Click(object sender, EventArgs e)
        {
            DAL d = new DAL();
            d.ClearParameters();
            d.AddParameters("empid", Class2.CInt(txtempid.Text).ToString());
            d.isPROcall = true;
            d.AddParameters("action", "delete");
            int res = d.ExecuteQuery("pr_empmaster");
            if (res > 0)
            {
                Response.Write("Record Deleted Successfully");
                txtempid.Text = "";
                txtempname.Text = "";
                ddesignation.SelectedIndex = 0;
                txtgrossal.Text = "";
                txtdeduct.Text = "";
                txtnetsal.Text = "";
                chckisactive.Checked = false;
            }
            else
            {
                Response.Write("Record Can Not Be Deleted");
            }
            ShowGrid();
        }
        /* protected void txtdeduct_TextChanged(object sender, EventArgs e)
{
double netsal = Class2.CDouble(txtgrossal.Text) -
Class2.CDouble(txtdeduct.Text);
txtnetsal.Text = netsal.ToString("0.00");
chckisactive.Focus();
}*/
    }
}
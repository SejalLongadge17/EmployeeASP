<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="frmemployeemaster.aspx.cs" Inherits="Employee.frmemployeemaster" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <script type="text/javascript">
        function CalculateSalary()
        {
            var grossal = document.getElementById("MainContent_txtgrossal").value;
            var deductions = document.getElementById("MainContent_txtdeduct").value;
            document.getElementById("MainContent_txtnetsal").value =grossal-deductions;
        }
        function ClearControls()
        {
           /* document.getElementById("MainContent_txtempid").value = "";
            document.getElementById("MainContent_txtempname").value = "";
            document.getElementById("MainContent_txtgrossal").value = "";
            document.getElementById("MainContent_txtdeduct").value = "";
            document.getElementById("MainContent_txtnetsal").value = "";
            document.getElementById("MainContent_chckisactive").checked = false;
            */

            var ctrls = document.getElementsByTagName('INPUT');
            for (var i = 0; i < ctrls.length; i++)
            {
                if (ctrls[i].id.indexOf('MainContent') >= 0 && ctrls[i].type == 'text')
                {
                    ctrls[i].value = '';
                }
                else if (ctrls[i].id.indexOf('MainContent') >= 0 && ctrls[i].type == 'checkbox')
                {
                    ctrls[i].checked = false;
                }                   
            }
            return false;
        }
        function validatecontrols()
        {
            var returnflag = true;
            if (document.getElementById("MainContent_txtempid").value == '')
            {
                alert("Please Enter Employee ID");
                document.getElementById('MainContent_txtempid').focus();
                returnflag = false;
            }
            else if (document.getElementById("MainContent_txtempname").value == '')
            {
                alert("Please Enter Employee Name");
                document.getElementById('MainContent_txtempname').focus();
                returnflag = false;
            }
            else if (document.getElementById("MainContent_txtgrossal").value == '')
            {
                alert("Please Enter Employee Gross Salary");
                document.getElementById('MainContent_txtgrossal').focus();
                returnflag = false;
            }
            else if (document.getElementById("MainContent_txtdeduct").value == '')
            {
                alert("Please Enter Employee Salary Deductions");
                document.getElementById('MainContent_txtdeduct').focus();
                returnflag = false;
            }
            else if (document.getElementById("MainContent_txtnetsal").value == '') {
                alert("Netsalary cant be Empty");
                document.getElementById('MainContent_txtnetsal').focus();
                returnflag = false;
            }
        }
        function validatefields(ctrls, datatype, e)
        {
            debugger;
            var returnflg = true;

            if (datatype == 'int')
            {
                var nums = '0123456789\b';
                if (nums.indexOf(e.key.toString()) == -1)
                    returnflg = false;
            }
            else if (datatype == 'string')
            {
                var nums = 'abcdefghijklmnopqrstuvwxyz .@-\b';
                if (nums.indexOf(e.key.toString().toLowerCase()) == -1)
                {
                    returnflg = false;
                }

                if (ctrls.value.split(' ').length >= 3 && e.key == ' ')
                {
                    returnflg = false;
                }
            }
            else if (datatype == 'double')
            {
                var nums = '0123456789.\b';
                if (nums.indexOf(e.key.toString()) == -1)
                {
                    returnflg = false;
                }

                if (ctrls.value.indexOf('.') >= 3 && e.key == '.')
                {
                    returnflg = false;
                }
            }
            return returnflg;
        }
        function SetColors(Row,Color)
        {
            debugger;
            Row.style.backgroundColor = Color;
        }
        function ShowRecords(Row)
        {
            document.getElementById('MainContent_txtempid').value = Row.childern[0].innerHTML;
            document.getElementById('MainContent_txtempname').value = Row.childern[1].innerHTML;
            document.getElementById('MainContent_ddesignation').value = Row.childern[2].innerHTML;
            document.getElementById('MainContent_txtgrossal').value = Row.childern[3].innerHTML;
            document.getElementById('MainContent_txtdeduct').value = Row.childern[4].innerHTML;
            document.getElementById('MainContent_txtnetsal').value = Row.childern[5].innerHTML;

            if (Row.childern[6].innerHTML == 'Y')
            {
                document.getElementById('MainContent_chckisactive').checked = true;
            }
            else
            {
                document.getElementById('MainContent_chckisactive').checked = false;
            }
        }
    </script>
    Employee Master Entry
    <table border="1" style="width:100%">
        <tr>
            <th>EmployeeID</th>
            <td>
                <asp:TextBox ID="txtempid" runat="server" OnTextChanged="txtempid_TextChanged" AutoPostBack="True" onkeypress="return validatefields(this,'int',event);"></asp:TextBox>
            </td>
        </tr>
         <tr>
             <th>Employee Name</th>
             <td>
                 <asp:HiddenField ID="hdnfnd" runat="server" Value="false" />
                 <asp:TextBox ID="txtempname" runat="server" onkeypress="return validatefields(this,'string',event);"></asp:TextBox>
             </td>
        </tr>
        
         <tr>
             <th>Designation</th>
             <td>
                 <asp:DropDownList ID="ddesignation" runat="server">
                     <asp:ListItem>Senior Project Manager</asp:ListItem>
                     <asp:ListItem Selected="true">Developer</asp:ListItem>
                     <asp:ListItem>Analyst</asp:ListItem>
                     <asp:ListItem>Tester</asp:ListItem>
                     <asp:ListItem>Team Lead</asp:ListItem>
                 </asp:DropDownList>

             </td>
        </tr>
         <tr>
           <th>Gross Salary</th>
            <td>
                <asp:TextBox ID="txtgrossal" runat="server" onkeypress="return validatefields(this,'double',event);"></asp:TextBox>
           </td>
         </tr>
         <tr>
             <th>Deductions</th>
             <td>
                 <asp:TextBox ID="txtdeduct" runat="server" onblur="CalculateSalary();" onkeypress="return validatefields(this,'double',event);"></asp:TextBox>
             </td>
        </tr>
         <tr>
             <th>NetSalary</th>
             <td>
                 <asp:TextBox ID="txtnetsal" runat="server" onkeypress="return validatefields(this,'double',event);"></asp:TextBox>
             </td>
        </tr>
         <tr>
             <th>Is Active</th>
             <td>
                 <asp:CheckBox ID="chckisactive" runat="server" />
             </td>
        </tr>
         <tr>
             <th>&nbsp;</th>
             <td>
                 <asp:Button ID="btnsave" runat="server" OnClientClick="return validatecontrols();" Text="Save" OnClick="btnsave_Click"/>&nbsp;
                 <asp:Button ID="btncancel" runat="server" OnClientClick="return ClearControls();" Text="Cancel" OnClick="btncancel_Click"/>&nbsp;
                 <asp:Button ID="btndelete" runat="server" Text="Delete" OnClientClick="return confirm('Do you want to delete a record');" OnClick="btndelete_Click" />
             </td>
        </tr>
        <tr>
            <td colspan="2">
            <asp:GridView ID="grddata" runat="server" Height="211px" OnRowCreated="grddata_RowCreated" Width="285px"></asp:GridView>
                </td>
        </tr>
    </table>
</asp:Content>

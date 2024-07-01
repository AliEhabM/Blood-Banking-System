<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="organization.aspx.cs" Inherits="WebApplication1.organization" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="UTF-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title id="title"></title>
    <link rel="stylesheet" href="Organization_Style.css"/>
</head>
<body>
     <div id="book_ticket_div">
    <form id="book_ticket_form" runat="server">
         <div id="from_div" class="div">
             <label for="Amount of Bags">Amount of Bags</label><br>
             <asp:TextBox class="from_to_class" ID="amount" runat="server" TextMode="Number" min="1" max="99"></asp:TextBox>
         </div>

         <div id="to_div" class="div">
            <label for="Blood Type">Blood Type</label><br>
             <asp:DropDownList class="from_to_class" ID="bloodTypeList" runat="server" AppendDataBoundItems="True" AutoPostBack="True"></asp:DropDownList>
         </div>

          <div id="btn_div" id="div">
              <asp:Button ID="Make_Request" runat="server" Text="Submit Request" OnClick="submitRequest_Click" />
          </div>
    
          <div id="div_of_list">
          <h2>Active Requests</h2>
              <asp:GridView ID="requestGrid" runat="server">
                  <Columns>
                      <asp:TemplateField>
                          <ItemTemplate>     <asp:LinkButton ID="CancelRequest" runat="server" OnClick="CancelRequest_Click">Cancel</asp:LinkButton></ItemTemplate>
                      </asp:TemplateField>
                  </Columns>
              </asp:GridView>

          </div>
        <asp:Button ID="logout" runat="server" Text="Log Out" OnClick="logout_Click" />
    </form>
</div>
</body>
</html>

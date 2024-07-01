<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="receptionist.aspx.cs" Inherits="WebApplication1.receptionist" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">

    <meta charset="UTF-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>homepage</title>
    <link rel="stylesheet" href="Receptionist_Style.css"/>
</head>
<body>
       <form id="book_ticket_form" runat="server">
      <div id="book_ticket_div">
          <div class="div">
              <label for="DonorInfo">Donor Info:</label><br />
              <p>First Name: <asp:TextBox runat="server" ID="fName" placeholder="First Name" MaxLength="25"></asp:TextBox></p>
              <p>Last Name: <asp:TextBox runat="server" ID="lName" placeholder="Last Name" MaxLength="25"></asp:TextBox></p>
              <p>Phone: <asp:TextBox runat="server" ID="phone" placeholder="Phone" pattern="[0-9]*" TextMode="Number" MaxLength="16"></asp:TextBox></p>
              <p>SSID: <asp:TextBox runat="server" ID="ssid" pattern="[0-9]*" TextMode="Number" MaxLength="33"></asp:TextBox></p>
              <p>Blood Type:
                  <asp:DropDownList runat="server" ID="ddlBloodType" CssClass="blood-type-dropdown">
                  </asp:DropDownList>
              </p>
          </div>
          <div class="div">
              <asp:Button runat="server" ID="Make_Request" Text="Register Donor" OnClick="Make_Request_Click" />
              <br />
              <asp:Label runat="server" Text="Donor Registered Successfully" ForeColor="#66FF33" ID="successLabel" Font-Bold="True" Visible="false"></asp:Label>
          </div>

          <div id="div_of_list">
              <h2>Requests</h2>
              <asp:GridView ID="GridViewRequests" runat="server" AutoGenerateColumns="true">
                  <Columns>
                      <asp:TemplateField>
                          <ItemTemplate>
                              <asp:LinkButton ID="accept" runat="server" OnClick="accept_Click" autopostback="false">Accept</asp:LinkButton>
                              <asp:LinkButton ID="deny" runat="server" OnClick="deny_Click" autopostback="false">Deny</asp:LinkButton>
                          </ItemTemplate>
                      </asp:TemplateField>
                  </Columns>
                </asp:GridView>
              <ol runat="server" id="list"></ol>
          </div>
          <asp:Button runat="server" ID="logout" Text="Log Out" OnClick="logout_Click" />
      </div>
  </form>
</body>
</html>

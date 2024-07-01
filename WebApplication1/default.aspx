<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="default.aspx.cs" Inherits="WebApplication1.WebForm1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Sign In</title>
    <meta charset="UTF-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <link rel="stylesheet" href="Signin_Style.css"/>    
</head>
<body>
    <form runat="server">
        <div>
            <h3>Sign-In</h3>

            <asp:Label ID="unameLabel" runat="server" Text="Username"></asp:Label>
            <asp:TextBox ID="username" runat="server" placeholder="Enter your username"></asp:TextBox>
            <br />
            <asp:Label ID="pwLabel" runat="server" Text="Password"></asp:Label>
            <asp:TextBox ID="password" runat="server" TextMode="Password" placeholder="Enter your password"></asp:TextBox>
            <br />

            <asp:Label ID="identif" runat="server" Text="You Are?"></asp:Label>
            
            <asp:DropDownList ID="identification" runat="server">
                <asp:ListItem Selected="True" Value="Organization">Organization</asp:ListItem>
                <asp:ListItem Value="Receptionist">Receptionist</asp:ListItem>
                <asp:ListItem Value="Physician">Phyisican</asp:ListItem>
            </asp:DropDownList>

            <asp:Label ID="errorLabel" runat="server" Text="Incorrect username or password. Try again." ForeColor="#CC0000" Visible="False"></asp:Label>
            <asp:Button ID="signinButton" runat="server" Text="Sign-In" OnClick="signinButton_Click" />

        </div>
    </form>
</body>
</html>

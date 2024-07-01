<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="physician.aspx.cs" Inherits="WebApplication1.physician" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link rel="stylesheet" type="text/css" href="Physician_Style.css"/>
    <title>Physician Landing</title>
</head>
<body>
    <form id="form1" runat="server">   
        <div class="grid-container">
        <div class="grid-item">
            <h2>Donors</h2>
            <asp:GridView class="Grid" ID="donorTable"  runat="server">
                <Columns>
                    <asp:TemplateField>
                        <ItemTemplate>
                             <asp:LinkButton ID="viewer" runat="server" OnClick="viewer_Click">View Tests</asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>
        <div class="grid-item">
            <h2>Tests</h2>
            <asp:GridView class="Grid" ID="testTable" runat="server">
                <Columns>
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:LinkButton ID="accept" runat="server" OnClick="accept_Click">Pass</asp:LinkButton>
                            <asp:LinkButton ID="deny" runat="server" OnClick="deny_Click">Fail</asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>
</div>
<div id="donorGroupBox">
    <asp:GridView ID="DonorDetails" runat="server"></asp:GridView>
</div>
            <asp:Button ID="logout" runat="server" Text="Log Out" OnClick="logout_Click" />

    </form>
</body>
</html>

<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Korisnik.aspx.cs" Inherits="Igraonica_za_rodjendane.Korisnik1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Home</title>
    <link href="Korisnik.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <div class="user">
            <asp:Label ID="Label1" runat="server" Text="."></asp:Label>
    </div>
    <form id="form1" runat="server">
            <asp:DropDownList ID="DropDownList1" runat="server" style="margin-top: 0px" AutoPostBack="True" OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged">
            </asp:DropDownList>
            <asp:ImageButton ID="ImageButton1" runat="server" Height="19px" ImageUrl="~/calendar.png" OnClick="ImageButton1_Click" Width="19px" />
            <br /><br /><br /><br />
            <asp:Calendar ID="Calendar1" runat="server" BackColor="White" BorderColor="Black" Font-Names="Times New Roman" Font-Size="Medium" ForeColor="Black" Height="400px" Width="100%" OnDayRender="Calendar1_DayRender" FirstDayOfWeek="Monday">
                <DayHeaderStyle BackColor="#CCCCCC" Font-Bold="True" Font-Size="7pt" ForeColor="#333333" Height="10pt" />
                <DayStyle Width="14%" />
                <NextPrevStyle Font-Size="8pt" ForeColor="White" />
                <OtherMonthDayStyle ForeColor="#999999" />
                <SelectedDayStyle BackColor="#CC3333" ForeColor="White" />
                <SelectorStyle BackColor="#CCCCCC" Font-Bold="True" Font-Names="Verdana" Font-Size="8pt" ForeColor="#333333" Width="1%" />
                <TitleStyle BackColor="Black" Font-Bold="True" Font-Size="13pt" ForeColor="White" Height="14pt" />
                <TodayDayStyle BackColor="#CCCC99" />
            </asp:Calendar>
            <p>
                &nbsp;</p>
            <p>
                &nbsp;</p>
            <div class="zakazi">
                <asp:Button ID="Button1" runat="server" Text="Zakazi" OnClick="Button1_Click" />
            </div>
    </form>
</body>
</html>

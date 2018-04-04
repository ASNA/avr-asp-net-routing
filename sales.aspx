<%@ Page Language="AVR" AutoEventWireup="false" CodeFile="sales.aspx.vr" Inherits="views_sales" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Sales</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <h1>
            Sales Report for
            <asp:Literal ID="LocaleLiteral" runat="server"></asp:Literal>,
            <asp:Literal ID="YearLiteral" runat="server"></asp:Literal>
        </h1>    
    </div>
    </form>
</body>
</html>

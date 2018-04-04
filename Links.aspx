<%@ Page Language="AVR" AutoEventWireup="false" CodeFile="Links.aspx.vr" Inherits="Links" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Links</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:HyperLink ID="HyperLink1" runat="server" 
            NavigateUrl="~/salesreportsummary/2010">
            Sales Report - All locales, 2010
        </asp:HyperLink>
        <br />
        <asp:HyperLink ID="HyperLink2" runat="server" 
            NavigateUrl="~/salesreport/WA/2011">
            Sales Report - WA, 2011
        </asp:HyperLink>
        <br />
        <asp:HyperLink ID="HyperLink3" runat="server" 
            NavigateUrl="~/expensereport">
            Expense Report - Default Locale and Year (US, current year)
        </asp:HyperLink>
        <br />    
        <hr />
        <asp:HyperLink ID="HyperLink4" runat="server" 
            NavigateUrl="<%$RouteUrl:year=2011%>">
            Sales Report - All locales, 2011
        </asp:HyperLink>
        <br />
        <asp:HyperLink ID="HyperLink5" runat="server" 
            NavigateUrl="<%$RouteUrl:locale=CA,year=2009,routename=salesroute%>">
            Sales Report - CA, 2009
        </asp:HyperLink>
        <br />
        <asp:HyperLink ID="HyperLink6" runat="server">
            Expense Report - CA, 2008
        </asp:HyperLink>
        <br />
    </div>
    </form>
</body>
</html>

<%@ Page Language="AVR" AutoEventWireup="false" CodeFile="expenses.aspx.vr" Inherits="views_expenses" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Untitled Page</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <h1>
            Expense Report for
            <asp:Literal ID="Literal1" 
              Text="<%$RouteValue:locale%>" 
              runat="server"></asp:Literal>,

            <asp:Literal ID="Literal2" 
              Text="<%$RouteValue:year%>" 
              runat="server"></asp:Literal>

           <asp:Literal ID="Literal3" 
            Text="<%$RouteValue:extrainfo%>" 
            runat="server"></asp:Literal>
        
        </h1>

    </div>
    </form>
</body>
</html>

<%@ Application Language="AVR" %>

<%@ Import Namespace="System.Web.Routing" %> 

<script runat="server">

    BegSr Application_Start
        DclSrParm sender Type(*Object)
        DclSrParm e Type(EventArgs)

        RegisterRoutes(RouteTable.Routes)   
    EndSr

    BegSr RegisterRoutes
        DclSrParm routes Type(RouteCollection)

        DclFld map1 Type(RouteValueDictionary) 
        DclFld map2 Type(RouteValueDictionary) 

        routes.MapPageRoute("", + 
                           "SalesReportSummary/{year}", + 
                           "~/sales.aspx")

        routes.MapPageRoute("SalesRoute", +
                            "SalesReport/{locale}/{year}", +
                            "~/sales.aspx")

        map1 = *New RouteValueDictionary() 
        map1.Add('locale', 'US')
        map1.add( "year", DateTime.Now.Year.ToString())

        map2 = *New RouteValueDictionary() 
        map2.Add('locale', '[a-z]{2}')
        map2.add( "year", '\d{4}')

        routes.MapPageRoute("ExpensesRoute", +
                            "ExpenseReport/{locale}/{year}/{*extrainfo}", +
                            "~/expenses.aspx", +
                            *True, +
                            map1, map2) 
    EndSr
      
</script>

## Using ASP.NET routing with AVR for .NET ASP.NET Web apps

ASP.NET's WebForms model acquired a semantic, or "friendly", routing feature several years ago. This routing feature lets you use semantic URLs instead of page-based URLs. For example, consider a page named `CustDtls.aspx`. Using the default page-based routing, that pages is accessed with this URL:

    mywebsite.com/CustDtls.aspx

In this case, the URL given is mapped directly against the file `CustDtls.aspx` in the application root.

The ASP.NET semantic routing feature lets you get to that page with this URL:

    mywebsite.com/CustomerDetails 

In this the case, the "virtual" url (there isn't a file named `CustomerDetails` in the application root) is checked against a map you provide to determine the underlying physical path to the page to be shown. 

ASP.NET routing also lets you virtually group pages so you could also configure a route to the CustDtls.aspx page with:

    mywebsite.com/customer/details

> ASP.NET routing is case-insensitive; you can use any case in the URL. 

Routing is built into .NET (via the [System.Web.Routing namespace](https://msdn.microsoft.com/en-us/library/system.web.routing(v=vs.110).aspx)) and works great with AVR. Support for it is also built into IIS (with no special configuration needed) from version 7 and up. I tested the example that accompanies this article on IIS 10 and it ran just fine. (In very early versions of ASP.NET routing, IIS did require a special URL rewriting module and clumsy configuration.) 

This routing feature may not be something you want to retrofit into exsiting applications, but it's a nice feature for new apps. Semantic routing does coexist nicely with page-based routing so you could easily add it to existing apps for a new group of pages. 

> Semantic routing is frequently used with RESTful services. An upcoming article introduces how to create RESTful services for an AVR ASP.NET application. That article uses semantic routing exclusively. This article is an introduction to semantic routing with AVR and we'l build on its concepts in that upcoming RESTful services article.

### Implementing semantic routing with AVR for .NET

Microsoft has [a great explanation Webforms routing](https://www.asp.net/web-forms/overview/routing) and it also has [a thorough walkthrough](https://msdn.microsoft.com/en-us/library/dd329551.aspx). Every concept discussed in these articles works with AVR. However, the code-behind examples are provided in VB and C# exclusively and the examples use a .NET language feature that AVR doesn't support. Rather than reinvent the wheel, this article explains where AVR differs from the C# presented in the [walkthrough article](https://msdn.microsoft.com/en-us/library/dd329551.aspx). Be sure to read the two MS articles referenced here. They provide important details not included here. 

> There aren't any differences between AVR and C# in the `ASPX` markup. The `ASPX` markup presented in the MS article is _exactly_ the same markup AVR uses.

#### Configuring routing

Routing is configured in `global.asax`. Here is the AVR version of the MS article's `global.asax`.

    01  <%@ Application Language="AVR" %>
    02  
    03  <%@ Import Namespace="System.Web.Routing" %> 
    04  <%@ Import Namespace="ASNA.JsonRestRouting" %> 
    05  
    06  <script runat="server">
    07  
    08      BegSr Application_Start
    09          DclSrParm sender Type(*Object)
    10          DclSrParm e Type(EventArgs)
    11  
    12          RegisterRoutes(RouteTable.Routes)   
    13      EndSr
    14  
    15      BegSr RegisterRoutes
    16          DclSrParm routes Type(RouteCollection)
    17  
    18          DclFld map1 Type(RouteValueDictionary) 
    19          DclFld map2 Type(RouteValueDictionary) 
    20  
    21          routes.MapPageRoute("", + 
    22                             "SalesReportSummary/{year}", + 
    23                             "~/sales.aspx")
    24  
    25          routes.MapPageRoute("SalesRoute", +
    26                              "SalesReport/{locale}/{year}", +
    27                              "~/sales.aspx")
    28  
    29          map1 = *New RouteValueDictionary() 
    30          map1.Add('locale', 'US')
    31          map1.add( "year", DateTime.Now.Year.ToString())
    32  
    33          map2 = *New RouteValueDictionary() 
    34          map2.Add('locale', '[a-z]{2}')
    35          map2.add( "year", '\d{4}')
    36  
    37          routes.MapPageRoute("ExpensesRoute", +
    38                              "ExpenseReport/{locale}/{year}/{*extrainfo}", +
    39                              "~/expenses.aspx", +
    40                              *True, +
    41                              map1, map2) 
    42      EndSr
    43        
    44  </script>

<small>Figure 1. The full AVR version of the `global.asax` for the walkthrough.</small>

Lines 21, 25, and 37 in Figure 1 above configure routes to ASPX pages. Read the MS article for more details on these route declarations. With ASP.NET routing, values that are passed as arguments are shown inside braces (such as {locale} and {year}). These values are distinct from query strings. You can still also use query strings with routing, but especially in RESTful work, it's common to put data in the URL as though its part of the path to the underlying page (or resource, as REST would have you call it).

The biggest difference between the C# and AVR versions is in passing the last two arguments to the `MapPageRoute` method in line 41 above. C# supports an object literal notion to instance new classes that AVR does not support. Consider a class named `Point` that has two public properties, `X` and `Y`. C# can instance that `Point` class, and populate `X` and `Y` with a single line, like this (using what's called an [`object literal` or `object initializer`](https://docs.microsoft.com/en-us/dotnet/csharp/programming-guide/classes-and-structs/object-and-collection-initializers)):

    var x = new Point { X = 0, Y = 1 };

AVR requires this more verbose approach:    

    DclFld x Type(Point)  

    x = *New Point()
    x.x = 0
    x.y = 1

 > Whenever VB or C# using `object initializer` notation, you'll need to translate that notation to AVR's more explicit, verbose notation.
         
C# is able to pass  two instances of `RouteValueDictionary` to `MapPageRoute` as inline arguments like this:  

    routes.MapPageRoute("ExpensesRoute",
        "ExpenseReport/{locale}/{year}/{*extrainfo}",
        "~/expenses.aspx", true,
        new RouteValueDictionary { 
            { "locale", "US" }, 
            { "year", DateTime.Now.Year.ToString() } },
        new RouteValueDictionary { 
            { "locale", "[a-z]{2}" }, 
            { "year", @"\d{4}" } });    

While AVR has to explicitly create two instances of `RouteValueDictionary` first and then pass those two values to `MapPageRoute.`

    DclFld map1 Type(RouteValueDictionary) 
    DclFld map2 Type(RouteValueDictionary) 

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

Watch for the `object initializer` pattern while reading MS's C# and VB ASP.NET routing examples. It is used frequently. While it takes a little more code with AVR, ultimately you end up with the same result. 

#### Generating links at runtime

Routes can optionally be assigned names when they are defined. In Figure 1, you'll notice that on line 37 the route declared there is named `ExpenseRoute`. This route name can later be used to generate a link to that route, as shown below. 

In the MS article, this C# is provided as the way to generate a URL from a named route. 

    RouteValueDictionary parameters = 
        new RouteValueDictionary  
            { 
                {"locale", "CA" }, 
                { "year", "2008" } , 
                { "category", "recreation" }
            };

    VirtualPathData vpd = 
        RouteTable.Routes.GetVirtualPath(null, "ExpensesRoute", parameters);

As we saw before, AVR needs to use its more verbose method of instancing the `RouteValuesDictionary` class and separating `vpd`'s declaration from its assignment:

    DclFld parameters Type(RouteValueDictionary) 
    DclFld vpd Type(VirtualPathData) 

    parameters = *New RouteValueDictionary()
    parameters.Add('locale', 'CA')
    parameters.Add('year', '2008')
    parameters.Add('category', 'recreation')

    vpd = RouteTable.Routes.GetVirtualPath(*Nothing, +
                                           "ExpensesRoute", +
                                           parameters)
    HyperLink6.NavigateUrl = vpd.VirtualPath


Download the full AVR routing example and play around with it. You'll see it used frequently in upcoming AVR for .NET ASP.NET examples. 
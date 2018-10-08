<html>
<head>
<LINK rel=stylesheet href="<%=request.getContextPath() %>/css/kyccss.css">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/kycpanel/style.css" />
</head>
<body>
<%@ page import="java.util.Properties" %>
<%@ page import="java.util.Enumeration" %>
<%

// Get a list of all the system properties and their values
// Not available in unsigned Applets, only applications and signed Applets.
Properties sysprops = System .getProperties();

out.println("<table border=1 cellpadding=3 cellspacing=0 width='80%' align=center>");
out.println("<tr class=tableheading><td>Name</td><td>Value</td></tr>");
for ( Enumeration e = sysprops.propertyNames(); e.hasMoreElements(); )
   {
   String key = (String)e.nextElement();
   String value = sysprops.getProperty( key );
//   System.out.println( key + "=" + value );
   out.println("<tr><td class=tablebold>"+key+"</td><td WRAP=HARD>"+value+"</td></tr>");
   } // end for
out.println("</table>");
   %>
</body>
   </html>
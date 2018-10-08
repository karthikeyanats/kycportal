 <%@page language="java" import ="java.sql.*" %>
 <%

 String country=request.getParameter("count");
 response.setContentType("text/html");
 response.setHeader("Cache-Control","no-cache");
 try
 {String buffer="<select name='state'><option value='-1'>Pick One</option>";
 try
 {Class.forName("com.mysql.jdbc.Driver").newInstance();
 }
 catch(ClassNotFoundException e)
 {}
 String dbURL = "jdbc:mysql://192.168.2.41/kycportal";
 java.sql.Connection dbCon;
 dbCon = DriverManager.getConnection(dbURL,"root","root");
 Statement stmt = dbCon.createStatement();
 //out.println("country-->"+country);
 String query = "Select * from standard where standardid='1' ";
 //System.out.println(query);
 ResultSet rs = stmt.executeQuery(query);
   while(rs.next())
   {buffer=buffer+"<option value='"+rs.getString(2)+"'>"+rs.getString(2)+"</option>";
   }
  buffer=buffer+"</select>";
 response.getWriter().println(buffer);
 }
 catch(Exception e)
 {response.getWriter().println(e);
 }
 %>
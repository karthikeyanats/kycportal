<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Know Your Child Enterprise</title>
</head>
<body>
<%

out.println("userid "+session.getValue("userid"));
out.println("usercategory "+		session.getValue("usercategory"));
out.println("institutename "+session.getValue("institutename"));
out.println("userfullname "+session.getValue("userfullname"));
out.println("instituteid "+session.getValue("instituteid"));
out.println("prefix "+session.getValue("prefix"));
out.println("institutelogo "+session.getValue("institutelogo"));
%>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script>

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Loading...</title>
</head>
<body>
<%@ page language="java" import="java.util.ResourceBundle,java.util.ArrayList,java.util.HashMap"%>
<jsp:useBean id="login_object" scope="page" class="com.iGrandee.Login.LoginAction"/>
<% 
	
	String username 			= "";
	String password 			= "";
	int return_state			= 0;
	int nameindex				= 0;
	int passindex				= 0;

	try
	{		System.out.println("return_state");
			username = request.getParameter("username");
			password = request.getParameter("password");
			if((username!=null)&&(!username.equals(""))&&(password!=null)&&(!password.equals("")))
			{
				nameindex=username.lastIndexOf("'");
				passindex=password.lastIndexOf("'");
			
				if((nameindex==-1)&&(passindex==-1))
				{
					return_state = login_object.checkUserParent(username,"login"); 
					//System.out.println(return_state);
				}
				else
				{
					return_state =0;
					session.putValue("invalid","user/Invalid Username");
					response.sendRedirect(request.getContextPath()+"/indexv1.jsp");
				}
				
			}
			System.out.println("return_state"+return_state);
			if(return_state == 1)
			{
				return_state				= login_object.checkPasswordParent(username,password);
				System.out.println("return_state"+return_state);
				session.putValue("username",username);
				if(return_state == 2)
				{
					
					java.util.ArrayList details 	= login_object.getParentDetails(username,password);
					System.out.println("details"+details);
					java.util.HashMap hashmap		= null;		
					if(details != null && details.size()>0){
						hashmap	= (java.util.HashMap)details.get(0);
						String sessionstatus = (String)hashmap.get("sessionstatus");
						
						if(sessionstatus == "A" || sessionstatus.equals("A")){
						session.putValue("instituteid",(String)hashmap.get("instituteid"));
						session.putValue("institutelogo",(String)hashmap.get("institutelogo"));
						session.putValue("institutename",(String)hashmap.get("institutename"));
						session.putValue("userfullname",(String)hashmap.get("fathername"));
						session.putValue("prefix","Mr.");
						session.putValue("parentid",(String)hashmap.get("parentloginid"));
						session.putValue("userid",(String)hashmap.get("parentloginid"));
						System.out.println("************************************** here1");

						session.putValue("userrolename","Parent");
						session.putValue("usercategory","P");
						System.out.println("************************************** here");
						response.sendRedirect(request.getContextPath()+"/jsp/Parent/ParentHome.jsp");
						}
						else if(sessionstatus == "R" || sessionstatus.equals("R"))
						{						
							//session.putValue("invalid","Academic Year : "+hashmap.get("sessionname")+" was Archived");
							//String sess = session.getValue("invalid").toString();
							//response.sendRedirect("./indexv1.jsp");						
						}						
					}
					else{
						session.putValue("invalid","Invalid password-"+username);
						String sess = session.getValue("invalid").toString();
						response.sendRedirect(request.getContextPath()+"/indexv1.jsp");						
					}

				}
				else
				{
					//session.putValue("invalid","Invalid password-"+username);
				//	String sess = session.getValue("invalid").toString();
				//	response.sendRedirect("./indexv1.jsp");
				
				}
			}
			else
			{
			
				return_state =0;
				session.putValue("invalid","Invalid Username");
				response.sendRedirect(request.getContextPath()+"/indexv1.jsp");
			}
	
	
	
	}catch(Exception e){
		e.printStackTrace();
	}
%>
</body>
</html>
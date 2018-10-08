<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script>
function contact()
{
alert('contact Administrator');

}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%@ page language="java" import="java.util.ResourceBundle,java.util.ArrayList,java.util.HashMap"%>
<jsp:useBean id="login_object" scope="page" class="com.iGrandee.Login.LoginAction"/>
<%

		String username 				= "";
		String password 				= "";
		int return_state				= 0;
		int nameindex					= 0;
		int passindex					= 0;
		int return_status 				= 0;
		String user_category 			= "";
		String lastname					= null;
		String middlename				= null;
		String firstname				= null;
		String institutename			= null;
		String instituteid 				= null;
		String prefix					= null;
		String userfullname 			= null;
		String institutelogo 			= null;
		String user_id 					= null;
		String rolename 				= null;
		String roleid 					= null;
		String departmentid 			= null;
		String departmentname 			= null;
		String staffid 					= null;
		String sessionid				= null;
		String sessionname				= null;
		String standardname				= null;
		

		try
		{
			username = request.getParameter("username");
			password = request.getParameter("password");
			
			if((username!=null)&&(!username.equals(""))&&(password!=null)&&(!password.equals(""))){
				
				
				
				nameindex	= username.lastIndexOf("'");
				passindex	= password.lastIndexOf("'");
			
				if((nameindex==-1)&&(passindex==-1)){
					
					return_state = login_object.checkUser(username,"login");
				}
				else{
					
					return_state =0;
					session.putValue("invalid","user/Invalid Username");
					response.sendRedirect(request.getContextPath()+"/indexv1.jsp");
				}
			}
			
			if(return_state == 1)
			{
				return_state				= login_object.checkPassword(username,password);
				session.putValue("username",username);
				
				
				if(return_state == 2)
				{
					user_id				= login_object.getuserid();
					user_category		= login_object.getcategory();
					
					if(!user_category.equals("S"))
					{
						int usercnt= login_object.getUserDetails(username,password,user_category);
						if(usercnt >1)
						{
							user_id				= login_object.getuserid();
							user_category		= login_object.getcategory();
							institutename		= login_object.getinstitutename();
							//System.out.println("institutename"+institutename);
							firstname			= login_object.getfirstname();
							middlename			= login_object.getmiddlename();
							lastname			= login_object.getlastname();
							institutelogo 		= login_object.getinstitutelogo();
							rolename 			= login_object.getRolename();
							
							if(middlename== null || middlename.equals("-") || middlename.equals(""))
								middlename 		= "";
							userfullname = firstname+" "+middlename+" "+lastname;
							
							instituteid			= login_object.getinstituteid();
							prefix				= login_object.getprefix();
							departmentname 		= login_object.getDepartmentname();
							departmentid 		= login_object.getDepartmentid();
							roleid 				= login_object.getRoleid();
							staffid				= login_object.getstaffid();
							
							
							ArrayList sessionl	= login_object.getSessionDetails(instituteid);
							if(sessionl != null && sessionl.size()>0){
								HashMap	hashmap	= (HashMap)sessionl.get(0);
								
								sessionid		= (String)hashmap.get("sessionid");
								
								if(hashmap.get("sessionname")== null)
								{
									sessionname="Not yet allocated";
								}
								else{
									sessionname		= (String)hashmap.get("sessionname");}
							}else
							{
								sessionname="Not yet allocated";
							}
							
							session.putValue("sessionid",sessionid);
							session.putValue("sessionname",sessionname);						
							session.putValue("userid",user_id);
							session.putValue("usercategory",user_category);
							session.putValue("institutename",institutename);
							session.putValue("userfullname",userfullname);
							session.putValue("instituteid",instituteid);
							session.putValue("prefix",prefix);
							session.putValue("institutelogo",institutelogo);
							session.putValue("userrolename",rolename);
							session.putValue("roleid",roleid);
							session.putValue("departmentname",departmentname);
							session.putValue("departmentid",departmentid);
							session.putValue("staffid",staffid);
							
							
							if(user_category.equals("HM"))
							{
								response.sendRedirect(request.getContextPath()+"/jsp/Principal/PrincipalHomepage.jsp");
							}
							else if(user_category.equals("T"))
							{
								response.sendRedirect(request.getContextPath()+"/jsp/Staff/StaffHomepage.jsp");
							}
							else if(user_category.equals("F"))
							{
								response.sendRedirect(request.getContextPath()+"/jsp/Fees/FeesCollection_pre.jsp");
							}
							else if(user_category.equals("SA"))
							{
							response.sendRedirect(request.getContextPath()+"/jsp/kycpanel/Homepage.jsp");
							}
							else if(user_category.equals("LA"))
							{
							response.sendRedirect(request.getContextPath()+"/jsp/Library/LibraryHome.jsp");
							}
							else if(user_category.equals("MA"))
							{
							response.sendRedirect(request.getContextPath()+"/jsp/SuperAdmin/SuperAdminPage.jsp");
							}		
						}
						else
						{
							session.putValue("invalid","Invalid password-"+username);
							response.sendRedirect(request.getContextPath()+"/indexv1.jsp");
						}
					}
					else if(user_category.equals("S"))
					{
						ArrayList details 	= login_object.getStudentDetails(user_id);
						HashMap hashmap		= null;		
						if(details != null && details.size()>0){
							hashmap	= (HashMap)details.get(0);

							ArrayList sessionl	= login_object.getSessionDetails((String)hashmap.get("instituteid"));
							if(sessionl != null && sessionl.size()>0){
								HashMap	sessionmap	= (HashMap)sessionl.get(0);
								
								sessionid		= (String)sessionmap.get("sessionid");
								
								if(sessionmap.get("sessionname")== null)
								{
									sessionname="Not yet allocated";
								}
								else{
									sessionname		= (String)sessionmap.get("sessionname");}
							}else
							{
								sessionname="Not yet allocated";
							}
							
							if(hashmap.get("groupname")!=null)
								standardname = hashmap.get("standardname")+" - "+hashmap.get("groupname");
							else
								standardname = (String)hashmap.get("standardname");
							
							session.putValue("sessionid",sessionid);
							session.putValue("instituteid",(String)hashmap.get("instituteid"));
							session.putValue("institutelogo",(String)hashmap.get("institutelogo"));
							session.putValue("institutename",(String)hashmap.get("institutename"));
							session.putValue("sessionname",sessionname);							
							session.putValue("sectionscheduleid",(String)hashmap.get("sectionscheduleid"));
							session.putValue("standardscheduleid",(String)hashmap.get("standardscheduleid"));
							session.putValue("userfullname",(String)hashmap.get("studentname"));
							session.putValue("sectionname",(String)hashmap.get("sectionname"));
							session.putValue("standardname",standardname);
							session.putValue("boardname",(String)hashmap.get("boardname"));

							session.putValue("prefix",(String)hashmap.get("prefix"));
							session.putValue("studentid",(String)hashmap.get("studentallocationid"));
							session.putValue("studentrollno",(String)hashmap.get("rollno"));
							session.putValue("userrolename","Student");
						
			
						session.putValue("userid",user_id);
						session.putValue("usercategory",user_category);
						response.sendRedirect(request.getContextPath()+"/jsp/Student/StudentHome.jsp");
						}
						else
						{
							session.putValue("invalid","Invalid password-"+username);
							response.sendRedirect(request.getContextPath()+"/indexv1.jsp");
						}
							
					}
				}
				else
				{
					session.putValue("invalid","Invalid password-"+username);
					response.sendRedirect(request.getContextPath()+"/indexv1.jsp");
				}
			}
			else 
			{
				session.putValue("invalid","Invalid Username");
				response.sendRedirect(request.getContextPath()+"/indexv1.jsp");
			}
	
		}catch(Exception e){
			e.printStackTrace();
		}
%>
</body>
</html>
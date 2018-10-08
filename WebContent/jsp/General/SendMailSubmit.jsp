<html>
<%@ page language="java" %>
<jsp:useBean id="sendmail" 	scope="page" class="com.iGrandee.SendMail.SendGeneralMail" />
<%
int retvalue = 0;
String returnurl="";
returnurl=request.getContextPath()+"/jsp/General/SendMail.jsp";
try
{

	String towhom = request.getParameter("towhom");
	String mailsubject = request.getParameter("mailsubject");
	String mailmessage= request.getParameter("mailmessage");
	String instituteid = (String)session.getValue("instituteid");
	//out.println(instituteid);
	//out.println(mailsubject);
	//out.println(mailmessage);
	out.println(towhom);
	
	retvalue = sendmail.sendMailToAll(mailsubject,mailmessage,towhom,instituteid);
	String resultword="";
	if(retvalue >0)
	{
			resultword="Mail Sent Successfully";
	}
	else
	{
			resultword="Operation Failed";
	}
	
	response.sendRedirect(request.getContextPath()+"/jsp/Operation_Result.jsp?message="+resultword+"&result="+retvalue+"&returnurl="+returnurl);
}catch(Exception e){e.printStackTrace();}	
%>

</html>
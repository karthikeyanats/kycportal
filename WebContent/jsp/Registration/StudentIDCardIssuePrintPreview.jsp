<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - Student Report View | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Calendar/Calendar.js"></script>
<script type="text/javascript">
function goBack()
{
window.close();
}

function printfun()
{	
document.getElementById("printbutt").style.visibility='hidden';
document.getElementById("backbutt").style.visibility='hidden';
window.print();
document.getElementById("printbutt").style.visibility='visible';
document.getElementById("backbutt").style.visibility='visible';	
}
</script>
</head>
<body style="background-color: white;background-image: none;">

<%@ page language="java"
	import="java.util.ResourceBundle,java.util.ArrayList,java.util.HashMap"%>
	<%@ page import="com.iGrandee.Common.DateTime" %>
	
<%@ page language="java" import="com.iGrandee.Prinicipal.PrinicipalQuery,com.iGrandee.Common.DateTime"%>

<form name="StudentReport_Form" action="" method="post">

		
		<%
			String	status  = "A";
			if(request.getParameter("req_sessionstatus") != null && request.getParameter("req_sessionstatus").equals("R")){
			 	status = "D','A','C";  
		%>
		
		<%		
			}
		%>		
<%

		PrinicipalQuery prinicipalquery			= new PrinicipalQuery();
		HashMap	hashmap				= null;
		HashMap	hashmap1			= null;
		ArrayList 	studentList		=null;	
		DateTime dateobj=new DateTime();
		int rollNoNote = 0;
		String sessionid			= request.getParameter("session");
		String boardid				= request.getParameter("board");
		String standardscheduleid	= request.getParameter("standardscheduleid");
		String sectionscheduleid	= request.getParameter("sectionscheduleid");
		String sessionname			= request.getParameter("req_sessionname");
		String boardname			= request.getParameter("req_boardname");
		String standardschedulename	= request.getParameter("req_standardnamegp");
		String sectionschedulename	= request.getParameter("req_sectionname");
		String sessionuserid		= (String)session.getValue("userid");
		String instituteid			= (String)session.getValue("instituteid");
		String today				= DateTime.showTime("calendar");
		//out.println(standardscheduleid+"========"+sessionid+"========"+sectionscheduleid+"========"+instituteid);
		if(sessionid != null && boardid!= null && standardscheduleid!= null && sectionscheduleid!= null) {
			studentList			= prinicipalquery.loadSectionwiseStudent(sectionscheduleid,status);
			//studentList			= prinicipalquery.loadstudent(standardscheduleid,sessionid,sectionscheduleid,instituteid);
		}
		com.iGrandee.Registration.InstitutionQurey insquery=new com.iGrandee.Registration.InstitutionQurey();
		ArrayList insdetails=insquery.getInstituteDetails(instituteid);
%>
		<input type=hidden   name=hiddensession value="<%=sessionid%>">
		<input type=hidden   name=hiddenboard value="<%=boardid%>">
		<input type=hidden   name=standardscheduleid value="<%=standardscheduleid%>">
		<input type=hidden   name=sectionscheduleid value="<%=sectionscheduleid%>">
		<input type="hidden" name="req_sessionname" value="<%=sessionname%>">
		<input type="hidden" name="req_sessionstatus" value="<%=request.getParameter("req_sessionstatus")%>">
		<input type="hidden" name="req_boardname" value="<%=boardname%>">
		<input type="hidden" name="req_standardnamegp" value="<%=standardschedulename%>">
		<input type="hidden" name="req_sectionname" value="<%=sectionschedulename%>">
		<input type="hidden" name="studentprofileedit" value="studentprofileedit">
		<input type="hidden" name="req_rollno" >
		<input type="hidden" name="personid" value="">
		<input type="hidden" name="condition" value="studentlist">
		
		<font color=black>
									
					   	<%
					   	int datacount=0;
						if(studentList != null && studentList.size()>0){
							for(int y=0,j=1;y<studentList.size();y++,j++){
								if(y==0)
								{
									out.println("<table><tr height=140px ><td>&nbsp;</td></tr></table>");

									out.println("<table  border=0  width='760px'  cellpadding=0 cellspacing=0 ><tr><td>&nbsp;</td></tr>");
								}

								if(y!=0 && y%4==0)
								{
								out.println("</table>");
								out.println("<table><tr height=140px ><td>&nbsp;</td></tr></table>");
								out.println("<table  border=0  width='760px'  cellpadding=0 cellspacing=0 ><tr><td>&nbsp;</td></tr>");
								}
								datacount++;
								hashmap			= (HashMap)studentList.get(y);
								String Studname		= (String)hashmap.get("uname");
								String rollno		= hashmap.get("rollno")+"";
								if(rollno.equals("null")){
									rollno="<font color=red><i>-NYG-</i></font>";
									rollNoNote = rollNoNote+1;
								}
								String mobilenumber1		= hashmap.get("mobilenumber")+"";
								if(mobilenumber1.equals("null"))
									mobilenumber1="-";
								String emailid1		= hashmap.get("emailid")+"";
								if(emailid1.equals("null"))
									emailid1="-";								
								
								String studallocationid	= (String)hashmap.get("studentallocationid");
								String personid	= (String)hashmap.get("personid");
								if(y==0)
									out.print("<tr>");

								if(y!=0 && y%2==0)
								{
									out.print("</tr>");
									out.println("<tr height=100px ><td colspan=6>&nbsp;</td></tr>");
									out.print("<tr>");
								}
								out.print("<td width=5px >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td><td width=50% >");
								out.print("<table  width=100%  border=1  bordercolor=black cellpadding=0 cellspacing=0 rules=groups>");
								
								out.print("<tr height=100px ><td>");
								out.print("<table border=0  cellpadding='0' cellspacing='0' style='float:left;' align=left width='100%'>");
						    	if(insdetails!=null && insdetails.size()>0)
						    	{
						    		java.util.HashMap map=(java.util.HashMap)insdetails.get(0);
						        	String inslogo=map.get("institutelogo")+"";
						        	String insname=map.get("institutename")+"";
						        	String contactaddress=map.get("contactaddress")+"";
						        	String country=map.get("country")+"";
						        	String landlinenumber=map.get("landlinenumber")+"";
						        	String state=map.get("state")+"";
						        	String mobilenumber=map.get("mobilenumber")+"";
						        	String emailid=map.get("emailid")+"";
						        	String url=map.get("url")+"";
						        	String zip=map.get("zip")+"";
						        	String fax=map.get("fax")+"";
						        	        	
						        	if(url.equals("-") || url.equals("") || url.trim()=="")
						        		url="";
						        	else
						        		url="Web :"+url;
						        	if(zip.equals("-") || zip.equals("") || zip.trim()=="")
						        		zip="";
						        	else
						        		zip=", "+zip;
						        	
						        	out.println("<tr align=left>");
						        	out.println("<td rowspan=3 valign=top><img src='"+request.getContextPath()+"/OpenDocument?r1=storagepath&r2="+inslogo+"' width=75 height=75></td>");
						        	out.println("</tr>");
						        	out.println("<tr>");
						        	out.println("<td valign=top align=right>");
						        	out.println("<table  align=right width=80%' border=0 cellpadding=0 cellspacing=0>");
						        	out.println("<tr align=left>");
						        	out.println("<td class=tablelight><font size=3px>"+insname+"</font></td><tr>");
						        	out.println("<tr align=left>");
						        	out.println("<td>&nbsp;"+contactaddress+"</td>"); 
						        	out.println("</tr>");
						        	out.println("<tr align=left>");
						        	out.println("<td>&nbsp;"+state+","+country+"&nbsp;"+zip+"</td>");
						        	out.println("</tr>");
						        	out.println("<tr align=left>");
						        	out.println("<td>&nbsp;Ph.:"+landlinenumber+"&nbsp;Fax:"+fax+"</td>");
						        	out.println("</tr>");
						        	out.println("<tr align=left>");
						        	out.println("<td>&nbsp;Email:"+emailid+"</td>");
						        	out.println("</tr>");
						        	out.println("<tr align=left>");
						        	out.println("<td>&nbsp;"+url+"</td>");
						        	out.println("</tr>");
						        	}
						        out.print("</table></td></tr></table></td></tr>");
						        out.print("<tr><td colspan=3  align=center height=1px ><hr></tr>");

						        out.print("<tr><td colspan=3  align=center>"+sessionname+"</td></tr>");
						        out.print("<tr><td colspan=3  align=center>&nbsp;</tr>");

						        out.print("<tr><td align=left><table border=0 width=100% cellspacing=0 cellpadding=5><tr><td width=30% class=tablebold>Student Name</td><td  width=1px  class=tablebold>:</td><td>"+Studname+"</td><td rowspan=4 align=right valign=top><img src='"+request.getContextPath()+"/OpenDocument?r1=storagepath&r2="+hashmap.get("imagepath")+"' width=75 height=75></td></tr>");
								out.print("<tr><td class=tablebold>Roll No</td><td class=tablebold>:</td><td colspan=2>"+rollno+"</td></tr>");
								out.print("<tr><td class=tablebold>Standard</td><td class=tablebold>:</td><td  colspan=2>"+standardschedulename+"</td></tr>");
								out.print("<tr><td class=tablebold>Section</td><td class=tablebold>:</td><td  colspan=2>"+sectionschedulename+"</td></tr>");
								out.print("</table>");
								out.print("</td></tr>");
						        out.print("<tr  height=40px><td><table border=0 width=100% ><tr  height=40px><td width=1px>&nbsp;</td><td align=left><b> Student</b></td><td align=right><b>Principal</b></td><td width=1px>&nbsp;</td></tr></table></td></tr>");

						        out.print("</table>");

								out.print("<br></td><td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>");
			
							}
						}
						else
						{
							//out.print("<tr><td colspan='3' align='center'> Data Not Found</td></tr>");
							out.println("<tr align='center' class='tablebold'><td colspan='5'><font color='red'>Data Not Found</font></td></tr>");
						}
							out.print("</table>");
						%>
					</td>
					</tr>		
					</table>
<center>					
					<% 
					if(datacount>0){
					%>	
						<input type=button  name=printbutt id=printbutt  onclick='printfun()'  value=Print >
					<%}%>
					<input type=button name=backbutt id=backbutt onclick='goBack()' value=Close ></center>
					
				

</font>

				
		<!--<a href="#" class="bt_blue" onClick='backfun()'><span class="bt_blue_lft"></span><strong>Back</strong><span class="bt_blue_r"></span></a>-->
		
</form>		
   
</body>

</html>
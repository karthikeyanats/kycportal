
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
	<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title><%=bundle.getString("label.academicsession.trashpreviewlisttitle") %></title>

<LINK rel=stylesheet href="../css/kyccss.css">
<link rel="stylesheet" type="text/css" href="../../../jsp/kycpanel/style.css" />
<link rel="stylesheet" type="text/css" media="all" href="../jsp/kycpanel/niceforms-default.css" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<SCRIPT language="JavaScript" src="../../../js/Validation.js"></SCRIPT>
<script type="text/javascript" src="../jsp/jconfirmaction.jquery.js"></script>
<script language="javascript" type="text/javascript" src="niceforms.js"></script>

<script language="JavaScript">




function goToBack()
{
	document.MainForm.action= "AcademicSessionList.jsp";
document.MainForm.submit();
}
function goToUpdate()
{
if(check_ForParticularElements(document.MainForm.sessionname,"text"))
	{
	
if(confirm("Do you want to Update the Academic Session ...?"))
{
	monthstart  = parseInt(document.getElementById("monthstart").options[document.getElementById("monthstart").selectedIndex].value);
	yearstart  = parseInt(document.getElementById("yearstart").options[document.getElementById("yearstart").selectedIndex].value);
	monthend  = parseInt(document.getElementById("monthend").options[document.getElementById("monthend").selectedIndex].value);
	yearend  = parseInt(document.getElementById("yearend").options[document.getElementById("yearend").selectedIndex].value);
	
	if((monthstart+yearstart) > (monthend+yearend)){
		alert("The start (month, Year)  should not less than the End (month, year) ")
		return false;
	}
	document.MainForm.action= "AcademicSessionEditUpdate.jsp";
document.MainForm.submit();
}
}

else{}
}

</script>
</head>

<body>
<form name="MainForm" method="post" action="">

<div id="main_container">

	<div class="header">
	
<%@ include file="../../include/userheader.jsp" %>
   
	   </div>

    <div class="main_content">
    
<%@ include file="../../include/header.jsp" %>
    <div class="center_content">

     <div class="left_content">

    </div>

    <div class="right_content">
         <h2><%=bundle.getString("label.academicsession.updatelistrootpath") %></h2>

<%@ page language="java" import="java.util.*"%>
<jsp:useBean id="query_object" scope="page"
	class="com.iGrandee.MasterEntries.AcademicSession.AcademicSessionEntry" />
<%

String[] monthnameList={"January","February","March","April","May","June","July","August","September","October","November","December"};

HashMap<String,String> MonthMap=new HashMap<String,String>();
MonthMap.put("January", "1");MonthMap.put("February", "2");MonthMap.put("March", "3");
MonthMap.put("April", "4");MonthMap.put("May", "5");MonthMap.put("June", "6");
MonthMap.put("July", "7");MonthMap.put("August", "8");MonthMap.put("September", "9");
MonthMap.put("October", "10");MonthMap.put("November", "11");MonthMap.put("December", "12");

java.util.Calendar cal = java.util.Calendar.getInstance();  
int year = cal.get(cal.YEAR);  
int month = cal.get(cal.MONTH)+1; //zero-based  
System.out.println("year = "+year+"\nmonth = "+month);  

String startmonth= null;
String startyear= null;
String endmonth= null;
String endyear= null;

	String sessionid = request.getParameter("sessionid");
String sessionname=""; 
String description=""; 
	String sessionstatus= request.getParameter("sessionstatus");
try
{
ArrayList getDetailsForuadate=query_object.getDetailsForuadate(sessionid);     
HashMap DetailsForuadate=null;
for(int k=0;k<getDetailsForuadate.size();k++)
{
	DetailsForuadate=(HashMap)getDetailsForuadate.get(k);
	sessionname=(String)DetailsForuadate.get("sessionname");
	 description=(String)DetailsForuadate.get("description");
	 startmonth=(String)DetailsForuadate.get("startmonth");
	 startyear=(String)DetailsForuadate.get("startyear");
	 endmonth=(String)DetailsForuadate.get("endmonth");
	 endyear=(String)DetailsForuadate.get("endyear");

}
if(description.equals(""))
{
description="-";
} 

}
catch(Exception e)
{
	e.printStackTrace();
	}
	
	
%>
<form name="MainForm" method="post" action="">

<TABLE align="center" width="100%" height="100%" border=0 cellspacing=0
	cellpadding=0>
	
	<tr>
		<td>
<table id="rounded-corner" border=0 summary="Medium List" width="100%">
    <thead>
    	<tr>
        	
        	<th scope="col" class="rounded-company" width="80%"><%=bundle.getString("label.academicsession.updatetableheading") %></th>
        	<th scope="col" class="rounded-q4" width="20%" ><font color=red>*</font> <%=bundle.getString("label.academicsession.mandatoryfields") %></th>
            
        </tr>
    </thead>
    
</table>
		<table id="rounded-corner" border=0 width="100%">


    <thead>
			<tr bordercolor=white valign="top">
				<td  class="tablebold"><%=bundle.getString("label.academicsession.academicsessionname") %> <font color=red>*</font></td>
				<td class=tablebold>:</td><td><input type="text" name="sessionname" size=50  validate="Subject Mode Name" maxlength=45  value="<%=sessionname.replaceAll("\"","&quot")%>"></td>
			</tr>
			<tr valign="top">
				<td class="tablebold" >Session  Duration </td>
				<td class=tablebold>:</td>
				<td>
				<a class=tablebold>Start :</a><select id="monthstart" name="monthstart">
				<%
						
						for (int i = 0,j=1; i < monthnameList.length; i++,j++) {
					        String strName = monthnameList[i];
					        
					    	if(MonthMap.containsKey((startmonth))){
								if(Integer.parseInt(MonthMap.get(startmonth)) ==j)
					        	out.println("<option value="+j+" selected>"+strName+"</option>");
					        else
					        	out.println("<option value="+j+">"+strName+"</option>");
					    	}
					    	else{
					    		if(month==j)
					    		out.println("<option value="+j+" selected>"+strName+"</option>");
						        else
						        	out.println("<option value="+j+">"+strName+"</option>");
					    	}
					    		
					        
					      }
 
				%>
				</select>
				<select name="yearstart" id="yearstart">
				<%
				for(int x=1995;x<2050;x++){
					
					if(startyear !=null && !startyear.isEmpty()){
					if(x==Integer.parseInt(startyear))
						out.println("<option selected>"+x+"</option>");
					else
						out.println("<option>"+x+"</option>");
					}
					else
					{
						if(x==year)
							out.println("<option selected>"+x+"</option>");
						else
							out.println("<option>"+x+"</option>");
					}
				}
				%>
				</select>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<a class=tablebold>End :</a><select name="monthend"  id="monthend">
				<%
						
						for (int i = 0,j=1; i < monthnameList.length; i++,j++) {
					        String strName = monthnameList[i];
					        if(MonthMap.containsKey((endmonth))){
								if(Integer.parseInt(MonthMap.get(endmonth)) ==j)  
					        	out.println("<option value="+j+" selected>"+strName+"</option>");
					        else
					        	out.println("<option value="+j+">"+strName+"</option>");
					        }
					        else
					        {
					        	if(month ==j)
						        	out.println("<option value="+j+" selected>"+strName+"</option>");
						        else
						        	out.println("<option value="+j+">"+strName+"</option>");
						        
					        }
					        
					      }
 
				%>
				</select>
				<select name="yearend"   id="yearend">
				<%
				for(int x=2000;x<2050;x++){
					
					if(endyear !=null && !endyear.isEmpty()){
						if(x==Integer.parseInt(endyear))
						out.println("<option value="+x+" selected >"+x+"</option>");
						else
							out.println("<option value="+x+">"+x+"</option>");
					}
					
				else{
					if(x==year)
						out.println("<option value="+x+" selected >"+x+"</option>");
					else
						out.println("<option value="+x+">"+x+"</option>");
				}
				}
				%>
				</select>
				</td>
			</tr>
			
			<tr bordercolor=white valign="top">
							<td  class="tablebold"><%=bundle.getString("label.academicsession.description") %> </td>
			
			
									<td class=tablebold>:</td><td><textarea  cols=75 rows=2 class="tablelight" name="descryption" onkeydown="textCounter_label(document.MainForm.descryption,document.getElementById('labelid'),2000)" onkeyup="textCounter_label(document.MainForm.descryption,document.getElementById('labelid'),2000)"><%=description%></textarea>&nbsp; <br><br><i><font color="red"><label id="labelid" ><%=bundle.getString("label.academicsession.charactercount") %></label>&nbsp;&nbsp;<%=bundle.getString("label.academicsession.charactersleft") %></font></i></td>
				
			</tr>
			
		<tr>	
		<td colspan=3><input type="hidden" name="sessionid" value="<%=sessionid %>"></td></tr>
			
		</table>
				 <a href='#' onclick='goToBack()' class='bt_blue'><span class='bt_blue_lft'></span><strong><%=bundle.getString("button.academicsession.back") %></strong><span class='bt_blue_r'></span></a>
		
		<%
		//if(sessionstatus.equals("R") || sessionstatus.equals("A"))
			if(sessionstatus.equals("R"))
		{
			
		}
		else
		{
		out.println(" <a href='#' onclick=goToUpdate() class='bt_green'><span class='bt_green_lft'></span><strong>"+bundle.getString("button.academicsession.update") +"</strong><span class='bt_green_r'></span></a>");
		}
		%>
		

	
	
	<%
	if(sessionstatus.equals("R"))
	{
		out.println("<div class='warning_box'>");
		out.println(bundle.getString("label.academicsession.trashpreviewerrormessagedetails"));
		out.println("</div>");		
	}
	
	else if(sessionstatus.equals("A"))
	{
		out.println("<div class='warning_box'>");
		out.println(bundle.getString("label.academicsession.trashpreviewerrormessagedetails_1"));
		out.println("</div>");	
	}
	
			%>	
			
			
			
</TABLE>
</div><!-- end of right content-->


  </div>   <!--end of center content -->


    <div class="clear"></div>
    </div> <!--end of main content-->
    
<%@ include file="../../include/footer.jsp" %>

</div>

    </form>
	
</body>
</html>
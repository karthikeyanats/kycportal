<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
	<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title><%=bundle.getString("label.academicsession.entrytitle") %></title>


<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<SCRIPT language="JavaScript" src="<%=request.getContextPath()%>/js/Validation.js"></SCRIPT>

<script language="JavaScript">

	
function submitfun()
{
	if(check_ForParticularElements(document.MainForm.sessionname,"text"))
	{
		
		monthstart  = parseInt(document.getElementById("monthstart").options[document.getElementById("monthstart").selectedIndex].value);
		yearstart  = parseInt(document.getElementById("yearstart").options[document.getElementById("yearstart").selectedIndex].value);
		monthend  = parseInt(document.getElementById("monthend").options[document.getElementById("monthend").selectedIndex].value);
		yearend  = parseInt(document.getElementById("yearend").options[document.getElementById("yearend").selectedIndex].value);
		
		if((monthstart+yearstart) > (monthend+yearend)){
			alert("The start (month, Year)  should not less than the End (month, year) ")
			return false;
		}
			document.MainForm.action= "AcademicSessionSubmit.jsp";
			document.MainForm.submit();
		
		
	}
		
}
function resetfun()
{
document.MainForm.reset();
document.getElementById("labelid").innerHTML	= "2000";

}
function deptview()
{
document.MainForm.action= "AcademicSessionList.jsp";
document.MainForm.submit();
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
		       <h2><%=bundle.getString("label.academicsession.entryrootpath") %></h2>
	
	<%
	String[] monthnameList={"January","February","March","April","May","June","July","August","September","October","November","December"};

	java.util.Calendar cal = java.util.Calendar.getInstance();  
    int year = cal.get(cal.YEAR);  
    int month = cal.get(cal.MONTH)+1; //zero-based  
    //System.out.println("year = "+year+"\nmonth = "+month);  
	
	%>
	
<TABLE align="center" width="100%" height="100%" border=0 cellspacing=0
	cellpadding=0>
	
	
	<tr>
		<td>
<table id="rounded-corner" border=0 summary="Department List" width="100%">
    <thead>
    	<tr>
    
        	<th scope="col" class="rounded-company" width="80%"><%=bundle.getString("label.academicsession.entrytableheading") %></th>
        	<th scope="col" class="rounded-q4" width="20%" ><font color=red>*</font> <%=bundle.getString("label.academicsession.mandatoryfields") %></th>
            
        </tr>
    </thead>
    <tfoot>
    	<tr>
        	<td  class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
     <tbody>
</tbody>
<table id="rounded-corner" border=0  width="100%">
    <thead>			<tr valign="top">
				<td class="tablebold" >
				<%=bundle.getString("label.academicsession.academicsessionname") %> <font color=red>*</font></td>
				
				<td class=tablebold>:</td>
				<td><input type="text" name="sessionname"
					validate="Year Of Session" class=tablelight size="50" value=""
					maxlength=45/>
					</td>
			</tr>
			<tr valign="top">
				<td class="tablebold" >Session  Duration </td>
				<td class=tablebold>:</td>
				<td>
				<a class=tablebold>Start :</a><select id="monthstart" name="monthstart">
				<%
						
						for (int i = 0,j=1; i < monthnameList.length; i++,j++) {
					        String strName = monthnameList[i];
					        if(month ==j)
					        	out.println("<option value="+j+" selected>"+strName+"</option>");
					        else
					        	out.println("<option value="+j+">"+strName+"</option>");
					        
					      }
 
				%>
				</select>
				<select name="yearstart" id="yearstart">
				<%
				for(int x=1995;x<2050;x++){
					if(x==year)
						out.println("<option selected>"+x+"</option>");
					else
						out.println("<option>"+x+"</option>");
				}
				%>
				</select>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<a class=tablebold>End :</a><select name="monthend"  id="monthend">
				<%
						
						for (int i = 0,j=1; i < monthnameList.length; i++,j++) {
					        String strName = monthnameList[i];
					        if(month ==j)
					        	out.println("<option value="+j+" selected>"+strName+"</option>");
					        else
					        	out.println("<option value="+j+">"+strName+"</option>");
					        
					      }
 
				%>
				</select>
				<select name="yearend"   id="yearend">
				<%
				for(int x=1995;x<2050;x++){
					if(x==year)
						out.println("<option value="+x+" selected >"+x+"</option>");
					else
						out.println("<option value="+x+">"+x+"</option>");
				}
				%>
				</select>
				</td>
			</tr>
			<tr valign="top">
				<td class="tablebold"  ><%=bundle.getString("label.academicsession.description") %></td>
				<td class=tablebold>:</td><td>
				<textarea validate="Description" class="tablelight" cols=75 rows=2 name="descryption" onkeydown="textCounter_label(document.MainForm.descryption,document.getElementById('labelid'),2000)" onkeyup="textCounter(document.MainForm.descryption,document.getElementById('labelid'),2000)"></textarea>&nbsp; <br><br><i><font color="red"><label id="labelid" ><%=bundle.getString("label.academicsession.charactercount") %></label>&nbsp;&nbsp;<%=bundle.getString("label.academicsession.charactersleft") %></font></i>
					
					</td>
			</tr>
			
			</thead>
		</table>
						    <a href="#" onclick="resetfun()" class="bt_blue"><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.academicsession.reset") %></strong><span class="bt_blue_r"></span></a>
							     <a href="#" onclick="deptview()"  class="bt_blue"><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.academicsession.viewallacademicsession") %> </strong><span class="bt_blue_r"></span></a>
							<a href="#" onclick="submitfun()" class="bt_green"><span class="bt_green_lft"></span><strong><%=bundle.getString("button.academicsession.addnewitem") %></strong><span class="bt_green_r"></span></a>
		

		</td>
	</tr>
	
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
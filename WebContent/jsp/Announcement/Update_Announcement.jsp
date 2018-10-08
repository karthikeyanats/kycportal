<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<jsp:useBean id="query_object" scope="page"	class="com.iGrandee.Announcement.AnnouncementEntry" />
<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - <%=bundle.getString("label.announcement.updatetitle") %> | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockp.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockh.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>
<script type="text/javascript" src="jquery.min.js"></script>
<script type="text/javascript" src="ddaccordion.js"></script>
<script language="JavaScript" src="<%=request.getContextPath()%>/js/Calendar/Calendar.js"></script>

<script type="text/javascript">


function submitfun(obj)
{
val = obj.getAttribute("operationMode");
	msgstr = "Do you want to "+val+" the Announcment...?";


	//if(confirm(msgstr))
	{//alert(parseInt(document.main_Form.hide_check.length));
		announcechk = 0;
		for(var k=0;k<parseInt(document.main_Form.hide_check.length);k++)
		{
			req_i = parseInt(k);
			if(eval("document.main_Form.check"+req_i+".checked"))
				announcechk++;
		}
		if(announcechk > 0)
		{
			for(var i=0;i<parseInt(document.main_Form.hide_check.length);i++)
			{
				if(document.main_Form.hide_check[i].value!="Nil")
				{
										req_i = parseInt(i);

					if(eval("document.main_Form.check"+req_i+".checked"))
					{
						flag = true;
						checked_flag =true;
						var tbody  = document.createElement("tbody");
						var newrow1=document.createElement("tr");
						var newcell1 =  document.createElement("td");
						var head_id = eval("document.main_Form.check"+req_i+".getAttribute('content_id')");
						newcell1.innerHTML="<input type=text name=head_id value='"+head_id+"'>";
						newrow1.appendChild(newcell1);


						var newcell1 =  document.createElement("td");
						var content = eval("document.main_Form.content"+req_i+".value");
						newcell1.innerHTML="<textarea name=content_hide style='visibility:hidden'>"+content+"</textarea>";
						newrow1.appendChild(newcell1);

						var newcell1 =  document.createElement("td");
						var status = eval("document.main_Form.check"+req_i+".getAttribute('status_flag')");
						newcell1.innerHTML="<input type=text name=status_hide value='"+status+"'>";
						newrow1.appendChild(newcell1);
						tbody.appendChild(newrow1);
						document.getElementById("tabtop2").appendChild(tbody);

					}
				}
			}
			if(confirm(msgstr)){
			document.main_Form.mode_of_operation.value = val;
			document.main_Form.action = "updatesubmit_announce.jsp";
			document.main_Form.submit();
			}
		}
		
		else if(announcechk == 0)
		{
			
				if(document.main_Form.hide_check.value!="Nil")
				{

					if(document.main_Form.check0.checked)
					{
						flag = true;
						checked_flag =true;
						var tbody  = document.createElement("tbody");
						var newrow1=document.createElement("tr");
						var newcell1 =  document.createElement("td");
						var head_id = eval("document.main_Form.check0.getAttribute('content_id')");
						newcell1.innerHTML="<input type=text name=head_id value='"+head_id+"'>";
						newrow1.appendChild(newcell1);


						var newcell1 =  document.createElement("td");
						var content = eval("document.main_Form.content0.value");
						newcell1.innerHTML="<textarea name=content_hide style='visibility:hidden'>"+content+"</textarea>";
						newrow1.appendChild(newcell1);

						var newcell1 =  document.createElement("td");
						var status = eval("document.main_Form.check0.getAttribute('status_flag')");
						newcell1.innerHTML="<input type=text name=status_hide value='"+status+"'>";
						newrow1.appendChild(newcell1);
						tbody.appendChild(newrow1);
						document.getElementById("tabtop2").appendChild(tbody);

					}
					else
					{
								alert("Select Checkbox");
					return false;
					}
				}
			if(confirm(msgstr)){
			document.main_Form.mode_of_operation.value = val;
			document.main_Form.action = "updatesubmit_announce.jsp";
			document.main_Form.submit();
			}
		}
		
	
		
		else
		{
			alert("Select checkbox");
		}
	}
}


function checkfun(id,flag)
{
	if(eval("document.main_Form.content"+id+".value.length <= 0"))
	{
		alert("Empty  Content Not Allowed for Para"+(parseInt(id)+1));
		eval("document.main_Form.content"+id+".focus()");
	}
	
}
function goback()
{
document.main_Form.action = "announcement.jsp";
			document.main_Form.submit();
}

</script>
</head>
<body>


<%@ page language="java"%>

<%@ page import="java.util.ResourceBundle,java.util.ArrayList,java.util.HashMap"%>
<%
	String userid			= "";
	boolean token_flag 		= false;
	String current_content 	= "";
	ArrayList announcelist	= null;
	
%>
<%
String createdby = (String)session.getValue("userid");
String instituteid = (String)session.getValue("instituteid");

	try
	{
		if(session.getValue("userid")==null)
			out.println("<script></script>");
		else
			userid		= session.getValue("userid").toString();

		announcelist	= query_object.getAnnouncement(instituteid);
	}
	catch(NullPointerException ne)
	{
		//System.out.println(ne);
	}
%>
<div id="main_container">
	<div class="header">
<%@ include file="../include/userheader.jsp" %>
   
    </div>

    <div class="main_content">

<%@ include file="../include/header.jsp" %>


    <div class="center_content">



    <div class="left_content">

    </div>

    <div class="right_content">

    <h2><%=bundle.getString("label.announcement.viewlist") %></h2>
 		  <form name="main_Form" method="post" action="">
 
<TABLE align="center" width="100%" height="100%" border=0 cellspacing=0
	cellpadding=0>
	
	
<table id="rounded-corner" border=0 summary="Department List" width="100%">
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="5%"><%=bundle.getString("label.announcement.slno") %></th>
        	<th scope="col" class="rounded" width="55%"><%=bundle.getString("label.announcement.content") %></th>
        	<th scope="col" class="rounded" width="20%" ><a  ><%=bundle.getString("label.announcement.dateofcreation") %></a></th>
        	<th scope="col" class="rounded" width="10%"  ><a ><%=bundle.getString("label.announcement.status") %></a></th>
            <th scope="col" class="rounded-q4" width="8%" ><a  ><%=bundle.getString("label.announcement.check") %></a></th>
            
        </tr>
    </thead>
    <tbody>
			
		  	<tr>
		  	<%
		  	try
		  	{
				if(announcelist != null && announcelist.size()>0)
				{
					String state_str 	= null;
					token_flag= true;
					for(int y=0;y<announcelist.size();y++)
					{
						HashMap hm =(HashMap)announcelist.get(y);
						String contentid = (String)hm.get("announcementid");
						String content = (String)hm.get("annoucementdetails");
						String status= (String)hm.get("announcementstatus");
						String newdates = (String)hm.get("newdates");

						if(status.equals("A"))
							state_str = "<font color=green>"+bundle.getString("label.announcement.activated")+"</font>";
						else if(status.equals("D"))
							state_str = "<font color=red>"+bundle.getString("label.announcement.deactivated")+"</font>";
							
				
					
						out.println("<tr class=tablelight id='tabs"+y+"'><td align=center width='5%'>"+(y+1)+"</td><td><textarea name=content"+y+" class=tablelight rows=3 cols=60 onkeydown=textCounter_label(document.main_Form.content"+y+",document.getElementById('labelid"+y+"'),2000) onkeyup=textCounter_label(document.main_Form.content"+y+",document.getElementById('labelid"+y+"'),2000)>"+content+"</textarea><br><br><i><font color='red'><label id='labelid"+y+"' >"+bundle.getString("label.announcement.charactercount") +"</label>&nbsp;&nbsp;"+bundle.getString("label.announcement.charactersleft") +"</font></i></td><td class=tablelight width='15%' class=tablelight>"+newdates+"</td><td  class=tablebold>"+state_str+"</td><td width='8%'><input type=checkbox name=check"+y+" status_flag='"+status+"' content_id='"+contentid+"' id='"+y+"' class=tabledivison onclick=checkfun('"+y+"','checked')><input type=hidden name=hide_check></tr>");

					
					}
				}
				else
				{  
					out.println("<td colspan='5' align=center><font color='red'><b>Data Not Found</b></font></td>");
					//out.println("<td align=center colspan=5>Data Not Found</td>");
				}
		  	%>
		  	</tr>
		  	</tbody>
    
    
    
    
    <tfoot>
    	<tr>
        	<td colspan=4  class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
     <tbody>
</tbody>
</table>
 
		
			
			<%
				if(token_flag)
				{%>
		  <center><a href="#" onclick="goback()" name=bck1 value='BACK' class="bt_blue"><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.announcement.back") %> </strong><span class="bt_blue_r"></span></a></center>
		   <center><a href="#" class="bt_red" name=trash value='TRASH' operationMode='TRASH' onclick=submitfun(this)><span class="bt_red_lft"></span><strong><%=bundle.getString("button.announcement.trash") %></strong><span class="bt_red_r"></span></a></center>
		   <center>  <a href="#" class="bt_red" name=deact value='DEACTIVATE'  flag_v='D' operationMode='DEACTIVATE' onclick=submitfun(this)><span class="bt_red_lft"></span><strong><%=bundle.getString("button.announcement.deactive") %></strong><span class="bt_red_r"></span></a></center>
		   <center> <a href="#" class="bt_green" name=acts value='ACTIVE' flag_v='A'  operationMode='ACTIVATE' onclick=submitfun(this)><span class="bt_green_lft"></span><strong><%=bundle.getString("button.announcement.active") %></strong><span class="bt_green_r"></span></a></center>
		  <center><a href="#" class="bt_green" name=updte value='UPDATE' operationMode='UPDATE' onclick=submitfun(this)><span class="bt_green_lft"></span><strong><%=bundle.getString("button.announcement.update") %></strong><span class="bt_green_r"></span></a></center> 		
		  	<%}
		  	else
		  		{%>
		  <center><a href="#" onclick="goback()" name=bck1 value='BACK' class="bt_blue"><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.announcement.back") %> </strong><span class="bt_blue_r"></span></a></center>
		  <%
			}
		  	}catch(Exception e){}
			%>	  		
		  		  		
<br>
 <input type=hidden name=mode_of_operation>

<table id="tabtop2" style=visibility:hidden></table>
</td></tr></TABLE>
    </thead>
</table>
</form>


   
 
     </td>
     </tr>
     </TABLE>
     </div><!-- end of right content-->


  </div>   <!--end of center content -->

    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../include/footer.jsp" %>
    
</form>

</div>
</body>
</html>
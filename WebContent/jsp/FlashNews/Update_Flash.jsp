<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>	
	
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - <%=bundle.getString("label.flashnews.updatetitle") %> | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockp.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockh.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>
<script type="text/javascript" src="jquery.min.js"></script>
<script type="text/javascript" src="ddaccordion.js"></script>
<script language="JavaScript" src="<%=request.getContextPath()%>/js/Calendar/Calendar.js"></script>

<script type="text/javascript">

function submitfun(val,val1)
{
	msgstr = "Do you want to "+val+" the Flash News...?";

	if(confirm(msgstr))
	{
		announcechk = 0;
		for(var k=0;k<parseInt(document.main_Form.hide_check.length)-1;k++)
		{
			req_i = parseInt(k);
			if(eval("document.main_Form.check"+req_i+".checked"))
				announcechk++;
		}
		if(announcechk >= 1)
		{
			for(var i=0;i<parseInt(document.main_Form.hide_check.length)-1;i++)
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
						newcell1.innerHTML="<input type=hidden name=head_id value='"+head_id+"'>";
						newrow1.appendChild(newcell1);


						var newcell1 =  document.createElement("td");
						var content = eval("document.main_Form.content"+req_i+".value");
						newcell1.innerHTML="<textarea name=content_hide style='visibility:hidden' onkeydown=textCounter_label(this) onkeyup=textCounter_label(this) value='"+content+"' >"+content+"</textarea>";
						newrow1.appendChild(newcell1);

						var newcell1 =  document.createElement("td");
						var status = eval("document.main_Form.check"+req_i+".getAttribute('status_flag')");
						newcell1.innerHTML="<input type=hidden name=status_hide value='"+status+"'>";
						newrow1.appendChild(newcell1);
						tbody.appendChild(newrow1);
						document.getElementById("tabtop2").appendChild(tbody);

					}
				}
			}
			
			document.main_Form.mode_of_operation.value = val;
			document.main_Form.action = "Insert_Flash.jsp";
			document.main_Form.submit();
		}
		else
		{
			alert("Select checkbox");
		}
	}
}

function goback()
{
	location.replace("./FlashNews.jsp");
}

function checkfun(id,flag)
{

	if(eval("document.main_Form.content"+id+".value.length <= 0"))
	{
		alert("Empty  Content Not Allowed for Para"+(parseInt(id)+1));
		eval("tabs"+id+".bgcolor='#ffffff'");
		eval("document.main_Form.content"+id+".focus()");
		eval("document.main_Form.check"+id+".checked=false");

	}
	
}



</script>
</head>
<body>
<%@ page import="java.util.ArrayList,java.util.HashMap"%>

<jsp:useBean id="query_object" 	scope="page" class="com.iGrandee.FlashNews.FlashNewsEntry" />
<jsp:useBean id="instituteBean" 	scope="page" class="com.iGrandee.FlashNews.FlashNewsBean" />

<%
String instituteid=(String)session.getValue("instituteid");
	String date_str 		= null;
	ArrayList alist			= null;
	ArrayList flist			= null;

	flist=query_object.getAllFlashNews(instituteid);
%>

<%
	boolean token_flag = false;
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

    <h2><%=bundle.getString("label.flashnews.updaterootpath") %></h2>
    
 		  <form name="main_Form" method="post" action="">
 

<table id="rounded-corner" border=0 summary="Department List" width="100%">
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="5%"><%=bundle.getString("label.flashnews.slno") %></th>
        	<th scope="col" class="rounded" width="80%"><%=bundle.getString("label.flashnews.content") %></th>
        	   <th scope="col" class="rounded" width="20%" ><a  ><%=bundle.getString("label.flashnews.dateofcreation") %></a></th>
        	  <th scope="col" class="rounded" width="10%"><%=bundle.getString("label.flashnews.status") %></th>
        	  <th scope="col" class="rounded-q4" width="8%" ><%=bundle.getString("label.flashnews.check") %></th>
            
        </tr>
    </thead>
    <tbody>
		  	<tr>
		  	<%

		  		if(flist != null && flist.size()>0)
				{	
					token_flag= true;
					String state_str 		= null;
					int inc_i = 0; int inc_i1 =1;
					for(int t=0;t<flist.size();t++)
					{
						HashMap hm 			= (HashMap)flist.get(t);
						String cdate 		= (String)hm.get("dateofcreation");
						String contentid 	= (String)hm.get("flashid");
						String content 		= (String)hm.get("flashmessage");
						String status		= (String)hm.get("flashstatus");

						if(status.equals("A"))
							state_str = "<font color=green>"+bundle.getString("label.flashnews.activated")+"</font>";
						else if(status.equals("D"))
							state_str = "<font color=red>"+bundle.getString("label.flashnews.deactivated")+"</font>";

						
						out.println("<tr class=tablelight id='tabs"+t+"'><td align=center>"+(t+1)+"</td><td><textarea name=content"+t+" class=tablebig rows=3 cols=50 onkeydown=textCounter_label(document.main_Form.content"+t+",document.getElementById('labelid"+t+"'),2000) onkeyup=textCounter_label(document.main_Form.content"+t+",document.getElementById('labelid"+t+"'),2000)>"+content+"</textarea><br><br><i><font color='red'><label id='labelid"+t+"' >"+bundle.getString("label.flashnews.charactercount")+"</label>&nbsp;&nbsp;"+bundle.getString("label.flashnews.charactersleft")+"</font></i></td><td  class=tablelight>"+(String)hm.get("newdates")+"</td><td   class=tablebold>"+state_str+"</td><td><input type=checkbox name=check"+t+" status_flag='"+status+"' content_id='"+contentid+"' id='"+t+"' class=tabledivison onclick=checkfun('"+t+"','checked')><input type=hidden name=hide_check></tr>");

						inc_i++;
					}
				}
				else
				{
					out.println("<tr align='center' class='tablebold'><td colspan='9'><font color='red'>Data Not Found</font></td></tr>");
					//out.println("<tr class=tablebold><td align=center colspan=5>Data Not Found</td></tr>");
				}


		  	%>
		  	</tr>
		  	</tbody>
		  	</table>
		  	
		  	<br>
		  	
	<table id="tabtop2" style=visibility:hidden>
</table>			
			
			
			<%
				if(!token_flag)
				{%>
			 <a href="#" onclick="goback()" name=bck1 value='' class="bt_blue"><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.flashnews.back") %> </strong><span class="bt_blue_r"></span></a>
		  	<%}
		  	else
		  		{%>
			<center><a href="#" onclick="goback()" name=bck1 value='BACK' class="bt_blue"><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.flashnews.back") %> </strong><span class="bt_blue_r"></span></a></center>
		   		  		   <center> <a href="#" class="bt_green" name=acts value='TRASH' flag_v='T'  operationMode='TRASH' onclick=submitfun('TRASH','T')><span class="bt_green_lft"></span><strong><%=bundle.getString("button.flashnews.trash") %></strong><span class="bt_green_r"></span></a></center>
		   		  
		   		  <center>  <a href="#" class="bt_green" name=deact value='DEACTIVATE'  flag_v='D' operationMode='DEACTIVATE' onclick=submitfun('DEACTIVATE','D')><span class="bt_green_lft"></span><strong><%=bundle.getString("button.flashnews.deactive") %></strong><span class="bt_green_r"></span></a></center>
		   
		   <center> <a href="#" class="bt_green" name=acts value='ACTIVE' flag_v='A'  operationMode='ACTIVATE' onclick=submitfun('ACTIVATE','A')><span class="bt_green_lft"></span><strong><%=bundle.getString("button.flashnews.active") %></strong><span class="bt_green_r"></span></a></center>
		  <center><a href="#" class="bt_green" name=updte value='UPDATE' operationMode='UPDATE' onclick=submitfun('UPDATE','U')><span class="bt_green_lft"></span><strong><%=bundle.getString("button.flashnews.update") %></strong><span class="bt_green_r"></span></a></center>
		  		  		
		  <%
			}
		  	
			%>	  	
			
			
		


<input type="hidden" name="first" value="">
						<input type="hidden" name="second" value="">
						<input type="hidden" name="third" value="">


<input type=hidden name="hide_check" value="nil">
<input type=hidden name=mode_of_operation>

     </form>
     
     </div><!-- end of right content-->

  </div>   <!--end of center content -->

    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../include/footer.jsp" %>
    

</div>
</body>
</html>
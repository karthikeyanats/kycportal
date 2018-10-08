<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - <%=bundle.getString("label.scalecreation.updatetitle") %> | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>

<script type="text/javascript">


function updateFun()
{
	if(check_ForParticularElements(document.scaleform.scalename,"text",document.scaleform.standardboard,"select"))
	{
		var scaleName = RTrim(document.scaleform.scalename.value);
		scaleName = LTrim(scaleName);
		document.scaleform.scalename.value = scaleName;	
	document.scaleform.reqboardid.value = document.scaleform.standardboard.options[document.scaleform.standardboard.options.selectedIndex].value;
	document.scaleform.reqboardname.value = document.scaleform.standardboard.options[document.scaleform.standardboard.options.selectedIndex].text;
	document.scaleform.action="./UpdateScale.jsp";
	document.scaleform.submit();
	}
}
function checkNames()
{
 var date = new Date();   
	 var url = "checkDuplicate.jsp?flage=scaleupdate&fieldname1="+document.scaleform.scalename.value+"&reqscaleid="+document.scaleform.reqscaleid.value+"&standardboard_temp="+document.scaleform.standardboard_temp.value+"&date="+date;

 	   var req =initRequest(); 
 	   req.onreadystatechange = function()
 	   {
 		   if (req.readyState == 4)
 		   {   

 			   if (req.status == 200)
 			   {

  				  parseMessages(req.responseXML,"LoadReply");

 			   }
 			   else if (req.status == 204)
 			   {

 			   }
 		   }
 	   };
 	   req.open("GET", url, true);
 	   req.send(null);
 	}
 	
 
function parseMessages(parseXML,check_var)
{
	   var rootobj=parseXML.getElementsByTagName("complaintdetails");
	  
		var clength=rootobj[0].childNodes.length;
		var ask=rootobj[0].childNodes.item(0).childNodes.item(0).firstChild.nodeValue;
		if(ask=="true")
		{
		alert("Scale Name already Exist")
		}
		else
		{
		updateFun()
		}
	}
	function boardchange()
	{
		document.scaleform.standardboard_temp.value = document.scaleform.standardboard.options[document.scaleform.standardboard.options.selectedIndex].value;
	
	}

	function goBack()
	{
	document.scaleform.action="./ScaleList.jsp";
	document.scaleform.submit();	
	}	

</script>
</head> 
<body>
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

    <h2><%=bundle.getString("label.scalecreation.updaterootpath") %></h2>
    <form name="scaleform" action="" method="post">
   
<%@ page import="java.util.ArrayList,java.util.HashMap,com.iGrandee.MasterEntries.Standard.StandardQuery,com.iGrandee.GradeSetting.GradeScaleQuery"%>

     <%
     
     com.iGrandee.MasterEntries.Standard.StandardQuery  standardQuery = new com.iGrandee.MasterEntries.Standard.StandardQuery();
     com.iGrandee.GradeSetting.GradeScaleQuery  gradescaleQuery = new com.iGrandee.GradeSetting.GradeScaleQuery();

     String instituteid = null;
     ArrayList BoardList = null;
     ArrayList scaleList = null;
     ArrayList scalegradeFlagList = null;
     String reqboardid = null;
     String reqboardname = null;
     String reqscalename = null;
     String reqscaleid = null;

     //ArrayList subjectFlagList = null;
     try
     {
    	 reqboardid= request.getParameter("reqboardid");
    	instituteid = (String)session.getValue("instituteid");
   		reqscaleid = request.getParameter("reqscaleid");
   		scaleList = gradescaleQuery.loadScaleDetails(reqscaleid);
   		scalegradeFlagList = gradescaleQuery.loadGradeStatusforUpdate(reqscaleid,"grade");
   		BoardList = standardQuery.listBoard(instituteid);
   		
   		//subjectFlagList = standardQuery.loadStandardStatusforUpdate(reqscaleid,"subject");

   		
    }catch(Exception e){}
    
    %>
    <%
    
	    String scaleid   = "";
		String scalename = "";
		String boardid     	= "";
		String boardname   	= "";
		String mediumname 	= "";
		
	    if(scaleList!=null && scaleList.size()>0)
		{
			HashMap StandardListMap=(HashMap)scaleList.get(0);
	
			scaleid       = (String)StandardListMap.get("scaleid");
			scalename      = (String)StandardListMap.get("scalename");
			boardid      = (String)StandardListMap.get("boardid");
			boardname      = (String)StandardListMap.get("boardname");
			mediumname      = (String)StandardListMap.get("mediumname");
		}
   %>
    <input type="hidden" name="standardboard_temp" value="<%=reqboardid %>">
               
     
    <table id="rounded-corner" border=0 summary="Selected List" width="100%">
    <thead>
    	<tr>
    	
        	<th scope="col" class="rounded-company" width="90%"><%=bundle.getString("label.scalecreation.updatetheading") %> </th>
        	<th scope="col" class="rounded-q4" width="10%"></th>
            
        </tr>
    </thead>
    <tfoot>
    	<tr>
        	<td colspan=1 class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
     <tbody>
   
  <tr>
  <td colspan=2>
    <table id="" border="0" cellpadding=5 width="100%">
	<tr>
	<td class=tablebold><%=bundle.getString("label.scalecreation.Board-Medium") %> </td><td class=tablebold>:</td><td><%= boardname+"-"+mediumname %></td>
	<td class=tablebold> <%=bundle.getString("label.scalecreation.StandardName") %> </td><td class=tablebold>:</td><td><%= scalename %></td></tr>
	</table>
	</td>
	
	</tr>
	</tbody>
	</table>
	
    
    <br>
    
 <table id="rounded-corner" border=0 summary="Selected List" width="100%">
    <thead>
    	<tr>
    	
        	<th scope="col" class="rounded-company" width="80%"><%=bundle.getString("label.scalecreation.updatetheading_1") %></th>
        	<th scope="col" class="rounded-q4" width="20" colspan=3><font color=red>*</font> <%=bundle.getString("label.scalecreation.mandatoryfields") %></th>
            
        </tr>
    </thead>
    <tfoot>
    	<tr>
        	<td class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
     <tbody>
   
  <tr>
  <td colspan=2>
<table border="0" width="100%">
	<tr><td class=tablebold><%=bundle.getString("label.scalecreation.Standard") %> <font color="red">*</font> </td><td class=tablebold>:</td><td><input type=text name="scalename" validate="Scale Name" value="<%=scalename %>" size="27" maxlength="43"/></td></tr>

<tr><td class=tablebold><%=bundle.getString("label.scalecreation.Board-Medium") %> <font color="red">*</font></td><td class=tablebold>:</td><td>

<select name="standardboard" class=tablelight onchange="boardchange()"> <option>-Select Board-Medium- </option>
        <%
   			
        	if(BoardList!=null && BoardList.size()>0)
			{
   		 	for (int i = 0, j = 1; i < BoardList.size(); i++) {
			
				HashMap boardListMap=(HashMap)BoardList.get(i);
				String sboardid     = (String)boardListMap.get("boardid");
				String sboardname      = (String)boardListMap.get("boardname");
				String smediumid      = (String)boardListMap.get("mediumid");
				String smediumname      = (String)boardListMap.get("mediumname");
				if(boardid.equals(sboardid))
				{
       		 		out.println("<option value='"+sboardid+"' class=tablelight selected>"+sboardname+"-"+smediumname+"</option>");
				}
				else
				{
				out.println("<option value='"+sboardid+"' class=tablelight >"+sboardname+"-"+smediumname+"</option>");
				}
   		 	}
			}
   		 %>
        </select>
</td>
</tr>

</table>
  
  </td>

 </tr>
</tbody>
</table>
<br>
<%
	if(scalegradeFlagList != null && scalegradeFlagList.size() > 0)
	{
		%>
		<div class="warning_box">
       <%=bundle.getString("label.scalecreation.errormessage") %>Update
     	</div>
		<%
	}
%>
          <a href="#" onclick="goBack()" class="bt_blue"><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.scalecreation.BacktoStandardList") %></strong><span class="bt_blue_r"></span></a>

<%if(scalegradeFlagList == null || scalegradeFlagList.size() == 0)
{ %>
	<a href="#" onclick="checkNames()" class="bt_green"><span class="bt_green_lft"></span><strong><%=bundle.getString("button.scalecreation.UpdateStandard") %></strong><span class="bt_green_r"></span></a>
	<%} %>     
     
     <input type="hidden" name="reqboardname"/>
     <input type="hidden" name="reqboardid" value="<%=reqboardid %>"/>
     <input type="hidden" name="reqscaleid" value="<%=reqscaleid %>"/>
     <input type="hidden" name="reqscalename"/>
     <input type="hidden" name="reqgroupstatus"/>
      <input type="hidden" name="scaleoperation" value="UpdateScale"/>
     
     
</form>
     </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../../include/footer.jsp" %>
    

</div>
</body>
</html>


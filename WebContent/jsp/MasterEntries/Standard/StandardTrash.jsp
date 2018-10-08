<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - <%=bundle.getString("label.standard.trashtitle") %> | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockp.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockh.js"></script>
<script type="text/javascript">


function trashFun()
{
	document.standardForm.action="./UpdateStandard.jsp";
	document.standardForm.submit();
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

    <h2><%=bundle.getString("label.standard.trashrootpath") %></h2>
    <form name="standardForm" action="" method="post">
<%@ page import="java.util.ArrayList,java.util.HashMap,com.iGrandee.MasterEntries.Standard.StandardQuery"%>

     <%
     
     com.iGrandee.MasterEntries.Standard.StandardQuery  standardQuery = new com.iGrandee.MasterEntries.Standard.StandardQuery();
     String instituteid = null;
     ArrayList BoardList = null;
     ArrayList standardList = null;
     
     String reqboardid = null;
     String reqboardname = null;
     String reqstandardname = null;
     String reqstandardid = null;
     ArrayList standardscheduleFlagList = null;
     ArrayList subjectFlagList = null;
     
     try
     {
    	instituteid = (String)session.getValue("instituteid");
   		reqstandardid = request.getParameter("reqstandardid");
   		standardList = standardQuery.loadStandardDetails(reqstandardid);
   		BoardList = standardQuery.listBoard(instituteid);
   		
   		subjectFlagList = standardQuery.loadStandardStatusforUpdate(reqstandardid,"subject");
   		
    }catch(Exception e){}
    
    %>
    <%
    
	    String standardid   = "";
		String standardname = "";
		String description  = "";
		
		String groupstatus  = "";
		String boardid     	= "";
		String boardname   	= "";
		String mediumname 	= "";
		
	    if(standardList!=null && standardList.size()>0)
		{
			HashMap StandardListMap=(HashMap)standardList.get(0);
	
			standardid       = (String)StandardListMap.get("standardid");
			standardname      = (String)StandardListMap.get("standardname");
			description     = (String)StandardListMap.get("description");
			if(description == null)
				description = "";
			groupstatus      = (String)StandardListMap.get("groupstatus");
			boardid      = (String)StandardListMap.get("boardid");
			boardname      = (String)StandardListMap.get("boardname");
			mediumname      = (String)StandardListMap.get("mediumname");
		}
   %>
    <table id="rounded-corner" border=0 summary="Selected List" width="100%">
    <thead>
    	<tr>
    	
        	<th scope="col" class="rounded-company" width="95%"><%=bundle.getString("label.standard.trashheading") %> </th>
        	<th scope="col" class="rounded-q4" width="5%"></th>
            
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
    <table id="" border="0" cellpadding=5 width="100%">
	<tr>
	<td class=tablebold><%=bundle.getString("label.standard.Board-Medium") %>  </td>
	<td class=tablebold>:</td>
	<td><%= boardname+"-"+mediumname %></td>
	<td class=tablebold><%=bundle.getString("label.standard.StandardName") %>  </td>
	<td class=tablebold>:</td>
	<td><%= standardname %></td></tr>
	<tr><td class=tablebold><%=bundle.getString("label.standard.GroupDescription") %>  </td>
	<td class=tablebold>:</td>
	<td ><%= description %></td></tr>
	<tr><td class=tablebold><%=bundle.getString("label.standard.GroupStatus") %>  </td>
	<td class=tablebold>:</td>
	<td><%= groupstatus %></td></tr>
	</table>
	</td>
	
	</tr>
	</tbody>
	</table>
	
    
    <br>
    
 

<%
	if(subjectFlagList != null && subjectFlagList.size() > 0)
	{
		%>
		<div class="warning_box">
       <%=bundle.getString("label.standard.errormessage") %>
     	</div>
		<%
	}
%>
  
  
          <a href="./StandardList.jsp" class="bt_blue"><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.standard.BacktoStandardList") %></strong><span class="bt_blue_r"></span></a>

<%if(subjectFlagList == null || subjectFlagList.size() == 0)
{ %>
	<a href="#" onclick="trashFun()" class="bt_green"><span class="bt_green_lft"></span><strong><%=bundle.getString("button.standard.Trash") %></strong><span class="bt_green_r"></span></a>
	<%} %>
     
     
     <input type="hidden" name="reqboardname"/>
     <input type="hidden" name="reqboardid"/>
     <input type="hidden" name="reqstandardid" value="<%=reqstandardid %>"/>
     <input type="hidden" name="reqstandardname"/>
     <input type="hidden" name="reqgroupstatus"/>
     <input type="hidden" name="requeststatus" value="T"/>
     <input type="hidden" name="standardoperation" value="UpdateStandardStatus"/>
     
     
     
</form>
     </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../../include/footer.jsp" %>
    

</div>
</body>
</html>


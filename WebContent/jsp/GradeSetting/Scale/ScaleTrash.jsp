<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - <%=bundle.getString("label.scalecreation.trashtitle") %> | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript">


function trashFun()
{
	document.scaleForm.action="./UpdateScale.jsp";
	document.scaleForm.submit();
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

    <h2><%=bundle.getString("label.scalecreation.trashrootpath") %></h2>
    <form name="scaleForm" action="" method="post">
<%@ page import="java.util.ArrayList,java.util.HashMap,com.iGrandee.GradeSetting.GradeScaleQuery"%>

     <%
     
     com.iGrandee.GradeSetting.GradeScaleQuery  gradescaleQuery = new com.iGrandee.GradeSetting.GradeScaleQuery();
     String instituteid = null;

     ArrayList scaleList = null;
     
     String reqboardid = null;
     String reqboardname = null;
     String reqscalename = null;
     String reqscaleid = null;
     ArrayList scalegradeFlagList = null;
     ArrayList gradeFlagList = null;
     
     try
     {
    	instituteid = (String)session.getValue("instituteid");
    	reqscaleid = request.getParameter("reqscaleid");
    	reqboardid = request.getParameter("reqboardid");
    	
    	scaleList = gradescaleQuery.loadScaleDetails(reqscaleid);
   		
    	scalegradeFlagList = gradescaleQuery.loadGradeStatusforUpdate(reqscaleid,"grade");
   		
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
			HashMap scaleListMap=(HashMap)scaleList.get(0);
	
			scaleid       = (String)scaleListMap.get("scaleid");
			scalename      = (String)scaleListMap.get("scalename");
			boardid      = (String)scaleListMap.get("boardid");
			boardname      = (String)scaleListMap.get("boardname");
			mediumname      = (String)scaleListMap.get("mediumname");
		}
   %>
    <table id="rounded-corner" border=0 summary="Selected List" width="100%">
    <thead>
    	<tr>
    	
        	<th scope="col" class="rounded-company" width="95%"><%=bundle.getString("label.scalecreation.trashheading") %> </th>
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
	<td class=tablebold><%=bundle.getString("label.scalecreation.Board-Medium") %>  </td>
	<td class=tablebold>:</td>
	<td><%= boardname+"-"+mediumname %></td>
	<td class=tablebold><%=bundle.getString("label.scalecreation.StandardName") %>  </td>
	<td class=tablebold>:</td>
	<td><%= scalename %></td></tr>

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
       <%=bundle.getString("label.scalecreation.errormessage") %>Trash
     	</div>
		<%
	}
%>
  
  
          <a href="./ScaleList.jsp" class="bt_blue"><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.scalecreation.BacktoStandardList") %></strong><span class="bt_blue_r"></span></a>

<%if(scalegradeFlagList == null || scalegradeFlagList.size() == 0)
{ %>
	<a href="#" onclick="trashFun()" class="bt_red"><span class="bt_red_lft"></span><strong><%=bundle.getString("button.scalecreation.Trash") %></strong><span class="bt_red_r"></span></a>
	<%} %>
     
     
     <input type="hidden" name="reqboardname"/>
     <input type="hidden" name="reqboardid" value="<%=reqboardid %>"/>
     <input type="hidden" name="reqscaleid" value="<%=reqscaleid %>"/>
     <input type="hidden" name="reqscalename"/>
     <input type="hidden" name="reqgroupstatus"/>
     <input type="hidden" name="requeststatus" value="T"/>
     <input type="hidden" name="scaleoperation" value="UpdateScaleStatus"/>
     
     
     
</form>
     </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../../include/footer.jsp" %>
    

</div>
</body>
</html>


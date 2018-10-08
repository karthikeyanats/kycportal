<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - <%=bundle.getString("label.standard.trasklisttitle") %> | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockp.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockh.js"></script>
<script type="text/javascript" src="jquery.min.js"></script>
<script type="text/javascript" src="ddaccordion.js"></script>
<script type="text/javascript">

function gotoAction(obj)
{
var status=obj.getAttribute("reqstatus");
var statusword="";
//alert("status>>"+status);
if(status=="A")
{
		statusword="Restore the Standard...?";
}
else if(status=="D")
{
		statusword="Delete the Standard...?";
}

if(confirm("Do You Want to "+statusword))
{
	document.standardForm.reqstandardid.value = obj.getAttribute("standardid");
	document.standardForm.requeststatus.value = obj.getAttribute("reqstatus");

	document.standardForm.action="./UpdateStandard.jsp";
	document.standardForm.submit();
	}
}
function loadStandard()
{
	document.standardForm.reqboardid.value = document.standardForm.standardboard.options[document.standardForm.standardboard.options.selectedIndex].value;
	document.standardForm.reqboardname.value = document.standardForm.standardboard.options[document.standardForm.standardboard.options.selectedIndex].text;
	
	document.standardForm.action="StandardStatusList.jsp";
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
    
    <h2><%=bundle.getString("label.standard.trasklistrootpath") %></h2>
    <form name="standardForm" action="" method="post">
<%@ page import="java.util.ArrayList,java.util.HashMap,com.iGrandee.MasterEntries.Standard.StandardQuery"%>

     <%
     
     com.iGrandee.MasterEntries.Standard.StandardQuery  standardQuery = new com.iGrandee.MasterEntries.Standard.StandardQuery();
     String instituteid = null;
     ArrayList BoardList = null;
     String reqboardid = null;
     
     try
     {
    	 instituteid = (String)session.getValue("instituteid");
    	  BoardList = standardQuery.listBoard(instituteid);
    	  
    	  if(request.getParameter("reqboardid") != null)
    	  {
    	  	reqboardid = request.getParameter("reqboardid");
    	  }
    	  //reqboardid = request.getParameter("reqboard");
    }catch(Exception e){}
    
    %>
    
    
<table id="" border="0" cellpadding=5>
<tr><td class=tablebold><%=bundle.getString("label.standard.Board") %>  </td><td>
<select name="standardboard" class=tablelight onchange="loadStandard()"> <option>-Select Board-Medium- </option>
<%
   			
        	if(BoardList!=null && BoardList.size()>0)
			{
   		 	for (int i = 0, j = 1; i < BoardList.size(); i++) {
			
				HashMap boardListMap=(HashMap)BoardList.get(i);
				String boardid     = (String)boardListMap.get("boardid");
				String boardname      = (String)boardListMap.get("boardname");
				String mediumid      = (String)boardListMap.get("mediumid");
				String mediumname      = (String)boardListMap.get("mediumname");
				if(request.getParameter("reqboardid") != null)
		    	  {
		    	  	reqboardid = request.getParameter("reqboardid");
		    	  	if(reqboardid.equals(boardid))
		    	  	{
		          		 out.println("<option value='"+boardid+"' class=tablelight selected>"+boardname+"-"+mediumname+"</option>");
	    	  		}else
	    	  		{
		    	  	out.println("<option value='"+boardid+"' class=tablelight >"+boardname+"-"+mediumname+"</option>");
	    	  		}
		    	  	
		    	  }
				else{
       		 out.println("<option value='"+boardid+"' class=tablelight >"+boardname+"-"+mediumname+"</option>");}
   		 }
			}
   		 %></select>
</td></tr>
</table>

<table id="rounded-corner" border=0 summary="Department List" width="100%">
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="10%"><%=bundle.getString("label.standard.SL.No") %></th>
            <th scope="col" class="rounded" width="30%"><%=bundle.getString("label.standard.StandardName") %></th>
            <th scope="col" class="rounded" width="30%"><%=bundle.getString("label.standard.Description") %></th>
            <th scope="col" class="rounded" width="15%"><%=bundle.getString("label.standard.GroupStatus") %></th>
            <th scope="col" class="rounded" width="15%"><%=bundle.getString("label.standard.Dateofcreation") %></th>
            <th scope="col" class="rounded" width="5%"><center><%=bundle.getString("label.standard.Delete") %></center></th>
            <th scope="col" class="rounded-q4" width="5%"><center><%=bundle.getString("label.standard.Restore") %></center></th>
            
        </tr>
    </thead>
    <tfoot>
    	<tr>
        	<td colspan="6" class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
     <tbody>

     <%
     
     ArrayList StandardList = null;
     try
     {
    	 
    	//  instituteid = (String)session.getValue("instituteid");
    	  if(request.getParameter("reqboardid") != null)
    	  {
    	  	reqboardid = request.getParameter("reqboardid");
    	  
    	  	StandardList = standardQuery.listStandardList(instituteid,reqboardid,"T");
    	  }
    	 
    	//standardid, standardname, boardid, boardname, mediumname, mediumid
    	 if(StandardList!=null && StandardList.size()>0)
			{
    		 for (int i = 0, j = 1; i < StandardList.size(); i++) {
			
				HashMap StandardListMap=(HashMap)StandardList.get(i);

				String standardid       = (String)StandardListMap.get("standardid");
				String standardname      = (String)StandardListMap.get("standardname");
				String description     = (String)StandardListMap.get("description");
				if(description == null)
					description = "-";
				String groupstatus      = (String)StandardListMap.get("groupstatus");
				String stdcreateddate      = (String)StandardListMap.get("dateofcreation");
				
				%>
				
				<tr>
        	 <td><%=j++ %></td>
            <td><%=standardname %></td>
            <td><%=description %></td>
           <td><%=groupstatus %></td>
            <td><%=stdcreateddate %> </td>
               <td width="5%"> <a href="#"  standardid="<%=standardid %>" reqstatus="D" onclick="gotoAction(this)"> <img src="<%=request.getContextPath()%>/jsp/kycpanel/images/user_logout.png" alt="delete" title="Delete" border="0" /></a></td>
               <td width="5%"><a href="#" standardid="<%=standardid %>" reqstatus="A" onclick="gotoAction(this)"><img src="<%=request.getContextPath()%>/jsp/kycpanel/images/16-undo1.png" alt="restore" title="Restore" border="0" /> </a></td> 
            
        </tr>          
				<%
    		 }
			}
    	 	else{
    	 		if(request.getParameter("reqboardid") != null)
    	    	  {
    	 			out.println("<tr align='center' class='tablebold'><td colspan='7'><font color='red'>Data Not Found</font></td></tr>");
    	 			//out.println("<tr><td colspan=7>Data not found</td></tr>");	
    	    	  }
    	 		else
    	 		{
    	 			out.println("<tr align='center'><td colspan=7>Select Board-Medium</td></tr>");
    	 		}
     			    	 
    	 	}
     }catch(Exception e){e.printStackTrace();}
          
     %>
    	
    </tbody>
</table>

          <a href="./StandardList.jsp" class="bt_blue"><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.standard.BacktoActiveStandardList") %></strong><span class="bt_blue_r"></span></a>
     
     
     <input type="hidden" name="reqboardname"/>
     <input type="hidden" name="reqboardid"/>
     <input type="hidden" name="reqstandardid"/>
     <input type="hidden" name="reqstandardname"/>
     <input type="hidden" name="reqgroupstatus"/>
          <input type="hidden" name="requeststatus"/>
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


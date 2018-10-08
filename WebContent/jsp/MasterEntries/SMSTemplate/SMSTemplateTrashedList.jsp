<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - SMSTemplate List| Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockp.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockh.js"></script>
<script type="text/javascript">
function backfun()
{
		document.smstemplatelistform.action="SMSTemplateList.jsp";
		document.smstemplatelistform.submit();
}
function updatefun(obj)
{
	document.smstemplatelistform.smsoperation.value="UpdatStatus";
	document.smstemplatelistform.requpdatestatus.value="Restore";
	
	document.smstemplatelistform.reqtemplateid.value =obj.getAttribute("templateid");
	
	document.smstemplatelistform.action="SMSTemplateSubmit.jsp";
		document.smstemplatelistform.submit();
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

    <h2>General/ SMS Template / Trashed List</h2>
<form name="smstemplatelistform" action="" method="post">
  <%@ page import="java.util.ArrayList,java.util.HashMap,com.iGrandee.MasterEntries.SMSTemplate.SMSTemplateQuery"%>

     <%
     
     SMSTemplateQuery  smstemplateQuery = new SMSTemplateQuery();
     String instituteid = null;
     ArrayList templateList = null;    
         
     try
     {
    	 instituteid = (String)session.getValue("instituteid");
    	 
    }catch(Exception e){}
    
    %>
    <table id="rounded-corner" border=0 summary="Selected List" width="100%">
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="5%">Sl. No.</th>
        	<th scope="col" class="rounded" width="30%">SMS Template Name</th>
        	<th scope="col" class="rounded" width="40%%"> Description</th>
        	<th scope="col" class="rounded" width="15%%">Date of Creation</th>
        	<th scope="col" class="rounded-q4" width="15%" colspan=3>Action</th>
            
        </tr>
    </thead>
    <tfoot>
    	<tr>
        	<td colspan=4  class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
   <%
   

   templateList = smstemplateQuery.listSMSTemplateList(instituteid,"Trash");
   try{
   int inc = 1;
    if(templateList != null && templateList.size()>0){
					    		for(int y=0;y<templateList.size();y++){
					    			HashMap templateListMap		= (HashMap)templateList.get(y);
					    			String smstemplateid		= (String)templateListMap.get("smstemplateid");
					    			String smstemplatename		= (String)templateListMap.get("smstemplatename");
					    			String smsdescription		= (String)templateListMap.get("smsdescription");
					    			String dateofcreation		= (String)templateListMap.get("dateofcreation");
					    			String smstemplatestatus		= (String)templateListMap.get("smstemplatestatus");
					    			
out.print("<tr><td>"+inc+"</td><td>"+smstemplatename+"</td><td>"+smsdescription+"</td><td>"+dateofcreation+"</td><td><a href='#' act='Trash' templateid='"+smstemplateid+"' onclick=updatefun(this)>Restore</a></td></tr>");	    			
		inc++;			    		
		}
    }
    else
    {
    	out.println("<tr align='center' class='tablebold'><td colspan='5'><font color='red'>Data Not Found</font></td></tr>");
    	//out.print("<tr><td colspan=5 align=center>Data not found</td></tr>");
    
    
    }
    
   }catch(Exception e){}
					    			%>
     <tbody>
  
    </table>
    
          <a href="#" onclick="backfun()" class="bt_blue"><span class="bt_blue_lft"></span><strong>Back to Active List</strong><span class="bt_blue_r"></span></a>
        <input type=hidden name="smsoperation" value=""/>
   <input type=hidden name="requpdatestatus" value=""/>

      <input type=hidden name="reqtemplateid" value=""/>
   

     </form>
     </div><!-- end of right content-->

  </div>   <!--end of center content -->

    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../../include/footer.jsp" %>
    

</div>
</body>
</html>

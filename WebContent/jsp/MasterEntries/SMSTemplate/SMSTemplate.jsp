<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - SMSTemplate Creation| Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockp.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockh.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>
<script type="text/javascript">
function saveTemplate()
{

if(check_ForParticularElements(document.smstemplateform.smstemplatename,"text",document.smstemplateform.smstemplatedescription,"textarea"))
	{
		document.smstemplateform.action="SMSTemplateSubmit.jsp";
		document.smstemplateform.submit();
	}

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

    <h2>Master Entries / SMS Template / SMS Template Creation</h2>
<form name="smstemplateform" action="" method="post">
  <%@ page import="java.util.ArrayList,java.util.HashMap,com.iGrandee.MasterEntries.SMSTemplate.SMSTemplateQuery"%>

     <%
     
     SMSTemplateQuery  lessonQuery = new SMSTemplateQuery();
     String instituteid = null;
     ArrayList subjecttypeList = null;
    
     

     
     try
     {
    	 instituteid = (String)session.getValue("instituteid");
    	 
    	 // BoardList = lessonQuery.listBoard(instituteid);
    }catch(Exception e){}
    
    %>
    <table id="rounded-corner" border=0 summary="Selected List" width="100%">
    <thead>
    	<tr>
    		<th scope="col" class="rounded-company" width="1%"></th>
        	<th scope="col" class="rounded">SMS Template Creation</th>
        	<th scope="col" class="rounded-q4" width="5"></th>
            
        </tr>
    </thead>
    <tfoot>
    	<tr>
        	<td colspan=2  class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
    <tr>
    <td colspan=3>
    <table border=0 cellpadding=5 cellspacing=0 width="100%"><tr>
    <td class=tablebold>
Template Name<font color="red">*</font></td><td><input type="text" name="smstemplatename" validate="Template Name" class=tablelight size="40" maxlength="40"></td>
    </tr>
    <tr>
    <td class=tablebold>Template Description<font color="red">*</font></td><td><textarea name="smstemplatedescription" validate="Description" class=tablelight rows="3" cols="50" 
    
    onkeydown="textCounter_label(document.smstemplateform.smstemplatedescription,document.getElementById('remLen3'),80)" onkeyup="textCounter_label(document.smstemplateform.smstemplatedescription,document.getElementById('remLen3'),80)"></textarea>
    
    <br><i><font color=red> <label id="remLen3"><a class=tablelight>80</a></label>&nbsp; characters left</font></td>
    </tr>

  
    </table>
    </td></tr></table>
              <a href="#" onclick="document.smstemplateform.reset()"  class="bt_blue"><span class="bt_blue_lft"></span><strong>Reset</strong><span class="bt_blue_r"></span></a>
    
          <a href="<%=request.getContextPath() %>/jsp/MasterEntries/SMSTemplate/SMSTemplateList.jsp"  class="bt_blue"><span class="bt_blue_lft"></span><strong>Active Template List</strong><span class="bt_blue_r"></span></a>
               <a href="<%=request.getContextPath() %>/jsp/MasterEntries/SMSTemplate/SMSTemplateTrashedList.jsp"  class="bt_blue"><span class="bt_blue_lft"></span><strong>Trashed Template List</strong><span class="bt_blue_r"></span></a>
     
          <a href="#" class="bt_green" onclick="saveTemplate()"><span class="bt_green_lft"></span><strong>Save Template</strong><span class="bt_green_r"></span></a>
          
   <input type=hidden name="smsoperation" value="insert"/>

     </form>
     </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../../include/footer.jsp" %>
    

</div>
</body>
</html>

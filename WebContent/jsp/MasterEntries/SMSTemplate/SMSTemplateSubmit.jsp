
<%@ page import="java.util.ArrayList,java.util.HashMap,com.iGrandee.MasterEntries.SMSTemplate.SMSTemplateBean,com.iGrandee.MasterEntries.SMSTemplate.SMSTemplateQuery"%>

<%
String instituteid = null;
String userid = null;
String reqstandardid = null;
String[] lessonname;
String[] lessondescription; 
int rows = 0;
String return_file = "";
String message="";
SMSTemplateQuery  smsTemplateQuery = new SMSTemplateQuery();
SMSTemplateBean smsTemplateBean = new SMSTemplateBean();
String smstemplatedescription=null;
String smstemplatename = null;
String resultword="";
String smsoperation = "";
String reqtemplateid = "";
String requpdatestatus = "";
String reqtemplatename = "";
String reqtemplatedescription= "";

try
{
	smstemplatename = request.getParameter("smstemplatename");
	smstemplatedescription = request.getParameter("smstemplatedescription");
	smsoperation = request.getParameter("smsoperation");
	 instituteid = (String)session.getValue("instituteid");
	userid = (String)session.getValue("userid");
	
	
	

	if(smsoperation.equals("insert"))
	{
		smsTemplateBean.setSmstemplatename(smstemplatename);
		smsTemplateBean.setSmsdescription(smstemplatedescription);
		smsTemplateBean.setCreatedby(userid);
	rows += smsTemplateQuery.insertSMSTemplate(smsTemplateBean);
			
		return_file = request.getContextPath()+"/jsp/MasterEntries/SMSTemplate/SMSTemplate.jsp";
	if(rows >0)
		message = "SMS Template Successfully Inserted";
	else
			message = "SMS Template Insertion failed";

	}
	else if(smsoperation.equals("Update"))
	{
		reqtemplateid= request.getParameter("reqtemplateid");
		reqtemplatename= request.getParameter("smstemplatename");
		reqtemplatedescription= request.getParameter("smstemplatedescription");
		smsTemplateBean.setSmstemplatename(reqtemplatename);
		smsTemplateBean.setSmsdescription(reqtemplatedescription);
		smsTemplateBean.setSmstemplateid(reqtemplateid);

		rows += smsTemplateQuery.updateSMSTemplate(smsTemplateBean);
				
		
					if(rows >0)
			message = "SMS Template Successfully Updated";
		else
				message = "SMS Template Updation failed";
					return_file = request.getContextPath()+"/jsp/MasterEntries/SMSTemplate/SMSTemplateList.jsp";

			
		
	}
		
	else if(smsoperation.equals("UpdatStatus"))
	{
		//System.out.println("ASDFADSFASDF");
		reqtemplateid= request.getParameter("reqtemplateid");
		//System.out.println("ASDFADSFASDF"+reqtemplateid);
		requpdatestatus= request.getParameter("requpdatestatus");
		//System.out.println("requpdatestatusasdf adsf asdf"+requpdatestatus);
		
		
		smsTemplateBean.setSmstemplateid(reqtemplateid);
		
		
		if(requpdatestatus.equals("Trash"))
			smsTemplateBean.setSmstemplatestatus("T");
		if(requpdatestatus.equals("Restore"))
			smsTemplateBean.setSmstemplatestatus("A");
		
		rows += smsTemplateQuery.updateSMSTemplateStatus(smsTemplateBean);
		
		
		
		if(requpdatestatus.equals("Restore"))
			{
					if(rows >0)
			message = "SMS Template Successfully Restored";
		else
				message = "SMS Template Restoration failed";
					return_file = request.getContextPath()+"/jsp/MasterEntries/SMSTemplate/SMSTemplateList.jsp";

			}
		
		else if(requpdatestatus.equals("Trash"))
		{
				if(rows >0)
		message = "SMS Template Successfully Trashed";
	else
			message = "SMS Template Trash failed";
				
			return_file = request.getContextPath()+"/jsp/MasterEntries/SMSTemplate/SMSTemplateTrashedList.jsp";
			
		}
		
	}
	response.sendRedirect(request.getContextPath()+"/jsp/Operation_Result.jsp?message="+message+"&result="+rows+"&returnurl="+return_file);

}catch(Exception e){e.printStackTrace();}

%>
<html>
<head>
<script language="javascript">
function loadResult()
{
	document.templatesubmitform.action="<%=request.getContextPath()%>/jsp/Opreation_result_withrequest.jsp";
	document.templatesubmitform.submit();
}
</script>
</head>
<body >
<form name="templatesubmitform" action="" method="post">
<input type="text" name="result" value="<%=rows %>">
      	  <input type="text" name="returnurl" value="<%=return_file%>">
      	
    	  <input type="hidden" name="message" value="<%=resultword%>">
    	  
    	  
    	  
</form>
</body>
</html>

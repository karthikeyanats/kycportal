<%@ page language="java" %>
<%@ page import="java.util.ArrayList,java.util.StringTokenizer" %>
<%@ page import="com.iGrandee.sms.SendMessageWithPortsSMSLib" %>

<%
	//String mobile_no 	= "919868771737,919868415431,919810007933,919868982777,919868771735";//request.getParameter("mobilenos");
	//String message 	= "Today we have successfully configured SMS for eGovernance Portal - coming from RB Portal. Do not reply. Thank you - IGST";//request.getParameter("message");
	try
	{
	String[] mobile_no 	= request.getParameterValues("mobilenos");
	String message 		= request.getParameter("message");
	String smsId 		= request.getParameter("smsId");
	ArrayList mobile_nos = new ArrayList();

	//System.out.println("IGST:INF Mobile No(s)"+mobile_no+"	Message	"+message+" in :"+smsId);
	//StringTokenizer tokens = new StringTokenizer(mobile_no,",");
	for (int i=0;i<mobile_no.length;i++)
	{
		mobile_nos.add("+"+(String)mobile_no[i]);
	}
	SendMessageWithPortsSMSLib sms_object = new SendMessageWithPortsSMSLib();
	//sms_object.sendMessage("+"+mobile_nos,message);
	sms_object.sendMessage(mobile_nos, message, smsId);
	}catch(Exception e){e.printStackTrace();}
%>
<%@ page language="java" %>
<%@ page import="java.util.ArrayList,java.util.HashMap" %>
<%@ page import="com.iGrandee.ExamManagement.QuestionEntry" %>

<%!
public synchronized String setForXML(String inputstring)
{
	StringBuffer outputstring = new StringBuffer("");
	if(inputstring != null)
	{
		for(int i = 0; i < inputstring.length(); i++)
		{
			char c = inputstring.charAt(i);
			if(c == '\'')
				outputstring.append("&#39;");
			else if(c == '"')
				outputstring.append("&quot;");
			else if(c == '&')
				outputstring.append("&amp;");
			else if(c == '<')
				outputstring.append("&lt;");
			else if(c == '>')
				outputstring.append("&gt;");
			else if(c == '\u03B2')
				outputstring.append("&beta;");
			else if(c == '\u03BC')
				outputstring.append("&mu;");
			else if(c == '\u00B0')
				outputstring.append("&deg;");
			else if(c == '\u00B2')
				outputstring.append("&sup2;");
			else if(c == '\u00B3')
				outputstring.append("&sup3;");
			else if(c == '\u03B1')
				outputstring.append("&alpha;");
			else if(c == '\u03C3')
				outputstring.append("&sigma;");
			else if(c == '\u03C0')
				outputstring.append("&pi;");
			else if(c == '\u03B8')
				outputstring.append("&theta;");
			else if(c == '\u03B3')
				outputstring.append("&gamma;");
			else
				outputstring.append(c);
		}
	}
	
	return outputstring.toString();
}

%>
<%

		QuestionEntry query	= new QuestionEntry();
		String instituteid	= (String)session.getValue("instituteid");
		StringBuffer buffer = new StringBuffer();
		ArrayList reqlist	= null;
		HashMap hashmap		= null;

	try{
	
		if(request.getParameter("action").equals("standard"))
		{
			String boardid 		= request.getParameter("boardid");
			reqlist				= query.loadStandard(boardid);

			if(reqlist!=null && reqlist.size()>0)
			for(int ii=0;ii<reqlist.size();ii++)
			{
				hashmap		= (HashMap)reqlist.get(ii);
				buffer.append("<result>");
					buffer.append("<standardid>"+hashmap.get("standardid")+"</standardid>");
					buffer.append("<standardname>"+setForXML((String)hashmap.get("standardname"))+"</standardname>");
				buffer.append("</result>");
			}

			response.setContentType("text/xml");
			response.setHeader("Cache-Control", "no-cache");
			response.getWriter().write("<MainEntity>"+buffer.toString()+"</MainEntity>");
		}
			else if(request.getParameter("action").equals("subject"))
			{
				String standardid 		= request.getParameter("standardid");
				reqlist					= query.loadSubject(standardid);
				if(reqlist!=null && reqlist.size()>0)
					for(int ii=0;ii<reqlist.size();ii++)
					{
						hashmap		= (HashMap)reqlist.get(ii);
						buffer.append("<result>");
							buffer.append("<subjectid>"+hashmap.get("subjectid")+"</subjectid>");
							buffer.append("<subjectname>"+setForXML((String)hashmap.get("subjectname"))+"</subjectname>");
						buffer.append("</result>");
					}

	
				response.setContentType("text/xml");
				response.setHeader("Cache-Control", "no-cache");
				response.getWriter().write("<MainEntity>"+buffer.toString()+"</MainEntity>");
			}
			else if(request.getParameter("action").equals("lesson"))
			{
	
				String subjectid 		= request.getParameter("subjectid");
				reqlist					= query.loadLesson(subjectid);
				if(reqlist!=null && reqlist.size()>0)
					for(int ii=0;ii<reqlist.size();ii++)
					{
						hashmap		= (HashMap)reqlist.get(ii);
						buffer.append("<result>");
							buffer.append("<lessonid>"+hashmap.get("lessonid")+"</lessonid>");
							buffer.append("<lessonname>"+setForXML((String)hashmap.get("lessonname"))+"</lessonname>");
						buffer.append("</result>");
					}

				response.setContentType("text/xml");
				response.setHeader("Cache-Control", "no-cache");
				response.getWriter().write("<MainEntity>"+buffer.toString()+"</MainEntity>");
			}
	}
	catch(Exception ex)
	{
	}
%>
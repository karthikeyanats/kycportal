<%@page import="java.net.URLEncoder"%>
<HTML>
<LINK REL=stylesheet HREF="../css/vlearn_sty.css">
<HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=ISO-8859-1">
<SCRIPT language="JavaScript" src="../js/MenuRoller.js"></SCRIPT>
<SCRIPT language="JavaScript" src="../js/ServerPath.js"></SCRIPT>
<SCRIPT language="JavaScript" src="../js/Elements.js"></SCRIPT>
<SCRIPT language="JavaScript" src="../js/form_label.js"></SCRIPT>
<SCRIPT language="JavaScript" src="../js/Validation.js"></SCRIPT>
<SCRIPT language="JavaScript" src='../js/Calendar/Calendar.js'></SCRIPT>
<link rel="StyleSheet" href="<%= request.getContextPath() %>/css/dtree.css" type="text/css" />
<script type="text/javascript" src="<%= request.getContextPath() %>/js/dtree.js"></script>
<title>Content Browsing</title>
<script language="javascript">
function decreaseFrame()
{
	parent.document.getElementsByTagName('frameset')[1].cols='0,*';
}
</script>
</HEAD>
<BODY LINK="#0000FF" VLINK="#800080" TEXT="#000000" TOPMARGIN=0 LEFTMARGIN=0 MARGINWIDTH=0 MARGINHEIGHT=0>
<%@ page import="java.util.*,java.lang.*"%>
<form name="listform" method="post">
<jsp:useBean id="content_query" scope="page" class="com.iGrandee.Content.ContentQurey"/>
<jsp:useBean id='replaceback' scope='page' class='com.iGrandee.Common.CommonDataAccess'/>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<%
	String dbsubjectid = "";
	String subjectId=request.getParameter("req_subjectscheduleid");

	System.out.println("SUBID::::"+subjectId);
	String subjectname  =request.getParameter("req_subjectname");
	System.out.println("subjectname::::"+subjectname);
	String userid  =(String)session.getValue("userid");
	String semestername =(String)session.getValue("semestername");
	ArrayList lessonList=new ArrayList();
	HashMap lessonMap=new HashMap();
	lessonList = content_query.listLesson(subjectId);
	System.out.println("lessonList======>>>>>>"+lessonList);
	session.putValue("reqkhansubjectid", subjectId);
%>

<TABLE  border="0"   align=center  height=100% width=100% cellspacing=0 cellpadding=0 valign="top">
    <tr valign=top  class=tablehead  height="80%" valign="top" width='100%'>
	  <td colspan=5 >
		<table class="dtree" width="1000px">
		<tr><td>
			<script type="text/javascript">

				d = new dTree('d');
				d.add(0,-1,"<%=subjectname%>","<%=request.getContextPath()%>/jsp/ContentManagement/View/ViewContent.jsp?SubjectList=<%=subjectId%>&submitmode=subject&SubjectName=<%=subjectname%>","Click here to go Lesson","clientpanel");
				d.add(1,0,'Lesson List',"","Click here to add new Category","clientpanel");

				<%

				if(lessonList != null)
				{
					int lessinc = 2;
					int incval1=3;
					int incval2=4;
					int incval3=5;
					int firstvalue=1;
					int secondvalue=2;

					int contentvalue=300;
				
					int listvalue=1;

					int lessionincvalue=2;

				  for(int j=0;j<lessonList.size();j++)
				   {


						ArrayList fileList=new ArrayList();
						HashMap fileMap=new HashMap();
						lessonMap = (HashMap)lessonList.get(j);
					    String lessonId = (String)lessonMap.get("lessonid");
					    String lessonName = (String)lessonMap.get("lessonname");
					    dbsubjectid = (String)lessonMap.get("lessonscheduleid");
 
					    fileList=content_query.LoadDeployedContentLesson(lessonId,dbsubjectid,"A");
				    
					 
					  %>
						d.add("<%=lessinc%>","1","<%=lessonName%>","ViewContent.jsp?SubjectList=<%=subjectId%>&lessonid=<%=lessonId%>&lessonScheduleid=<%=dbsubjectid%>&value=<%=0%>&lessonName=<%=URLEncoder.encode(lessonName)%>&submitmode=lesson","<%=URLEncoder.encode(lessonName)%>","clientpanel");
					  <%
								ArrayList contentList=new ArrayList();

						 	    contentList=content_query.LoadDeployedContentLessonList(lessonId,dbsubjectid,"A","txt','jpeg','jpg','gif','png','bmp','doc','docx','ppt','pptx','swf','pdf");

						 	    if(contentList!=null && contentList.size()>0)
								{
						 		%>
						 		d.add("<%=contentvalue%>","<%=lessinc%>",'Content',"","","clientpanel");
								<%
								}
								if(contentList!=null && contentList.size()>0)
								{
								int fileinc =1001;
								for(int i=0;i<contentList.size();i++)
								{
									HashMap innermap=(HashMap)contentList.get(i);
								%>
							 		d.add("<%=fileinc%>","<%=contentvalue%>","<%=innermap.get("filename")%>","presentationview.jsp?filePath=<%=innermap.get("filepath")%>&commonsubjectid=<%=dbsubjectid%>&userid=<%=userid%>&fileName=<%=innermap.get("filename")%>&contentNotes=<%=innermap.get("contentnotes")%>&lessonName=<%=lessonName%>&cmscontentid=<%=innermap.get("cmscontentid")%>","<%=innermap.get("filename")%>","clientpanel");
							 	<%
							 	fileinc++;
								}
								contentvalue++;
								}
						 		contentList=content_query.LoadDeployedContentLessonList(lessonId,dbsubjectid,"A","wav','mp3','wma");
								if(contentList!=null && contentList.size()>0)
								{
							    %>
							    d.add("<%=contentvalue%>","<%=lessinc%>",'Audio',"","","clientpanel");
							    <%
								}
				  		    	if(contentList!=null && contentList.size()>0)
								{
				  		    	int fileinc =1001;
								for(int i=0;i<contentList.size();i++)
								{
									HashMap innermap=(HashMap)contentList.get(i);
								%>
							 		d.add("<%=fileinc%>","<%=contentvalue%>","<%=innermap.get("filename")%>","presentationview.jsp?filePath=<%=innermap.get("filepath")%>&commonsubjectid=<%=dbsubjectid%>&userid=<%=userid%>&fileName=<%=innermap.get("filename")%>&contentNotes=<%=innermap.get("contentnotes")%>&lessonName=<%=lessonName%>&cmscontentid=<%=innermap.get("cmscontentid")%>","<%=innermap.get("filename")%>","clientpanel");
							 	<%
							 	fileinc++;
								}
								contentvalue++;
								}
						 		contentList=content_query.LoadDeployedContentLessonList(lessonId,dbsubjectid,"A","flv','mpeg','mp4','wmv','avi','3gp");

								if(contentList!=null && contentList.size()>0)
								{%>
								d.add("<%=contentvalue%>","<%=lessinc%>",'Video',"","","clientpanel");
								<%
								}
								if(contentList!=null && contentList.size()>0)
								{
								int fileinc =1001;
								for(int i=0;i<contentList.size();i++)
								{
									HashMap innermap=(HashMap)contentList.get(i);
								%>
							 		d.add("<%=fileinc%>","<%=contentvalue%>","<%=innermap.get("filename")%>","presentationview.jsp?filePath=<%=innermap.get("filepath")%>&commonsubjectid=<%=dbsubjectid%>&userid=<%=userid%>&fileName=<%=innermap.get("filename")%>&contentNotes=<%=java.net.URLEncoder.encode((String)innermap.get("contentnotes"))%>&lessonName=<%=lessonName%>&cmscontentid=<%=innermap.get("cmscontentid")%>","<%=innermap.get("filename")%>","clientpanel");
							 	<%
							 	fileinc++;
								}
								contentvalue++;
								}


						/*  if(fileList!=null && fileList.size()>0)
							  {
						 		 int fileinc = 1001;
								  String temptype="";
								  String temptype1="";

							  for(int k=0;k<fileList.size();k++)
							  {
								 fileMap=(HashMap)fileList.get(k);
								 String fileName=(String)fileMap.get("filename");
							  	 fileName= replaceback.replaceSingleChars_back(fileName);
							 	 String fileId=(String)fileMap.get("fileid");
							 	 String logid=(String)fileMap.get("logid");
							 	 String filePath=(String)fileMap.get("filepath");
							 	 String contentNotes=(String)fileMap.get("contentnotes");
							 	 String filetype=(String)fileMap.get("type");
							 	 //System.out.println("filetype>>>>"+filetype);


						 		if(!temptype.equalsIgnoreCase(filetype))
							 	{
								 	if(filetype.equals("swf") || filetype.equals("png") || filetype.equals("gif") || filetype.equals("jpeg") || filetype.equals("jpg") || filetype.equals("txt") ||filetype.equals("pdf") || filetype.equals("ppt") || filetype.equals("jpg") || filetype.equals("docx"))
								 	{
								 		%>
								 		d.add("<%=contentvalue+1%>","<%=lessinc%>",'Content',"","","clientpanel");
										<%

								 	}
								    else if(filetype.equalsIgnoreCase("mp3"))
								    {
									    %>
									    d.add("<%=contentvalue+1%>","<%=lessinc%>",'Audio',"","","clientpanel");
									    <%

							  		}
								    else if (filetype.equalsIgnoreCase("flv") || filetype.equalsIgnoreCase("mp4"))
							 		{
						  		    	%>
										d.add("<%=contentvalue+1%>","<%=lessinc%>",'Video',"","","clientpanel");
										<%
									}
							 		temptype=filetype;
								 	contentvalue++;
							 	}
						 		%>
						 		d.add("<%=fileinc%>","<%=contentvalue%>","<%=fileName%>","presentationview.jsp?filePath=<%=filePath%>&commonsubjectid=<%=dbsubjectid%>&userid=<%=userid%>&logid=<%=logid%>&fileName=<%=fileName%>&contentNotes=<%=contentNotes%>","<%=fileName%>","clientpanel");
						 		<%
								fileinc++;
					   }

					 }*/
					  	incval1++;
					  	incval2++;
					  	incval3++;
					  	firstvalue++;
					    lessinc=lessinc+4;
					    incval1++;
					  	incval2++;
					  	incval3++;
					  	secondvalue++;
					  	lessionincvalue++;
				   	   	listvalue++;

			       }

			}
			    %>
			    document.write(d);
			</script>
			</td></tr>
		 </table>
       </td>
  	</tr>

<!--  BODY CONTENT TABLE  START  -->



      </TABLE>

</BODY>
</HTML>

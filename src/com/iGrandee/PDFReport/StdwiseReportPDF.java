package com.iGrandee.PDFReport;
import com.lowagie.text.pdf.PdfWriter;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.NumberFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Locale;
import java.awt.Color;
import com.lowagie.text.*;
import com.lowagie.text.pdf.PdfWriter;
import java.io.FileOutputStream;

import com.lowagie.text.Chunk;
import com.lowagie.text.Document;
import com.lowagie.text.Font;
import com.lowagie.text.PageSize;
import com.lowagie.text.Paragraph;
import com.lowagie.text.Rectangle;
import com.lowagie.text.pdf.PdfPTable;
import com.lowagie.text.pdf.PdfPCell;
import com.lowagie.text.Element;
import java.util.ResourceBundle;
import com.lowagie.text.PageSize;
import com.lowagie.text.pdf.PdfPageEventHelper;
import com.lowagie.text.pdf.BaseFont;
import com.lowagie.text.pdf.PdfGState;
import com.lowagie.text.pdf.PdfPTable;
import com.lowagie.text.pdf.PdfContentByte;
import com.lowagie.text.pdf.PdfReader;
import com.lowagie.text.pdf.PdfStamper;
import com.lowagie.text.Image;
import com.iGrandee.Attendance.AttendanceQuery;
import com.iGrandee.Common.DateTime;
import com.iGrandee.Registration.InstitutionQurey;
import com.iGrandee.SchoolCalender.SchoolCalenderBean;
import com.iGrandee.SchoolCalender.SchoolCalenderEntry;


public class StdwiseReportPDF
{
	DateTime datobj =new DateTime();
	InstitutionQurey insquery=new InstitutionQurey();
	com.iGrandee.Application.RegistrationProcess  applicationQuery = new com.iGrandee.Application.RegistrationProcess();
	com.iGrandee.Fees.FeesSchedule  feesscheduleQuery = new com.iGrandee.Fees.FeesSchedule();
	com.iGrandee.Exam.ExamAllotment.ExamAllotmentQuery  examQuery = new com.iGrandee.Exam.ExamAllotment.ExamAllotmentQuery();
	com.iGrandee.Prinicipal.PrinicipalQuery prinicipal =new com.iGrandee.Prinicipal.PrinicipalQuery();
	com.iGrandee.Attendance.AttendanceQuery attencequery=new com.iGrandee.Attendance.AttendanceQuery();
	
public int generatePdf(ArrayList studentList,String sessionid,String sessionname,String boardid,String boardname,String instituteid,String standardname,String standardscheduleid)
{
int rows = 0;
//String institutelogo 	= (String)session.getValue("institutelogo");
ArrayList innerList2=new ArrayList();

 String fileName=null;
 String tempPath=null;

 String stdSchedId      = "";
 String applicantName	= "";
 String rollNo      	= "";
 String standardName    = "";
 String groupName      	= "";
 String secName      	= "";
 String emailId			= "";

try
{


Document document = new Document(PageSize.A4, 30, 30, 105, 40);
String storagepath = "";
try {
			ResourceBundle bundle  =ResourceBundle.getBundle("resources.serversetup");
			storagepath = bundle.getString("storagepath");
				//String storagepath = "C:/Documents and Settings/subhashchandran_d.IGSTDEV/Desktop/";  
			//tempPath=storagepath+"PDFReports/studentList1.pdf";
			//fileName=storagepath+"PDFReports/Student List for "+sessionname+"--"+boardname+".pdf";
			
			String time_stamp=datobj.showTime("WithTime");
			time_stamp = time_stamp.substring(0,time_stamp.length()-3);
			time_stamp = time_stamp.replaceAll(":", "_");			
			
			
			String fileLoc=storagepath+instituteid+"/archivalpdfs/"+sessionname+"_"+sessionid+"/Standardwise List/"+standardscheduleid+"/";
			//System.out.print("fileLoc-->"+fileLoc);
			File createFile=new File(fileLoc);
			boolean flag = createFile.exists(); 
			if(flag)
			{
				
			}
			else
			{
				createFile.mkdirs();
			}   

			//tempPath=storagepath+instituteid+"/archivalpdfs/"+sessionname+"_"+sessionid+"/Standardwise List"+"/Standardwise List "+time_stamp+"_temp.pdf";
			tempPath=storagepath+instituteid+"/archivalpdfs/"+sessionname+"_"+sessionid+"/Standardwise List/"+standardscheduleid+"/output.pdf";
			fileName=storagepath+instituteid+"/archivalpdfs/"+sessionname+"_"+sessionid+"/Standardwise List/"+standardscheduleid+"/Standardwise List "+time_stamp+".pdf" ;
			//fileName=storagepath+instituteid+"/archivalpdfs/"+sessionname+"_"+sessionid+"/Standardwise List"+"/Standardwise List.pdf" ;
			
			//temppath=storagepath+instituteid+"/archivalpdfs/"+sessionname+"_"+reg_sessionid+"/ExamDetails"+"/ExamDetails "+time_stamp+"_temp.pdf";
			//filepath=storagepath+instituteid+"/archivalpdfs/"+sessionname+"_"+reg_sessionid+"/ExamDetails"+"/ExamDetails "+time_stamp+".pdf" ;


//PdfWriter writer = PdfWriter.getInstance(document,new FileOutputStream(storagepath+"PDFReports/studentList1.pdf"));
			PdfWriter writer = PdfWriter.getInstance(document,new FileOutputStream(tempPath));
document.open();
Paragraph p3=new Paragraph("Standardwise Report",new Font(Font.TIMES_ROMAN, 14, Font.BOLD,Color.BLACK));
p3.setAlignment(Element.ALIGN_CENTER);
document.add(p3);
Paragraph p1=new Paragraph("Academic Year : "+sessionname,new Font(Font.TIMES_ROMAN, 14, Font.BOLD,Color.BLACK));
p1.setAlignment(Element.ALIGN_CENTER);
document.add(p1);   
Paragraph p2=new Paragraph("( Board Name : "+boardname+" )",new Font(Font.COURIER, 10, Font.BOLD,Color.BLACK));
p2.setAlignment(Element.ALIGN_CENTER);
document.add(p2);

//Paragraph p = new Paragraph();
//p.add(new Chunk("Timesheet status for the date :"+strartdae+"\t"+ "to"+"\t"+enddate, new Font(Font.TIMES_ROMAN, 12,Font.BOLD,Color.black)));
//p.add(new Chunk("Student List for the session :"+sessionname+"\t", new Font(Font.TIMES_ROMAN, 12,Font.BOLD,Color.black)));
//document.add(new Paragraph(p));
Paragraph Twogapnext=new Paragraph("\n");
document.add(Twogapnext);
//document.add(Chunk.NEXTPAGE);

Paragraph Twogap=new Paragraph("\n\n");
//document.add(Twogap);

PdfPTable table = new PdfPTable(5);

PdfPCell cell;
//cell = new PdfPCell(new Paragraph("Board : "+boardname, new Font(Font.TIMES_ROMAN, 11,Font.BOLD,Color.black)));
//cell.setBackgroundColor(new Color(255,229,255));
//cell.setBackgroundColor(new Color(14,118,188));
//cell.setColspan(5);
//table.addCell(cell);


Paragraph p4=new Paragraph("Standard : "+standardname,new Font(Font.TIMES_ROMAN, 12, Font.BOLD,Color.red));
p4.setAlignment(Element.ALIGN_LEFT);
document.add(p4);
document.add(Twogapnext);

/*PdfPCell cell1;
cell1 = new PdfPCell(new Paragraph("Standard : "+standardname, new Font(Font.TIMES_ROMAN, 11,Font.BOLD,Color.black)));
cell1.setBackgroundColor(new Color(255,229,255));
//cell1.setBackgroundColor(new Color(14,138,188));
cell1.setColspan(5);
table.addCell(cell1);*/		
/*********************STUDENT LIST****************************/

int headerwidths[] = { 8, 25, 20, 20, 28}; // percentage
table.setWidths(headerwidths);
table.setWidthPercentage(100); // percentage
table.getDefaultCell().setPadding(1);
table.getDefaultCell().setBorderWidth(0);
table.getDefaultCell().setHorizontalAlignment(Element.ALIGN_LEFT);

//System.out.println("studentList.size()-->"+studentList.size());
ArrayList tempStdList = new ArrayList();
if(studentList!=null && studentList.size()>0)
{
	for (int i = 0, j = 1; i < studentList.size(); i++) {
		//System.out.println("0-->");
		HashMap applicantListMap=(HashMap)studentList.get(i);
		stdSchedId      = (String)applicantListMap.get("standardscheduleid");
		applicantName      = (String)applicantListMap.get("applicantname");
		rollNo      = (String)applicantListMap.get("rollno");
		standardName      = (String)applicantListMap.get("standardname");
		groupName      = (String)applicantListMap.get("groupname");
		secName      = (String)applicantListMap.get("sectionname");
		emailId      	  = (String)applicantListMap.get("emailid");
		
		if(groupName!=null)
			standardName = standardName+" - "+groupName; 
		
		//System.out.println("1-->");
		if(!tempStdList.contains(standardName))
		{
		PdfPCell cell2;
		cell2 = new PdfPCell(new Paragraph("Student List", new Font(Font.TIMES_ROMAN, 11,Font.BOLD,Color.black)));
		cell2.setBackgroundColor(new Color(255,115,255));
		//cell2.setBackgroundColor(new Color(14,138,188));
		cell2.setColspan(5);
		table.addCell(cell2);		
		//System.out.println("2-->");
		table.getDefaultCell().setBorderWidth(1);
		table.getDefaultCell().setBackgroundColor(new Color(255,229,255));
		table.addCell(new Paragraph("Sl no",new Font(Font.TIMES_ROMAN, 11,Font.BOLD,Color.black)));
		table.addCell(new Paragraph("Name of Student ",new Font(Font.TIMES_ROMAN, 11,Font.BOLD,Color.black)));
		table.addCell(new Paragraph("Roll No",new Font(Font.TIMES_ROMAN, 11,Font.BOLD,Color.black)));
		table.addCell(new Paragraph("Section",new Font(Font.TIMES_ROMAN, 11,Font.BOLD,Color.black)));
		table.addCell(new Paragraph("Email ID",new Font(Font.TIMES_ROMAN, 11,Font.BOLD,Color.black)));
				
		//table.getDefaultCell().setBackgroundColor(Color.WHITE);
		
		}
		//System.out.println("3-->");
		String seri=(i+1)+"";
		cell = new PdfPCell(new Paragraph(seri));
		cell.setHorizontalAlignment(Element.ALIGN_LEFT);
		table.addCell(cell);

		//String names=timesheetAList.get(9).toString();
		cell = new PdfPCell(new Paragraph(applicantName));
		cell.setHorizontalAlignment(Element.ALIGN_LEFT);
		table.addCell(cell);

		//String roles=timesheetAList.get(5).toString();
		if(rollNo==null || rollNo.equals("null"))
			rollNo = "-";
		
		cell = new PdfPCell(new Paragraph(rollNo));
		cell.setHorizontalAlignment(Element.ALIGN_LEFT);
		table.addCell(cell);

		cell = new PdfPCell(new Paragraph(secName));
		cell.setHorizontalAlignment(Element.ALIGN_LEFT);
		table.addCell(cell);
		//System.out.println("4-->");
		cell = new PdfPCell(new Paragraph(emailId));
		cell.setHorizontalAlignment(Element.ALIGN_LEFT);
		table.addCell(cell);
		tempStdList.add(standardName);   
	}
}

table.getDefaultCell().setBackgroundColor(new Color(96,200,242));

document.add(table);
/*************************FEES DETAILS********************************/
Paragraph Twogapnext1=new Paragraph("\n");
//document.add(Twogapnext);
//document.add(Chunk.NEXTPAGE);
document.newPage();


Paragraph Twogapnext2=new Paragraph("\n\n\n");
document.add(Twogapnext2);
PdfPTable table1 = new PdfPTable(8);
PdfPCell cellFees;
cellFees = new PdfPCell(new Paragraph("Fees Details", new Font(Font.TIMES_ROMAN, 11,Font.BOLD,Color.black)));
cellFees.setBackgroundColor(new Color(255,115,255));
table1.setWidthPercentage(100);
cellFees.setColspan(8);
table1.addCell(cellFees);
ArrayList pendingFeesList= null;
pendingFeesList	=	(ArrayList)applicationQuery.displayStdwiseFeesDetailsforPdf(sessionid,boardid,instituteid,standardscheduleid);
//System.out.print("pendingFeesList-->"+pendingFeesList);

if(pendingFeesList!=null && pendingFeesList.size()>0)
{
	tempStdList = new ArrayList();
	String feeStatus=null;
	String paidAmount=null;
	String remainAmount=null;
	String standardscheduleId  = "";
	 applicantName		= "";
	 rollNo      		= "";
	 standardName    	= "";
	 groupName      		= "";
	 secName      		= "";
		ArrayList standardList = new ArrayList();
		ArrayList termList = new ArrayList();
		String pendingStatus = "";
		int count = 0;
		int totPendingCount = 0;
		int pendingCount = 0;
		ArrayList pendingCountList= null;
		String formattedTermFeeCurrency=null;
		String formattedPaidCurrency=null;
		String formattedPendCurrency=null;
		//ResourceBundle bundle  =ResourceBundle.getBundle("resources.serversetup");
	    Locale localcurrency = new Locale(bundle.getString("language"), bundle.getString("code"));
	 
	//System.out.println("pendingFeesList.size()-->"+pendingFeesList.size());

	
	//System.out.println("timesheetAList(3)-->"+applicantList.size()+"sessionname-->"+sessionname+"institutelogo-->"+institutelogo);
	//cell = new PdfPCell(new Paragraph("Board : "+boardname, new Font(Font.TIMES_ROMAN, 11,Font.BOLD,Color.black)));
	//cell.setBackgroundColor(new Color(255,229,255));
	//cell.setBackgroundColor(new Color(14,118,188));
	//cell.setColspan(8);
	//table.addCell(cell);

	int headerwidthsFees[] = { 3, 21, 10, 11, 15, 15, 15, 9}; // percentage
	table1.setWidths(headerwidthsFees);
	table1.setWidthPercentage(100); // percentage
	table1.getDefaultCell().setPadding(1);
	table1.getDefaultCell().setBorderWidth(0);
	table1.getDefaultCell().setHorizontalAlignment(Element.ALIGN_LEFT);

	Color gencolor = Color.decode("0x009900");
	Color custColor = new Color(gencolor.getRed(),gencolor.getGreen(),gencolor.getBlue(),150);
	
	int serialCount = 0;
	for (int i = 0, j = 1; i < pendingFeesList.size(); i++) {
		//System.out.println("0-->");
		
		HashMap map					=	(HashMap)pendingFeesList.get(i);
		standardName			=	(String) map.get("standardname");
		standardscheduleId	=	(String) map.get("standardscheduleid");				
		groupName			=	(String) map.get("groupname");
		String termfeesId			=	(String) map.get("termfeesid");				
		String termfeesAmount		=	(String) map.get("termfeesamount");
		String termName				=	(String) map.get("termname");
		String dueDate				=	(String) map.get("duedate");
		
		
	    Long termFeeObj 			= Long.valueOf(termfeesAmount); 
	    NumberFormat termFeeFormat 	= NumberFormat.getCurrencyInstance(localcurrency);
	    formattedTermFeeCurrency 	= termFeeFormat.format(termFeeObj);
	    
		if(groupName!=null)
			standardName = standardName+" - "+groupName;
		
		if(!standardList.contains(standardName))
		{
			count=0;
			flag = false;
		}
			
		//System.out.println("standardscheduleId,termfeesId-->"+standardscheduleId+"--"+termfeesId);		
		pendingCountList	=	(ArrayList)feesscheduleQuery.displayFeesDetailsPdf(standardscheduleId,termfeesId);
			pendingCount = 0;
			//System.out.println("pendingCountList.size()-->"+pendingCountList.size());
			if(pendingFeesList.size()!=0)
			{
				//pendingCount = 0;
				
			for(int k=0;k<pendingCountList.size();k++)
			{
				
				HashMap pendingMap			= (HashMap)pendingCountList.get(k);
				//System.out.println("pendingMap-->"+pendingMap);
				
				applicantName		= (String)pendingMap.get("applicantname");
				rollNo		= (String)pendingMap.get("rollno");
				secName		= (String)pendingMap.get("sectionname");
				
				feeStatus		= (String)pendingMap.get("feestatus");
				//termFeesAmount		= (String)pendingMap.get("termfeesamount");
				paidAmount		= (String)pendingMap.get("FeesPaid");
				remainAmount		= (String)pendingMap.get("RemAmount");				
				pendingStatus		= (String)pendingMap.get("pendingstatus");
				
				//System.out.println("rollno-->"+(String)pendingMap.get("rollno"));
				//System.out.println("feestatus-->"+(String)pendingMap.get("feestatus"));
				//System.out.println("pendingMap-->"+pendingMap+"feeStatus-->"+feeStatus);
				if(rollNo==null)
					rollNo = "-";

			    Long paidFeeObj 			= Long.valueOf(paidAmount); 
			    NumberFormat paidFeeFormat 	= NumberFormat.getCurrencyInstance(localcurrency);
			    formattedPaidCurrency 		= paidFeeFormat.format(paidFeeObj);
			    
			    Long pendFeeObj 			= Long.valueOf(remainAmount); 
			    NumberFormat pendFeeFormat 	= NumberFormat.getCurrencyInstance(localcurrency);
			    formattedPendCurrency 		= pendFeeFormat.format(pendFeeObj);
			    
			    
			    PdfPCell cell1;
		if(!tempStdList.contains(standardscheduleId))
				{
				/*PdfPCell cell1;
					if(!standardList.contains(standardName)){	
				
				cell1 = new PdfPCell(new Paragraph("Standard : "+standardName, new Font(Font.TIMES_ROMAN, 11,Font.BOLD,Color.black)));
				cell1.setBackgroundColor(new Color(255,115,255));
				//cell1.setBackgroundColor(new Color(14,138,188));
				cell1.setColspan(8);
				table.addCell(cell1);*/		
				//System.out.println("2-->");

				
				standardList.add(standardName);
					}
					//System.out.println("termList-->"+termList);
					if(!termList.contains(termfeesId)){
						serialCount = 1;
						//PdfPCell cell2;
						cell1 = new PdfPCell(new Paragraph("Term Name : "+termName, new Font(Font.TIMES_ROMAN, 11,Font.BOLD,Color.black)));
						cell1.setBackgroundColor(new Color(255,172,255));
						//cell1.setBackgroundColor(new Color(14,138,188));
						cell1.setColspan(8);
						table1.addCell(cell1);		
						//System.out.println("2-->");
						termList.add(termfeesId);
						table1.getDefaultCell().setBorderWidth(1);
						table1.getDefaultCell().setBackgroundColor(new Color(255,229,255));
						table1.addCell(new Paragraph("Sl",new Font(Font.TIMES_ROMAN, 11,Font.BOLD,Color.black)));
						table1.addCell(new Paragraph("Name of Student ",new Font(Font.TIMES_ROMAN, 11,Font.BOLD,Color.black)));
						table1.addCell(new Paragraph("Roll No",new Font(Font.TIMES_ROMAN, 11,Font.BOLD,Color.black)));
						table1.addCell(new Paragraph("Section",new Font(Font.TIMES_ROMAN, 11,Font.BOLD,Color.black)));
						table1.addCell(new Paragraph("Term Fee",new Font(Font.TIMES_ROMAN, 11,Font.BOLD,Color.black)));
						table1.addCell(new Paragraph("Paid Fee",new Font(Font.TIMES_ROMAN, 11,Font.BOLD,Color.black)));
						table1.addCell(new Paragraph("Pending Fee",new Font(Font.TIMES_ROMAN, 11,Font.BOLD,Color.black)));
						table1.addCell(new Paragraph("Status",new Font(Font.TIMES_ROMAN, 11,Font.BOLD,Color.black)));
						
						//table1.getDefaultCell().setBackgroundColor(Color.WHITE);						
					}
					

				//}
				//System.out.println("3-->");
				//String seri=(i+1)+"";
				String seri=(serialCount++)+"";
				cell = new PdfPCell(new Paragraph(seri));
				cell.setHorizontalAlignment(Element.ALIGN_LEFT);
				table1.addCell(cell);

				//String names=timesheetAList.get(9).toString();
				cell = new PdfPCell(new Paragraph(applicantName));
				cell.setHorizontalAlignment(Element.ALIGN_LEFT);
				table1.addCell(cell);

				//String roles=timesheetAList.get(5).toString();
				if(rollNo==null || rollNo.equals("null"))
					rollNo = "-";
				
				cell = new PdfPCell(new Paragraph(rollNo));
				cell.setHorizontalAlignment(Element.ALIGN_LEFT);
				table1.addCell(cell);

				cell = new PdfPCell(new Paragraph(secName));
				cell.setHorizontalAlignment(Element.ALIGN_LEFT);
				table1.addCell(cell);

				cell = new PdfPCell(new Paragraph(formattedTermFeeCurrency));
				cell.setHorizontalAlignment(Element.ALIGN_LEFT);
				table1.addCell(cell);
				
				cell = new PdfPCell(new Paragraph(formattedPaidCurrency));
				cell.setHorizontalAlignment(Element.ALIGN_LEFT);
				table1.addCell(cell);
				
				cell = new PdfPCell(new Paragraph(formattedPendCurrency));
				cell.setHorizontalAlignment(Element.ALIGN_LEFT);
				table1.addCell(cell);
				
				//System.out.println("4-->");
								
				if(feeStatus.equals("Pending")){
				cell = new PdfPCell(new Paragraph(feeStatus,new Font(Font.TIMES_ROMAN, 12,Font.NORMAL,Color.red)));
				cell.setHorizontalAlignment(Element.ALIGN_LEFT);
				table1.addCell(cell);
				}
				else{
					cell = new PdfPCell(new Paragraph(feeStatus,new Font(Font.TIMES_ROMAN, 12,Font.NORMAL,custColor)));
					cell.setHorizontalAlignment(Element.ALIGN_LEFT);
					table1.addCell(cell);					
				}
				tempStdList.add(standardscheduleId);				
				if( pendingStatus.equals("0"))
				{
					pendingCount = pendingCount+1;
				}
		
			}
			//System.out.println("pendingCount-->"+pendingCount);
			
			}
			count = count+1;
			totPendingCount = totPendingCount + pendingCount;
			//out.print("<tr><td>"+(count)+"</td><td>"+termName+"</td><td>"+formattedTermFeeCurrency+"</td><td>"+dueDate+"</td>");
			//if(pendingCount>0)
				//out.print("<td style='background-color:#B0FFB0' >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href='#' standardscheduleid='"+standardscheduleId+"' standardname='"+standardName+"' termfeesid='"+termfeesId+"' termname='"+termName+"' termfeesamount='"+termfeesAmount+"' duedate='"+dueDate+"'  onclick='pendingView(this)'>"+pendingCount+"</a></td></tr>");
			//else
				//out.print("<td style='background-color:lightblue' >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+pendingCount+"</td></tr>");
	}		
		}
		else
		{
			cellFees = new PdfPCell(new Paragraph("Data Not Found", new Font(Font.TIMES_ROMAN, 11,Font.BOLD,Color.red)));
			cellFees.setBackgroundColor(Color.WHITE);
			//cellFees.setBackgroundColor(new Color(255,229,255));
			cellFees.setColspan(8);
			cellFees.setHorizontalAlignment(Element.ALIGN_CENTER);
			table1.addCell(cellFees);
			//out.println("<tr><td colspan=5 align=center><font color=red><b>Data not found</b></font></td></tr>");
	 		//out.println("<tr align='center' class='tablebold'><td colspan='5'><font color='red'>Data Not Found</font></td></tr>");


		//
		}


table1.getDefaultCell().setBackgroundColor(new Color(96,200,242));
document.add(table1);

/*************************EXAM SCHEDULE********************************/
ArrayList ExamList= null;
ExamList	=	(ArrayList)applicationQuery.displayStdwiseExamnameListforPdf(instituteid,sessionid,boardid,standardscheduleid);
//System.out.print("ExamList-->"+ExamList);
 //table1 = new PdfPTable(8);
PdfPTable table2 = new PdfPTable(7);
 Twogapnext1=new Paragraph("\n");
//document.add(Twogapnext);
 //document.add(Chunk.NEXTPAGE);
 document.newPage();

 Twogapnext2=new Paragraph("\n\n\n");
document.add(Twogapnext2);

ArrayList subjectList=null;

PdfPCell cellExam;

cellExam = new PdfPCell(new Paragraph("Exam Details", new Font(Font.TIMES_ROMAN, 11,Font.BOLD,Color.black)));
cellExam.setBackgroundColor(new Color(255,115,255));
table2.setWidthPercentage(100);
cellExam.setColspan(7);
table2.addCell(cellExam);

if(ExamList!=null && ExamList.size()>0)
{

	
	//PdfPCell cellExam;
	for (int i = 0, j = 1; i < ExamList.size(); i++) 
	{
	j=1;
HashMap ExamListMap=(HashMap)ExamList.get(i);
String examId     = (String)ExamListMap.get("examnameid");
String examName      = (String)ExamListMap.get("examname");
String examallotmentid= (String)ExamListMap.get("examallotmentid");
	//subjectList=examQuery.LoadExamSubjectList(examId,sessionid);
subjectList=applicationQuery.loadExamSubjectListStdwise(examId,sessionid,standardscheduleid);

	           
	//System.out.print("subjectList-->"+subjectList);

String duration=null;
  if(subjectList!=null && subjectList.size()>0)
	{ 					
	  cellExam = new PdfPCell(new Paragraph("Exam Name : "+examName, new Font(Font.TIMES_ROMAN, 11,Font.BOLD,Color.black)));
	  cellExam.setBackgroundColor(new Color(255,172,255));
		//cellExam.setBackgroundColor(new Color(14,138,188));
	  cellExam.setColspan(7);
		table2.addCell(cellExam);
		
	  	/*Paragraph examP = new Paragraph();         
		examP.add(new Chunk("Exam Name : "+examName+"\t", new Font(Font.TIMES_ROMAN, 12,Font.BOLD,Color.red)));
		document.add(new Paragraph(examP));
		Paragraph TwogapnextExam=new Paragraph("\n");
		document.add(TwogapnextExam);*/
	
		int headerwidthsExam[] = { 8, 34, 16, 12,12,7,7}; 
		table2.setWidths(headerwidthsExam);
		table2.setWidthPercentage(100); 
		table2.getDefaultCell().setPadding(2);
		table2.getDefaultCell().setBorderWidth(1); 
		table2.getDefaultCell().setHorizontalAlignment(Element.ALIGN_LEFT);
		

		
		table2.getDefaultCell().setBackgroundColor(new Color(255,229,255));
		table2.addCell(new Paragraph("Sl",new Font(Font.TIMES_ROMAN, 11,Font.BOLD,Color.black)));
		//table2.addCell(new Paragraph("Standard",new Font(Font.TIMES_ROMAN, 11,Font.BOLD,Color.black)));
		table2.addCell(new Paragraph("Subject Name",new Font(Font.TIMES_ROMAN, 11,Font.BOLD,Color.black)));
		table2.addCell(new Paragraph("Date",new Font(Font.TIMES_ROMAN, 11,Font.BOLD,Color.black)));
		table2.addCell(new Paragraph("Start Time",new Font(Font.TIMES_ROMAN, 11,Font.BOLD,Color.black)));
		table2.addCell(new Paragraph("End Time",new Font(Font.TIMES_ROMAN, 11,Font.BOLD,Color.black)));
		table2.addCell(new Paragraph("Duration",new Font(Font.TIMES_ROMAN, 11,Font.BOLD,Color.black)));
		table2.addCell(new Paragraph("Exam Type",new Font(Font.TIMES_ROMAN, 11,Font.BOLD,Color.black)));
		
		//table2.getDefaultCell().setBackgroundColor(Color.WHITE);
	  //String standardscheduleid="";
	 	for (int i1 = 0; i1 < subjectList.size(); i1++)
	 	{	
	 		
	 		HashMap subjectListMap=(HashMap)subjectList.get(i1);
			String groupname      = (String)subjectListMap.get("groupname")+"";
			 standardname      = (String)subjectListMap.get("standardname");
			if(!groupname.equals("null"))
			{
			standardname=standardname+"  -"+groupname;
			}
			String subjectname      = (String)subjectListMap.get("subjectname");
			String standardid      = (String)subjectListMap.get("standardscheduleid");
			String examdate      = (String)subjectListMap.get("examdate");
			String examtimein      = (String)subjectListMap.get("examtimein");
			String examtimeout      = (String)subjectListMap.get("examtimeout");
			String examtimeinampm      = (String)subjectListMap.get("examtimeinampm");
			String examtimeoutampm      = (String)subjectListMap.get("examtimeoutampm");
			duration				=	(String)subjectListMap.get("duration");
			String examtype				=	(String)subjectListMap.get("examtype");
		

			if(examdate == null){
				examdate= " ";}
			if(examtimein == null){
				examtimein= " ";}
			if(examtimeout == null){
				examtimeout= " ";}
			//if(subjectListMap.get("examtimein") != null && subjectListMap.get("examtimeout")!=null)
			//duration = examQuery.getHourMin(examtimein,examtimeout);
		
			if(!standardscheduleid.equals(standardid))
			{
		 	  
		 		standardscheduleid=standardid;
			}
	 		else
	 		{
	 		
	 		}
			cellExam = new PdfPCell(new Paragraph(j+""));
			table2.addCell(cellExam);
			//cellExam = new PdfPCell(new Paragraph(standardname));
			 //table2.addCell(cellExam);
			 cellExam = new PdfPCell(new Paragraph(subjectname));
			  table2.addCell(cellExam);
			  cellExam = new PdfPCell(new Paragraph(examdate));
	 		table2.addCell(cellExam);
	 		cellExam = new PdfPCell(new Paragraph(examtimeinampm));
	 		table2.addCell(cellExam);
	 		cellExam = new PdfPCell(new Paragraph(examtimeoutampm));
	 		table2.addCell(cellExam);
	 		cellExam = new PdfPCell(new Paragraph(duration));
	 		table2.addCell(cellExam);
	 		cellExam = new PdfPCell(new Paragraph(examtype));
	 		table2.addCell(cellExam);	 		
	 		j++;
	 	}
}
  else
  {
		cellExam = new PdfPCell(new Paragraph("Data Not Found", new Font(Font.TIMES_ROMAN, 11,Font.BOLD,Color.red)));
		cellExam.setHorizontalAlignment(Element.ALIGN_CENTER);
		cellExam.setColspan(7);
		table2.addCell(cellExam);
	  
  }
	}
}
else
{
	cellExam = new PdfPCell(new Paragraph("Data Not Found", new Font(Font.TIMES_ROMAN, 11,Font.BOLD,Color.red)));
	cellExam.setHorizontalAlignment(Element.ALIGN_CENTER);
	cellExam.setColspan(7);
	table2.addCell(cellExam);
}


table2.getDefaultCell().setBackgroundColor(new Color(96,200,242));
document.add(table2);
/***********************EXAM MARK**********************************/

ArrayList examAllotList = null;
examAllotList 			= (ArrayList)applicationQuery.allotedStdwiseExamforPDF(sessionid,boardid,instituteid,standardscheduleid);	

 Twogapnext=new Paragraph("\n");
document.add(Twogapnext);

 Twogap=new Paragraph("\n\n");
document.add(Twogap);

//System.out.println("studentList.size()-->"+studentList.size());
 tempStdList = new ArrayList();
ArrayList tempFeeIdList = new ArrayList();
ArrayList standardList = new ArrayList();
ArrayList examAllotIdList = new ArrayList();
ArrayList studAllocIdList = new ArrayList();
ArrayList examMarkList= null;

PdfPTable tableMark = new PdfPTable(8);

	//System.out.println("pendingFeesList.size()-->"+pendingFeesList.size());
	
     Twogapnext1=new Paragraph("\n");
    //document.add(Twogapnext);
	    //document.add(Chunk.NEXTPAGE);
	    document.newPage();
    

     Twogapnext2=new Paragraph("\n\n\n");
    document.add(Twogapnext2);
	
    PdfPCell cellMark;    
	

	//System.out.println("timesheetAList(3)-->"+applicantList.size()+"sessionname-->"+sessionname+"institutelogo-->"+institutelogo);
	cellMark = new PdfPCell(new Paragraph("Note : NE - Not Entered", new Font(Font.TIMES_ROMAN, 11,Font.BOLD,Color.red)));
//cell.setBackgroundColor(new Color(255,229,255));
	//cell.setBackgroundColor(new Color(14,118,188));
	cellMark.setColspan(8);
	cellMark.setHorizontalAlignment(Element.ALIGN_RIGHT);
	cellMark.setBorder(0);
	tableMark.addCell(cellMark);

    cellMark = new PdfPCell(new Paragraph("Mark Details : ", new Font(Font.TIMES_ROMAN, 11,Font.BOLD,Color.black)));
    cellMark.setBackgroundColor(new Color(255,115,255));
    tableMark.setWidthPercentage(100);
    cellMark.setColspan(8);
    tableMark.addCell(cellMark);
	
	if(examAllotList!=null && examAllotList.size()>0)
	{
	int headerwidthsMark[] = { 5, 21, 10, 11, 20, 15, 10, 7}; // percentage
	tableMark.setWidths(headerwidthsMark);
	tableMark.setWidthPercentage(100); // percentage
	tableMark.getDefaultCell().setPadding(1);
	tableMark.getDefaultCell().setBorderWidth(0);
	tableMark.getDefaultCell().setHorizontalAlignment(Element.ALIGN_LEFT);
	
	Color gencolor = Color.decode("0x009900");
	Color custColor = new Color(gencolor.getRed(),gencolor.getGreen(),gencolor.getBlue(),150);
	//Color getcolor = new Color(gerrncolor.getRed(),gerrncolor.getGreen(),gerrncolor.getBlue(),150);
	String examAllotmentId  = "";
	String examNameId  = "";
	String examName  = "";
	String standardscheduleId  = "";
	String subjectName			= "";
	 String subjectCode			= "";
	 String subjectMark			= "";
	 String resultStat			= "";
	 String studAllocId			= "";
	 String passMark			= "";
	
	int serialCount = 0;
	for (int i = 0, j = 1; i < examAllotList.size(); i++) {
		//System.out.println("0-->");
		
		HashMap map				=	(HashMap)examAllotList.get(i);
		examAllotmentId			=	(String) map.get("examallotmentid");
		examNameId				=	(String) map.get("examnameid");
		examName				=	(String) map.get("examname");
		standardscheduleId		=	(String) map.get("standardscheduleid");
		standardName			=	(String) map.get("standardname");
		groupName				=	(String) map.get("groupname");
		
		//String termfeesId		=	(String) map.get("termfeesid");				
		//String termfeesAmount	=	(String) map.get("termfeesamount");
		//String termName			=	(String) map.get("termname");
		//String dueDate			=	(String) map.get("duedate");
		
		
	    /*Long termFeeObj 			= Long.valueOf(termfeesAmount); 
	    NumberFormat termFeeFormat 	= NumberFormat.getCurrencyInstance(localcurrency);
	    formattedTermFeeCurrency 	= termFeeFormat.format(termFeeObj);*/
	    
		if(groupName!=null)
			standardName = standardName+" - "+groupName;
		
		if(!standardList.contains(standardName))
		{
			int count=0;
			 flag = false;
		}
			
		//System.out.println("standardscheduleId,termfeesId-->"+standardscheduleId+"--"+termfeesId);		
		//pendingCountList	=	(ArrayList)feesscheduleQuery.displayFeesDetailsPdf(standardscheduleId,termfeesId);
		//System.out.print("standardscheduleid-->"+standardscheduleid);
		examMarkList	=	(ArrayList)examQuery.examMarkforPDF(standardscheduleid,examAllotmentId);
		
			int pendingCount = 0;
			//System.out.println("pendingCountList.size()-->"+pendingCountList.size());
			if(examAllotList.size()!=0)
			{
				//pendingCount = 0;
					
			for(int k=0;k<examMarkList.size();k++)
			{
				resultStat = "Pass";
				HashMap examMarkMap			= (HashMap)examMarkList.get(k);
				//System.out.println("examMarkMap-->"+examMarkMap);
				
				applicantName	= (String)examMarkMap.get("studentname");
				rollNo			= (String)examMarkMap.get("rollno");
				secName			= (String)examMarkMap.get("sectionname");
				subjectName 	= (String)examMarkMap.get("subjectname");
				subjectCode 	= (String)examMarkMap.get("subjectcode");
				subjectMark 	= (String)examMarkMap.get("marktaken");
				studAllocId 	= (String)examMarkMap.get("studentallocationid");
				passMark 		= (String)examMarkMap.get("theoryexternalmin");
				

				if(subjectMark==null){
					subjectMark = "NE";
					resultStat = "NE";
				}
				else{
					try
					{
					if(Integer.parseInt(subjectMark)<Integer.parseInt(passMark))
						resultStat = "Fail";
					}catch(NumberFormatException ne){subjectMark="A";resultStat="Fail";}

					//if(Integer.parseInt(subjectMark)<Integer.parseInt(passMark))
						//resultStat = "Fail";					
				}
//System.out.println("resultStat-->"+resultStat);
				//feeStatus		= (String)pendingMap.get("feestatus");
				//termFeesAmount		= (String)pendingMap.get("termfeesamount");
				//paidAmount		= (String)pendingMap.get("FeesPaid");
				//remainAmount		= (String)pendingMap.get("RemAmount");				
				//String pendingStatus		= (String)pendingMap.get("pendingstatus");
				
				//System.out.println("rollno-->"+(String)pendingMap.get("rollno"));
				//System.out.println("feestatus-->"+(String)pendingMap.get("feestatus"));
				//System.out.println("pendingMap-->"+pendingMap+"feeStatus-->"+feeStatus);
				if(rollNo==null)
					rollNo = "-";

			    /*Long paidFeeObj 			= Long.valueOf(paidAmount); 
			    NumberFormat paidFeeFormat 	= NumberFormat.getCurrencyInstance(localcurrency);
			    formattedPaidCurrency 		= paidFeeFormat.format(paidFeeObj);
			    
			    Long pendFeeObj 			= Long.valueOf(remainAmount); 
			    NumberFormat pendFeeFormat 	= NumberFormat.getCurrencyInstance(localcurrency);
			    formattedPendCurrency 		= pendFeeFormat.format(pendFeeObj);*/
			    
		//if(!tempStdList.contains(standardscheduleId))
				{
				PdfPCell cell1;
					if(!standardList.contains(standardName)){	
				
				//cell1 = new PdfPCell(new Paragraph("Standard : "+standardName, new Font(Font.TIMES_ROMAN, 11,Font.BOLD,Color.black)));
				//cell1 = new PdfPCell(new Paragraph("Mark Details", new Font(Font.TIMES_ROMAN, 11,Font.BOLD,Color.black)));		
				//cell1.setBackgroundColor(new Color(255,115,255));
				//cell1.setBackgroundColor(new Color(14,138,188));
				//cell1.setColspan(8);
				//tableMark.addCell(cell1);		
				//System.out.println("2-->");
				
				standardList.add(standardName);
					}
					//System.out.println("termList-->"+termList);
					if(!examAllotIdList.contains(examAllotmentId)){
						serialCount = 1;
						//PdfPCell cell2;
						cell1 = new PdfPCell(new Paragraph("Exam Name : "+examName, new Font(Font.TIMES_ROMAN, 11,Font.BOLD,Color.black)));
						cell1.setBackgroundColor(new Color(255,172,255));
						//cell1.setBackgroundColor(new Color(14,138,188));
						cell1.setColspan(8);
						tableMark.addCell(cell1);		
						//System.out.println("2-->");
						examAllotIdList.add(examAllotmentId);
						tableMark.getDefaultCell().setBorderWidth(1);
						tableMark.getDefaultCell().setBackgroundColor(new Color(255,229,255));
						tableMark.addCell(new Paragraph("Sl",new Font(Font.TIMES_ROMAN, 11,Font.BOLD,Color.black)));
						tableMark.addCell(new Paragraph("Name of Student ",new Font(Font.TIMES_ROMAN, 11,Font.BOLD,Color.black)));
						tableMark.addCell(new Paragraph("Roll No",new Font(Font.TIMES_ROMAN, 11,Font.BOLD,Color.black)));
						tableMark.addCell(new Paragraph("Section",new Font(Font.TIMES_ROMAN, 11,Font.BOLD,Color.black)));
						tableMark.addCell(new Paragraph("Subject Name",new Font(Font.TIMES_ROMAN, 11,Font.BOLD,Color.black)));
						tableMark.addCell(new Paragraph("Subject Code",new Font(Font.TIMES_ROMAN, 11,Font.BOLD,Color.black)));
						tableMark.addCell(new Paragraph("Mark",new Font(Font.TIMES_ROMAN, 11,Font.BOLD,Color.black)));
						tableMark.addCell(new Paragraph("Result",new Font(Font.TIMES_ROMAN, 11,Font.BOLD,Color.black)));
						//tableMark.getDefaultCell().setBackgroundColor(Color.WHITE);
							
					}
					

				}
				//System.out.println("3-->");
				//String seri=(i+1)+"";
				
				if(!studAllocIdList.contains(studAllocId))
				{
				String seri=(serialCount++)+"";
				cellMark = new PdfPCell(new Paragraph(seri));
				cellMark.setHorizontalAlignment(Element.ALIGN_LEFT);
				tableMark.addCell(cellMark);

				//String names=timesheetAList.get(9).toString();
				
				
				cellMark = new PdfPCell(new Paragraph(applicantName));
				cellMark.setHorizontalAlignment(Element.ALIGN_LEFT);
				tableMark.addCell(cellMark);

				//String roles=timesheetAList.get(5).toString();
				if(rollNo==null || rollNo.equals("null"))
					rollNo = "-";
				
				cellMark = new PdfPCell(new Paragraph(rollNo));
				cellMark.setHorizontalAlignment(Element.ALIGN_LEFT);
				tableMark.addCell(cellMark);

				cellMark = new PdfPCell(new Paragraph(secName));
				cellMark.setHorizontalAlignment(Element.ALIGN_LEFT);
				tableMark.addCell(cellMark);
				
				studAllocIdList.add(studAllocId);
				}
				else
				{
					cellMark = new PdfPCell(new Paragraph(""));
					cellMark.setHorizontalAlignment(Element.ALIGN_LEFT);
					tableMark.addCell(cellMark);

					//String names=timesheetAList.get(9).toString();
					
					
					cellMark = new PdfPCell(new Paragraph(""));
					cellMark.setHorizontalAlignment(Element.ALIGN_LEFT);
					tableMark.addCell(cellMark);

					//String roles=timesheetAList.get(5).toString();
					if(rollNo==null || rollNo.equals("null"))
						rollNo = "-";
					
					cellMark = new PdfPCell(new Paragraph(""));
					cellMark.setHorizontalAlignment(Element.ALIGN_LEFT);
					tableMark.addCell(cellMark);

					cellMark = new PdfPCell(new Paragraph(""));
					cellMark.setHorizontalAlignment(Element.ALIGN_LEFT);
					tableMark.addCell(cellMark);					
					
				}		
				

				cellMark = new PdfPCell(new Paragraph(subjectName));
				cellMark.setHorizontalAlignment(Element.ALIGN_LEFT);
				tableMark.addCell(cellMark);
				
				cellMark = new PdfPCell(new Paragraph(subjectCode));
				cellMark.setHorizontalAlignment(Element.ALIGN_LEFT);
				tableMark.addCell(cellMark);
				
				cellMark = new PdfPCell(new Paragraph(subjectMark));
				cellMark.setHorizontalAlignment(Element.ALIGN_LEFT);
				tableMark.addCell(cellMark);

				//cell = new PdfPCell(new Paragraph("Note : NE - Not Entered", new Font(Font.TIMES_ROMAN, 11,Font.BOLD,new Color(gerrncolor.getRed(),gerrncolor.getGreen(),gerrncolor.getBlue(),150))));
				
				//System.out.println("4-->");
				if(resultStat.equals("Fail")){
					cellMark = new PdfPCell(new Paragraph(resultStat,new Font(Font.TIMES_ROMAN, 14,Font.NORMAL,Color.red)));
					cellMark.setHorizontalAlignment(Element.ALIGN_LEFT);
				tableMark.addCell(cellMark);
				}
				else if(resultStat.equals("Pass")){
					//cell = new PdfPCell(new Paragraph(resultStat,new Font(Font.TIMES_ROMAN, 14,Font.NORMAL,Color.red)));
					cellMark = new PdfPCell(new Paragraph(resultStat, new Font(Font.TIMES_ROMAN, 14,Font.NORMAL,custColor)));
					cellMark.setHorizontalAlignment(Element.ALIGN_LEFT);
					tableMark.addCell(cellMark);					
				}
				else{
					cellMark = new PdfPCell(new Paragraph(resultStat));
					cellMark.setHorizontalAlignment(Element.ALIGN_LEFT);
					tableMark.addCell(cellMark);					
				}
				tempStdList.add(standardscheduleId);				
				//if( pendingStatus.equals("0"))
				//{
					//pendingCount = pendingCount+1;
				//}
		
			}
			//System.out.println("pendingCount-->"+pendingCount);
			
			}
			else
			{
				cellMark = new PdfPCell(new Paragraph("Data Not Found", new Font(Font.TIMES_ROMAN, 11,Font.BOLD,Color.red)));
				cellMark.setHorizontalAlignment(Element.ALIGN_CENTER);
				cellMark.setColspan(8);
				tableMark.addCell(cellMark);				
			}
			//count = count+1;
			//totPendingCount = totPendingCount + pendingCount;
			//out.print("<tr><td>"+(count)+"</td><td>"+termName+"</td><td>"+formattedTermFeeCurrency+"</td><td>"+dueDate+"</td>");
			//if(pendingCount>0)
				//out.print("<td style='background-color:#B0FFB0' >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href='#' standardscheduleid='"+standardscheduleId+"' standardname='"+standardName+"' termfeesid='"+termfeesId+"' termname='"+termName+"' termfeesamount='"+termfeesAmount+"' duedate='"+dueDate+"'  onclick='pendingView(this)'>"+pendingCount+"</a></td></tr>");
			//else
				//out.print("<td style='background-color:lightblue' >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+pendingCount+"</td></tr>");
				
		}
		}
		else
		{
			cellMark = new PdfPCell(new Paragraph("Data Not Found", new Font(Font.TIMES_ROMAN, 11,Font.BOLD,Color.red)));
			cellMark.setHorizontalAlignment(Element.ALIGN_CENTER);
			cellMark.setColspan(8);
			tableMark.addCell(cellMark);			
			
		}
		tableMark.getDefaultCell().setBackgroundColor(new Color(96,200,242));
		
		document.add(tableMark);
/***********************SUBJECT ALLOTMENT*********************************/

		ArrayList StandardList=new ArrayList();
		ArrayList StaffList=new ArrayList();

	     Twogapnext1=new Paragraph("\n");
	    //document.add(Twogapnext);
	    //document.add(Chunk.NEXTPAGE);
	    document.newPage();
	    
		Twogapnext=new Paragraph("\n");
		document.add(Twogapnext);
		Twogap=new Paragraph("\n\n");
		document.add(Twogap);


		if(!sessionid.equals("null") && !sessionid.equals("0"))
		{
			StandardList=applicationQuery.loadstdusingsessionid(sessionid,boardid,standardscheduleid);
		}
		if(StandardList != null && StandardList.size()>0)
		{
		for(int f=0;f<StandardList.size();f++){
		HashMap hashmap		= (HashMap)StandardList.get(f);
		 standardname=hashmap.get("standardname")+"";
		String groupname=hashmap.get("groupname")+"";
		if(!groupname.equals("null"))
		standardname=standardname+" -"+groupname;

		PdfPCell cellSubj;
		/*Paragraph subjP=new Paragraph("Standard : "+standardname,new Font(Font.TIMES_ROMAN, 12, Font.BOLD,Color.red));
		subjP.setAlignment(Element.ALIGN_LEFT);
		document.add(subjP);
		document.add(Twogapnext);*/

		
		PdfPTable tableSubj = new PdfPTable(4);
		int headerwidthsSubj[] = { 8, 33, 33, 27}; // percentage
		tableSubj.setWidths(headerwidthsSubj);

		cellSubj = new PdfPCell(new Paragraph("Subject Allotment Details", new Font(Font.TIMES_ROMAN, 11,Font.BOLD,Color.black)));		
		cellSubj.setBackgroundColor(new Color(255,115,255));
		//cell1.setBackgroundColor(new Color(14,138,188));
		cellSubj.setColspan(4);
		tableSubj.addCell(cellSubj);				
		
		tableSubj.setWidthPercentage(100); // percentage
		tableSubj.getDefaultCell().setPadding(1);
		tableSubj.getDefaultCell().setBorderWidth(1);
		tableSubj.getDefaultCell().setHorizontalAlignment(Element.ALIGN_LEFT);
		//tableSubj.getDefaultCell().setBackgroundColor(new Color(236,214,255));
		tableSubj.getDefaultCell().setBackgroundColor(new Color(255,172,255));		
		tableSubj.addCell(new Paragraph("Sl",new Font(Font.TIMES_ROMAN, 11,Font.BOLD,Color.black)));
		tableSubj.addCell(new Paragraph("Staff Name",new Font(Font.TIMES_ROMAN, 11,Font.BOLD,Color.black)));
		tableSubj.addCell(new Paragraph("Subject Name",new Font(Font.TIMES_ROMAN, 11,Font.BOLD,Color.black)));
		tableSubj.addCell(new Paragraph("Subject code",new Font(Font.TIMES_ROMAN, 11,Font.BOLD,Color.black)));
		tableSubj.getDefaultCell().setBackgroundColor(Color.WHITE);

		String stdid="";

		if(!sessionid.equals("null") && !sessionid.equals("0"))
		{
			//StaffList=prinicipal.loadstaffusingstandardscheduleid(hashmap.get("standardscheduleid")+"");
			StaffList=prinicipal.loadstaffusingstandardscheduleid(standardscheduleid);			
			stdid=hashmap.get("standardscheduleid")+"";
		}
		ArrayList SubjectList=null;
		if(StaffList != null && StaffList.size()>0)
					{		
					ArrayList sectionList=new ArrayList();
					ArrayList unameList=new ArrayList();
					String tempuname="";

					int gg=1;
					for(int y=0,i=1;y<StaffList.size();y++,i++){
					hashmap		= (HashMap)StaffList.get(y);
					String rolename=hashmap.get("rolename")+"";
					String sectionname=hashmap.get("sectionname")+"";
					String uname=hashmap.get("uname")+"";
					String staffid=hashmap.get("staffid")+"";
					String departmentname=hashmap.get("departmentname")+"";
					String sectionpublishid=hashmap.get("sectionpublishid")+"";

					
					if(!sectionList.contains(sectionname))
					{
						cellSubj = new PdfPCell(new Paragraph("Section :"+sectionname, new Font(Font.TIMES_ROMAN, 11,Font.BOLD,Color.black)));
						cellSubj.setBackgroundColor(new Color(255,229,255));
						cellSubj.setColspan(4);
						tableSubj.addCell(cellSubj);
						sectionList.add(sectionname);
					}
					if(!staffid.equals("null") )
					{
						SubjectList=prinicipal.loadsubjectusingstaffid(staffid,stdid,sectionpublishid); 
					}
					if(SubjectList != null && SubjectList.size()>0)
					{
						
						String tempsectionid="";
						for(int g=0;g<SubjectList.size();g++){
						hashmap		= (HashMap)SubjectList.get(g);
						String subjectname=hashmap.get("subjectname")+"";
						String subjectscheduleid=hashmap.get("subjectscheduleid")+"";
						String standardid=hashmap.get("standardid")+"";
						String subjectid=hashmap.get("subjectid")+"";
						String subjectcode=hashmap.get("subjectcode")+"";
						if(subjectcode.equals(""))
						subjectcode="-";
						String sectionid=hashmap.get("sectionid")+"";
						if(!uname.equals(tempuname))
						{
							cellSubj = new PdfPCell(new Paragraph(gg+""));
							cellSubj.setHorizontalAlignment(Element.ALIGN_LEFT);
							tableSubj.addCell(cellSubj);
							cellSubj = new PdfPCell(new Paragraph(uname));
							cellSubj.setHorizontalAlignment(Element.ALIGN_LEFT);
							tableSubj.addCell(cellSubj);
							cellSubj = new PdfPCell(new Paragraph(subjectname));
							cellSubj.setHorizontalAlignment(Element.ALIGN_LEFT);
							tableSubj.addCell(cellSubj);
							cellSubj = new PdfPCell(new Paragraph(subjectcode));
							cellSubj.setHorizontalAlignment(Element.ALIGN_LEFT);
							tableSubj.addCell(cellSubj);
							tempuname=uname;
						gg++;
						}
						else
						{
							cellSubj = new PdfPCell(new Paragraph(""));
							cellSubj.setHorizontalAlignment(Element.ALIGN_LEFT);
							cellSubj.setColspan(2);
							tableSubj.addCell(cellSubj);
							cellSubj = new PdfPCell(new Paragraph(subjectname));
							cellSubj.setHorizontalAlignment(Element.ALIGN_LEFT);
							tableSubj.addCell(cellSubj);
							cellSubj = new PdfPCell(new Paragraph(subjectcode));
							cellSubj.setHorizontalAlignment(Element.ALIGN_LEFT);
							tableSubj.addCell(cellSubj);
						}
					}
					}
				else
				{
					cellSubj = new PdfPCell(new Paragraph("Data Not Found", new Font(Font.TIMES_ROMAN, 11,Font.BOLD,Color.red)));
					cellSubj.setBackgroundColor(new Color(255,229,255));
					cellSubj.setColspan(4);
					cellSubj.setHorizontalAlignment(Element.ALIGN_CENTER);
					tableSubj.addCell(cellSubj);
				}
				}			

				}
			else
			{
				cellSubj = new PdfPCell(new Paragraph("Staff Not Allotted", new Font(Font.TIMES_ROMAN, 11,Font.BOLD,Color.black)));
				cellSubj.setColspan(4);
				cellSubj.setHorizontalAlignment(Element.ALIGN_CENTER);
				tableSubj.addCell(cellSubj);
			}

		tableSubj.getDefaultCell().setBackgroundColor(new Color(96,200,242));
		
		document.add(tableSubj);		

		}

		}
/************************ATTENDANCE********************************/

	    Twogapnext1=new Paragraph("\n");
	    //document.add(Twogapnext);
	    //document.add(Chunk.NEXTPAGE);
	    document.newPage();
	    
		 Twogap=new Paragraph("\n\n");
		 document.add(Twogap);
		
		ArrayList standList=new ArrayList();
		 studentList=new ArrayList();

			PdfPTable tableAtten = new PdfPTable(7);
		if(sessionid != null && boardid!= null )
		{
			 //standList=attencequery.loadstandard(boardid,sessionid,instituteid);
			standList=applicationQuery.loadstdwise(boardid,sessionid,instituteid,standardscheduleid);
			
		}
		if(standList!=null && standList.size()>0)
		{
			ArrayList tempList=new ArrayList();

			for(int i=0;i<standList.size();i++)
			{
				HashMap hashmap2 =(HashMap)standList.get(i);
				String Standardname=hashmap2.get("standardname")+"";
				 //standardscheduleid=hashmap2.get("standardscheduleid")+"";
				String groupname=hashmap2.get("groupname")+"";
				if(!groupname.equals("null"))
					Standardname=Standardname+" -"+groupname;
				if(!tempList.contains(standardscheduleid))
				{
					document.add(Twogapnext);
		
					
					/*p1=new Paragraph("Standard : "+Standardname,new Font(Font.TIMES_ROMAN, 12, Font.BOLD,Color.red));
					p1.setAlignment(Element.ALIGN_LEFT);
					document.add(p1);*/
					tempList.add(standardscheduleid);
					//document.add(Twogapnext);

				}
				

				int headerwidthsAtten[] = { 7, 20, 10, 15, 15, 15, 15}; // percentage
				tableAtten.setWidths(headerwidthsAtten);

				PdfPCell cellAtten;
				cellAtten = new PdfPCell(new Paragraph("Attendance Details", new Font(Font.TIMES_ROMAN, 11,Font.BOLD,Color.black)));		
				cellAtten.setBackgroundColor(new Color(255,115,255));
				//cell1.setBackgroundColor(new Color(14,138,188));
				cellAtten.setColspan(8);
				tableAtten.addCell(cellAtten);				
				
				tableAtten.setWidthPercentage(100); // percentage
				tableAtten.getDefaultCell().setPadding(3);
				tableAtten.getDefaultCell().setBorderWidth(1);
				tableAtten.getDefaultCell().setHorizontalAlignment(Element.ALIGN_LEFT);
				tableAtten.getDefaultCell().setBackgroundColor(new Color(255,172,255));
				tableAtten.addCell(new Paragraph("Sl",new Font(Font.TIMES_ROMAN, 11,Font.BOLD,Color.black)));
				tableAtten.addCell(new Paragraph("Student Name",new Font(Font.TIMES_ROMAN, 11,Font.BOLD,Color.black)));
				tableAtten.addCell(new Paragraph("Roll No",new Font(Font.TIMES_ROMAN, 11,Font.BOLD,Color.black)));
				tableAtten.addCell(new Paragraph("No Of Working Days",new Font(Font.TIMES_ROMAN, 9,Font.BOLD,Color.black)));
				tableAtten.addCell(new Paragraph("No Of Present Days",new Font(Font.TIMES_ROMAN, 9,Font.BOLD,Color.black)));
				tableAtten.addCell(new Paragraph("No Of Absent Days",new Font(Font.TIMES_ROMAN, 9,Font.BOLD,Color.black)));
				tableAtten.addCell(new Paragraph("No Of On Duty Days",new Font(Font.TIMES_ROMAN, 9,Font.BOLD,Color.black)));
				tableAtten.getDefaultCell().setBackgroundColor(Color.WHITE);


		ArrayList sectionList=new ArrayList();
		//System.out.print("standardscheduleid-->"+standardscheduleid);
		if(!standardscheduleid.equals("null") && instituteid!= null )
		{
			sectionList=	attencequery.loadsection(standardscheduleid,instituteid);
		}
		//System.out.print("sectionList-->"+sectionList);
		if(sectionList!=null && sectionList.size()>0)
		{
			ArrayList tempList1=new ArrayList();

			for(int j=0;j<sectionList.size();j++)
			{			
				HashMap hashmap3 =(HashMap)sectionList.get(j);
				String sectionscheduleid=hashmap3.get("sectionscheduleid")+"";
				String sectionname=hashmap3.get("sectionname")+"";
				if(!tempList1.contains(sectionscheduleid))
				{
					cellAtten = new PdfPCell(new Paragraph("Section :"+sectionname, new Font(Font.TIMES_ROMAN, 11,Font.BOLD,Color.black)));
					cellAtten.setBackgroundColor(new Color(255,229,255));
					cellAtten.setColspan(7);
					tableAtten.addCell(cellAtten);
					tempList1.add(sectionscheduleid);
				}
				if(!sessionid.equals("null") && !boardid.equals("null") && !standardscheduleid.equals("null") && !sectionscheduleid.equals("null")) {
					studentList			= attencequery.loadstudentwithstatus(standardscheduleid,sessionid,sectionscheduleid,instituteid,"A','D','C");
				}
				//System.out.print("studentList-->"+studentList.size());
				if(studentList != null && studentList.size()>0)
				{
				for(int y=0,sl=1;y<studentList.size();y++)
						{
						HashMap hashmap					= (HashMap)studentList.get(y);
						String Studname			= (String)hashmap.get("applicantname");
						String rollno			= (String)hashmap.get("rollno");
						String studallocationid	= (String)hashmap.get("studentallocationid");
						cellAtten = new PdfPCell(new Paragraph(sl+""));
						cellAtten.setHorizontalAlignment(Element.ALIGN_CENTER);
						tableAtten.addCell(cellAtten);
						cellAtten = new PdfPCell(new Paragraph(Studname,new Font(Font.TIMES_ROMAN, 10,Font.BOLD,Color.black)));
						cellAtten.setHorizontalAlignment(Element.ALIGN_LEFT);
						tableAtten.addCell(cellAtten);
						cellAtten = new PdfPCell(new Paragraph(rollno));
						cellAtten.setHorizontalAlignment(Element.ALIGN_LEFT);
						tableAtten.addCell(cellAtten);
						
						ArrayList DetailList=new ArrayList();
						DetailList=attencequery.loadNoofworkingdayabsentod(studallocationid,sessionid,instituteid,standardscheduleid,"A','D','C");
							if(DetailList!=null && DetailList.size()>0)
							{
								HashMap atten=(HashMap)DetailList.get(0);
								cellAtten = new PdfPCell(new Paragraph(atten.get("totalworkingdays")+""));
								cellAtten.setHorizontalAlignment(Element.ALIGN_LEFT);
								tableAtten.addCell(cellAtten);
								cellAtten = new PdfPCell(new Paragraph(atten.get("noofpreset")+""));
								cellAtten.setHorizontalAlignment(Element.ALIGN_LEFT);
								tableAtten.addCell(cellAtten);
								cellAtten = new PdfPCell(new Paragraph(atten.get("noofabsent")+""));
								cellAtten.setHorizontalAlignment(Element.ALIGN_LEFT);
								tableAtten.addCell(cellAtten);
								cellAtten = new PdfPCell(new Paragraph(atten.get("noofod")+""));
								cellAtten.setHorizontalAlignment(Element.ALIGN_LEFT);
								tableAtten.addCell(cellAtten);
								sl++;
							}
						}
					}
					else
					{
						cellAtten = new PdfPCell(new Paragraph("Data Not Found", new Font(Font.TIMES_ROMAN, 11,Font.BOLD,Color.red)));
						cellAtten.setHorizontalAlignment(Element.ALIGN_CENTER);
						cellAtten.setColspan(7);
						tableAtten.addCell(cellAtten);
					}
			}
		}
			}
			tableAtten.getDefaultCell().setBackgroundColor(new Color(96,200,242));

			document.add(tableAtten);			
		}

/**************************SCHOOL CALENDAR***************************************/		
		SchoolCalenderBean calendderbean;
		 calendderbean	= new SchoolCalenderBean();
		 calendderbean.setSessionid(sessionid);
		 calendderbean.setboardid(boardid);
		 calendderbean.setinstituteid(instituteid);
		 SchoolCalenderEntry query_object=new SchoolCalenderEntry();
			ArrayList eventList = query_object.eventListRK(calendderbean);
			int pdffile=0;
		int inc =1;
		String temp_total  = "";
		String status_ori = null;

		
	    Twogapnext1=new Paragraph("\n");
	    //document.add(Twogapnext);
	    //document.add(Chunk.NEXTPAGE);
	    document.newPage();
		
	    Twogap=new Paragraph("\n\n");
	    document.add(Twogap);
	    
		PdfPTable tableCal = new PdfPTable(4);
		PdfPCell cellCal;
		 
		int headerwidthsCal[] = { 8, 15, 25, 12}; 
		tableCal.setWidths(headerwidthsCal);
		tableCal.setWidthPercentage(100); 
		tableCal.getDefaultCell().setPadding(2);
		tableCal.getDefaultCell().setBorderWidth(1); 
		tableCal.getDefaultCell().setHorizontalAlignment(Element.ALIGN_LEFT);
		
		cellCal = new PdfPCell(new Paragraph("School Calendar Event", new Font(Font.TIMES_ROMAN, 11,Font.BOLD,Color.black)));		
		cellCal.setBackgroundColor(new Color(255,115,255));
		//cell1.setBackgroundColor(new Color(14,138,188));
		cellCal.setColspan(4);
		tableCal.addCell(cellCal);
		
		if(eventList!=null &&eventList.size() > 0 )
		{
			
			tableCal.getDefaultCell().setBackgroundColor(new Color(255,172,255));
			tableCal.addCell(new Paragraph("Sl",new Font(Font.TIMES_ROMAN, 11,Font.BOLD,Color.black)));
			tableCal.addCell(new Paragraph("Event Date",new Font(Font.TIMES_ROMAN, 11,Font.BOLD,Color.black)));
			tableCal.addCell(new Paragraph("Event Name",new Font(Font.TIMES_ROMAN, 11,Font.BOLD,Color.black)));
			tableCal.addCell(new Paragraph("Holiday Status",new Font(Font.TIMES_ROMAN, 11,Font.BOLD,Color.black)));
			//tableCal.getDefaultCell().setBackgroundColor(Color.WHITE);

			
		for(int s=0,s1=1;s<eventList.size();s++,s1++)
		{
				HashMap map=(HashMap)eventList.get(s);
				String calendarid=(String)map.get("schoolcalendarid");
				String eventdescription=(String)map.get("eventdescription");
				String eventdate=(String)map.get("newdates");
				String newdates1=(String)map.get("newdates1");

				String status=(String)map.get("calendarstatus");
				String sessionstatus=(String)map.get("sessionstatus");
				String holidaystatus=(String)map.get("holidaystatus");
				


				cellCal = new PdfPCell(new Paragraph(s1+""));   
				 tableCal.addCell(cellCal);
				 cellCal = new PdfPCell(new Paragraph(eventdate));
				 tableCal.addCell(cellCal);
				 cellCal = new PdfPCell(new Paragraph(eventdescription));
		 		tableCal.addCell(cellCal);
		 		//cell = new PdfPCell(new Paragraph(newdates1));
		 		//tableCal.addCell(cell);
		 		if(holidaystatus.equals("Y"))
		 		{
		 			cellCal = new PdfPCell(new Paragraph("Holiday"));
		 			tableCal.addCell(cellCal);
		 		}
		 		else
		 		{
		 			cellCal = new PdfPCell(new Paragraph("-"));
		 			tableCal.addCell(cellCal);
		 		}
			}
		         pdffile=1;  
		
		}
		else
		{
			cellCal = new PdfPCell(new Paragraph("Data Not Found", new Font(Font.TIMES_ROMAN, 11,Font.BOLD,Color.black)));
			cellCal.setBackgroundColor(new Color(255,255,255));
			cellCal.setColspan(4);
			cellCal.setHorizontalAlignment(Element.ALIGN_CENTER);
				tableCal.addCell(cellCal);
				 pdffile=0;  
		}
		document.add(tableCal);		
		
document.close();
rows = 1;
}

catch (DocumentException de)
{
//System.err.println(de.getMessage());
}
StdwiseReportPDF pagenooo=new StdwiseReportPDF();
//pagenooo.pagenumber(tempPath,fileName,document);
onEverypage(tempPath,fileName,document,instituteid,storagepath);

}

catch(Exception sel)
{
//System.out.println("GeneralException" + sel.getMessage());
}
return rows;
}


public void onEverypage(String s,String s1,Document document,String insid,String storagepath)
{
	try {
              Rectangle page = document.getPageSize();
		      PdfReader reader = new PdfReader(s);

		      int n = reader.getNumberOfPages();
		      PdfStamper stamp = new PdfStamper(reader, new FileOutputStream(s1));

		      int i = 0;

		      PdfContentByte over;
		      BaseFont bf = BaseFont.createFont(BaseFont.HELVETICA, BaseFont.WINANSI, BaseFont.EMBEDDED);

		      while (i < n) {
		        i++;
		        over = stamp.getOverContent(i);
		        /*over.beginText();
	        over.setFontAndSize(bf, 10);
	        over.setTextMatrix(30, (page.height()-120));
	        over.showText("Student List");
	        over.setFontAndSize(bf, 2f);
	        over.endText();*/
	        try {
	        	ArrayList insdetails=insquery.getInstituteDetails(insid);
	         	if(insdetails!=null && insdetails.size()>0)
	        	{
	        		HashMap map=(HashMap)insdetails.get(0);
		        	String inslogo=map.get("institutelogo")+"";
		        	String insname=map.get("institutename")+"";
		        	String contactaddress=map.get("contactaddress")+"";
		        	String country=map.get("country")+"";
		        	String landlinenumber="Phone :" + map.get("landlinenumber")+"";
		        	String state=map.get("state")+"";
		        	String zip=  map.get("zip")+"";
		        	String fax="Fax:" + map.get("fax")+"";

		        	String emailid="Email:"+map.get("emailid")+"";
		        	String url=map.get("url")+"";
		        	
		        	if(url.equals("-") || url.equals("") || url.trim()=="")
		        		url="";
		        	else
		        		url="Website :"+url;
		        	if(zip.equals("-") || zip.equals("") || zip.trim()=="")
		        		zip="";
		        	else
		        		zip="Zipcode :"+zip;
		        	
		        	Image jpg = Image.getInstance(storagepath+inslogo);
		        	jpg.scaleAbsolute(100, 100);
		        	jpg.setAbsolutePosition(10,(page.height()-100));
		        	over.addImage(jpg);
		        	over.beginText();
   			        over.setFontAndSize(bf, 12);
   			        over.setTextMatrix(120, (page.height()-50));
   			        over.showText(insname);
   			        over.endText();
   			        over.beginText();
   			        over.setFontAndSize(bf, 9);    
   			        over.setTextMatrix((page.width()/2)+120, (page.height()-10));  
   			        over.showText(contactaddress);
   			        over.endText();
   			        over.beginText();
   			        over.setFontAndSize(bf, 9);
   			        over.setTextMatrix((page.width()/2)+120, (page.height()-20));
   			        over.showText(state);
   			        over.endText(); 
   			        over.beginText();
   			        over.setFontAndSize(bf, 9);
   			        over.setTextMatrix((page.width()/2)+120, (page.height()-30));
   			        over.showText(country);
   			        over.endText(); 
   			        over.beginText();
   			        over.setFontAndSize(bf, 9);
   			        over.setTextMatrix((page.width()/2)+120, (page.height()-40));
   			        over.showText(zip);
   			        over.endText(); 
   			        over.beginText();
   			        over.setFontAndSize(bf, 9);
   			        over.setTextMatrix((page.width()/2)+120, (page.height()-50));
   			        over.showText(landlinenumber);
   			        over.endText();
   			        over.beginText();
			        over.setFontAndSize(bf, 9);
			        over.setTextMatrix((page.width()/2)+120, (page.height()-60));
			        over.showText(fax);
			        over.endText();
   			        over.beginText();
   			        over.setFontAndSize(bf, 9);
   			        over.setTextMatrix((page.width()/2)+120, (page.height()-70));
   			        over.showText(emailid);
   			        over.endText();
   			        over.beginText();
   			        over.setFontAndSize(bf, 9);
   			        over.setTextMatrix((page.width()/2)+120, (page.height()-80));
   			        over.showText(url);
   			        over.endText();   
	        	}
	        	}
	        	catch(Exception e)
	        	{
	        		e.printStackTrace();
	        	}
		        over.beginText();
		        over.setFontAndSize(bf, 10);
		        over.setTextMatrix((page.width()-20)/2, 20);
		        over.showText("- " + i+" -");
		        over.endText();
		        over.beginText();
	        over.setFontAndSize(bf, 9);
	        over.setTextMatrix((page.width()-100), 20);
	        over.showText(datobj.showTime("calendar")+" "+datobj.showTime("Time"));
	        over.endText();
	        for (int j=0;j<(page.width());j++)
	        {
	        over.beginText();
	        over.setFontAndSize(bf, 15);
	        over.setTextMatrix(j, (page.height()-108));
	        over.showText("-");
	        over.endText();
	        }
	        for (int j=0;j<(page.width());j++)
	        {
	        over.beginText();
	        over.setFontAndSize(bf, 15);
	        over.setTextMatrix(j, 30);
	        over.showText("-");
	        over.endText();
	        }
		      }
		      stamp.close();
		    }

		    catch (Exception de)
		    {
		      de.printStackTrace();
		    }
		    
	}

public void pagenumber(String s,String s1,Document document) {
   try {
   	              Rectangle page = document.getPageSize();
   			      PdfReader reader = new PdfReader(s);

   			      int n = reader.getNumberOfPages();
   			      PdfStamper stamp = new PdfStamper(reader, new FileOutputStream(s1));

   			      int i = 0;

   			      PdfContentByte over;
   			      BaseFont bf = BaseFont.createFont(BaseFont.HELVETICA, BaseFont.WINANSI, BaseFont.EMBEDDED);

   			      while (i < n) {
   			        i++;

   			        over = stamp.getOverContent(i);
   			        over.beginText();
   			        over.setFontAndSize(bf, 10);
   			        over.setTextMatrix((page.width()-20)/2, 20);
   			        over.showText("- " + i+" -");
   			        over.endText();
   			      }
   			      stamp.close();
   			    }

   			    catch (Exception de)
   			    {
   			      de.printStackTrace();
   			    }
}



}


package com.iGrandee.Content;

import java.util.ArrayList;
import java.util.HashMap;
import java.sql.PreparedStatement;
import java.sql.Connection;
import java.sql.SQLException;

import org.apache.log4j.Logger;

import com.iGrandee.Common.CommonDataAccess;
import com.iGrandee.Common.DateTime;

import com.iGrandee.Common.ConnectionManager;

public class ContentViewQry {
	static Logger log = Logger.getLogger(ContentQurey.class);

	public ContentViewQry() 
	{
		common_data_object = new CommonDataAccess();
		 datetime =new DateTime();
		 select_query="";
	}
	 

	 

	public ArrayList getLearningSubjectDetail(String s)
	{
		ArrayList subjectList = new ArrayList();
		try
		{
			select_query = "select a.subjectid, a.subjectname, a.subjectcode, a.credithours from subject a, subjectschedule b where b.subjectscheduleid='"+s+"' and a.subjectstatus='A' and b.status='A' and a.subjectid=b.subjectid;";
		   subjectList = common_data_object.getListMap(select_query);
		}
		catch(Exception e)
		{
			System.out.println("Exception in getSubjectDetails ---->"+e);
		}
		return subjectList;
	}
	
	public ArrayList getStudentSelfAssesment(String subjectscheduleid)
	{
		ArrayList subjectList = null;
		try
		{
			select_query 	= "select c.qsid,c.examname,sum(noqn) as totalquestion from standardschedule a,subjectschedule b,questionsheetmaster c, questionsheetdetail d where b.subjectscheduleid='"+subjectscheduleid+"' and b.status='A' and a.standardscheduleid=b.standardscheduleid and b.subjectid=c.subjectid and c.questionsheetstatus='A' and c.qsid=d.qsid and c.templatetype='Self Assessment' and d.qsdid in (select qsdid from questions where qsdid=d.qsdid) group by c.qsid";
		   subjectList 		= common_data_object.getListMap(select_query);
		   //and a.sessionid=c.sessionid and templatetype='Self Assessment' 
		}
		catch(Exception e)
		{
			System.out.println("Exception in getSubjectDetails ---->"+e);
		}
		return subjectList;
	}
	
	public ArrayList loadGeneratedQuestions(String qsid)
	{
		ArrayList academicList = null;
		try
		{
			select_query  	= "select a.examquestionid,question, A, B, C, D, E, F, G, a.correctans,countans, a.image, a.mark, timelimit,a.type from examquestion a,questions b,questionsheetdetail c where c.qsid='"+qsid+"' and c.qsdid=b.qsdid and b.examquestionid=a.examquestionid";  
			academicList 	= common_data_object.getListMap(select_query);

		}
		catch(Exception exception) { 

		}
		return academicList;
	}	

public String getSubjectsStaff(String subjectid) {
	String staffName = "";
	 try {
		 String nameQry="select concat(a.firstname,' ',a.lastname) as staffname from personmaster a where a.personid in (select b.staffid from staffmaster b where b.staffid in (select a.staffid from subjectallotment a where a.subjectscheduleid='"+subjectid+"' and a.status='A'))";
		staffName = common_data_object.getString(nameQry);
	 }
	 catch(Exception ex) {
		 ex.printStackTrace();
		//System.out.println("Exception in V-Learn:QueryBean getSubjectStaff()  :"+ex);
	 }
	 return staffName;
 }


public ArrayList getAllocatedLessons(String subSchedId) {
	ArrayList lessList = null;
	try {
		String lessQry = "select lessonid, lessonname from lesson where lessonid in (select lessonid from lessonschedule where subjectscheduleid='"+subSchedId+"' and status='A')";
		lessList = common_data_object.getListMap(lessQry);
		//System.out.println("lessQry>>>>>"+lessQry);
	}
	catch(Exception ex) {
		System.out.println("Exception in V-Learn:QueryBean getAllocatedLessons() :"+ex);
	}
	return lessList;
}
CommonDataAccess common_data_object;
DateTime datetime;
String select_query;

}
	 
	 
package com.iGrandee.ExamManagement.Servlets;
import com.iGrandee.Common.CommonDataAccess;
import com.iGrandee.Common.ConnectionManager;

public class ResultDAO {


	public StringBuffer getExamName(String userid, String qsid)
	{

		String sqlQuery = "";
		StringBuffer buffer= null;
		try
		{
	        ldac   = new CommonDataAccess();


			sqlQuery  = "select distinct e.lessonname from question_sheet_master_tb a join  question_sheet_detail_tb b on a.qsid=b.qsid and a.qsid='"+qsid+"' join question_tb c on b.qsdid=c.qsdid join questable d on c.qid=d.qid join institutelesson_tb e  on d.lessonid=e.lessonid left outer join online_answers_tb f on f.qid = c.qid and f.qsid = a.qsid and f.userid='"+userid+"' group by d.qid order by e.lessonname,c.sno asc;";

			buffer      = ldac.getListXML(sqlQuery,"time");

		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		finally
		{
			ldac=null;
		}
		return buffer;
	}
	public StringBuffer loadAnswerDetails(String studentid,String qsid)
	{
		StringBuffer buffer= null;
		try
		{
        	ldac   			= new CommonDataAccess();
			String qry 		= "select d.examquestionid,d.question,d.correctAns,d.mark,f.answer from questionsheetmaster a join  questionsheetdetail b on a.qsid=b.qsid and a.qsid='"+qsid+"' join questions c on b.qsdid=c.qsdid join examquestion d on c.examquestionid=d.examquestionid join lesson e  on d.lessonid=e.lessonid left outer join onlineanswers f on f.examquestionid = c.examquestionid and f.qsid = a.qsid and f.studentid='"+studentid+"' group by d.examquestionid order by e.lessonname,c.serialnumber asc";
			buffer 			= ldac.getListXML(qry,"result");
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		finally
		{
			ldac=null;
		}
		return buffer;
	}


    CommonDataAccess ldac;
    ConnectionManager conmgr;
}

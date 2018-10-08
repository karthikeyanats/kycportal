package com.iGrandee.ExamManagement.Servlets;

import java.sql.Connection;
import java.sql.PreparedStatement;

import com.iGrandee.Common.CommonDataAccess;
import com.iGrandee.Common.ConnectionManager;

public class ExamDAO
{
	public StringBuffer getPreviousQuestion(String qsid,String studentid)
	{

		StringBuffer buffer = new StringBuffer();
		ldac   = new CommonDataAccess();
		try
		{
			String query 	= "select count(answerid) as count from onlineanswers where qsid='"+qsid+"' and studentid='"+studentid+"'";
			buffer 			= ldac.getListXML(query,"countquestion");
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		return buffer;
	}
	
	
	public StringBuffer getQuestionBank(String qsid)
	{
		String sqlQuery 	= "";
		StringBuffer buffer	= null;
		try
		{
	        ldac   		= new CommonDataAccess();
			sqlQuery  	= "select d.examquestionid,d.question,d.A,d.B,d.C,d.D,d.E,d.F,d.G,d.correctAns,d.image,d.countans, d.timelimit,d.mark, date_format(current_timestamp(),'%d-%b-%Y %H:%i:%S') as currenttime from questionsheetdetail b join questions c on b.qsdid = c.qsdid and b.qsid='"+qsid+"' join examquestion d on c.examquestionid=d.examquestionid";
			buffer      = ldac.getListXML(sqlQuery,"quesion_tb");
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
	
	public StringBuffer getExamInstructionList(String qsid)
	{
		StringBuffer buffer		= null;
		ldac   = new CommonDataAccess();
		try
		{
			String qry		= "select a.examname,concat(b.subjectname,' - ',b.subjectcode) as subjectname, date_format(a.createddate,'%d-%b-%Y') as createddate, a.instruction,current_timestamp,timediff(d.examtimeout,d.examtimein) as duration, timediff(ADDTIME(concat(curDate(),' 00:00:00'),d.examtimeout), current_timestamp) as remaining,case when ADDTIME(concat(curDate(),' 00:00:00'), d.examtimeout)> current_timestamp then 'A' else 'E' end as status from questionsheetmaster a, subject b, subjectschedule c, examschedule d where a.qsid='"+qsid+"' and a.subjectscheduleid=c.subjectscheduleid and a.subjectscheduleid=d.subjectscheduleid and c.subjectid=b.subjectid";
			buffer 			= ldac.getListXML(qry,"examdetails");
		}
		catch(Exception exception)
		{
			exception.printStackTrace();
		}
		return buffer;
	}
	
	public StringBuffer getTotalQuestionCount(String qsid,String studentid)
	{
		String query 		= "";
		StringBuffer buffer = new StringBuffer();
		ldac   				= new CommonDataAccess();
		try
		{
			query	 	= "select count(c.examquestionid) as totalcount from questionsheetdetail b, questions c where b.qsid='"+qsid+"' and c.qsdid = b.qsdid and c.examquestionid not in(select examquestionid from onlineanswers where studentid='"+studentid+"' and qsid='"+qsid+"') group by b.qsid";
			buffer 		= ldac.getListXML(query,"countquestion");
		}
		catch(Exception e)
		{
		}
		return buffer;
	}
	
	public int insertAnswersUsingBatch(String qid,String qsid,String answer,String userid,String attempt)throws Exception
	{
		int return_value		= 0;
		int tempreturn[]		= null;
		Connection con        	= ConnectionManager.getKycConnection();
		PreparedStatement psmd	= null ;

		try {

			String[] answerArray	= answer.split("@");
			String[] questionArray	= qid.split("@");
			
			con.setAutoCommit(false);
			
			psmd  					= con.prepareStatement("insert into onlineanswers(studentid, qsid, examquestionid, answer,attempt) values(?,?,?,?,?)");

			if(answerArray!=null && answerArray.length!=0)
				for(int i=0;i<answerArray.length;i++)
				{
					psmd.setString(1,userid);
					psmd.setString(2,qsid);
					psmd.setString(3,questionArray[i]);
					psmd.setString(4,answerArray[i]);
					psmd.setString(5,attempt);
					psmd.addBatch();
				}

			tempreturn		=  psmd.executeBatch();
			if(tempreturn != null && tempreturn.length>0)
				for(int j=0;j<tempreturn.length;j++)
					return_value += tempreturn[j];

			con.commit();
		}
		catch(Exception e) {

			if(con !=null)
				con.rollback();
			e.printStackTrace();
		}
		finally {

			if(psmd != null)
				psmd.close();
			ConnectionManager.closeConnection(con);
		}
		return return_value;
	}


CommonDataAccess ldac;
ConnectionManager conmgr;
}

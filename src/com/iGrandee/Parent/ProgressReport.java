package com.iGrandee.Parent;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.iGrandee.Common.CommonDataAccess;
import com.iGrandee.Common.ConnectionManager;
import com.iGrandee.Common.DateTime;
import org.apache.log4j.Logger;
public class ProgressReport
{
	static Logger log = Logger.getLogger(ProgressReport.class);

	public  ProgressReport()
	{
		common_data_object = new CommonDataAccess();
		select_query= "";
	}
	
	 public ArrayList listStandardList(String studentallocationid)
	    {
	        ArrayList arraylist = new ArrayList();
	        try
	        {select_query = "select d.examname,sum(marktaken) marktaken from exammark a,examschedule b,examallotment c,examname d where a.studentallocationid='"+studentallocationid+"' and a.examscheduleid=b.examscheduleid and c.examallotmentid=b.examallotmentid and d.examnameid=c.examnameid";
	        log.info(select_query);
	        	arraylist = common_data_object.getListMap(select_query);
	        }
	        catch(Exception exception) {log.error(exception);}
	        return arraylist;
		}
	 
	 String select_query;
	 CommonDataAccess common_data_object;
}
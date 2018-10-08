package com.iGrandee.Common;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Vector;

import org.apache.log4j.Logger;


public class CommonDataAccess extends ConnectionInfo
{
	static Logger log = Logger.getLogger(CommonDataAccess.class);

    public CommonDataAccess()
    {
        state  			= null;
        pstate 			= null;
        result 			= null;
        rs 				= null;
        rsmd 			= null;
        l_return_value 	= 0L;
        i_return_value 	= 0;
        column_count 	= 0;
        row_count 		= 0;
    }

    public int insertUpdatePreparedCommon(HashMap parametermap,String query)throws SQLException
	 {
		 try
			{
				makeConnection();
				pstate = super.virtual_dbCon.prepareStatement(query);

				if(parametermap!=null && parametermap.size()>0)
				{
					for(int y=0;y<parametermap.size();y++)
					{
						pstate.setString((y+1),(String)parametermap.get(y+""));
					}
		 		}
		 		i_return_value = pstate.executeUpdate();
			 }
			 catch(SQLException sqlexception)
			 {
			 		//System.out.println("LMS -SQL Exception in com.iGrandee.Common.CommonDataAccess.insertUpdatePreparedCommon "+sqlexception.getMessage());
				 log.error("",sqlexception);
        	 }
			 finally
			 {
				if(pstate!=null)
					pstate.close();

				takeDown();
			 }
		 return i_return_value;
	 }
    public boolean validateConnection(String warmode) throws SQLException
    {
		Connection connection 	= null;
		boolean connection_flag = false;
		try
		{
			if(warmode.equals("vlearn"))
			{
				connection = checkConnection();
			}
			else if(warmode.equals("virtuald"))
			{
				connection = checkVirtualDConnection();
			}

			if(connection == null)
				connection_flag = false;
			else
				connection_flag = true;
		}
		catch(Exception sqlexception)
		{
			//System.out.println("LMS -SQL Exception in com.iGrandee.Common.CommonDataAccess.validateConnection "+sqlexception.getMessage());
			log.error("",sqlexception);
		}
	 	finally
	    {
	     	takeDown();
	    }

		return connection_flag;
	}

    public String replaceSingleChars_back(String s)
    {
        String s1 = "";
        try
        {
            if(s != null)
            {
                for(int i = 0; i < s.length(); i++)
                {
                    char c = s.charAt(i);
                    if(c == '\361')
                        s1 = s1 + "'";
                    else
                    if(c == '\360')
                        s1 = s1 + "`";
                    else
                    if(c == '\377')
                        s1 = s1 + ",";
                    else
                        s1 = s1 + c;
                }

            }
        }
        catch(Exception exception)
		{
			//System.out.println("LMS -Exception in com.iGrandee.Common.CommonDataAccess.replaceSingleChars_back "+exception.getMessage());
        	log.error("",exception);
        }
        return s1;
    }
    
    
    public ArrayList getListMap(String queryValue)throws SQLException
	{
		ArrayList branchList = new ArrayList();
		try
		{
			makeConnection();
			state 			= super.virtual_dbCon.createStatement();
			result 			= state.executeQuery(queryValue);
			rsmd			= result.getMetaData();
			column_count	= rsmd.getColumnCount();
			HashMap innerMap = null;
			while(result.next())
			{
				innerMap = new HashMap();
				for(int colcnt=1;colcnt<=column_count;colcnt++)
				{
					innerMap.put(rsmd.getColumnLabel(colcnt), result.getString(colcnt));
				}
				branchList.add(innerMap);
			}
		}
		catch(SQLException exception)
		{
			log.error("",exception);
		}
		finally
        {
			if(result!=null)
				result.close();

			if(state!=null)
				state.close();

			takeDown();
		}
		return branchList;
    }
    
    
    public Vector getVector(String s) throws SQLException
    {
        Vector vector = null;
        try
        {
            result = null;
            vector = new Vector();
            makeConnection();
            state = super.virtual_dbCon.createStatement();
            result = state.executeQuery(s);
            rsmd = result.getMetaData();
            column_count = rsmd.getColumnCount();
            HashMap hashmap;
            for(; result.next(); vector.addElement(hashmap))
            {
                hashmap = new HashMap();
                for(int i = 1; i <= column_count; i++)
                    hashmap.put(rsmd.getColumnLabel(i), result.getString(i));
            }

        }
        catch(SQLException exception)
		{
			//System.out.println("LMS -SQL Exception in com.iGrandee.Common.CommonDataAccess.getVector "+exception.getMessage());
        	log.error("",exception);
        }
        finally
        {
			if(result!=null)
				result.close();

			if(state!=null)
				state.close();

			takeDown();
		}

        return vector;
    }

    public String getString(String s) throws SQLException
    {
		String s1 = null;
        try
        {
            result = null;
            makeConnection();
            state = super.virtual_dbCon.createStatement();
            result = state.executeQuery(s);
            if(result.next())
                s1 = result.getString(1);
		}
        catch(SQLException exception)
		{
        	log.error("",exception);
        	exception.printStackTrace();
			//System.out.println("LMS -SQL Exception in com.iGrandee.Common.CommonDataAccess.getString "+exception.getMessage());
		}
        finally
        {
			if(result!=null)
				result.close();

			if(state!=null)
				state.close();

			takeDown();
		}
        return s1;
    }
    public String getRecordAsString(String s)throws SQLException
    {
	    String s1 = "";
        try
        {
            result = null;
            makeConnection();
            state = super.virtual_dbCon.createStatement();
            result = state.executeQuery(s);
            rsmd = result.getMetaData();
            column_count = rsmd.getColumnCount();
            while(result.next())
            {
                for(int i = 1; i <= column_count; i++)
                {
                    String s3 = result.getString(i);
                    if(s3 == null || s3.equals("null") || s3.equals("Null") || s3.equals("") || s3.equals("NULL"))
                        s3 = "-";
                    s1 = s1 + s3 + "\365";
                }

                if(s1.length() != 0)
                    s1 = s1.substring(0, s1.length() - 1);
                s1 = s1 + "\364";
            }
            if(s1.length() != 0)
                s1 = s1.substring(0, s1.length() - 1);
        }
        catch(SQLException exception)
		{
        	log.error("",exception);
        	//System.out.println("LMS -SQL Exception in com.iGrandee.Common.CommonDataAccess.getRecordAsString "+exception.getMessage());
		}
        finally
        {
			if(result!=null)
				result.close();

			if(state!=null)
				state.close();

			takeDown();
		}
        return s1;
    }
    public boolean checkDuplicate(String tablename,String columnname,String fieldname)
	{
		boolean return_flag = false;
		String return_string = null;
		try
		{
			String select_query = "select "+columnname+" from "+tablename+" where "+columnname+"='"+fieldname+"'  ";
			return_string = getString(select_query);

			if(return_string ==null || return_string.equalsIgnoreCase("null") || return_string.equals("")) {
				return_flag = false;
			}
			else {
				return_flag = true;
			}

		}
		catch(Exception e)
		{
			
			log.error("",e);
			//e.printStackTrace();
		}
		return return_flag;
	}
    
    /*
	  * This method is accessed from kycportal/jsp/masterentries/role/checkDuplicate.jsp
	  * This method is accessed from kycportal/jsp/masterentries/medium/checkDuplicate.jsp
	  * This method is accessed from kycportal/jsp/masterentries/group/checkDuplicate.jsp
	  * This method is accessed from kycportal/jsp/masterentries/section/checkDuplicate.jsp
      * This method is accessed from kycportal/jsp/masterentries/SubjectType/checkDuplicate.jsp
      * This method is accessed from kycportal/jsp/masterentries/AcademicSession/checkDuplicate.jsp
      * This method is accessed from kycportal/jsp/masterentries/Fees/checkDuplicate.jsp
      * @param  tablename,columnname,fieldname,status,instituteid  that can be used to check duplicate names from corresponding table fields
        @return  boolean by which result can be printed on the screen
	  * for check duplicate names      - prasanth
	 */
    public boolean checkDuplicatewithstatus(String tablename,String columnname,String fieldname,String status,String instituteid)
	{
		boolean return_flag = false;
		String return_string = null;
		try
		{
			String select_query = "select "+columnname+" from "+tablename+" where "+columnname+"='"+fieldname+"' and instituteid='"+instituteid+"' and "+status+" <> 'X' ";
			return_string = getString(select_query);

			if(return_string ==null || return_string.equalsIgnoreCase("null") || return_string.equals("")) {
				return_flag = false;
			}
			else {
				return_flag = true;
			}

		}
		catch(Exception e)
		{
			//e.printStackTrace();
			log.error("",e);
		}
		return return_flag;
	}
  
    public long maxId(String s)
    throws SQLException
{
	try
    {
        l_return_value = 0L;
        result = null;
        makeConnection();
        state = super.virtual_dbCon.createStatement();
        result = state.executeQuery(s);
        if(result.next())
            l_return_value = result.getLong(1);
    }
    catch(SQLException exception)
    {
		//System.out.println("LMS -SQL Exception in com.iGrandee.Common.CommonDataAccess.maxId "+exception.getMessage());
    	log.error("",exception);
    }
    finally
    {
		if(result!=null)
			result.close();

		if(state!=null)
			state.close();

		takeDown();
     }
    return l_return_value;
}

    public long fmaxId(String s) throws SQLException
    {

        try
        {
            l_return_value = 0L;
            result = null;
            makeConnection();
            state = super.virtual_dbCon.createStatement();
            result = state.executeQuery(s);
            if(result.next())
                l_return_value = result.getLong(1);
            l_return_value++;
        }
        catch(SQLException e)
        {
			//System.out.println("LMS -SQL Exception in com.iGrandee.Common.CommonDataAccess.fmaxId "+e.getMessage());
        	log.error("",e);
        }
        finally
        {
			if(result!=null)
				result.close();

			if(state!=null)
				state.close();

			takeDown();
		}
		return l_return_value;
    }

    public long fmaxIdVirtualD(String s)throws SQLException
    {
		l_return_value = 0L;
        result = null;
        try
        {
            makeVirtualConnection();
            state = super.vd_db_connection.createStatement();
            result = state.executeQuery(s);
            if(result.next())
                l_return_value = result.getLong(1);
            l_return_value++;

        }
        catch(SQLException exception)
		{
			//System.out.println("LMS -SQL Exception in com.iGrandee.Common.CommonDataAccess.fmaxIdVirtualD "+exception.getMessage());
        	log.error("",exception);
        }
		finally
		{
			if(result!=null)
				result.close();

			if(state!=null)
				state.close();

			takeDown();
		}
        return l_return_value;
    }

    public int insertUpdateDeleteRecord(String s)throws SQLException
    {
		try
        {
            result = null;
            makeConnection();
            state = super.virtual_dbCon.createStatement();
            i_return_value = state.executeUpdate(s);
        }
        catch(SQLException exception)
		{
			//System.out.println("LMS -SQL Exception in com.iGrandee.Common.CommonDataAccess.insertUpdateDeleteRecord "+exception.getMessage());
        	log.error("",exception);
        }
		finally
		{
			if(state!=null)
				state.close();

			takeDown();
		}
        return i_return_value;
    }

    public String getRecordsAsString(String s) throws SQLException
    {
	    String s1 = "";
        try
        {
            result = null;
            makeConnection();
            state = super.virtual_dbCon.createStatement();
            result = state.executeQuery(s);
            rsmd = result.getMetaData();
            column_count = rsmd.getColumnCount();
            while(result.next())
            {
                for(int i = 1; i <= column_count; i++)
                    s1 = s1 + result.getString(i) + "~";

                if(s1.length() != 0)
                    s1 = s1.substring(0, s1.length() - 1);
                s1 = s1 + ",";
            }
            if(s1.length() != 0)
                s1 = s1.substring(0, s1.length() - 1);
        }
        catch(SQLException exception)
		{
			//System.out.println("LMS -SQL Exception in com.iGrandee.Common.CommonDataAccess.getRecordsAsString "+exception.getMessage());
        	log.error("",exception);
		}
        finally
        {
			if(result!=null)
				result.close();

			if(state!=null)
				state.close();

			takeDown();
		}
        return s1;
    }

    public ArrayList getList(String s) throws SQLException
	 {

       ArrayList arraylist 	= new ArrayList();
       Statement statement		= null;
       ResultSet resultset		= null;
       ResultSetMetaData resultsetmetadata;
       ArrayList arraylist1 	= null;
       int i = 0;
       try
		{
			makeConnection();
			statement = super.virtual_dbCon.createStatement();
			resultset = statement.executeQuery(s);
			resultsetmetadata = resultset.getMetaData();
			i = resultsetmetadata.getColumnCount();
			for(; resultset.next(); arraylist.add(arraylist1))
			{
				arraylist1 = new ArrayList();
				for(int j = 1; j <= i; j++)
					arraylist1.add(resultset.getString(j));
			}

		}
       catch(SQLException exception)
		{
			//System.out.println("LMS -SQL Exception in com.iGrandee.Common.CommonDataAccess.getList "+exception.getMessage());
    	   log.error("",exception);
		}
		finally
       {
			if(resultset!=null)
				resultset.close();

			if(statement!=null)
				statement.close();

			takeDown();
       }
       return arraylist;
   }
    public String replaceSingleChars_new(String s)
    {
        String s1 = "";
        try
        {
            char ac[] = {
                'a'
            };
            int i = 0;

            if(s != null)
                for(; i < s.length(); i++)
                {
                    ac[0] = s.charAt(i);
                    String s2 = new String(ac);
                    if(s2.equals("'"))
                        s1 = s1 + "\361";
                    else
                    if(s2.equals("`"))
                        s1 = s1 + "\360";
                    else
                        s1 = s1 + s2;
                }

        }
        catch(Exception exception)
        {
			//System.out.println("LMS -Exception in com.iGrandee.Common.CommonDataAccess.replaceSingleChars_new "+exception.getMessage());
        	log.error("",exception);
        }
        return s1;
    }
    public int insertUpdateDeleteVirtualRecord(String s) throws SQLException
    {
        try
        {
            makeVirtualConnection();
            state = super.vd_db_connection.createStatement();
            i_return_value = state.executeUpdate(s);
        }
        catch(SQLException sqlexception)
        {
			//System.out.println("LMS -SQL Exception in com.iGrandee.Common.CommonDataAccess.insertUpdateDeleteVirtualRecord "+sqlexception.getMessage());
        	log.error("",sqlexception);
		}
		finally
		{
			if(state!=null)
				state.close();

			takeVirtualDown();
		}

        return i_return_value;
    }

    public boolean checkColumnData(String s) throws SQLException
    {
	    boolean flag = false;
        try
        {
            result = null;
            makeConnection();
            state = super.virtual_dbCon.createStatement();
            result = state.executeQuery(s);
            if(result.next())
                flag = true;
            else
                flag = false;
        }
        catch(SQLException exception)
		{
			//System.out.println("LMS -SQL Exception in com.iGrandee.Common.CommonDataAccess.checkColumnData "+exception.getMessage());
        	log.error("",exception);
		}
        finally
        {
			if(result!=null)
				result.close();

			if(state!=null)
				state.close();

			takeDown();
		}
        return flag;
    }

    public HashMap getData(String s)throws SQLException
    {
        HashMap hashmap = null;
        result 			= null;
        state 			= null;
        try
        {
            hashmap = new HashMap();
            makeConnection();
            state = super.virtual_dbCon.createStatement();
            result = state.executeQuery(s);
            rsmd = result.getMetaData();
            column_count = rsmd.getColumnCount();
            for(row_count = 0; result.next(); row_count++)
            {
                Vector vector = new Vector();
                for(int i = 1; i <= column_count; i++)
                    vector.addElement(result.getString(i));

                Integer integer = new Integer(row_count);
                hashmap.put(integer.toString(), vector);
            }
        }
        catch(SQLException exception)
		{
			//System.out.println("LMS -SQL Exception in com.iGrandee.Common.CommonDataAccess.getData "+exception.getMessage());
        	log.error("",exception);
		}
        finally
		{
			if(result!=null)
				result.close();

			if(state!=null)
				state.close();

			takeDown();
		}
        return hashmap;
    }

    
    public void cleanup() throws SQLException
    {
        try
        {
			if(result!=null)
            	result.close();
            if(state!=null)
           		state.close();

            takeDown();
        }
        catch(SQLException sqlexception)
        {
			//System.out.println("LMS -SQL Exception in com.iGrandee.Common.CommonDataAccess.cleanup "+sqlexception.getMessage());
        	log.error("",sqlexception);
        }
    }

   

    public String getSingleColumn(String s)throws SQLException
    {
        String s1 = "";
        result = null;
        try
        {
            makeConnection();
            state = super.virtual_dbCon.createStatement();
            for(result = state.executeQuery(s); result.next();)
                s1 = result.getString(1);
        }
        catch(SQLException exception)
		{
			//System.out.println("LMS -SQL Exception in com.iGrandee.Common.CommonDataAccess.getSingleColumn "+exception.getMessage());
        	log.error("",exception);
		}
        finally
        {
			if(result!=null)
				result.close();

			if(state!=null)
				state.close();

			takeDown();
		}
        return s1;
    }

    public ArrayList getArrayList(String s)throws SQLException
	{
		ArrayList arraylist = null;
		try
		{
			result = null;
			arraylist = new ArrayList();
			makeConnection();
			state = super.virtual_dbCon.createStatement();
			result = state.executeQuery(s);
			rsmd = result.getMetaData();
			column_count = rsmd.getColumnCount();
			ArrayList arraylist_add;
			for(; result.next(); arraylist.add(arraylist_add))
			{
				arraylist_add = new ArrayList();
				for(int i = 1; i <= column_count; i++)
				{
					String coming_string =  result.getString(i);
					if(coming_string == null)
						arraylist_add.add("Nil");
					else
						arraylist_add.add(coming_string);
				}

			}
		}
		catch(SQLException exception)
		{
			//System.out.println("LMS -SQL Exception in com.iGrandee.Common.CommonDataAccess.getArrayList "+exception.getMessage());
			log.error("",exception);
		}
		finally
		{
			if(result!=null)
				result.close();

			if(state!=null)
				state.close();

			takeDown();
		}
		return arraylist;
    }
    
    public StringBuffer getListXML(String s, String tb_para)throws Exception
    {
 	   StringBuffer sb 		= new StringBuffer();
 	   ResultSet resultset 	= null;

 	   try
 	   {
 		   makeConnection();
 		   state 			= super.virtual_dbCon.createStatement();
 		   resultset 		= state.executeQuery(s);
 		   ResultSetMetaData rsmd = resultset.getMetaData();
 		   int column_count	= rsmd.getColumnCount();

 		   while(resultset.next())
 		   {
 			   
 			   sb.append("<"+tb_para+">");
 			   for(int colcnt=1;colcnt<=column_count;colcnt++)
 			   {
					if(resultset.getString(colcnt)!=null && !resultset.getString(colcnt).equals(""))
					{
						String replaceString=resultset.getString(colcnt).trim();
						sb.append("<"+rsmd.getColumnLabel(colcnt)+">"+replaceString+"</"+rsmd.getColumnLabel(colcnt)+">");
					}
					else
					{
						sb.append("<"+rsmd.getColumnLabel(colcnt)+">-</"+rsmd.getColumnLabel(colcnt)+">");
					}
 			   }
 			   sb.append("</"+tb_para+">");
 		   }
	    }
	    catch(Exception sqlexception)
		{
				log.error("",sqlexception);
	    }
	    finally
	    {
	    	
			if(resultset != null)
				resultset.close();

			if(state != null)
				state.close();

			takeDown();
	    }
	    return sb;
    }
    
    
    

	PreparedStatement pstate;
    Statement state;
    ResultSet result;
    ResultSet rs;
    ResultSetMetaData rsmd;
    long l_return_value;
    int i_return_value;
    int column_count;
    int row_count;
}

package com.iGrandee.Common;

import com.iGrandee.Common.util.IGSTFatalException;
import com.iGrandee.Common.util.Resource;
//import com.iGrandee.writer.DebugWriter;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.DriverManager;
import java.util.Hashtable;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import org.apache.log4j.Logger;

public class ConnectionManager
{
	static Logger log = Logger.getLogger(ConnectionManager.class);

    public ConnectionManager()
    {
    }
    
    public static synchronized Connection getKycConnection()throws SQLException
	{
		Connection conn 		= null;
		java.util.ResourceBundle bundle=java.util.ResourceBundle.getBundle("resources.serversetup");
		try
		{

			String kycjndi = bundle.getString("kycjndi");
			InitialContext ctx = new InitialContext();
			DataSource ds = (DataSource)ctx.lookup(kycjndi);
			conn = ds.getConnection();

		}
		catch(SQLException e)
		{e.printStackTrace();
			log.error("",e);
		}
		catch(NamingException ex)
		{
			ex.printStackTrace();
			log.error("",ex);
		}
		return conn;
   }
 

    public static synchronized Connection getVirtualDConnection() throws SQLException
	{
		Connection connection 	= null;

		if(virtuald_datasource == null)
		{
			resource = Resource.getSampleConfig();
			String s = resource.getString("VIRTUALD");
			s1 = resource.getString("DB_USER_ID");
			s2 = resource.getString("DB_PWD_SEED");
			String s3 = resource.getString("INITIAL_CONTEXT_FACTORY");
			try
			{
				Hashtable hashtable = new Hashtable();
				hashtable.put("java.naming.factory.initial", s3);
				if(s3 != null && !s3.equals("-"))
				{
					InitialContext initialcontext = new InitialContext(hashtable);
					virtuald_datasource = (DataSource)initialcontext.lookup(s);
					initialcontext.close();
					throughFactory = true;
				} else
				{
					throughFactory = false;
				}
			}
			catch(NamingException namingexception)
			{
				log.error(namingexception);
			}
		}
		try
		{
			if(s1 == null && s2 == null)
			{
				if(resource == null)
					resource = Resource.getSampleConfig();
				s1 = resource.getString("DB_USER_ID");
				s2 = resource.getString("DB_PWD_SEED");
			}
			if(!throughFactory)
			{
				Class.forName(resource.getString("DRIVER"));
				connection = DriverManager.getConnection(resource.getString("VIRTUALDURL"), s1, s2);
			} else
			{
				connection = virtuald_datasource.getConnection(s1, s2);
				connection.setAutoCommit(true);
			}
		}
		catch(SQLException e)
		{
			//System.out.println("SQLException inside method getVirtualDConnection() in V-Learn"+e.getMessage());
			log.error(e);
		}
		catch(ClassNotFoundException e)
		{
			//System.out.println("ClassNotFoundException inside method getVirtualDConnection() in V-Learn"+e.getMessage());
			log.error(e);
		}
		return connection;
    }


   /* public static synchronized Connection getVirtualDConnection() throws SQLException
	{
		Connection connection 	= null;
		try
		{

			resource = Resource.getSampleConfig();
			String s = resource.getString("VIRTUALD");
			String s1 = resource.getString("DB_USER_ID");
			String s2 = resource.getString("DB_PWD_SEED");
				Class.forName(resource.getString("DRIVER"));
				connection = DriverManager.getConnection(resource.getString("VIRTUALDURL"), s1, s2);

		}
		catch(SQLException e)
		{
			System.out.println("SQLException inside method getVirtualDConnection() in V-Learn"+e.getMessage());
		}
		catch(ClassNotFoundException e)
		{
			System.out.println("ClassNotFoundException inside method getVirtualDConnection() in V-Learn"+e.getMessage());
		}
		return connection;
    }*/

    public static void closeConnection(Connection connection)throws SQLException
      {
          try{
   		   if(connection != null)
   				connection.close();
          	}catch(SQLException exception){
   			//System.out.println("SQLException inside method closeConnection(connection)"+exception.getMessage());
          		log.error(exception);
   		}
   }
    public static void commitTransaction(Connection connection)throws IGSTFatalException,SQLException
    {
        try{
			if(connection != null)
				connection.commit();
			else
				throw new IGSTFatalException("Connection passed for performing commit is null");
			}catch(SQLException exception){
						   //System.out.println("SQLException inside method commitTransaction(connection)"+exception.getMessage());
				log.error(exception);
			}
    }

    public static void rollbackTransaction(Connection connection)throws IGSTFatalException,SQLException
    {
        try{
			if(connection != null)
				connection.rollback();
			else
				throw new IGSTFatalException("Connection passed for performing rollback is null");
		}catch(SQLException exception){
									   //System.out.println("SQLException inside method rollbackTransaction(connection)"+exception.getMessage());
			log.error(exception);
		}
    }

    static Resource resource 					= null;
    static boolean throughFactory 				= true;
    static DataSource virtuald_datasource 		= null;
    static String s1 							= null;
    static String s2 							= null;
}

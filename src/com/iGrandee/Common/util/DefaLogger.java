// Decompiled by DJ v3.7.7.81 Copyright 2004 Atanas Neshkov  Date: 12/8/2010 12:38:34 PM
// Home Page : http://members.fortunecity.com/neshkov/dj.html  - Check often for new version!
// Decompiler options: packimports(3) 
// Source File Name:   DefaLogger.java

package com.iGrandee.Common.util;

import java.io.*;

// Referenced classes of package com.iGrandee.Common.util:
//            Logger

public class DefaLogger
    implements Logger
{

    public DefaLogger()
    {
        verboseLevel = 0;
        try
        {
            verboseLevel = Integer.parseInt(System.getProperty("verboseLevel", "0").trim());
        }
        catch(Exception e)
        {
            e.printStackTrace(System.out);
        }
    }

    public void verbose(String msg, int lev)
    {
        if(lev <= verboseLevel)
            log(msg);
    }

    public int getVerboseLevel()
    {
        return verboseLevel;
    }

    public void setVerboseLevel(int level)
    {
        verboseLevel = level;
    }

    public void log(Exception e)
    {
        try
        {
            if(!Boolean.getBoolean("log.mute"))
                e.printStackTrace(System.out);
            StringWriter sw = new StringWriter();
            PrintWriter pw = new PrintWriter(sw, true);
            e.printStackTrace(pw);
            pw.close();
            log(sw.toString());
        }
        catch(Exception exception) { }
    }

    public void log(String msg)
    {
        if(!Boolean.getBoolean("log.mute"))
            logFl(msg);
    }

    protected void logFl(String msg)
    {
        String fl = "ApplicationLog.txt";
        if(fl == null)
            return;
        try
        {
            synchronized(LOCK)
            {
                FileOutputStream wr = new FileOutputStream(fl, true);
                wr.write(msg.getBytes());
                wr.write("\r\n".getBytes());
                wr.close();
            }
        }
        catch(Exception e)
        {
            e.printStackTrace(System.out);
        }
    }

    public static final Object LOCK = new Object();
    protected int verboseLevel;

}
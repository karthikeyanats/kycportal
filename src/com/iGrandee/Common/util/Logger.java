// Decompiled by DJ v3.7.7.81 Copyright 2004 Atanas Neshkov  Date: 12/8/2010 12:38:40 PM
// Home Page : http://members.fortunecity.com/neshkov/dj.html  - Check often for new version!
// Decompiler options: packimports(3) 
// Source File Name:   Logger.java

package com.iGrandee.Common.util;


public interface Logger
{

    public abstract void log(Exception exception);

    public abstract void log(String s);

    public abstract void verbose(String s, int i);

    public abstract int getVerboseLevel();

    public abstract void setVerboseLevel(int i);

    public static final int VERBOSE_ALWAYS = 0;
    public static final int VERBOSE_HI_PRIORITY = 1;
    public static final int VERBOSE_LO_PRIORITY = 2;
    public static final int VERBOSE_VLO_PRIORITY = 3;
}
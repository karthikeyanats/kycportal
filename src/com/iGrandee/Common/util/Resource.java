// Decompiled by DJ v3.6.6.79 Copyright 2004 Atanas Neshkov  Date: 9/20/2008 10:47:01 AM
// Home Page : http://members.fortunecity.com/neshkov/dj.html  - Check often for new version!
// Decompiler options: packimports(3) 
// Source File Name:   Resource.java

package com.iGrandee.Common.util;

import java.io.PrintStream;
import java.lang.reflect.AccessibleObject;
import java.lang.reflect.Field;
import java.net.InetAddress;
import java.util.*;
import sun.misc.SoftCache;

public class Resource
{

    private Resource(String propertyFile)
    {
        resourceBundle = null;
        resourceBundle = ResourceBundle.getBundle(propertyFile);
    }

    private Resource(String propertyFile, Locale locale)
    {
        resourceBundle = null;
        resourceBundle = ResourceBundle.getBundle(propertyFile, locale);
    }

    public boolean getBoolean(String key)
    {
        boolean booleanValue = false;
        String value = null;
        try
        {
            value = getString(key);
            if("true".equalsIgnoreCase(value) || "yes".equalsIgnoreCase(value))
                booleanValue = true;
        }
        catch(Exception e)
        {
            System.out.println("Resource.getBoolean() >> Exception parsing boolean, tried to parse: " + value + " \nException was " + e);
            return false;
        }
        return booleanValue;
    }

    public int getInt(String key)
    {
        String value = "";
        int intValue;
        try
        {
            value = getString(key);
            intValue = Integer.parseInt(value);
        }
        catch(Exception e)
        {
            System.out.println("Resource.getInt() >> Error parsing integer, tried to parse: " + value + " \nException was " + e);
            return 0;
        }
        return intValue;
    }

    public static Resource getSampleConfig()
    {
        return getBundle("config.databaseconfig");
    }

    public static Resource getBundle(String propertyFile)
    {
        Locale hostLocale = null;
        try
        {
            if(localHostName == null)
            {
                localHostName = InetAddress.getLocalHost().getHostName();
                if(localHostName.indexOf(".") != -1)
                    localHostName = localHostName.substring(0, localHostName.indexOf("."));
            }
            hostLocale = new Locale(localHostName, "");
        }
        catch(Exception e)
        {
            System.out.println("com.ibm.mlucas.resource.Resource: Caught exception trying to get hostname for property file: " + propertyFile + ". Exception was: " + e);
            hostLocale = new Locale("en", "US");
        }
        return getBundle(propertyFile, hostLocale);
    }

    public static Resource getBundle(String propertyFile, Locale locale)
    {
        String key = propertyFile + "_" + locale.toString();
        if(resourceBundles.containsKey(key))
        {
            return (Resource)resourceBundles.get(key);
        } else
        {
            Resource newBundle = new Resource(propertyFile, locale);
            resourceBundles.put(key, newBundle);
            return newBundle;
        }
    }

    public ResourceBundle getResourceBundle()
    {
        return resourceBundle;
    }

    public String getString(String key)
    {
        try
        {
            return getResourceBundle().getString(key).trim();
        }
        catch(MissingResourceException mre)
        {
            return "KeyNotFound." + key;
        }
    }

    public String getClassSpecificString(Class aClass, String key)
    {
        String classname = classNameOf(aClass.getName()).toLowerCase();
        return getString(classname + "." + key);
    }

    public boolean getClassSpecificBoolean(Class aClass, String key)
    {
        String classname = classNameOf(aClass.getName()).toLowerCase();
        return getBoolean(classname + "." + key);
    }

    public static synchronized void reloadBundles()
    {
        Map newMap = Collections.synchronizedMap(new HashMap());
        if(resourceBundles != null && !resourceBundles.isEmpty())
        {
            for(Iterator iterator = resourceBundles.keySet().iterator(); iterator.hasNext();)
            {
                String key = (String)iterator.next();
                Resource eBundle = null;
                try
                {
                    eBundle = (Resource)resourceBundles.get(key);
                    Locale locale = eBundle.getResourceBundle().getLocale();
                    Object bundle = eBundle.getResourceBundle();
                    Class klass = bundle.getClass().getSuperclass();
                    Field field = klass.getDeclaredField("cacheList");
                    field.setAccessible(true);
                    SoftCache cache = (SoftCache)field.get(null);
                    cache.clear();
                    if(locale != null)
                    {
                        int underscoreLoc = key.indexOf("_");
                        if(underscoreLoc != -1)
                            key = key.substring(0, underscoreLoc);
                        eBundle = new Resource(key, locale);
                    } else
                    {
                        eBundle = new Resource(key);
                    }
                    newMap.put(key, eBundle);
                }
                catch(Exception e)
                {
                    System.out.println("Caught exception in Resource.reloadBundles() --> " + e);
                }
            }

            resourceBundles = newMap;
        }
    }

    public static String classNameOf(String fullyQualifiedName)
    {
        if(fullyQualifiedName != null)
        {
            int lastDotLoc = fullyQualifiedName.lastIndexOf('.');
            if(lastDotLoc > 0)
                return fullyQualifiedName.substring(lastDotLoc + 1);
        }
        return null;
    }

    private static final String SAMPLE_CONFIG = "config.databaseconfig";
    private static String localHostName;
    private ResourceBundle resourceBundle;
    private static Map resourceBundles = Collections.synchronizedMap(new HashMap());

}
# ssl-support-interceptor-v3

Authors: Luis Majano, Ernst van der Linden, Paul Marcotte

Rewritten by Akitogo Internet and Media Applications GmbH

Based on
https://github.com/ColdBox/cbox-interceptors/tree/master/ssl

Based on the ssl interceptor originally developed by Ernst van der Linden 
(http://evdlinden.behindthe.net/index.cfm/2008/1/22/ColdBox-SSL-Interceptor-2--SSL-for-specific-events-only) 

This version of the ssl interceptor uses regular expressions for event pattern matches
and will preserve SES urls by leveraging event.buildLink().  Some small changes to the
configuration setup are required.  See notes below.

Configuration:

Add the following interceptor configuration to you coldbox config.

```
interceptors = [
    {class="#moduleMapping#.interceptors.ssl", name="ssl"}
];
```

```
settings = {
    SSLRequired = true, // default is set to false
    SSLPattern = ".*"   // pattern (regex) - a regex pattern for events that must use ssl. '.*' by default
                        // examples:  .*  - all events
                        // ^admin - all events beginning with "admin"
}
```

## Version 3
 - rewritten in cfscript
 - pulls the settings from moduleconfig.cfc
 - renamed properties

/*
	Based on the SSL interceptor originally developed by Ernst van der Linden
	(http://evdlinden.behindthe.net/index.cfm/2008/1/22/ColdBox-SSL-Interceptor-2--SSL-for-specific-events-only)

	Copyright 2009 Ernst van der Linden, Paul Marcotte, Luis Majano

	Licensed under the Apache License, Version 2.0 (the "License");
	you may not use this file except in compliance with the License.
	You may obtain a copy of the License at

		http://www.apache.org/licenses/LICENSE-2.0

	Unless required by applicable law or agreed to in writing, software
	distributed under the License is distributed on an "AS IS" BASIS,
	WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
	See the License for the specific language governing permissions and
	limitations under the License.

	
	Checks incoming event patterns for SSL requirements or NOT.

	To force SSL add to your moduleConfig.cfc:
	SSLRequired = true;
	SslPattern = '.*';		// this is optional

*/

component output="false" extends="coldbox.system.Interceptor" {
	
	/**
	 * This is the configuration method for your interceptors
	 */
	public void function configure() output=false {

		// check ssl enablement off by default
		setProperty("SSLRequired", getSetting('SSLRequired',false,false) );

		// check custom pattern, else use default
		setProperty("SslPattern", getSetting('SslPattern',false,".*") );

		// set configuration time
		setProperty('SslConfigurationTime', now() );
	}

	/**
	 * Invokes checkSSL when required and not framework reload.
	 */
	public void function preProcess(event, interceptData) output=false {

		if (getProperty('SSLRequired') && (!event.valueExists("fwreinit"))) {
			checkSSL(event);
		}
	}

	/**
	 * Determines whether to redirect to https or http.
	 */
	private void function checkSSL(event) output=false {

		var isSSL = event.isSSL();

		// check if SSL request and SSL Required
		if( !isSSL && isSSLRequired(event) ){
			flash.keep();
			setNextEvent(uri=cgi.script_name & cgi.path_info,ssl=true,statusCode=302,queryString=cgi.query_string);
		}
		// Check if in SSL and NO SSL Required
		else if( isSSL && !isSSLRequired(event) ){
			flash.keep();
			setNextEvent(uri=cgi.script_name & cgi.path_info,ssl=false,statusCode=302,queryString=cgi.query_string);
		}
	}

	/**
	 * Returns boolean for ssl required.
	 */
	private boolean function isSSLRequired(event) output=false {

		var isSSLRequired 	= false;
		var pattern 		= getProperty('SslPattern');
		var cEvent			= event.getCurrentEvent();

		// check in pattern list
		for(var i=1; i lte listLen(pattern); i++){
			if ( reFindNoCase(listGetAt(pattern,i), cEvent) ){
				isSSLRequired = true;
				break;
			}
		}
		return isSSLRequired;
	}

}

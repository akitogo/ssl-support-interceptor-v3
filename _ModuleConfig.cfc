component{

	// Module Properties
	this.title 				= "SSL Support Interceptor v3";
	this.author 			= "Akitogo";
	this.webURL 			= "http://www.akitogo.com";
	this.description 		= "Rewritten SSL Interceptor";
	this.version			= "3.0.0";
	this.viewParentLookup 	= true;
	this.layoutParentLookup = true;
	this.entryPoint			= "ssl-support-interceptor-v3";
	this.dependencies 		= [  ];
	
	function configure(){

        interceptors = [
            {class="#moduleMapping#.interceptors.Ssl", name="ssl"}
        ];

        settings = {
            SSLRequired = true, // default is set to false
            SSLPattern = ".*"   // pattern (regex) - a regex pattern for events that must use ssl. '.*' by default
                                // examples:  .*  - all events
                                // ^admin - all events beginning with "admin"
        }        
	}
	
	/**
	* Fired when the module is registered and activated.
	*/
	function onLoad(){
		
	}
	
	/**
	* Fired when the module is unregistered and unloaded
	*/
	function onUnload(){
		
	}	

	

}
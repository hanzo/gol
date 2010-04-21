/*
 * This code initialises the iPhone framework and then starts Processing (see note below)
 * This code searches for all the <script type="application/processing" target="canvasid">
 * in your page and loads each script in the target canvas with the proper id.
 * It is useful to smooth the process of adding Processing code in your page and starting
 * the Processing.js engine.
 */

/*
 * iProcessing.js - Tom Hulbert (http://tomhulbert.com)
 * Modified processing.js to integrate with iPhone javascript framework.  
 * Enables Native iPhone apps to be developed using Processing
 */

if ( window.addEventListener ) {
	window.addEventListener("load", function() {
    initProcessing();
	}, false);
}

// Processing Initialisation
function initProcessing() {
	var platform = document.getElementById("platform").text;
	var scripts = document.getElementsByTagName("script");
	
	for ( var i = 0; i < scripts.length; i++ ) {
		if ( scripts[i].type == "application/processing" ) {
			var src = scripts[i].src, canvas = scripts[i].nextSibling;
			
			if ( src && src.indexOf("#") ) {
				canvas = document.getElementById( src.substr( src.indexOf("#") + 1 ) );
			} else {
				while ( canvas && canvas.nodeName.toUpperCase() != "CANVAS" )
					canvas = canvas.nextSibling;
			}
			
			if ( canvas ) {
				Processing(canvas, scripts[i].text, platform);
			}
		}
	}
}
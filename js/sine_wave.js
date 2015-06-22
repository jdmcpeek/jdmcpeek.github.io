/**
 * Author: David McPeek
 *
 * A file with functions that build array-form 'paths' to follow during jquery animation
 * 
 */

function BuildPath(fun) {
	/**
	 * Closure: returns a path-building function
	 *
	 * Args
	 * 	fun: the mathematical function used to map x-coordinates to y
	 */
	var Path = function(cycles, samples) {
		/**
	 	 * Returns a list of x, y coordinates
 		 *
 	 	 * Args:
 	 	 * 	cycles (int): the number of sinusoidal cycles
 	 	 * 	samples (int): the number of desired samples. Determined the length of the returned array
 	 	*/

		// cycles are for wave forms, but scaling should normalize for any function
		var length = cycles * 2 * Math.PI;
	 	var interval = length / samples;
	 	var path = []; // the array to be returned

	 	for (var i = 0.0; i < samples; i = i + interval) {
	 		// use the function parameter passed in the parent function, `BuildPath`
	 		path.push([i * interval, fun(i * interval)]); 
	 	};

	 	return path;
	}

	return Path;

}

function ScaleAndConvert(path, len, amplitude, start) {
	/**
	 * Scales x,y elements in the path array
	 *
	 * Args:
	 * 	path: the path array
	 * 	len (integer): distance of movement in pixels. Can be negative to reverse direction.
	 * 	amplitude (float): the y-scaling factor
	 * 	start (array): two-item array giving the top and left positions at start (in pixels)
	 */
	var cur = path[path.length - 1][0] - path[0][0];  // current length of the wave
	var xscale = len / cur;  // the scaling factor
	for (var i = 0; i < path.length; i++) {
		// scale x,y by xscale and amplitude
		path[i][0] = path[i][0] * xscale;
		path[i][1] = path[i][1] * amplitude;
		path[i] = { left: path[i][0] + start[0], top: path[i][1] + start[1] };
	};


	return path;

}

function ScaleBuilder(len, amplitude) {
	/**
	 * returns a scaling function suited for a specific path. Remembers len, amplitude, and start attrs
	 * Args:
	 * 	len (integer): distance of movement in pixels. Can be negative to reverse direction.
	 * 	amplitude (float): the y-scaling factor
	 * 	start (array): two-item array giving the top and left positions at start (in pixels)
	 */
	function Scaler(path, direction, start) {
		/**
		 * Scales x,y elements in the path array
		 *
		 * Args:
		 * 	path: the path array
		 * 	direction: 1 or -1, determines a sign change
		 * 	start: able to redefine start
		 * 	
		 */
		var cur = path[path.length - 1][0] - path[0][0];  // current length of the wave
		var xscale = direction * (len / cur);  // the scaling factor
		for (var i = 0; i < path.length; i++) {
			// scale x,y by xscale and amplitude
			path[i][0] = path[i][0] * xscale;
			path[i][1] = path[i][1] * amplitude;
			path[i] = { left: path[i][0] + start[0], top: path[i][1] + start[1] };
		};

		return path;

	}

	return Scaler;

}



function AnimateAlongPath(object, path, index, direction) {
	/**
	 * Animates `object` along all the points in the given `path`
	 *
	 * Args: 
	 * 	Object (string): the identifier of an object
	 * 	Start, end (points) 
	 * 	Path (array): array of x,y coordinates describing the path of the animation
	 * 	dest (int): an integer that describes the index the object is flying towards in the array 
	 * 	direction: 1 or -1
	 */
	if (index < path.length) { 
		$(object).animate(path[index], 
											{ duration: 5000 / path.length, 
												easing: "linear", 
												complete: function() { 
													AnimateAlongPath(object, path, index + 1, direction); 
												}
											});
	} else { 
		// // recreate path in the reverse direction
		path = BirdScale(path, 1, [$(object).offset().left, $(object).offset().top]);
		$(object).css(flip(direction));
		AnimateAlongPath(object, path, 0, -1 * direction);  // what is index?

	}

}

var SineWave = BuildPath(Math.sin);
var wave = SineWave(3, 100);
var BirdScale = ScaleBuilder(0.75 * $(window).width(), 50);
// BirdScale knows how far it's gonna go, it just needs a starting point, which will be its current position
wave = BirdScale(wave, -1, [$("#longbeak").offset().left, $("#longbeak").offset().top]); 
AnimateAlongPath("#longbeak", wave, 0, -1);


/**
 * TODO
 * 1. get the bird to fly the way we want it to, not backwards. Will have to combine the `AnimateAlongPath`
 * 		function with `Fly` in scripts.js
 * 
 */










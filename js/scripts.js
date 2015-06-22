function changeColor(object) {
	object.style.color = "red";
}

function duplicateElement(object) {
	document.body.innerHTML += object.innerHTML;
}

$(".ui-draggable").draggable({appendTo: "body"});

// hide scrollbar and overflow
document.documentElement.style.overflowX = 'hidden';
document.documentElement.style.overflowY = 'hidden';


function getPos(el) {
    for (var lx=0, ly=0;
         el != null;
         // bubble up the DOM until there are no parent nodes
         lx += el.offsetLeft, ly += el.offsetTop, el = el.offsetParent); 
    return { x: lx, y: ly };
}


function flip(direction) {
	// returns the proper transformation based on desired direction
	return { "-moz-transform": "scaleX( " + direction + " )",
       		  	 "-o-transform": "scaleX( " + direction + " )",
              	 "--webkit-transform": "scaleX( " + direction + " )",
        	  	 "transform": "scaleX( " + direction + " )",
        	  	 "filter": "FlipH",
              	 "-ms-filter": "FlipH" 
            }; 
}

// function float() {
// 	$("#longbeak").css({})
// 	top: Math.sin(getPos($("#longbeak").get()[0])["x"]) * 250 
// }

function getTop() {
	return (Math.sin(getPos($("#longbeak").get()[0])["x"]) * 500 * Math.cos(getPos($("#longbeak").get()[0])["y"]))
}

function Curve(direction) {
	return direction * Math.random() * 250;
}





// can I write a reasonable closure for this?
// I'm seeing too many integers and not enough abstraction in this code. Refactor later. 
// (function Fly(direction, object) {
// 	/**
// 	 * animates object
// 	 *
// 	 * Args:
// 	 * 	direction (int): -1 or 1. 1 -> fly to the right. -1 -> fly to the left.
// 	 * 	object (string): an HTML identifier
// 	 */

// 	direction = typeof direction !== 'undefined' ? direction : 1;
// 	$(object).css(flip(-1 * direction)); // change the sign of `direction` because the bird starts to the left
// 	if (direction == -1) {
// 		wave = ScaleAndConvert(wave, 
// 			                     -1.75 * $(window).width(), 
// 			                     50, 
// 			                     [$(window).width(), 0.3 * $(window).height()]);
// 		AnimateAlongPath("#longbeak", wave);

// 	} else {
	
// 		$("#longbeak").animate({left: "110%",
// 								top: getTop() }, 
// 								8000, 
// 								function() { 
// 									fly(1); 
// 								});
// 	}

	
// }());


// (function fly(direction) {
// 	direction = typeof direction !== 'undefined' ?  direction : 1;
// 	$("#longbeak").css(flip(direction)); 
// 	if (direction == 1) {
// 		$("#longbeak").animate({top: Curve(1) },
// 								1000, 
// 								function() {
// 									Curve(-1);
// 								});
// 		$("#longbeak").animate({left: "-30%", 
// 								top: getTop() }, 
// 								8000, 
// 								function() { 
// 									fly(-1); // wrap `fly` in closure to avoid infinite recursion when evaluation function as parameter
// 								});
// 	} else {
// 		$("#longbeak").animate({top: Curve(1) },
// 								1000, 
// 								function() {
// 									Curve(1);
// 								});
// 		$("#longbeak").animate({left: "110%",
// 								top: getTop() }, 
// 								8000, 
// 								function() { 
// 									fly(1); 
// 								});
// 	}

	
// }());




	

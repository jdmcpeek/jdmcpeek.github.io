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
    // yay readability
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



(function fly(direction) {
	direction = typeof direction !== 'undefined' ?  direction : 1;
	$("#longbeak").css(flip(direction)); 
	if (direction == 1) {
		$("#longbeak").animate({left: "-30%", 
								top: getTop() }, 
								8000, 
								function() { 
									fly(-1); // wrap `fly` in closure to avoid infinite recursion when evaluation function as parameter
								});
	} else {
		$("#longbeak").animate({left: "110%",
								top: getTop() }, 
								8000, 
								function() { 
									fly(1); 
								});
	}

	
}());




	

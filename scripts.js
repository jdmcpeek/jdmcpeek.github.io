function changeColor(object) 
{
	object.style.color = "red";
}

function duplicateElement(object)
{
	document.body.innerHTML += object.innerHTML;
}

function changePosition(event) {
	$(".testbox").css({"left": event.pageX - 40, "top": event.pageY -40});
}


$(".testbox").draggable({appendTo: "body"});


// $(".testbox").on("click", function(event) {

// 	// how do I delay this next function from happening until the next click? Do I need to stop propagation or something?
// 	// $(".testbox").css({"left": event.pageX - 40, "top": event.pageY -40});

// 	$("body").bind("click");


// 	$("body").on("click", function() {
		
// 			$(".testbox").css({"left": event.pageX - 40, "top": event.pageY -40});
// 			clicked = false;	

// 	});

	



// });



	

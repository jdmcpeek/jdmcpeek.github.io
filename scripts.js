function changeColor(object) 
{
	object.style.color = "red";
}

function duplicateElement(object)
{
	document.body.innerHTML += object.innerHTML;
}

clicked = false;

$(".testbox").on("click", function() {

	// how do I delay this next function from happening until the next click? Do I need to stop propagation or something?
	clicked = true;


});

if (clicked == true) 
{
	$("body").on("click", function() {
		
			$(".testbox").css({"left": event.pageX - 40, "top": event.pageY -40});
			clicked = false;	

	});
}
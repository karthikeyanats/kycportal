$(document).ready(function() 
		{
	$('#homelink').addClass("current-page");
$('#homelink').click(function()
{
		$('#homelink').addClass("current-page");
		$('#aboutuslink').removeClass("current-page");
		$('#gallerylink').removeClass("current-page");
		$('#academiclink').removeClass("current-page");
		$('#contactuslink').removeClass("current-page");
});

$('#aboutuslink').click(function()
{
		$('#homelink').removeClass("current-page");
		$('#aboutuslink').addClass("current-page");
		$('#gallerylink').removeClass("current-page");
		$('#academiclink').removeClass("current-page");
		$('#contactuslink').removeClass("current-page");
});

$('#gallerylink').click(function()
{
		$('#homelink').removeClass("current-page");
		$('#aboutuslink').removeClass("current-page");
		$('#gallerylink').addClass("current-page");
		$('#academiclink').removeClass("current-page");
		$('#contactuslink').removeClass("current-page");
});

$('#academiclink').click(function()
{
		$('#homelink').removeClass("current-page");
		$('#aboutuslink').removeClass("current-page");
		$('#gallerylink').removeClass("current-page");
		$('#academiclink').addClass("current-page");
		$('#contactuslink').removeClass("current-page");
});

$('#contactuslink').click(function()
{
		$('#homelink').removeClass("current-page");
		$('#aboutuslink').removeClass("current-page");
		$('#gallerylink').removeClass("current-page");
		$('#academiclink').removeClass("current-page");
		$('#contactuslink').addClass("current-page");
});
});
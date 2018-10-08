<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>:::Welcome to Lalitha-Lal Bahadur Shastri Public School:::</title>


<link rel="stylesheet" href="<%=request.getContextPath()%>/css/bootstrap-responsive.css">

<link rel="stylesheet" href="<%=request.getContextPath()%>/css/bootstrap.css">

<link rel="stylesheet" href="<%=request.getContextPath()%>/css/LLBS1.css">

<link rel="stylesheet" href="<%=request.getContextPath()%>/css/flexslider.css">

<link rel="stylesheet" href="<%=request.getContextPath()%>/css/font-awesome.min.css">




<!-- <link rel="stylesheet" href="<%=request.getContextPath()%>/css/font-awesome-ie7.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/font-awesome-ie7.min.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/font-awesome.css"> -->


<script type="text/javascript">

	function checkLogin(){
	if(document.loginForm.username.value==""){

		alert("User Name should not be empty");
		return false;
	}
	if(document.loginForm.password.value==""){

		alert("Password should not be empty");
		return false;
	}


	if(document.loginForm.userstate[0].checked){
		document.loginForm.action="./loginverifyparent.jsp";
	//	document.loginForm.submit();
	}
	else{

		document.loginForm.action="./loginverify.jsp";
	//	document.loginForm.submit();
	}

}
</script> 

<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-1.8.3.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.ui.totop.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/bootstrap.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.flexslider-min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.flexslider.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/customstyle.js"></script>



<script type="text/javascript">
// Popup window code
function newPopup(url) {
	popupWindow = window.open(
		url,'popUpWindow','height=700,width=800,left=10,top=10,resizable=yes,scrollbars=yes,toolbar=yes,menubar=no,location=no,directories=no,status=yes')
}
</script>





</head>
<body class="back">

	<header>
		<div class="container">

			<div class="row-fluid id">
				<div class="span12">	
					<div class="span2 pull-right">
							<ul class="nav pull-right">						
								<li class="dropdown"><a class="dropdown-toggle" href="#" data-toggle="dropdown">Login | <strong class="caret"></strong></a>
									
									<div class="dropdown-menu">
										<form method="post" name="loginForm">
											<input type="text" name="username" id="login_name" placeholder="UserName"> 
												<input type="password" name="password" id="login_password" placeholder="Password"> 
												
												<input class="btn btn-primary loginform" type="submit" name="commit" value="Login" onclick="checkLogin()" style="width:65px; ">												
												  <input type="radio" name="userstate" value="parent" id="" size="54" onkeydown="if(event.keyCode==13) return checkLogin();"> Parent
                       							  <input type="radio" name="userstate" value="others" id="" checked="" size="54" onkeydown="if(event.keyCode==13) return checkLogin();"> Others
                       							  <div class="btn-group" data-toggle="buttons-radio">
                       							   										 
												</div>
                       							  <a href="<%=request.getContextPath()%>/forgotpassword.jsp"><u>Forgot Your Password?</u></a>
										</form>											
									</div>
									</li>
								</ul>
						</div>
					
					
				</div>
			</div>

			<div class="row-fluid">
				<div class="span12"></div> 
			</div>


			<div class="navbar ">

				<div class="row-fluid">
					<div class="span12">

						<div class="span6 letter">

							<a class="brand" href=""> <img src="<%=request.getContextPath()%>/image/LLBS/newlogo.png" width="90" height="90" alt="optional log"></a> 
								<span class="logo"><strong>Lalitha-Lal Bahadur Shastri Public School</strong>
						</div>


	 <!-- Header div start -->
        <div class="container">
            <div class="header row-fluid">
                <div class="span12">
                    <div class="navbar">
                        <div class="navbar-inner">
                            <a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
                                <span class="icon-bar"></span>
                                <span class="icon-bar"></span>
                                <span class="icon-bar"></span>
                            </a>
                            
                            <div class="nav-collapse collapse">
                               <ul class="nav pull-right">
									<li id="homelink" class="current-page"><a href="home.jsp"><i class="icon-home"></i>Home</a></li>
									<li id="aboutuslink"><a href="#"><i class="icon-comments"></i>About Us</a></li>
									<li id="gallerylink"><a href="#"><i class="icon-camera"></i>Gallery</a></li>
									<li id="academiclink"><a href="#"><i class="icon-tasks"></i>Academics</a></li>	
									<li id="contactuslink"><a href="Contact_LLBS.jsp"><i class="icon-envelope-alt "></i>Contact Us</a></li>
								</ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
		</div>
			</div>
			</div>
		</div>
	</header>
<!-- Header div end -->




<!-- slide show div start  -->

<div class="container">

	<section id="carousel">
		<div id="main_slider" class="slider">
			<div id="myCarousel" class="carousel slide user">
				<div class="carousel-inner">			
						
								
				<!-- LLBS02 div start  -->
				
					<div class="item active image1">
						<p class="flex-caption" style="margin-left: 575px;">Correspondent  Visit on the occasion of 20th sport meet-2012</p>
						<img src="<%=request.getContextPath()%>/image/LLBS/LLBS03.png" alt="" style="margin-left: 155px;">
						
						<div class="container">	
											
						</div>
					</div>
					
				<!-- LLBS02 div end  -->					
					
					
					
					<!-- LLBS02 div start  -->					
					
					<div class="item image1">
					<p class="flex-caption" style="margin-left: 691px;">Students skating at 20th sport meet - 2012</p>
						<img src="<%=request.getContextPath()%>/image/LLBS/LLBS02.png" alt="" style="margin-left: 155px;">
						<div class="container">
							</div>
					</div>
					
					<!-- LLBS02 div end  -->
					
				
					
					<!--LLBS04 div end  -->
					
					<div class="item image1">
					<p class="flex-caption" style="margin-left: 734px;">Received 2012 Best students award </p>
						<img src="<%=request.getContextPath()%>/image/LLBS/LLBS04.png" alt="" style="margin-left: 155px;"/>
						</div>
					
					<!-- LLBS04 div end  -->
					
					
					
					
				<!-- LLBS05 div start  -->
					
					<div class="item image1">
					<p class="flex-caption" style="margin-left: 748px;">Play school in our school Campus </p>
						<img src="<%=request.getContextPath()%>/image/LLBS/LLBS05.png" alt="" style="margin-left: 155px;"/>
						</div>
					
			   <!-- LLBS05 div end  -->
					
					
					
					
				</div>
				<a class="left carousel-control" href="#myCarousel"
					data-slide="prev">&lsaquo;</a> <a class="right carousel-control"
					href="#myCarousel" data-slide="next">&rsaquo;</a>


				<ol class="flex-control-nav flex-control-paging">
					
					
				</ol>
				<!-- <ul class="flex-direction-nav">
					<li><a class="flex-prev" href="#">Previous</a></li>
					<li><a class="flex-next" href="#">Next</a></li>
				</ul> -->

			</div>
 		</div>
	</section>
	</div>
	
<!-- slide show div end  -->






	<div id="main">
		<div class="container" >
			<section class="action">
				<p class="value"  class="value" style="margin-top: -58px;" > Welcome to Lalitha-Lal Bahadur Shastri Public School</p>
				<p> The CBSE School is named after the Great Patriot and Freedom Fighter, and Great Leader and Ex-Prime Minister of India Shri. Lal Bahadur shastri’s wife Srimathi. Lalitha Lal Bahadur Shastri, who is the life part and support of our Great Leader.</p><br>
				<p>It is a mile stone of the Trust started in the year 2010 under CBSE Syllabus, to up lift the Education Standard to International level with a dynamic and enthusiastic leadership of the Principal. The school is recognized by the Central Government to run </p>
					
			</section>

			<section id="teaser_wrapper">
				<div class="row-fluid">
					<div class="span4 feature_teaser">
						<img alt="responsive" src="image/LLBS/responsive.png">
						<p class="hed"><strong>News & Events</strong></p>
						<p style="text-align: justify; padding: 10px;">
							The CBSE School is named after the Great Patriot and Freedom Fighter, and Great Leader and Ex-Prime Minister of India Shri. Lal Bahadur shastri’s wife Srimathi. Lalitha Lal Bahadur Shastri, who is the life part and support of our Great Leader.
							<a href="#">More...<i class="icon-angle-right"></i></a>
						</p>							
						
					</div>

					<div class="span4 feature_teaser">
						<img alt="responsive" src="image/LLBS/git.png">						
						<p class="hed"><strong>Principal’s Message</strong></p>						
						<p style="text-align: justify; padding: 10px;">Appeared in the sky of education, to brighten the sattur society, with its flaw less effort our school, Lalitha Lalbahadur Shastri Public School is started. The thought was brooded over and took its shape in the mind of our correspondent Thiru.Babu.A.Rajendran 
						<a href="#">More...<i class="icon-angle-right"></i></a> 
						</p>
					</div>

					<div class="span4 feature_teaser">
						<img alt="responsive" src="image/LLBS/less.png">					
						<p class="hed"><strong>Announcements</strong></p>
						<p style="text-align: justify; padding: 10px;">
						<strong>25.06.2013</strong>The school which is a dream child of our correspondent was born on 17 July,2010 with just 47 students on our enrolment. It grew colourfully into 260, hailing from various villages around. Our institution is child friendly ,treating every student as an individual.
						<a href="#">More...<i class="icon-angle-right"></i></a>
						</p>
					</div>
				</div>

			</section>
	
	
			<section id="portfolio">
				<p class="section_header"> <strong>Lalitha-Lal Bahadur Shastri Public School </strong><br>20th Annual Day & Sports Meet - 2012</br></p>
				<div class="container">
					<div class="row-fluid">
					
					
						<!-- Correspondent in School div start -->
					
						<div class="span3 image">
							<div class="content-img1"></div>

							<div class="content-des">
								
								<p><strong> Correspondent visit in school </strong></p>
							</div>
						</div>
						<!-- Correspondent in School div end -->	
						
						
						
						<!-- Best Students Awards div start -->
						
						<div class="span3 image">
							<div class="content-img2">												
							</div>
							<div class="content-des">
								
								<p><strong>Best Students Awards</strong></p>
							</div>
						</div>
						
							<!-- Best Students Awards div end -->
						
						
						
						<!--Sports Day div start -->
						
						<div class="span3 image">
							<div class="content-img3">	</div>
							<div class="content-des">
								
								<p><strong>Sports Day</strong></p>
							</div>
						</div>
						
						<!-- Sports Day div end -->
						
						
						
						
						<!-- 20th School Day 2010 div start -->
						
						<div class="span3 image">
							<div class="content-img4"></div>
							<div class="content-des">
								
								<p><strong>20th School Day 2012</strong></p>
							</div>
						</div>
						
						<!-- 20th School Day 2010 div end -->
						
						
					</div>
				</div>
			</section>
		</div>
		
		
	<footer>
			
			<div class="row-fluid">
							<div class="span12 footer_teaser">
								<p style="text-align: center; margin-top:7px;">	<a href="http://www.igrandee.com/" target="_blank">Powered by www.igrandee.com</a></p>							
							</div>
					</div>
				
	</footer>
	
	

 

	<a href="#" id="toTop" style="display: inline;"><span
		id="toTopHover" style="opacity: 1;"></span>To Top</a>

 
 
 <script>
	$(window).load(function() { 
		$("#portfolio .content-img1 > a ").css('visibility','hidden');
		$(".content-img1").mouseover(function() { $("#portfolio .content-img1 > a ").css('visibility','visible'); });
		 $(".content-img1").mouseout(function() { $("#portfolio .content-img1 > a ").css('visibility','hidden'); });
		 
		
	});
	
	</script> 
	 <script >
	$(window).load(function() { 
		$("#portfolio .content-img2 > a ").css('visibility','hidden');
		$(".content-img2").mouseover(function() { $("#portfolio .content-img2 > a ").css('visibility','visible'); });
		 $(".content-img2").mouseout(function() { $("#portfolio .content-img2 > a ").css('visibility','hidden'); });
		 
		
	});
	</script>
	<script>
	$(window).load(function() { 
		$("#portfolio .content-img3 > a ").css('visibility','hidden');
		$(".content-img3").mouseover(function() { $("#portfolio .content-img3 > a ").css('visibility','visible'); });
		 $(".content-img3").mouseout(function() { $("#portfolio .content-img3 > a ").css('visibility','hidden'); });
		 
		
	});
	
	</script>
	
	<script>
	$(window).load(function() { 
		$("#portfolio .content-img4 > a ").css('visibility','hidden');
		$(".content-img4").mouseover(function() { $("#portfolio .content-img4 > a ").css('visibility','visible'); });
		 $(".content-img4").mouseout(function() { $("#portfolio .content-img4 > a ").css('visibility','hidden'); });
		 
		
	});
	
	</script>
	

</body>
</html>

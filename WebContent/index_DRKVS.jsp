<!DOCTYPE html >
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>   :::  Welcome to Dr.Radhakrishnan Vidhyalaya Matric Higher Secondary School,  ::::</title>


<link rel="stylesheet" href="<%=request.getContextPath()%>/css/bootstrap.css" />
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/bootstrap-responsive.css" />
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/font-awesome.min.css" />
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/drrkv.css" />
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/flexslider.css">
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


</head>

<body>
	<div class="contain">
		<div class="container">
			<div class="navbar navbar-static-topic">
				<div id="header">
					<div class="row-fluid">
						<div class="span2">		
						<img  src="<%=request.getContextPath()%>/image/DRKVS/DRKVS_logo.png"  style="margin-left: 34px;"/>
							
						</div>
						<div class="span8 top-div">
							<h4 class="centerh4" style="margin-left: -53px;">Dr.Radhakrishnan Vidhyalaya Matric Higher Secondary School</h4>
							<!-- text-shadow:#ff4 0px 0px 10px; -->

						</div>
						<div class="span2">
							<ul class="nav pull-right">						
								<li class="dropdown"><a class="dropdown-toggle" href="#" data-toggle="dropdown"><strong>Login</strong> | <strong class="caret"></strong></a>
									<div class="dropdown-menu">
										<form method="post" name="loginForm">
											<input type="text" name="username" id="login_name" placeholder="UserName"> 
												<input type="password" name="password" id="login_password" placeholder="Password"> 
												
												<input class="btn btn-primary loginform" type="submit" name="commit" value="Login" onclick="checkLogin()" style="width:65px; ">												
												  <input type="radio" name="userstate" value="parent" id="" size="54" onkeydown="if(event.keyCode==13) return checkLogin();"> Parent
                       							  <input type="radio" name="userstate" value="others" id="" checked="" size="54" onkeydown="if(event.keyCode==13) return checkLogin();"> Others
                       							  <div class="btn-group" data-toggle="buttons-radio">
<%
                    	       // out.print((String)session.getValue("invalid"));
                    	        if(session.getValue("invalid") != null)
                    	        {
                    	        out.print("<center><font color='red'>"+(String)session.getValue("invalid")+"</font></center>");
                    	        session.putValue("invalid",null);
                    	        }

                    	        %>												</div>
                       							  <a href="<%=request.getContextPath()%>/forgotpassword.jsp"><u>Forgot Your Password?</u></a>
										</form>
									</div>
									</li>						
			
							</ul>
						</div>
					</div>
				</div> 

				<div class="container" id="firsthead">
					<div class="nav-in">
						<a class="btn btn-navbar" data-toggle="collapse"
							data-target=".nav-collapse"><i class="icon-tasks"></i> </a>
						<div class="nav-collapse collapse">
							<ul class="nav">
								
								<li class="dropdown"><a href="<%=request.getContextPath()%>/home.jsp">Home	</a>
								<li><a href="<%=request.getContextPath()%>/Aboutus_DRKVS.jsp">About Us</a></li>							
								<li class="dropdown"><a href="#">Gallery</a></li>									
								<li class="dropdown"><a href="#" ">Academics</a></li>								
								<li class="dropdown"><a href="<%=request.getContextPath()%>/Contact_DRKVS.jsp">Contact Us </a></li>
								
							</ul>
						</div>

						
					</div>
				</div>

		
				<div id="myCarousel" class="carousel slide">
					<div class="carousel-inner">
						<div class="item active">
							<div class="row-fluid">
					
						<div class="item ">				
							<div class="row-fluid">
								<div class="span6 right bgcol">
								
									<h3 style="margin-top:106px; color:#383735";>Dr.Radhakrishnan Vidhyalaya </h3>
									
									<p>Students pay homage to former Chief minister of Tamilnadu Mr. K.Kamaraj. </p>
									
								</div>
								<div class="span6">	<img src="<%=request.getContextPath()%>/image/DRKVS/slide1.jpg"></div>
							   </div>
						</div>
						</div>
						</div>
				
						<div class="item">
							<div class="row-fluid">
								<div class="span6 right bgcol">
									<h3 style="margin-top: 106px; color:#383735";">
										Dr.Radhakrishnan Vidhyalaya 
									</h3>
									<p>Dignitary unveiled a newly constructed building in the school premises </p>
									
								</div>
								<div class="span6">
									<img src="<%=request.getContextPath()%>/image/DRKVS/slide2.jpg">
								</div>
							</div>
						</div>
					
						<div class="item">
							<div class="row-fluid">

								<div class="span6 right bgcol">
									<h3 style="margin-top: 106px; color:#383735";">
										Dr.Radhakrishnan Vidhyalaya 
									</h3>
									
									<p>Students make use of the Computer lab to showcase their creativity</p>
									
								</div>
								<div class="span6">
									<img src="<%=request.getContextPath()%>/image/DRKVS/slide3.jpg">
								</div>


							</div>
						</div>
					
						<div class="item">
							<div class="row-fluid">

								<div class="span6 right bgcol">
									<h3 style="margin-top: 106px; color:#383735";">
										<span class="org">Dr.Radhakrishnan Vidhyalaya 
									</h3>
									
									<p>Students at the annual day meet perform random acts of yoga </p>
									
								</div>
								<div class="span6">
									<img src="<%=request.getContextPath()%>/image/DRKVS/slide4.jpg">
								</div>


							</div>
						</div>
					
						<div class="item">
							<div class="row-fluid">

								<div class="span6 right bgcol">
									<h3 style="margin-top: 106px; color:#383735";">
										<span class="org">Dr.Radhakrishnan Vidhyalaya 
									</h3>
									
									<p>Students perform Aerobics exercises at the annual day meet </p>
									
								</div>
								<div class="span6">
									<img src="<%=request.getContextPath()%>/image/DRKVS/slide5.jpg">
								</div>


							</div>
						</div>
					
						<div class="item">
							<div class="row-fluid">

								<div class="span6 right bgcol">
									<h3 style="margin-top: 106px; color:#383735";">
										Dr.Radhakrishnan Vidhyalaya 
									</h3>
									
									<p>Students march past band in the playground during the annual day meet </p>
									
								</div>
								<div class="span6">
									<img src="<%=request.getContextPath()%>/image/DRKVS/slide6.jpg">
								</div>


							</div>
						</div>
					
						
						<div class="item">
							<div class="row-fluid">

								<div class="span6 right bgcol">
									<h3 style="margin-top: 106px; color:#383735";">
										Dr.Radhakrishnan Vidhyalaya 
									</h3>
									
									<p>A dance imitating Lord krishna and Radha at the annual day meet </p>
									
								</div>
								<div class="span6">
									<img  src="<%=request.getContextPath()%>/image/DRKVS/slide7.jpg">
								</div>


							</div>
						</div>
					
						<div class="item">
							<div class="row-fluid">

								<div class="span6 right bgcol">
									<h3 style="margin-top: 106px; color:#383735";">
								Dr.Radhakrishnan Vidhyalaya 
									</h3>
									
									<p>Students dancing for a folk song at the annual day meet </p>
									
								</div>
								<div class="span6">
									<img src="<%=request.getContextPath()%>/image/DRKVS/slide8.jpg">
								</div>


							</div>
						</div>
						
					
						<div class="item">
							<div class="row-fluid">

								<div class="span6 right bgcol">
									<h3 style="margin-top: 106px; color:#383735";">
										Dr.Radhakrishnan Vidhyalaya 
									</h3>
									
									<p>Students at the physics lab accomplishing the experiments </p>
									
								</div>
								<div class="span6">
									<img src="<%=request.getContextPath()%>/image/DRKVS/slide9.jpg">
								</div>


							</div>
						</div>
				
					<div class="item">
							<div class="row-fluid">

								<div class="span6 right bgcol">
									<h3 style="margin-top: 106px; color:#383735";">
									Dr.Radhakrishnan Vidhyalaya 
									</h3>
									
									<p>Student at the Biology lab view different specimens </p>
									
								</div>
								<div class="span6">
									<img  src="<%=request.getContextPath()%>/image/DRKVS/slide10.jpg">
								</div>


							</div>
						</div>	
					
						<div class="item">
							<div class="row-fluid">

								<div class="span6 right bgcol">
									<h3 style="margin-top: 106px; color:#383735";">
									Dr.Radhakrishnan Vidhyalaya 
									</h3>
									
									<p>Honorary correspondent interacting with the students at the science exhibition </p>
									
								</div>
								<div class="span6">
									<img src="<%=request.getContextPath()%>/image/DRKVS/slide11.jpg">
								</div>


							</div>
						</div>
						
				
						<div class="item">
							<div class="row-fluid">

								<div class="span6 right">
									<h3 style="margin-top: 106px; color:#383735";">
									Dr.Radhakrishnan Vidhyalaya 
									</h3>
									
									<p>Honorary correspondent takes part in the Christmas and New year celebrations along with the students </p>
									
								</div>
								<div class="span6">
									<img src="<%=request.getContextPath()%>/image/DRKVS/slide12.jpg">
								</div>


							</div>
						</div>
						
					
						
						<div class="item">
							<div class="row-fluid">

								<div class="span6 right bgcol">
									<h3 style="margin-top: 106px; color:#383735";">
										Dr.Radhakrishnan Vidhyalaya  
									</h3>
									
									<p>Dignitary  garlanding the statue of Mahatma Gandhi</p>
									
								</div>
								<div class="span6">
									<img src="<%=request.getContextPath()%>/image/DRKVS/slide13.jpg">
								</div>


							</div>
						</div>
						</div>
						
					<a class="carousel-control left" href="#myCarousel" data-slide="prev">&lsaquo;</a>
					<a class="carousel-control right" href="#myCarousel"data-slide="next">&rsaquo;</a>
				</div>
						</div>

			</div>


			
		</div>


	<div class="contain1">
		<div class="pull-center">
			<div class="container">
				<div class="row-fluid" >
					<h3 class="bgcol" style="text-align:left"> Welcome to Dr.Radhakrishnan Vidhyalaya School </h3>
					<p style="text-align: justify;">The Trust is named after the Great Patriot & Freedom Fighter, 
					King Maker of India,Ex- Chief Minister of Tamilnadu and Founder of Education to our State of Tamilnadu,
					Sri.K.Kamarajar. The Matriculation School is named after the Great Patriot and Educationist Teacher, 
					Great Philosopher and Ex- President of our country Dr. Radhakrishnan.</p>
					
					<p style="text-align:justify;"> School was established in the heart of the SATTUR Town in the year 1991 by Kamaraj Children Educational Trust,
					 Sattur with the founder Trustee Shri. Babu A. Rajendran, with the prime aim of imparting the Best possible education 
					 with National and spiritual values for the needy students especially in Rural areas in and around SATTUR. 
					 The students are admitted from PRE - Kg to +2 standards.</p>
					 
					 
					<p style="text-align: justify;">All the R.K.V. School Teachers are dedicated in bringing-out the skills and talents
					 which are present within the students, by themselves realising them, step by step.  All such developments are
					 created by the enthusiastic and self motivated involvement of the Principal who is leading the Academic and
					 Non- Academic  (extra - Curricular) activities.</p>
					
					<p style="text-align: justify;">All the students are trained to be self - motivated and creative thinking to achieve their
					 around the World, though they were born and brought up in villages.</p>
					
				</div>					
				</div>
			</div>
		</div>
		
					<div class="container-fluid">
			<div class="row-fluid projects">
			
			
			
				<!-- news div start -->
				
				
				<div class="span3" style="margin-left: 159px";>	
					<div class="item afeature">
						<div>
							<div class="seperator">				
				<div class="row-fluid">
					<ul class="thumbnails">
						
						<li>
							
							<div class="ico-circle">
								<img  alt="responsive" src="image/DRKVS/news.png" width="92" height="92">
							</div>
							

							<h4>News</h4>
							<p class="bgcol1" style="padding-right:30px;">
								The Trust is named after the Great Patriot & Freedom Fighter, King Maker of India,Ex- Chief Minister of Tamilnadu and Founder of Education to our State of Tamilnadu, Sri.K.Kamarajar. The Matriculation School education with National Best possible life in our 
								<a href="#">..More<i class="icon-angle-right"></i> 
								</a>
							</p>
						</li>

						
					</ul>
				</div>
			</div>
						</div>
					</div>
				</div>
				
			<!-- news div end -->
				
				
			<!-- principal message div start -->
			
				
				<div class="span3">	
					<div class="item afeature">
						<div>
							<div class="seperator">				
				<div class="row-fluid">
					<ul class="thumbnails">
						
						<li>
							
							<div class="ico-circle">
								<img  alt="responsive" src="image/DRKVS/profile-01.jpg" width="92" height="92">
							</div>
							

							<h4>Principal  Message</h4>
							<p class="bgcol1" style="padding-right:30px;">
								All our students are happy and enthusiastic making the air around us cheerful. We make a point that each child has less burden, less tension thus leading stress free student life in our campus. They learn Skating, Yoga, campuslife in our campus
								<a href="#">..More<i class="icon-angle-right"></i>
								</a>
							</p>
						</li>

						
					</ul>
				</div>
			</div>
						</div>
					</div>
				</div>
				
				
		<!-- principal message div end -->	
		
		
		
			
		<!--  Announcements div start -->
		
		
		
			<div class="span3">	
					<div class="item afeature">
						<div>
							<div class="seperator">				
				<div class="row-fluid">
					<ul class="thumbnails">
						
						<li>							
							<div class="ico-circle">
								<img  alt="responsive" src="image/DRKVS/letter-closed.png" width="92" height="92">
							</div>
							<h4>Announcements</h4>
							<p class="bgcol1" style="padding-right:30px;">
								The School was established in the heart of the SATTUR Town in the year 1991 by Kamaraj Children Educational Trust, Sattur with the founder Trustee Shri. Babu  A. Rajendran, with the prime aim of imparting the Best possible education Yoga, campuslife
								<a href="#">..More<i class="icon-angle-right"></i>
								</a>
							</p>
						</li>						
					</ul>
				</div>
			</div>
						</div>
					</div>
				</div>
				
				
		
			
		
			</div>
		</div>
		
	<!-- footer div start -->
	<footer id="footer">
		<div class="container">
		<i
				class="icon-angle-up"></i></a>
			
			
			<div class="sfooter">
				<div class="row-fluid">
					<div class="span7">
						<p style="color:white;margin-left:-26px;">
							<a href="http://www.igrandee.com/" target="_blank">&nbsp; Powered by i-Grandee</a>
						</p>
						
					</div>
					<div class="span5">
						<ul class="inline pull-right">
							<li><a href="#">Terms</a></li>
							<li><a href="#">Privacy</a></li>
							<li><a href="Contact_DRKVS.jsp">Contact Us</a></li>
						</ul>
					</div>
				</div>
			</div>
		</div>
		</footer>
		
		<!-- footer div end -->
		
		
		
	

	<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-1.8.2.min.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/js/bootstrap.js"></script>
	
	<script src="js/jquery-1.8.2.min.js"></script>
    <script src="js/bootstrap/js/bootstrap.min.js"></script>
    <script src="js/jquery.flexslider.js"></script>
    <script src="js/jquery.tweet.js"></script>
    <script src="js/jflickrfeed.js"></script>
    
    <script src="http://maps.google.com/maps/api/js?sensor=true"></script>
    
    <script src="js/jquery.ui.map.min.js"></script>
    <script src="js/jquery.quicksand.js"></script>
	
	
	<script>
		!function($) {
			$(function() {
				// carousel demo
				$('#myCarousel').carousel();
			});
		}(window.jQuery)
	</script>
</body>
</html>
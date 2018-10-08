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
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/style.css">



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
                       							   										 
												</div>
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
								<li class="dropdown"><a href="<%=request.getContextPath()%>/index_DRKVS.jsp">Home	</a>
								<li><a href="<%=request.getContextPath()%>/Aboutus_DRKVS.jsp">About Us</a></li>							
								<li class="dropdown"><a href="#">Gallery</a></li>									
								<li class="dropdown"><a href="#">Academics</a></li>								
								<li class="dropdown"><a href="<%=request.getContextPath()%>/Contact_DRKVS.jsp">Contact Us </a></li>
							</ul>
						</div>

						
					</div>
				</div>

			<!-- 	<div class="flexslider">
                            <ul class="slides">
                                <li data-thumb="image/DRKVS/slide1.jpg">
                                    <img src="image/DRKVS/slide1.jpg">
                                    <p class="flex-caption">Students pay homage to former Chief minister of Tamil nadu Mr. k.Kamaraj. </p>
                                </li>
                                <li data-thumb="image/DRKVS/slide2.jpg">
                                    <img src="image/DRKVS/slide2.jpg">
                                    <p class="flex-caption">Dignitary unveiled a newly constructed building in the school premises
                                    </p>
                                </li>
                                <li data-thumb="image/DRKVS/slide3.jpg">
                                    <img src="image/DRKVS/slide3.jpg">
                                    <p class="flex-caption">Students make use of the Computer lab to showcase their creativity
                                    </p>
                                </li>
                                <li data-thumb="image/DRKVS/slide4.jpg">
                                    <img src="image/DRKVS/slide4.jpg">
                                    <p class="flex-caption">Students at the annual day meet perform random acts of yoga </p>
                                </li>
                               
                            </ul>
                        </div> -->
				<div id="myCarousel" class="carousel slide">
					<div class="carousel-inner">
						<div class="item active">
							<div class="row-fluid">
					
						<div class="item ">				
							<div class="row-fluid">
								<div class="span6 right bgcol">
									<h3 style="margin-top: 106px; color:#383735;">
										Dr.Radhakrishnan Vidhyalaya 
									</h3>
									<p>Students pay homage to former Chief minister of Tamil nadu Mr. k.Kamaraj. </p>
									
								</div>
								<div class="span6">
									<img src="<%=request.getContextPath()%>/image/DRKVS/slide1.jpg">
								</div>
							   </div>
						</div>
						</div>
						</div>
				
						<div class="item">
							<div class="row-fluid">
								<div class="span6 right bgcol">
									<h3 style="margin-top: 106px; color:#383735;">
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
									<h3 style="margin-top: 106px; color:#383735;">
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
									<h3 style="margin-top: 106px; color:#383735;">
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
									<h3 style="margin-top: 106px; color:#383735;">
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
									<h3 style="margin-top: 106px; color:#383735;">
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
									<h3 style="margin-top: 106px; color:#383735;">
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
									<h3 style="margin-top: 106px; color:#383735;">
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
									<h3 style="margin-top: 106px; color:#383735;">
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
									<h3 style="margin-top: 106px; color:#383735;">
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
									<h3 style="margin-top: 106px; color:#383735;">
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

								<div class="span6 right bgcol">
									<h3 style="margin-top: 106px; color:#383735;">
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
									<h3 style="margin-top: 106px; color:#383735;">
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
			<a class="carousel-control right" href="#myCarousel"
				data-slide="next">&rsaquo;</a>
				</div>
						</div></div></div>


	





<div class="contain1">
		<div class="pull-center">
			<div class="container">
				<div class="row-fluid" >
					

<!-- Page Title div start -->
	
	
        <div class="page-title">
            <div class="container">
                <div class="row">
                    <div class="span12"><hr>
                        <i class="icon-envelope-alt page-title-icon"></i>
                        <h2>Contact Us</h2>
                      	<hr>
                    </div>
                </div>
            </div>
        </div>
	<!--Page Title div end  -->				
					
	 <!-- Contact Us -->
        <div class="contact-us container">
            <div class="row-fluid">
            
            <div class="span12">
            
            <div class="span7">
            
             <div class="contact-address">
                    <h4>We Are Here</h4>           
                    
                
                  <!-- map div start -->  
                    <div class="map span12">
                   <iframe src="http://www.map-generator.org/1e8f7a68-2217-4055-8415-2eac802cfa8b/iframe-map.aspx" scrolling="no" height="240px" width="620px" frameborder="0" scrolling="no" marginheight="0" marginwidth="0"></iframe><br><small><a href="http://www.map-generator.org/1e8f7a68-2217-4055-8415-2eac802cfa8b/large-map.aspx" target="_blank">Open large map<a/></small>
	                   
                   	 </div>
				 <!-- map div end --> 
                </div>
            
            </div>
            <div class="span4">            
             <h4>Address</h4>
				<div class="footcolor">
				<br>
					<address>
					
					 <strong>DR. RADHAKRISHNAN VIDHYALAYA MATRIC. HR.SEC.SCHOOL, </strong><br> 
					 
					<abbr title="address"> <i class="icon-pushpin i-org"></i></abbr> 
					126, Railway Feeder Road, Sattur- 626 203, Tamilnadu, India. <br>
					<abbr title="phone"> <i class="icon-phone i-org"></i></abbr>				9786737071<br>
					<abbr title="Email"><i class="icon-envelope i-org"></i></abbr>
					<a href="#">info@drkvs.com</a><br>
					<a href="http://www.drradhakrishnanvidhyalaya.com/" target="_blank" >www.drradhakrishnanvidhyalaya.com</a>
					</address>				
				</div>
           	</div>  
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
	
	<script src="<%=request.getContextPath()%>/js/jquery-1.8.2.min.js"></script>
    <script src="<%=request.getContextPath()%>/js/jquery.flexslider.js"></script>
    <script src="<%=request.getContextPath()%>/js/jquery.tweet.js"></script>
    <script src="<%=request.getContextPath()%>/js/jflickrfeed.js"></script>
    <script src="http://maps.google.com/maps/api/js?sensor=true"></script>
    <script src="<%=request.getContextPath()%>/js/jquery.ui.map.min.js"></script>
    <script src="<%=request.getContextPath()%>/js/jquery.quicksand.js"></script>
    <script src="<%=request.getContextPath()%>/js/scripts.js"></script>
	
	
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
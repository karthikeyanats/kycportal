<html>
<head>
<script language="javascript">
function showfun()
{
f1.action="dbcheck.jsp";
f1.submit();
}

function deletefun()
{
	if(confirm("Hi Buddy!, you have clicked Delete Button. So, Plz confirm once again, what you did?!."))
	{
	f1.action="dbcheckdel.jsp";
	f1.submit();
	}
}
</script>
</head>
<body>
<form name=f1 method="post">
<a class=tablebold>Type query here ..</a>
<input type=text name="req_query"  size="70" class=tablelight><br>
<input type=button name=but value ="Submit Query" onclick=showfun()>
<input type=button name=but value ="Delete Query" onclick=deletefun()>

</form>
</body>
</html>
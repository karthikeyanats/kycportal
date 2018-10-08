<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<head>
<script lanaguage="javascript">
function funs()
{
var frm = document.getElementById('f11');

frm.action=document.getElementById("returnurl1").value;
alert(frm.action);

}
</script>
</head>
<body>
<form name="f11" id="f11" method="post">
<input type="button" name=but value="go" onclick=funs()>
<input type="text" id="returnurl1" value="jsp/MasterEntries/Lesson/LessonCreation.jsp">

</form>
</body>
</html>
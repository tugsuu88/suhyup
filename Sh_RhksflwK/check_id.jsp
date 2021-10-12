<%@ page import="java.util.*, java.text.*, Bean.Front.Common.*"  contentType="text/html;charset=euc-kr"%>
<%@ page import="util.*" %>
<jsp:useBean id="FrontBoard"  scope="request" class="Bean.Front.Common.FrontBoradType1"/>
<jsp:useBean id="FrontDbUtil" scope="request" class="Bean.Front.Common.FrontDbUtil"/>


<%
	try{
	    String return_field = Converter.nullchk(request.getParameter("return"));
	    String id = Converter.nullchk(request.getParameter("id"));
	   // String sh_div = Converter.nullchk(request.getParameter("sh_div"));
	    String values = Converter.nullchk(request.getParameter("values"));
	    
	    //null check
	    if (values == null ) values ="";
	        
		//if (sh_div == null) sh_div = (String)session.getValue("MEM_FLAG");
	
	    String TableName="";
	    String SelectCondition = null;
	    String WhereCondition = null;
	    String OrderCondition = null;
	    int search_flag = 1;
	    String Zip = null;
	    int PAGE = 0;                                   // default page value of PAGE;
	    Vector  ResultVector;
	
		if (id==null) id = "";
	
	    // define query string of each part value
		TableName = " sh_minwon_admin";
	    SelectCondition = " sh_id ";
	    WhereCondition  = " where sh_id = '" + id + "'";
	    OrderCondition  = " ";
	    
	    
	    ResultVector = FrontBoard.list(TableName, SelectCondition, WhereCondition, OrderCondition, PAGE, 1);
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html>
<head>
<title>수협</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<link rel='stylesheet' type='text/css' media='all' href='../css/screen.css' />
<link rel='stylesheet' type='text/css' media='all' href='../css/member.css' />
<style>
body {
	background:none;
}
</style>

	<script language="javascript">
	<!--
		function form_submit(){
			var d=document.form;
			if (d.id.value.length == 0){
				alert("아이디를 입력해주세요");
				return;
			}else{
				d.submit();
			}
		}
		
		
		function keyEnter() {
			var keycode = event.keyCode 
			var realkey = String.fromCharCode(event.keyCode);
			if(keycode==13)	 form_submit();
		}
		
		function LoadSubmit() {
			if (document.form.id.value.length != 0 ) {
				form_submit();
			}
		}
	//-->	
	</script>

</head>

<body id="popup">
<form name="form" onSubmit="return(false);form_submit()" onKeyPress="keyEnter();">
		<input type="hidden" name="return" value="<%=return_field%>">
<table cellspacing="0" align="center" id="cwt">
<tr>
	<td>
	<p class="title"><img src="img/id_check_title.gif"></p>
	<p class="input clear">
		<label for="file">아이디</label>
		<input type="text" class="typeText" style="width:100px;" name="id" value="<%=id%>" />
		<a style="cursor:hand;" onClick="form_submit()"><img src="../images/btT01Search.gif" title="" style="padding-top:6px;"></img></a>
	</p>
	<p class="comment" style="height:60px; line-height:20px;text-align:center;">
		<% if( ResultVector.size() > 0 && !id.equals("")){  %>
			검색하신 아이디는 사용 할 수 없습니다.<br />
			다시 검색하여 주십시요!</a>
		<% } else if( ResultVector.size() == 0 && !id.equals("")){ %>
			검색하신 아이디는 사용 할 수 있습니다.	
		<% } else { %>		
			아이디를 입력해 주세요.
		<% } %>
	</p>
	
	<p class="btn">
		<% if( ResultVector.size() == 0 && !id.equals("")){ %>
			<a href="javascript:setId('<%=id %>')"><img src="../pub_img/btT01Confirm.gif"  title="확인"></img></a>
			<script>
				function setId(userId){
					opener.f.sh_id.value = userId;		
					self.close();		
				}
			</script>
		<% } else { %>
			<a href="javascript:self.close();"><img src="../pub_img/btT01Confirm.gif"  title="확인"></img></a>
		<% } %>
	</p>
	</td>
</tr>
</table>
</form>
</body>
</html>

<% 
	} catch(Exception e) {
		out.println("id_search.jsp : " + e.getMessage());
	} finally {

	}
%> 
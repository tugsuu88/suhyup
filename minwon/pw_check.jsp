<%@ page import="java.util.*, util.*" contentType="text/html;charset=euc-kr"%>



<jsp:useBean id="FrontBoard" scope="request" class="Bean.Front.Common.FrontBoradType1"/>

<jsp:useBean id="FrontDbUtil" scope="request" class="Bean.Front.Common.FrontDbUtil"/>

<jsp:useBean id="AdminInfo" scope="request" class="board.admin.AdminInfo"/>



<%@ include file="../inc/requestSecurity.jsp" %>

<% String pageNum = "5"; %>


<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">


<head>


<meta http-equiv="Expires" content="0" />


<meta http-equiv="Cache-Control" content="no-cache" />
<meta http-equiv="Pragma" content="no-cache" />


<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />





<%	


	String passwd = request.getParameter("passwd");


	if(passwd == null) passwd="";



	String name = request.getParameter("name");

	if(name == null) name="";



	String TableName = " sh_minwon ";

	String SelectCondition = null;


    String WhereCondition = null;


    String OrderCondition = null;



	int TotalRecordCount = 0;




	// 1. 비밀번호 체크	

    WhereCondition = " where passwd = '"+passwd+"' and name = '"+name+"'";

	TotalRecordCount = FrontBoard.TotalCount(TableName, WhereCondition);


	


	if(TotalRecordCount < 1){


		%>


		   <script language='javascript'>


		   	alert('비밀번호를 정확히 입력해주십시오.');


			history.go(-1);

	       </script>


		<%		        


		if ( true ) return;	


	}else{

		%>

		<script language='javascript'>

			pbform.action= "shingo_test_list.jsp";

		</script>

	<%

	}	   


%>


</head>


<body>	


	<form name="pbform" action="" method="post">


		<input type="hidden" name="name" value="<%=name%>" />


		<input type="hidden" name="passwd" value="<%=passwd%>" />

	</form>

</body>


</html>
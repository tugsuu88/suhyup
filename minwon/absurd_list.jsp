<%@ page import="java.util.*, util.*" contentType="text/html;charset=euc-kr"%>



<jsp:useBean id="FrontBoard" scope="request" class="Bean.Front.Common.FrontBoradType1"/>

<jsp:useBean id="FrontDbUtil" scope="request" class="Bean.Front.Common.FrontDbUtil"/>

<jsp:useBean id="AdminInfo" scope="request" class="board.admin.AdminInfo"/>



<%@ include file="../inc/requestSecurity.jsp" %>

<% String pageNum = "5"; %>

<%



		String name = request.getParameter("name");

		if(name == null) name="";



		String telephone = Converter.nullchk(request.getParameter("telephone"));



		String sh_tel_1 = request.getParameter("sh_tel_1");

		if(sh_tel_1 == null) sh_tel_1="";



		String sh_tel_2 = request.getParameter("sh_tel_2");

		if(sh_tel_2 == null) sh_tel_2="";



		String sh_tel_3 = request.getParameter("sh_tel_3");

		if(sh_tel_3 == null) sh_tel_3="";



		String tel ="";

		if(sh_tel_1.equals("")){

			tel =  request.getParameter("tel");

		}

		else{

			tel = sh_tel_1 + "-" + sh_tel_2 + "-" + sh_tel_3;

		}



		if(tel == null) tel ="";



		String passwd = request.getParameter("passwd");

		if(passwd == null) passwd="";



		String ListPage = request.getParameter("ListPage");

		//String pageNum = request.getParameter("pageNum");

		String myPage = request.getRequestURI();



		int PAGE = 1;



	    String TableName = " sh_financetrouble ";

	    String SelectCondition = null;

	    String WhereCondition = null;

	    String OrderCondition = null;



		if (request.getParameter("PAGE") == null || ((String)request.getParameter("PAGE")).equals("")){

			PAGE = 1;

	    }else{

			PAGE = Integer.parseInt(request.getParameter("PAGE"));

	    }



	    SelectCondition = " thid, name, title, code, to_char(time1, 'YYYY-MM-DD') AS time1, to_char(time2, 'YYYY-MM-DD') AS time2, to_char(abandon_date, 'YYYY-MM-DD') AS abandon_date ";

	    OrderCondition  = " ORDER BY thid DESC ";



		if(telephone.equals("휴대폰")){

			WhereCondition = " where name = '"+name+"' and tel = '"+tel+"' and parcode = 2";

		}else if(telephone.equals("전화번호")){

			WhereCondition = " where name = '"+name+"' and tel1 = '"+tel+"' and parcode = 2";

		}



		int StartRecord = 0;

		int EndRecord   = 0;

		int DefaultListRecord = 10;

		int DefaultPageBlock = 10;



		int TotalRecordCount = FrontBoard.TotalCount(TableName, WhereCondition);





		//out.print("TotalRecordCount : " + TotalRecordCount + "<br/><br/>");

		///////////////////////////////////////////////////////////////////////////



%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"   "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
	<title>금융사고/금융부조리 신고 &gt; 신고센터 &gt; 고객지원 &gt; 수협</title>
	<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge" /><link rel="stylesheet" type="text/css" href="/css/screen.css" />
	<script type="text/javascript" src="/js/jquery-1.7.2.min.js"></script>
	<script type="text/javascript" src="/js/public.js"></script>
	<script type="text/javascript" src="/js/common.js"></script>

<script type="text/javascript" src="../js/quickMenu.js"></script>

<script type="text/javascript">

<!--

	function goView(mid){

		d.mid.value=mid;

		d.action = "absurd_view.jsp";

		d.submit();

	}



//-->

</SCRIPT>

</head>

<body id="shingo01">

	<!-- header -->
	<%@ include file="/include/shHeader.jsp" %>
	<!-- //header -->

<form method=post name="d" action="">

<INPUT TYPE="hidden" NAME="mid" />

<INPUT TYPE="hidden" NAME="telephone" value="<%=telephone%>" />

	<!-- container -->
	<div id="ContentLayer">
	
		<!-- LNB -->
		<%@ include file="/include/lnbService.jsp" %>
		<!-- //LNB -->
		
		<!-- contents -->
		<div id="primaryContent">
			<p class="indicate"><span class="shHome">수협</span><span>고객지원</span><span>신고센터</span>금융사고/금융부조리 신고</p>
			<h3>금융사고/금융부조리 신고</h3>	
<!--			<div class="thisComment">-->       <!-- 20170728 수정 -->
				<h4 class="dpNone">금융부조리 신고</h4>

		
			<table class="list" cellpadding="0" cellspacing="0" summary="">
				<caption></caption>
				<colgroup>
					<col width="10%" />
					<col width="*" />
					<col width="11%" />
					<col width="11%" />
					<col width="11%" />
					<col width="11%" />
				</colgroup>
				<thead>
					<tr>
						<th scope="col">번호</th>
						<th scope="col">제목</th>
						<th scope="col">처리상태</th>
						<th scope="col">작성자</th>
						<th scope="col">작성일</th>
						<th class="last" scope="col">답변일</th>
					</tr>
				</thead>
				<tbody>
	<%

		Vector ResultVector = FrontBoard.list(TableName, SelectCondition, WhereCondition, OrderCondition, PAGE, 0, DefaultListRecord);



		String sh_mid = "";

	    String sh_name = "";

		String sh_date = "";

		String sh_reply = "";

		String abandon_date = "";

		String sh_code = "";



	    if( ResultVector.size() > 0){

			for (int i=0; i < ResultVector.size();i++){

				Hashtable h = (Hashtable)ResultVector.elementAt(i);



				String TITLE = (String)h.get("TITLE");	//제목

				if (TITLE.length() > 31){

					TITLE = TITLE.substring(0,31);

					TITLE += "...";

				}



				sh_mid = (String)h.get("THID");

				sh_name = (String)h.get("NAME");

				sh_date = (String)h.get("TIME1");

				sh_reply = (String)h.get("TIME2");

				abandon_date = (String)h.get("ABANDON_DATE");

				sh_code = (String)h.get("CODE");



				//int listnum = DefaultListRecord * (PAGE - 1) + i + 1;	 //글번호 계산

				int listnum = (TotalRecordCount) - (i + (DefaultListRecord * (PAGE - 1)));	//글번호 계산(역순)



	%>
					<tr>
						<td><%=listnum%></td>
						<td class="title"><a href="javascript:goView('<%=sh_mid%>')"><%=TITLE%></a></td>
						<td>
							<%if(sh_code.equals("반송") || sh_code.equals("이첩")){%>
								처리중
							<% } else{ %>
								<%=sh_code%>
							<% } %>
						</td>
						<td><%=sh_name%></td>
						<td><%=sh_date%></td>
						<td>
							<%if("철회완료".equals(sh_code)){ %>
								<%=abandon_date%>
							<%}else{ %>
								<%=sh_reply%>
							<%} %>
						</td>
					</tr>
		 	<%

					}

				} else {

			%>
					<tr>
						<td class="noData" colspan="4">등록 자료가 없습니다.</td>
					</tr>
			<%

				}

			%>
				</tbody>
			</table>
		</div>
		<!-- //contents -->
	</div>
	<!-- //container -->
	<!-- footer -->
	<%@ include file="/include/shFooter.jsp" %>
	<!-- //footer -->
</form>
</body>
</html>
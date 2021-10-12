<%@ page import="java.util.*, util.*" contentType="text/html;charset=euc-kr"%>



<jsp:useBean id="FrontBoard" scope="request" class="Bean.Front.Common.FrontBoradType1"/>

<jsp:useBean id="FrontDbUtil" scope="request" class="Bean.Front.Common.FrontDbUtil"/>

<jsp:useBean id="AdminInfo" scope="request" class="board.admin.AdminInfo"/>



<%@ include file="../inc/requestSecurity.jsp" %>

<%@ include file="/inc/xssCheck.jsp" %>

<%
	String pageNum = "5";
	String ref = request.getHeader("REFERER");

	if(ref==null){
		String RedirectURL = "/index.jsp";	
		response.sendRedirect(RedirectURL);
		
	}


		String name = request.getParameter("name");

		if(name == null) name="";

		name = name.replaceAll("&", "");

		name = name.replaceAll("\'", "");

		name = name.replaceAll("<", "");

		name = name.replaceAll(">", "");

		name = name.replaceAll("-", "");

		name = name.replaceAll("%", "");

		String telephone = Converter.nullchk(request.getParameter("telephone"));



		String sh_tel_1 = request.getParameter("sh_tel_1");

		if(sh_tel_1 == null) sh_tel_1="";

		sh_tel_1 = sh_tel_1.replaceAll("'", "");

		sh_tel_1 = sh_tel_1.replaceAll("&", "");

		sh_tel_1 = sh_tel_1.replaceAll("\'", "");

		sh_tel_1 = sh_tel_1.replaceAll("<", "");

		sh_tel_1 = sh_tel_1.replaceAll(">", "");

		sh_tel_1 = sh_tel_1.replaceAll("-", "");

		sh_tel_1 = sh_tel_1.replaceAll("%", "");



		String sh_tel_2 = request.getParameter("sh_tel_2");

		if(sh_tel_2 == null) sh_tel_2="";

		sh_tel_2 = sh_tel_2.replaceAll("'", "");

		sh_tel_2 = sh_tel_2.replaceAll("&", "");

		sh_tel_2 = sh_tel_2.replaceAll("\'", "");

		sh_tel_2 = sh_tel_2.replaceAll("<", "");

		sh_tel_2 = sh_tel_2.replaceAll(">", "");

		sh_tel_2 = sh_tel_2.replaceAll("-", "");

		sh_tel_2 = sh_tel_2.replaceAll("%", "");



		String sh_tel_3 = request.getParameter("sh_tel_3");

		if(sh_tel_3 == null) sh_tel_3="";

		sh_tel_3 = sh_tel_3.replaceAll("'", "");

		sh_tel_3 = sh_tel_3.replaceAll("&", "");

		sh_tel_3 = sh_tel_3.replaceAll("\'", "");

		sh_tel_3 = sh_tel_3.replaceAll("<", "");

		sh_tel_3 = sh_tel_3.replaceAll(">", "");

		sh_tel_3 = sh_tel_3.replaceAll("-", "");

		sh_tel_3 = sh_tel_3.replaceAll("%", "");





		String tel ="";

		if(sh_tel_1.equals("")){

			tel =  Converter.nullchk(request.getParameter("tel"));

		}

		else{

			tel = sh_tel_1 + "-" + sh_tel_2 + "-" + sh_tel_3;

		}



		if(tel == null) tel ="";



		String passwd = request.getParameter("passwd");

		if(passwd == null) passwd="";

		passwd = passwd.replaceAll("'", "");

		passwd = passwd.replaceAll("&", "");

		passwd = passwd.replaceAll("\'", "");

		passwd = passwd.replaceAll("<", "");

		passwd = passwd.replaceAll(">", "");

		passwd = passwd.replaceAll("-", "");

		passwd = passwd.replaceAll("%", "");



		String ListPage = Converter.nullchk(request.getParameter("ListPage"));

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



		if(telephone.equals("�޴���")){

			WhereCondition = " where name = '"+name+"' and tel = '"+tel+"' and parcode = 3";

		}else if(telephone.equals("��ȭ��ȣ")){

			WhereCondition = " where name = '"+name+"' and tel1 = '"+tel+"' and parcode = 3";

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
	<title>�鼼���� �������� �Ű� &gt; �Ű����� &gt; �������� &gt; ����</title>
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

		d.action = "taxfree_view.jsp";

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
			<p class="indicate"><span class="shHome">����</span><span>��������</span><span>�Ű�����</span>�鼼���� �������� �Ű�</p>
			<h3>�鼼���� �������� �Ű�</h3>	
		
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
						<th scope="col">��ȣ</th>
						<th scope="col">����</th>
						<th scope="col">ó������</th>
						<th scope="col">�ۼ���</th>
						<th scope="col">�ۼ���</th>
						<th class="last" scope="col">�亯��</th>
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



				String TITLE = (String)h.get("TITLE");	//����

				if (TITLE.length() > 31){

					TITLE = TITLE.substring(0,31);

					TITLE += "...";

				}



				sh_mid = (String)h.get("THID");

				sh_name = (String)h.get("NAME");
				
				if(sh_name != null && !sh_name.equals(""))
					sh_name = sh_name.replaceAll("<", "&lt;").replaceAll(">", "&gt;");

				sh_date = (String)h.get("TIME1");

				sh_reply = (String)h.get("TIME2");
				
				if ( sh_reply != null ) {
					sh_reply = sh_reply.replaceAll("<","&lt;");
					sh_reply = sh_reply.replaceAll(">","&gt;");
				} else {
					return;
				}

				abandon_date = (String)h.get("ABANDON_DATE");

				sh_code = (String)h.get("CODE");

				int listnum = (TotalRecordCount) - (i + (DefaultListRecord * (PAGE - 1)));	//�۹�ȣ ���(����)


	%>
					<tr>
						<td><%= listnum %></td>
						<td class="title"><a href="javascript:goView('<%= xss_Check(sh_mid) %>')"><%= xss_Check(TITLE) %></a></td>
						<td>
							<% if(sh_code.equals("�ݼ�") || sh_code.equals("��ø")){ %>
								ó����
							<% } else { %>
								<%= xss_Check(sh_code) %>
							<% } %>
						</td>
						<td><%= xss_Check(sh_name) %></td>
						<td><%= xss_Check(sh_date) %></td>
						<td>
							<% if("öȸ�Ϸ�".equals(sh_code)){ %>
								<%= abandon_date %>
							<% }else{ %>
								<%= sh_reply %>
							<% } %>
						</td>
					</tr>
			 <%

					}

				} else {

			%>
					<tr>
						<td class="noData" colspan="6">��� �ڷᰡ �����ϴ�.</td>
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

</form>

	<!-- footer -->
	<%@ include file="/include/shFooter.jsp" %>
	<!-- //footer -->
</body>
</html>
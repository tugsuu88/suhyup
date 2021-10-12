<%@ page import="java.util.*, util.*"%>

<%@ page contentType="text/html;charset=euc-kr"%>
<% request.setCharacterEncoding("euc-kr"); %>
<% response.setContentType("text/html; charset=euc-kr"); %>

<jsp:useBean id="FrontBoard" scope="request" class="Bean.Front.Common.FrontBoradType1"/>
<jsp:useBean id="FrontDbUtil" scope="request" class="Bean.Front.Common.FrontDbUtil"/>
<jsp:useBean id="AdminInfo" scope="request" class="board.admin.AdminInfo"/>

<%@ include file="/inc/requestSecurity.jsp" %>

<% String pageNum = "5"; %>

<%

		String name = request.getParameter("sg_name");
		if(name == null) name="";
		name = name.replaceAll("'", "");
		name = name.replaceAll("&", "");
		name = name.replaceAll("\'", "");
		name = name.replaceAll("<", "");
		name = name.replaceAll(">", "");
		name = name.replaceAll("-", "");
		name = name.replaceAll("%", "");

		String telephone = Converter.nullchk(request.getParameter("telephone"));

		String sh_tel_1 = request.getParameter("sg_tel1");
		if(sh_tel_1 == null) sh_tel_1="";
		sh_tel_1 = sh_tel_1.replaceAll("'", "");
		sh_tel_1 = sh_tel_1.replaceAll("&", "");
		sh_tel_1 = sh_tel_1.replaceAll("\'", "");
		sh_tel_1 = sh_tel_1.replaceAll("<", "");
		sh_tel_1 = sh_tel_1.replaceAll(">", "");
		sh_tel_1 = sh_tel_1.replaceAll("-", "");
		sh_tel_1 = sh_tel_1.replaceAll("%", "");

		String sh_tel_2 = request.getParameter("sg_tel2");
		if(sh_tel_2 == null) sh_tel_2="";
		sh_tel_2 = sh_tel_2.replaceAll("'", "");
		sh_tel_2 = sh_tel_2.replaceAll("&", "");
		sh_tel_2 = sh_tel_2.replaceAll("\'", "");
		sh_tel_2 = sh_tel_2.replaceAll("<", "");
		sh_tel_2 = sh_tel_2.replaceAll(">", "");
		sh_tel_2 = sh_tel_2.replaceAll("-", "");
		sh_tel_2 = sh_tel_2.replaceAll("%", "");

		String sh_tel_3 = request.getParameter("sg_tel3");
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
			tel =  request.getParameter("sg_tel");
			System.out.println("tel a = " + tel);
		}else{
			tel = sh_tel_1 + "-" + sh_tel_2 + "-" + sh_tel_3;
			System.out.println("tel b = " + tel);
		}
		System.out.println("tel 0 = " + tel);
		
		if(tel == null) tel ="";
		
		String passwd = request.getParameter("sg_pass");
		if(passwd == null) passwd="";
		passwd = passwd.replaceAll("'", "");
		passwd = passwd.replaceAll("&", "");
		passwd = passwd.replaceAll("\'", "");
		passwd = passwd.replaceAll("<", "");
		passwd = passwd.replaceAll(">", "");
		passwd = passwd.replaceAll("-", "");
		passwd = passwd.replaceAll("%", "");
		
// 		System.out.println("tel = " + request.getParameter("tel"));
// 		System.out.println("sg_tel = " + request.getParameter("sg_tel"));
// 		System.out.println("sg_name = " + request.getParameter("sg_name"));
// 		System.out.println("sg_tel1 = " + request.getParameter("sg_tel1"));
// 		System.out.println("sg_tel2 = " + request.getParameter("sg_tel2"));
// 		System.out.println("sg_tel3 = " + request.getParameter("sg_tel3"));
// 		System.out.println("sg_pass = " + request.getParameter("sg_pass"));

		String ListPage = Converter.nullchk(request.getParameter("ListPage"));

		String myPage = request.getRequestURI();

		int PAGE = 1;

	    String TableName = " sh_chungtak ";
	    String SelectCondition = null;
	    String WhereCondition = null;
	    String OrderCondition = null;

		if (request.getParameter("PAGE") == null || ((String)request.getParameter("PAGE")).equals("")){
			PAGE = 1;
	    }else{
			PAGE = Integer.parseInt(request.getParameter("PAGE"));
	    }
		
	    SelectCondition = " thid, sg_name, title, ct_content, code, to_char(time1, 'YYYY-MM-DD') AS time1, to_char(time2, 'YYYY-MM-DD') AS time2, to_char(abandon_date, 'YYYY-MM-DD') AS abandon_date ";
	    OrderCondition  = " order by thid desc ";
	    WhereCondition = " where sg_name = '"+name+"' and sg_tel = '"+tel+"' and parcode = 6";

		int StartRecord = 0;
		int EndRecord   = 0;
		int DefaultListRecord = 10;
		int DefaultPageBlock = 10;
		int TotalRecordCount = FrontBoard.TotalCount(TableName, WhereCondition);

// 		System.out.print("TotalRecordCount : " + TotalRecordCount + "<br/><br/>");

		///////////////////////////////////////////////////////////////////////////
		
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"   "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
	<title>�������/���������� �Ű� &gt; �Ű��� &gt; ������ &gt; ����</title>
	<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge" /><link rel="stylesheet" type="text/css" href="/css/screen.css" />
	<script type="text/javascript" src="/js/jquery-1.7.2.min.js"></script>
	<script type="text/javascript" src="/js/public.js"></script>
	<script type="text/javascript" src="/js/common.js"></script>
	<script type="text/javascript" src="/js/quickMenu.js"></script>
	
	
	
<%
	if(TotalRecordCount == 0){
%>
	<script type="text/javascript">
		alert("��ϵ� ���� �����ϴ�.");
		history.back(-1);
	</script>
<%
	}
%>

<script type="text/javascript">



<!--

	function goView(nval){
		d.mid.value = nval;
		d.action = "chungtak_view.jsp";
		d.submit();
	}

//-->

</script>

</head>

<body id="shingo01">

	<!-- header -->
	<%@ include file="/include/shHeader.jsp" %>
	<!-- //header -->

	<form method="post" name="d" action="">
	
	<input type="hidden" name="mid" />
	<input type="hidden" name="telephone" value="<%=telephone%>" />
	
		<!-- container -->
		<div id="ContentLayer">
			<!-- LNB -->
			<%@ include file="/include/lnbService.jsp" %>
			<!-- //LNB -->
			<!-- contents -->
			<div id="primaryContent">
				<p class="indicate"><span class="shHome">����</span><span>������</span><span>�Ű���</span>ûŹ������ ���� �Ű�</p>
				<h3>ûŹ������ ���� �Ű�</h3>
				<table class="list" cellpadding="0" cellspacing="0" summary="ûŹ������ ���� �Ű� ����Ʈ�Դϴ�.">
					<caption>ûŹ������ ���� �Ű� ���</caption>
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
					sh_name = (String)h.get("SG_NAME");
					sh_date = (String)h.get("TIME1");
					sh_reply = (String)h.get("TIME2");
					abandon_date = (String)h.get("ABANDON_DATE");
					sh_code = (String)h.get("CODE");
	
					//int listnum = DefaultListRecord * (PAGE - 1) + i + 1;	 //�۹�ȣ ���
	
					int listnum = (TotalRecordCount) - (i + (DefaultListRecord * (PAGE - 1)));	//�۹�ȣ ���(����)
	
		%>
						<tr>
							<td><%=listnum%></td>
							<td class="title"><a href="javascript:goView('<%=sh_mid%>')"><%=TITLE%></a></td>
						<%if(sh_code.equals("�ݼ�") || sh_code.equals("��ø")){%>
							<td>ó����</td>
						<% } else{ %>
							<td><%=sh_code%></td>
						<% } %>
							<td><%=sh_name%></td>
							<td><%=sh_date%></td>
						 <%if("öȸ�Ϸ�".equals(sh_code)){ %>
							<td><%=abandon_date%></td>
						<%}else{ %>
							<td><%=sh_reply%></td>
						<%} %>
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
		<!-- footer -->
		<%@ include file="/include/shFooter.jsp" %>
		<!-- //footer -->
	</form>
</body>
</html>
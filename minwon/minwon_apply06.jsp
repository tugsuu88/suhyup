<%@ page import="java.util.*, util.*" %>
<%@ page contentType="text/html;charset=euc-kr" %>
<% request.setCharacterEncoding("euc-kr"); %>
<% response.setContentType("text/html; charset=euc-kr"); %>
 
 
<jsp:useBean id="FrontBoard" scope="request" class="Bean.Front.Common.FrontBoradType1"/>
<jsp:useBean id="FrontDbUtil" scope="request" class="Bean.Front.Common.FrontDbUtil"/>
<jsp:useBean id="AdminInfo" scope="request" class="board.admin.AdminInfo"/>
<jsp:useBean id="aes" scope="request" class="Bean.Front.Common.AES256Util" />

<%@ include file="../inc/requestSecurity.jsp" %>
<% String pageNum = "5"; %>
<%
	
	String ref = request.getHeader("REFERER");	if(ref==null){		String RedirectURL = "/index.jsp";			response.sendRedirect(RedirectURL);	}
		String name = request.getParameter("name");
		if(name == null) name="";
		name = name.replaceAll("'", "");
		name = name.replaceAll("&", "");
		name = name.replaceAll("\'", "");
		name = name.replaceAll("<", "");
		name = name.replaceAll(">", "");
		name = name.replaceAll("-", "");
		name = name.replaceAll("%", "");
		
		String telephone = request.getParameter("telephone");
		if(telephone == null) telephone="";
		telephone = telephone.replaceAll("'", "");
		telephone = telephone.replaceAll("&", "");
		telephone = telephone.replaceAll("\'", "");
		telephone = telephone.replaceAll("<", "");
		telephone = telephone.replaceAll(">", "");
		telephone = telephone.replaceAll("-", "");
		telephone = telephone.replaceAll("%", "");
		
		String mobile = "";				
		String sh_han_1 = request.getParameter("sh_han_1");
		
		System.out.println("########"+sh_han_1);
		if(sh_han_1 == null) sh_han_1="";
		sh_han_1 = sh_han_1.replaceAll("'", "");
		sh_han_1 = sh_han_1.replaceAll("&", "");
		sh_han_1 = sh_han_1.replaceAll("\'", "");
		sh_han_1 = sh_han_1.replaceAll("<", "");
		sh_han_1 = sh_han_1.replaceAll(">", "");
		sh_han_1 = sh_han_1.replaceAll("-", "");
		sh_han_1 = sh_han_1.replaceAll("%", "");
		
		String sh_han_2 = request.getParameter("sh_han_2");
		if(sh_han_2 == null) sh_han_2="";
		sh_han_2 = sh_han_2.replaceAll("'", "");
		sh_han_2 = sh_han_2.replaceAll("&", "");
		sh_han_2 = sh_han_2.replaceAll("\'", "");
		sh_han_2 = sh_han_2.replaceAll("<", "");
		sh_han_2 = sh_han_2.replaceAll(">", "");
		sh_han_2 = sh_han_2.replaceAll("-", "");
		sh_han_2 = sh_han_2.replaceAll("%", "");
		
		String sh_han_3 = request.getParameter("sh_han_3");
		if(sh_han_3 == null) sh_han_3="";
		sh_han_3 = sh_han_3.replaceAll("'", "");
		sh_han_3 = sh_han_3.replaceAll("&", "");
		sh_han_3 = sh_han_3.replaceAll("\'", "");
		sh_han_3 = sh_han_3.replaceAll("<", "");
		sh_han_3 = sh_han_3.replaceAll(">", "");
		sh_han_3 = sh_han_3.replaceAll("-", "");
		sh_han_3 = sh_han_3.replaceAll("%", "");
		
		if(sh_han_1.equals("")){
			mobile =  Converter.nullchk(request.getParameter("mobile"));
		} else {	
			mobile = sh_han_1 + "-" + sh_han_2 + "-" + sh_han_3;
		}
		
		if(mobile == null) {
			mobile ="";	
		}
		
		
		
		String passwd = request.getParameter("passwd");			
		 
		if(passwd == null) passwd="";		
		
	passwd = aes.aesEncode(passwd); 
	String ListPage = Converter.nullchk(request.getParameter("ListPage"));
	//String pageNum = request.getParameter("pageNum");
	String myPage = request.getRequestURI();

	int PAGE = 1;
	String TableName = " sh_minwon ";
	String SelectCondition = null;
	String WhereCondition = null;
	String OrderCondition = null;

	if (request.getParameter("PAGE") == null || ((String) request.getParameter("PAGE")).equals("")) {
		PAGE = 1;
	} else {
		PAGE = Integer.parseInt(request.getParameter("PAGE"));
	}
	SelectCondition = " mid, name, subject, status,fname, to_char(creation_date, 'YYYY-MM-DD') AS creation_date, to_char(answer_date, 'YYYY-MM-DD') AS answer_date, to_char(abandon_date, 'YYYY-MM-DD') AS abandon_date ";
	OrderCondition = " ORDER BY mid DESC ";
	int TotalRecordCount = 0;

	if (telephone.equals("�޴���")) {
		WhereCondition = " where name = '" + name + "' ";
		TotalRecordCount = FrontBoard.TotalCount(TableName, WhereCondition);
		if (TotalRecordCount != 0) {
			WhereCondition += " and mobile = '" + mobile + "' ";
			TotalRecordCount = FrontBoard.TotalCount(TableName, WhereCondition);
			if (TotalRecordCount != 0) {
				WhereCondition += " and passwd ='" + passwd + "' ";
				TotalRecordCount = FrontBoard.TotalCount(TableName, WhereCondition);
				if (TotalRecordCount != 0) {
				} else {
					out.println("<script language='javascript'>");
					out.print("alert('�̸� , �޴�����ȣ, ��й�ȣ�� ��ġ ���� �ʽ��ϴ�.');");
					out.println("history.go(-1);");
					out.println("</script>");
				}
			} else {
				out.println("<script language='javascript'>");
				out.print("alert('�̸� , �޴�����ȣ�� ��ġ ���� �ʽ��ϴ�.');");
				out.println("history.go(-1);");
				out.println("</script>");
			}
		} else {
			out.println("<script language='javascript'>");
			out.print("alert('��ϵ� �̸��� �����ϴ�..');");
			out.println("history.go(-1);");
			out.println("</script>");
		}
		TotalRecordCount = FrontBoard.TotalCount(TableName, WhereCondition);

	} else if (telephone.equals("��ȭ��ȣ")) {
		WhereCondition = " where name = '" + name + "' ";
		TotalRecordCount = FrontBoard.TotalCount(TableName, WhereCondition);
		if (TotalRecordCount != 0) {
			WhereCondition += " and mobile = '" + mobile + "' ";
			TotalRecordCount = FrontBoard.TotalCount(TableName, WhereCondition);
			if (TotalRecordCount != 0) {
				WhereCondition += " and passwd ='" + passwd + "' ";
				TotalRecordCount = FrontBoard.TotalCount(TableName, WhereCondition);
				if (TotalRecordCount != 0) {
				} else {
					out.println("<script language='javascript'>");
					out.print("alert('�̸� , �޴�����ȣ, ��й�ȣ�� ��ġ ���� �ʽ��ϴ�.');");
					out.println("history.go(-1);");
					out.println("</script>");
				}
			} else {
				out.println("<script language='javascript'>");
				out.print("alert('�̸� , ��ȭ��ȣ�� ��ġ ���� �ʽ��ϴ�.');");
				out.println("history.go(-1);");
				out.println("</script>");
			}
		} else {
			out.println("<script language='javascript'>");
			out.print("alert('��ϵ� �̸��� �����ϴ�.');");
			out.println("history.go(-1);");
			out.println("</script>");
		}
		TotalRecordCount = FrontBoard.TotalCount(TableName, WhereCondition);
	}

	int StartRecord = 0;
	int EndRecord = 0;
	int DefaultListRecord = 10;
	int DefaultPageBlock = 10;
	TotalRecordCount = FrontBoard.TotalCount(TableName, WhereCondition);
	
	// 191119 �� ����� ���� : ������ mid�� ���� ����
	String sesMid = "";
	Vector RVector = FrontBoard.list(TableName, SelectCondition, WhereCondition, OrderCondition, PAGE, 0, DefaultListRecord);
	if( RVector.size() > 0){
		for (int i=0; i < RVector.size();i++){
			Hashtable h = (Hashtable)RVector.elementAt(i);
			sesMid +=  "," + (String)h.get("MID") + ",";
		}
	}
	if(sesMid != null && !"".equals(sesMid)) {
		session.setAttribute("minwonMids", sesMid);
	}

	//�̸� �˻� 

	//����ó �˻�

	//��й�ȣ �˻�

	///////////////////////////////////////////////////////////////////////////
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"   "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
	<title>�ο� ���� Ȯ�� &gt; �ο�ó����� ��ȸ &gt; ���ڹο�â�� &gt; ������ &gt; ����</title>
	<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge" /><link rel="stylesheet" type="text/css" href="/css/screen_view.css" />
	<script type="text/javascript" src="/js/jquery-1.7.2.min.js"></script>
	<script type="text/javascript" src="/js/public.js"></script>
	<script type="text/javascript" src="/js/common.js"></script>
<SCRIPT LANGUAGE="JavaScript">
<!--
	function goView(mid){
		f.mid.value=mid;
		f.action = "minwon_apply04.jsp";
		f.submit();
	}

	function DownloadPopup(mid){
		f.mid.value=mid;
		var wint = (screen.height - 245) / 2;
		var winl = (screen.width - 300) / 2;
		winprops = 'height=245,width=300,top='+wint+',left='+winl+',status=no,scrollbars=no,resize=no'
		winurl = 'file_popup.jsp?mid='+mid;
		win = window.open(winurl, "file_popup1", winprops)
	}

//-->
</SCRIPT>

</head>
<body id="minwon02">
	<!-- header -->
	<%@ include file="/include/shHeader.jsp" %>
	<!-- //header -->

	<!-- container -->
	<div id="ContentLayer">
		<!-- LNB -->
		<%@ include file="/include/lnbService.jsp" %>
		<!-- //LNB -->
<FORM METHOD=POST name="f" ACTION="">
<INPUT TYPE="hidden" NAME="telephone" value="<%=telephone%>">
<INPUT TYPE="hidden" NAME="mid">

		<!-- contents -->
		<div id="primaryContent">
			<p class="indicate"><span class="shHome">����</span><span>������</span><span>���ڹο�â��</span>�ο�ó�������ȸ</p>
			<h3>�ο�ó����� ��ȸ</h3>
					
			<table class="list02" cellpadding="0" cellspacing="0" summary="�ο�ó����� ��ȸ�� �󼼳����� �����ָ� ��ȣ, ����, ó������, �ۼ���, ����, �ۼ���, �亯�� ������ �����Ǿ� �ֽ��ϴ�.">
				<caption>�ο�ó����� ��ȸ ����Ʈ</caption>
				<colgroup>
					<col width="7%" />
					<col width="*" />
					<col width="11%" />
					<col width="11%" />
					<col width="8%" />
					<col width="11%" />
					<col width="11%" />
				</colgroup>
				<thead>
					<tr>
						<th scope="col">��ȣ</th>
						<th scope="col">����</th>
						<th scope="col">ó������</th>
						<th scope="col">�ۼ���</th>
						<th scope="col">����</th>
						<th scope="col">�ۼ���</th>
						<th scope="col" class="last">�亯��</th>
					</tr>
				</thead>
				<tbody>
	<%
		Vector ResultVector = FrontBoard.list(TableName, SelectCondition, WhereCondition, OrderCondition, PAGE, 0, DefaultListRecord);

		String sh_mid = "";
	    String sh_name = "";
		String sh_status = "";
		String sh_date = "";
		String fname = "";
		String answer_date = "";
		String abandon_date = "";

	    if( ResultVector.size() > 0){
			for (int i=0; i < ResultVector.size();i++){
				Hashtable h = (Hashtable)ResultVector.elementAt(i);

				String TITLE = (String)h.get("SUBJECT");	//����
				if (TITLE.length() > 31){
					TITLE = TITLE.substring(0,31);
					TITLE += "...";
				}

				sh_mid = (String)h.get("MID");
				sh_name = (String)h.get("NAME");
				sh_status = (String)h.get("STATUS");
				sh_date = (String)h.get("CREATION_DATE");
				fname = (String)h.get("FNAME");
				answer_date = (String)h.get("ANSWER_DATE");
				abandon_date = (String)h.get("ABANDON_DATE");

				//int listnum = DefaultListRecord * (PAGE - 1) + i + 1;	 //�۹�ȣ ���
				int listnum = (TotalRecordCount) - (i + (DefaultListRecord * (PAGE - 1)));	//�۹�ȣ ���(����)

	%>
					<tr>
						<td><%=listnum%></td>
						<td><a href="javascript:goView('<%=sh_mid%>')"><%=TITLE%></td>
						<td>
							<%if(sh_status.equals("�ݼ�") || sh_status.equals("��ø")){%>
								ó����
							<% } else{ %>
								<%=sh_status%>
							<% } %>
						</td>
						<td><%=sh_name%></td>
						<td>
					    <%if(fname==null || fname.equals("")){%>
					    	&nbsp;
					    <%}else{%>
							<a href="javascript:DownloadPopup('<%=sh_mid%>');"><img src="/pub_img/icon_file01.gif" alt="����÷��" /></a>
					    <%} %>
						</td>
						<td><%=sh_date%></td>
						<td>
					  	<%if("öȸ�Ϸ�".equals(sh_status)){ %>
                      		<%=abandon_date%>
                      	<%}else{ %>
                      		<%=answer_date%>
                      	<%} %>
						</td>
					</tr>
	<%	} %>
	<% }else{ %>
					 <tr>
                     	<td class="noData" colspan="7">��� �ڷᰡ �����ϴ�.</td>
                     </tr>
	<% } %>
				</tbody>
			</table>
		</div>
		<!-- //contents -->

</FORM>

	</div>
	<!-- //container -->
	<!-- footer -->
	<%@ include file="/include/shFooter.jsp" %>
	<!-- //footer -->
</body>
</html>
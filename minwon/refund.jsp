<%@ page import="java.util.*, java.text.*, util.*" contentType="text/html;charset=euc-kr"%>

<jsp:useBean id="FrontBoard" scope="request" class="Bean.Front.Common.FrontBoradType1"/>
<jsp:useBean id="FrontDbUtil" scope="request" class="Bean.Front.Common.FrontDbUtil"/>
<jsp:useBean id="AdminInfo" scope="request" class="board.admin.AdminInfo"/>
<%
	//String pageNum 	= "6";
	//String ListPage = "data_01.jsp";
	//String sh_site 	= "1"; //����Ʈ ����
	//String sh_class = "97"; //�Խ��� ����
	//String incPage 	= request.getParameter("incPage");
	//String myPage 	= request.getRequestURI();
	
	int PAGE = 1;
	String TableName = " ncas.VW_CM_COOPINFO@LK_SUHYUP_NCAS ";
    String SelectCondition = " COOP_CD, COOP_NM ";
    String WhereCondition = null;
    String OrderCondition = " Order by COOP_NM ASC ";
	
	//�Ǹ�����
	NiceID.Check.CPClient niceCheck = new  NiceID.Check.CPClient();

    String sSiteCode = "G5890";				// NICE�κ��� �ο����� ����Ʈ �ڵ�
    String sSitePassword = "VN2VPY5TTKBU";
    String sRequestNumber = "REQ0000000001";        	// ��û ��ȣ, �̴� ����/�����Ŀ� ���� ������ �ǵ����ְ� �ǹǷ� 
    sRequestNumber = niceCheck.getRequestNO(sSiteCode);
  	session.setAttribute("REQ_SEQ" , sRequestNumber);	// ��ŷ���� ������ ���Ͽ� ������ ���ٸ�, ���ǿ� ��û��ȣ�� �ִ´�.

  	String sAuthType = "";      // ������ �⺻ ����ȭ��, M: �ڵ���, C: �ſ�ī��, X: ����������
   	String popgubun = "N";		//Y : ��ҹ�ư ���� / N : ��ҹ�ư ����
	String customize = "";		//������ �⺻ �������� / Mobile : �����������

    // CheckPlus(��������) ó�� ��, ��� ����Ÿ�� ���� �ޱ����� ���������� ���� http���� �Է��մϴ�.
    String sReturnUrl = "https://www.suhyup.co.kr/member/checkplus_success1.jsp";      // ������ �̵��� URL
    //String sReturnUrl = "http://localhost:8080/member/checkplus_success1.jsp";  		//���ÿ��� 
    String sErrorUrl = "https://www.suhyup.co.kr/member/checkplus_fail.jsp";          // ���н� �̵��� URL

    // �Էµ� plain ����Ÿ�� �����.
    String sPlainData = "7:REQ_SEQ" + sRequestNumber.getBytes().length + ":" + sRequestNumber +
                        "8:SITECODE" + sSiteCode.getBytes().length + ":" + sSiteCode +
                        "9:AUTH_TYPE" + sAuthType.getBytes().length + ":" + sAuthType +
                        "7:RTN_URL" + sReturnUrl.getBytes().length + ":" + sReturnUrl +
                        "7:ERR_URL" + sErrorUrl.getBytes().length + ":" + sErrorUrl +
                        "11:POPUP_GUBUN" + popgubun.getBytes().length + ":" + popgubun +
                        "9:CUSTOMIZE" + customize.getBytes().length + ":" + customize;

    String sMessage = "";
    String sEncData = "";

    int iReturn = niceCheck.fnEncode(sSiteCode, sSitePassword, sPlainData);

    if( iReturn == 0 ){
        sEncData = niceCheck.getCipherData();
    }else if( iReturn == -1){
        sMessage = "��ȣȭ �ý��� �����Դϴ�.";
    }else if( iReturn == -2){
        sMessage = "��ȣȭ ó�������Դϴ�.";
    }else if( iReturn == -3){
        sMessage = "��ȣȭ ������ �����Դϴ�.";
    }else if( iReturn == -9){
        sMessage = "�Է� ������ �����Դϴ�.";
    }else{
        sMessage = "�˼� ���� ���� �Դϴ�. iReturn : " + iReturn;
    }
%>

<%@ include file="../inc/requestSecurity.jsp" %>
<%@ include file="../inc/login_check.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"   "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
	<title>�ο���û &gt; ���ڹο�â�� &gt; �������� &gt; ����</title>
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<link rel="stylesheet" type="text/css" href="/css/screen.css" />
	<link rel="stylesheet" type="text/css" href="/css/new/service.css" />
	<script type="text/javascript" src="/js/jquery-1.7.2.min.js"></script>
	<script type="text/javascript" src="/js/public.js"></script>
	<script type="text/javascript" src="/js/common.js"></script>
	
	<script type="text/javascript">
		$(document).ready(function(){
			var titleName = "���ڡ����� ȯ����ȸ > �������� > ����";
			document.title = titleName;
		});
		
		//��ȸ
		function fnSearch() {
			if(document.pbform.code.value == null || document.pbform.code.value == ""){
				alert("�Ǹ������� ���ֽñ�ٶ��ϴ�.");
				return;
			}else{
				
				if(document.pbform.name.value.length == 0){
					alert("�̸��� �Էµ��� �ʾҽ��ϴ�.");
					document.pbform.name.focus();
					return;
				}
						
				if (document.pbform.ymd.value.length == 0){
					alert("��������� �Էµ��� �ʾҽ��ϴ�.");
					document.pbform.ymd.focus();
					return;
				}
				
				pbform.action = "refundRt.jsp";
				pbform.submit();
			} 
		}

		//����üũ
		function checkLetter(obj, rtnyn) {
		    var src_chars = obj.value;
		    var com_chars = "";
		    
	        com_chars = "0123456789";
	        
	        if (!ContainsCharsCheck(src_chars, com_chars)) {
	            alert("���ڸ� �Է� �����մϴ�.");
	            obj.value = ContainsCharsOnly(src_chars, com_chars);
	        } else {
	            obj.value = src_chars;
	        }
		    
		    if( rtnyn == "Y") {
		        return obj.focus();
		    }
		}
		
		//���Ե� ����Ȯ��
		function ContainsCharsCheck(str, chars) {
		    for (var inx = 0; inx < str.length; inx++) {
		       if (chars.indexOf(str.charAt(inx)) == -1)
		           return false;
		    }
		    return true;
		}

		//���ڸ�
		function ContainsCharsOnly(str, chars) {
		    var rtnstr = "";
		    
		    for (var inx = 0; inx < str.length; inx++) {
		       if (chars.indexOf(str.charAt(inx)) == -1) {
		           return rtnstr;
		       } else {
		               rtnstr += str.charAt(inx);
		       }
		    }
			return rtnstr;
		}
		
		window.name ="Parent_window";

		function fnPopup(){
			window.open('', 'popupChk', 'width=500, height=550, top=100, left=100, fullscreen=no, menubar=no, status=no, toolbar=no, titlebar=yes, location=no, scrollbar=no');
			document.vnoform.EncodeData.value = "<%= sEncData %>";
			document.vnoform.param_r1.value="";
			document.vnoform.action = "https://nice.checkplus.co.kr/CheckPlusSafeModel/checkplus.cb";
			document.vnoform.target = "popupChk";
			document.vnoform.submit();
		}
	</script>
</head>
<body id="minwon01">
	<!-- header -->
	<%@ include file="/include/shHeader.jsp" %>
	<!-- //header -->

	<!-- container -->
	<div id="ContentLayer">
		
		<!-- LNB -->
		<%@ include file="/include/lnbService.jsp" %>
		<!-- //LNB -->

		<form name="vnoform" method="post">
			<input type="hidden" name="m" value="checkplusSerivce"/>						<!-- �ʼ� ����Ÿ��, �����Ͻø� �ȵ˴ϴ�. -->
			<!-- <input type="hidden" name="EncodeData" value="AgAFRzU4OTAV28PMg2XgIr/+PjbKyS4kh6WX2FXI5BxGeQ6WBN+l0yL5VXnY0mloFNKSGS4vgo8wPhVCKg5yBid2wXPzUXSI9SaI4J9NX+pYqkml1x8fqzI+J0x+n7W3fApsaCpE/IrQToLrzAlwou7nYEiXlW1BnnV45T4DIZ9B40+NnLRfnJVvxeGkxeqB2kLxHnrGAlO2C/gzocHuDwn6O8fSSCjJfLdQeDEsZMCtZuXE2dnE2rb+ImdbA3+0bnxKlqaZnkharVdM7rFGv9vMyQgJIUby5G051SgJKfdrgg5XrJMcTDMSVHzZNJcgxxH8DSGoftsI2KgGKW3jiF6KrDXzbuyF0PbjIaBFPZK1q3ac056UDulsLwjMJBakcN7FdipZXnCRzqsUjazIk3+MX4f6XkoAwUTugnO2tAvSiKOWOqp2uecDo9voCKwEDvUR8O+QvrPYne1cfVGFtMVKBaLnKWGNtJKUE4m/mYlanUU3ltj/lA=="/> -->		<!-- ������ ��ü������ ��ȣȭ �� ����Ÿ�Դϴ�. -->
			<input type="hidden" name="EncodeData" value="<%= sEncData %>"/>		<!-- ������ ��ü������ ��ȣȭ �� ����Ÿ�Դϴ�. -->
		    <!-- ��ü���� ����ޱ� ���ϴ� ����Ÿ�� �����ϱ� ���� ����� �� ������, ������� ����� �ش� ���� �״�� �۽��մϴ�.
		    	 �ش� �Ķ���ʹ� �߰��Ͻ� �� �����ϴ�. -->
			<input type="hidden" name="param_r1" value=""/>
			<input type="hidden" name="param_r2" value=""/>
			<input type="hidden" name="param_r3" value=""/>
		</form>

		<form name="pbform" method="post" action="">	
			<input type="hidden" name="vDiscrNo" value=""/>
			<input type="hidden" name="code" value=""/>
			<!-- contents -->
			<div id="primaryContent">
				<p class="indicate"><span class="shHome">����</span><span>��������</span>���ڡ����� ȯ����ȸ</p>
				<h3>���ڡ����� ȯ����ȸ</h3>
				<div class="pdl20 pdr30">
					<p class="mgb10 mgl20">���ڡ����� ȯ����ȸ Ȯ�� �� �� �ʿ��� �������� �ݵ�� ��Ȯ�ϰ� �Է��� �ּ���.</p>
					<div class="mgl15">
						<table class="write" summary="���ڡ����� ȯ���� ���� ���ո�����, �̸�, ������� ����">
						<caption>���ڡ����� ȯ����ȸ</caption>						
						<colgroup>
							<col style="width:18%;" />
							<col style="width:auto;" />
						</colgroup>
						<tr>
							<th scope="row"><label for="cnm">��&nbsp; ��&nbsp; ��</label></th>
							<td>
								<select name="cnm" id="cnm" style="width:202px;">
<%
								Vector ResultVector = FrontBoard.list(TableName, SelectCondition, WhereCondition, OrderCondition, PAGE, 1);

								if( ResultVector.size() > 0){
									for (int i=0; i < ResultVector.size();i++){
										Hashtable h = (Hashtable)ResultVector.elementAt(i);

										String coopCd = (String)h.get("COOP_CD");
										String coopNm = (String)h.get("COOP_NM");
%>
									<option value="<%=coopCd%>"><%=coopNm%></option>
<%									} %>
<% 								}else{ %>
					 				<option value="">��ȸ���� �����ϴ�.</option>
<% 								} %>
								</select>
							</td>
						</tr>
						<tr>
							<th scope="row"><label for="name">��&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;��</label></th>
							<td>
								<input type="text" class="text readonly" name="name" id="name" style="width:198px;" readonly/>
									<a href="javascript:fnPopup();" class="btn_blue_s01 mgl10" title="��â����">
										<span>�Ǹ�����</span>
									</a>
							</td>
						</tr>
						<tr>
							<th scope="row"><label for="ymd">�������</label></th>
							<td>
								<input type="text"class="text readonly" name="ymd" id="ymd" style="width:198px;" size="6" maxlength="6" onkeyup="javascript:checkLetter(this,'Y');" readonly/>
							</td>
						</tr>
						</table>
					</div>
					<div class="btnR mgt30">
						<a href="javascript:fnSearch();" class="btn_green_arrowB01 w150"><span>��ȸ</span></a>
					</div>
				</div>
			</div>
			<!-- //contents -->
			
		</form>
		
	</div>
	<!-- //container -->

	<!-- footer -->
	<%@ include file="/include/shFooter.jsp" %>
	<!-- //footer -->

</body>

</html>
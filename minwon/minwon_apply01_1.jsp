<%@ page language="java" import="java.util.*, java.lang.*, java.sql.*, Bean.Front.Common.*, Bean.Common.*, util.*, SafeNC.kisinfo.*, Kisinfo.Check.IPINClient"%>
<%@ page import="java.util.Calendar" %>
<%@ page contentType="text/html;charset=euc-kr" %>

<jsp:useBean id="FrontBoard" scope="request" class="Bean.Front.Common.FrontBoradType1"/>



<% String pageNum = "5"; %>
<%
    NiceID.Check.CPClient niceCheck = new  NiceID.Check.CPClient();
    
    String sSiteCode = "G5890";				// NICE�κ��� �ο����� ����Ʈ �ڵ�
    String sSitePassword = "VN2VPY5TTKBU";		// NICE�κ��� �ο����� ����Ʈ �н�����
    
    String sRequestNumber = "REQ0000000001";        	// ��û ��ȣ, �̴� ����/�����Ŀ� ���� ������ �ǵ����ְ� �ǹǷ� 
                                                    	// ��ü���� �����ϰ� �����Ͽ� ���ų�, �Ʒ��� ���� �����Ѵ�.
    sRequestNumber = niceCheck.getRequestNO(sSiteCode);
  	session.setAttribute("REQ_SEQ" , sRequestNumber);	// ��ŷ���� ������ ���Ͽ� ������ ���ٸ�, ���ǿ� ��û��ȣ�� �ִ´�.
  	
   	String sAuthType = "";      	// ������ �⺻ ����ȭ��, M: �ڵ���, C: �ſ�ī��, X: ����������
   	
   	String popgubun 	= "N";		//Y : ��ҹ�ư ���� / N : ��ҹ�ư ����
		String customize 	= "";			//������ �⺻ �������� / Mobile : �����������
		
    // CheckPlus(��������) ó�� ��, ��� ����Ÿ�� ���� �ޱ����� ���������� ���� http���� �Է��մϴ�.
    String sReturnUrl = "http://www.suhyup.co.kr/member/checkplus_success.jsp";      // ������ �̵��� URL
    String sErrorUrl = "http://www.suhyup.co.kr/member/checkplus_fail.jsp";          // ���н� �̵��� URL

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
    if( iReturn == 0 )
    {
        sEncData = niceCheck.getCipherData();
    }
    else if( iReturn == -1)
    {
        sMessage = "��ȣȭ �ý��� �����Դϴ�.";
    }    
    else if( iReturn == -2)
    {
        sMessage = "��ȣȭ ó�������Դϴ�.";
    }    
    else if( iReturn == -3)
    {
        sMessage = "��ȣȭ ������ �����Դϴ�.";
    }    
    else if( iReturn == -9)
    {
        sMessage = "�Է� ������ �����Դϴ�.";
    }    
    else
    {
        sMessage = "�˼� ���� ���� �Դϴ�. iReturn : " + iReturn;
    }
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"   "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
			if(d.Month.value==""){
			if (pbform.sh_post_1.value.length == 0 /*|| pbform.sh_post_2.value.length == 0*/){
			if(d.self_text.value=='���ڼ� 15�ڸ�����'){
			if(d.sh_cata.value == 'cho') {
		}else if(document.all.agree.checked == false && document.all.agree2.checked == false){
		else if(document.all.agree2.checked == false){
		}
		var pop = window.open("/minwon/jusoPopup.jsp","pop","width=570,height=420, scrollbars=yes, resizable=yes");
		/*
		*/
	
	//������ȣ �ݹ�
	function jusoCallBack(roadFullAddr,roadAddrPart1,addrDetail,roadAddrPart2,engAddr, jibunAddr, zipNo, admCd, rnMgtSn, bdMgtSn){
		
		var frm = document.pbform;
		
		frm.sh_post_1.value = zipNo;
		frm.sh_address_1.value = roadAddrPart1;
		frm.sh_address_2.value = addrDetail;
		frm.sh_address_2.focus();
	}
<script language='javascript'>
	window.name ="Parent_window";
	function fnPopup(){
</script>
</head>
<body id="minwon01">
	<!-- header -->
	<!-- container -->
		<!-- LNB -->
<form name="pbform" method="post" action="">
		<!-- contents -->
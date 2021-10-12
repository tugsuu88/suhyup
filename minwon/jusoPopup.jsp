<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<% 
	//request.setCharacterEncoding("UTF-8");  //한글깨지면 주석제거
	request.setCharacterEncoding("EUC-KR");  //해당시스템의 인코딩타입이 EUC-KR일경우에
	String inputYn = request.getParameter("inputYn"); 
	if(inputYn != null && !inputYn.equals("")){
		inputYn = inputYn.replaceAll("<", "&lt;").replaceAll(">", "&gt;");
    }
	String roadFullAddr = request.getParameter("roadFullAddr"); 
	if(roadFullAddr != null && !roadFullAddr.equals("")){
		roadFullAddr = roadFullAddr.replaceAll("<", "&lt;").replaceAll(">", "&gt;");
    }
	String roadAddrPart1 = request.getParameter("roadAddrPart1"); 
	if(roadAddrPart1 != null && !roadAddrPart1.equals("")){
		roadAddrPart1 = roadAddrPart1.replaceAll("<", "&lt;").replaceAll(">", "&gt;");
    }
	String roadAddrPart2 = request.getParameter("roadAddrPart2"); 
	if(roadAddrPart2 != null && !roadAddrPart2.equals("")){
		roadAddrPart2 = roadAddrPart2.replaceAll("<", "&lt;").replaceAll(">", "&gt;");
    }
	String engAddr = request.getParameter("engAddr"); 
	if(engAddr != null && !engAddr.equals("")){
		engAddr = engAddr.replaceAll("<", "&lt;").replaceAll(">", "&gt;");
    }
	String jibunAddr = request.getParameter("jibunAddr"); 
	if(jibunAddr != null && !jibunAddr.equals("")){
		jibunAddr = jibunAddr.replaceAll("<", "&lt;").replaceAll(">", "&gt;");
    }
	String zipNo = request.getParameter("zipNo"); 
	if(zipNo != null && !zipNo.equals("")){
		zipNo = zipNo.replaceAll("<", "&lt;").replaceAll(">", "&gt;");
    }
	String addrDetail = request.getParameter("addrDetail"); 
	if(addrDetail != null && !addrDetail.equals("")){
		addrDetail = addrDetail.replaceAll("<", "&lt;").replaceAll(">", "&gt;");
    }
	String admCd = request.getParameter("admCd");
	if(admCd != null && !admCd.equals("")){
		admCd = admCd.replaceAll("<", "&lt;").replaceAll(">", "&gt;");
    }
	String rnMgtSn = request.getParameter("rnMgtSn");
	if(rnMgtSn != null && !rnMgtSn.equals("")){
		rnMgtSn = rnMgtSn.replaceAll("<", "&lt;").replaceAll(">", "&gt;");
    }
	String bdMgtSn = request.getParameter("bdMgtSn");
	if(bdMgtSn != null && !bdMgtSn.equals("")){
		bdMgtSn = bdMgtSn.replaceAll("<", "&lt;").replaceAll(">", "&gt;");
    }
%>
</head>
<script language="javascript">
function init(){
	var url = location.href;
	var confmKey = "U01TX0FVVEgyMDE2MDEyMjA5MDUwMzA=";
	var inputYn= "<%=inputYn%>";
	if(inputYn != "Y"){
		document.form.confmKey.value = confmKey;
		document.form.returnUrl.value = url;
		document.form.action="http://www.juso.go.kr/addrlink/addrLinkUrl.do"; //인터넷망
		document.form.submit();
	}else{
		opener.jusoCallBack("<%=roadFullAddr%>","<%=roadAddrPart1%>","<%=addrDetail%>","<%=roadAddrPart2%>","<%=engAddr%>","<%=jibunAddr%>","<%=zipNo%>", "<%=admCd%>", "<%=rnMgtSn%>", "<%=bdMgtSn%>");
		window.close();
	}
}
</script>
<body onload="init();">
	<form id="form" name="form" method="post">
		<input type="hidden" id="confmKey" name="confmKey" value=""/>
		<input type="hidden" id="returnUrl" name="returnUrl" value=""/>
		<!-- 해당시스템의 인코딩타입이 EUC-KR일경우에만 추가 START-->
		 
		<input type="hidden" id="encodingType" name="encodingType" value="EUC-KR"/>
		
		<!-- 해당시스템의 인코딩타입이 EUC-KR일경우에만 추가 END-->
	</form>
</body>
</html>
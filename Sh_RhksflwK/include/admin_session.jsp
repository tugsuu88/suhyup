<%

	String sa_id = Converter.nullchk((String)session.getAttribute("id"));
	String sa_name = Converter.nullchk((String)session.getAttribute("name"));
	String sa_buseo = Converter.nullchk((String)session.getAttribute("buseo"));
	String sa_mobile = Converter.nullchk((String)session.getAttribute("sh_mobile"));
	String sa_gicwe = Converter.nullchk((String)session.getAttribute("sh_gicwe"));
	String sa_admin_manager = Converter.nullchk((String)session.getAttribute("sh_admin_manager"));
	String sa_admin_faq = Converter.nullchk((String)session.getAttribute("sh_admin_faq"));
	String sa_admin_minwonall = Converter.nullchk((String)session.getAttribute("sh_admin_minwonall"));
	String sa_admin_buseo = Converter.nullchk((String)session.getAttribute("sh_admin_buseo"));
	String sa_admin_result = Converter.nullchk((String)session.getAttribute("sh_admin_result"));
	String sa_admin_jebo = Converter.nullchk((String)session.getAttribute("sh_admin_jebo"));
	String sa_admin_bujori = Converter.nullchk((String)session.getAttribute("sh_admin_bujori"));
	String sa_admin_myunsei = Converter.nullchk((String)session.getAttribute("sh_admin_myunsei"));
	String sa_admin_corruption = Converter.nullchk((String)session.getAttribute("sh_admin_corruption"));
	String sa_admin_upright = Converter.nullchk((String)session.getAttribute("sh_admin_upright"));
	
	
	//20170206 ûŹ�Ű����� �޴� �߰�
	String sa_admin_favors = Converter.nullchk((String)session.getAttribute("sh_admin_favors"));
	
	//20190725 Add by Bilguun(MKit)
	String sa_admin_sms = Converter.nullchk((String)session.getAttribute("sh_admin_sms"));
	
%>
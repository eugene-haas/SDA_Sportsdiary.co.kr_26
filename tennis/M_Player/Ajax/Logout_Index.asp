<%
	'��Ű ���� ó��
	with Response
		.Expires = -1
		.Cookies("MemberIDX") 	= ""	'ȸ����Ϲ�ȣ
		.Cookies("P_MemberIDX") = ""   	'�θ��� ��� ȸ����Ϲ�ȣ
		.Cookies("PlayerIDX") 	= ""	'������ȣ
		.Cookies("SportsGb") 	= ""   	'���񱸺�
		.Cookies("PlayerGb")  	= ""   	'��������
		.Cookies("NowSchIDX")  	= ""   	'�Ҽ�IDX
		.Cookies("UserName")  	= ""   	'����ڸ�		
		.Cookies("UserID")  	= ""   	'����ھ��̵�		
		.Cookies("UserPhone")  	= ""   	'����ڿ���ó
		.Cookies("BirthDay") 	= ""   	'�������
		.Cookies("Sex")  		= ""   	'����
		.Cookies("PlayerLevel") = ""   	'ü���ڵ�
		.Cookies("PhotoPath") 	= ""   	'������������� �̹���
		.Cookies("SvcStartDt") 	= ""   	'���������񽺽�����
		.Cookies("SvcEndDt") 	= ""   	'����������������
		.Cookies("Team") 		= ""   	'�Ҽ���
		.Cookies("PlayerReln") 	= ""   	'ȸ������
		.Cookies("EnterType") 	= ""   	'ȸ������[E:����Ʈ | A;�Ƹ��߾�]
'		.Cookies("idsave") 		= ""   	'�����ID
'		.Cookies("pwsave") 		= ""   	'�����PWD

		.addheader "pragma","no-cache"
		.addheader "cache-control","no-cache"
	End with  
	
	Session.Abandon

	Response.Redirect("/M_Player/Main/Login.asp")
	Response.End
%>
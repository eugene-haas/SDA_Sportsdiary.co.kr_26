<!--#include file="../Library/ajax_config.asp"-->
<%
	'=========================================================================================
	'������� ��������
	'=========================================================================================
	'�α������� �ʾҴٸ� login.asp�� �̵�
	Check_Login()	
	
	dim SportsType	: SportsType  	= fInject(Trim(Request("SportsType")))
	dim join_IDX	: join_IDX  	= fInject(Trim(Request("join_IDX")))
	dim UserID	 	: UserID 		= Request.Cookies("SD")("UserID")
			
	dim CSQL, CRs

	
	IF join_IDX = "" Or UserID = "" OR SportsType = "" Then 
		Response.Write "FALSE|200"
		Response.End
	Else
		On Error Resume Next			
		
		DBCon3.BeginTrans()
   
		'1. ������� �������� �ʱ�ȭ	
		CSQL =  " 		UPDATE [SD_Tennis].[dbo].[tblMember]"
		CSQL = CSQL & " SET SD_GameIDSET = 'N' "
		CSQL = CSQL & " 	,WriteDate = GETDATE() "				
		CSQL = CSQL & " WHERE DelYN = 'N'" 
		CSQL = CSQL & "		AND SD_UserID = '"&UserID&"' " 

		DBCon3.Execute(CSQL)
		ErrorNum = ErrorNum + DBCon3.Errors.Count

		'2. ������ ���� ����������� �����մϴ�.
		CSQL =  " 		UPDATE [SD_Tennis].[dbo].[tblMember]"
		CSQL = CSQL & " SET SD_GameIDSET = 'Y' "
		CSQL = CSQL & " 	,WriteDate = GETDATE() "
		CSQL = CSQL & " WHERE DelYN = 'N'" 
		CSQL = CSQL & "		AND SD_UserID = '"&UserID&"' " 
		CSQL = CSQL & "		AND MemberIDX = '"&join_IDX&"' " 

		DBCon3.Execute(CSQL)
		ErrorNum = ErrorNum + DBCon3.Errors.Count		
		
		IF ErrorNum > 0 Then
			DBCon3.RollbackTrans()			
			Response.Write "FALSE|99"			
		Else				
			DBCon3.CommitTrans()			
			Response.Write "TRUE|"
		End IF
		
		DBClose3()
		
	End If 
%>
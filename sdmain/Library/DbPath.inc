<% 
	'���������̾
	'����DB ���� �׽�Ʈ DB�� ���õ� App���½� �ǻ��DB 145�� ������ �����ؾ� �� 
	strConnect = strConnect&"Provider=SQLOLEDB.1;Persist Security Info=True;"
	strConnect = strConnect&"Data Source=49.247.9.88;"  
	strConnect = strConnect&"User ID=splog_dbJ0ehU9fpD0tmO1fld;"             
	strConnect = strConnect&"Password=slogp_gGu6+32!k0h04(BqP~4P7;"             
	strConnect = strConnect&"Initial Catalog=sportsdiary;"   
	
	
	'�����ۼ���(SMS�߼� ����)
	strConnect2 = strConnect2&"Provider=SQLOLEDB.1;Persist Security Info=True;"
	strConnect2 = strConnect2&"Data Source=db.itemcenter.co.kr;"  
	strConnect2 = strConnect2&"User ID=widsql;"             
	strConnect2 = strConnect2&"Password=ic%^&1058!@#;" 
	strConnect2 = strConnect2&"Initial Catalog=ITEMCENTER;" 
	
	
	'����ȸ��DB
	strConnect3 = strConnect3 & "Provider=SQLOLEDB.1;Persist Security Info=True;"
	strConnect3 = strConnect3 & "Data Source=49.247.9.88;"  
	strConnect3 = strConnect3 & "User ID=splog_dbJ0ehU9fpD0tmO1fld;"             
	strConnect3 = strConnect3 & "Password=slogp_gGu6+32!k0h04(BqP~4P7;"             
	strConnect3 = strConnect3 & "Initial Catalog=SD_Member;"   
	
	'�״Ͻ�
	strConnect4 = strConnect4 & "Provider=SQLOLEDB.1;Persist Security Info=True;"
	strConnect4 = strConnect4 & "Data Source=49.247.9.88;"  
	strConnect4 = strConnect4 & "User ID=splog_dbJ0ehU9fpD0tmO1fld;"             
	strConnect4 = strConnect4 & "Password=slogp_gGu6+32!k0h04(BqP~4P7;"             
	strConnect4 = strConnect4 & "Initial Catalog=SD_Tennis;"    


	'����
	strConnectsms = strConnectsms & "Provider=SQLOLEDB.1;Persist Security Info=True;"
	strConnectsms = strConnectsms & "Data Source=49.247.9.88;"  
	strConnectsms = strConnectsms & "User ID=sms_Ek27fh4gk;"             
	strConnectsms = strConnectsms & "Password=sms_VW&e@)&Py$5a^458bP*#e;"
	strConnectsms = strConnectsms & "Initial Catalog=SD_Tennis;"    
%>
<!DOCTYPE HTML>
<html lang="en">
<head>
<meta charset="utf-8">
<%
'ȭ���ѻ����� 1000px
Monitor_MaxSize = "1000"
'����� ����
TotGameCnt = 8
'�ѿ��� ���
oneSideCnt = TotGameCnt/2
Response.Write oneSideCnt&"<br>"

'���ʸ� ���� ���̺��
trCnt = oneSideCnt/2
Response.Write trCnt
'������ܻ�����
PlayerWidth="100"

'����������� ������ ������
LineWidth = Monitor_MaxSize - (PlayerWidth*2)
	

Function Chk_TD(cnt)
	If cnt = "4" Then 
		Chk_TD = 1
	ElseIf cnt = "8" Then 
		Chk_TD = 2
	ElseIf cnt = "16" Then 
		Chk_TD = 4
	ElseIf cnt = "32" Then 
		Chk_TD = 6
	ElseIf cnt = "64" Then 
		Chk_TD = 8
	ElseIf cnt = "128" Then 
		Chk_TD = 10
	End If 
End Function 

'��� ������ ǥ ���� ����
Function Chk_RowTD(cnt)
	If cnt = "4" Then 
		Chk_RowTD = 1
	ElseIf cnt = "8" Then 
		Chk_RowTD = 2
	ElseIf cnt = "16" Then 
		Chk_RowTD = 4
	ElseIf cnt = "32" Then 
		Chk_RowTD = 6
	ElseIf cnt = "64" Then 
		Chk_RowTD = 8
	ElseIf cnt = "128" Then 
		Chk_RowTD = 10
	End If
End Function 

%>
</head>
<body>
<!--��ʸ�Ʈ�� �׷��� ȭ�� ������ ���̺� ����-->
<table width="<%=Monitor_MaxSize%>px" border="1">
	<%
		'����ǥ�� ����
		For i = 1 To oneSideCnt
	%>
	<tr>
		<td>1</td>
		<!--���� ����-->
		<td>
			<%
				If i Mod 2 = 1 Then 
			%>
			��
			<%
				Else 			
			%>
			��
			<%
				End If 
			%>
		</td>
		<!--���� ����-->
		<!--�����߰� ��������-->
		<%
			If i Mod Chk_TD(TotGameCnt) = 1 Then 
		%>
		<td rowspan="<%=Chk_TD(TotGameCnt)%>"></td>
		<%
			ElseIf i Mod Chk_TD(TotGameCnt) = 1 Then
			End If 
		%>
		<!--�����߰� ��������-->
		<!--��¶���-->
		<%
			If i = 1 Then 
		%>
		<td rowspan="<%=oneSideCnt%>">----</td>
		<%
			End If 
		%>
		<!--��¶���-->
		<!--�����߰� ��������-->
		<%
			If i Mod Chk_TD(TotGameCnt) = 1 Then 
		%>
		<td rowspan="<%=Chk_TD(TotGameCnt)%>"></td>
		<%
			End If 
		%>
		<!--�����߰� ��������-->
		<!--���� ����-->
		<td>
			<%
				If i Mod 2 = 1 Then 
			%>
			��
			<%
				Else 			
			%>
			��
			<%
				End If 
			%>
		</td>
		<!--���� ����-->
		<td>1</td>
	</tr>
	<%
		Next
	%>
	
</table>
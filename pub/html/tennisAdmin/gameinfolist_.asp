<%If idx = "55" Then '�׽�Ʈ �׸�%>

	<%If USER_IP = "118.33.86.240" then%>
		<%If CDbl(ADGRADE) > 500 then%>
			<tr class="gametitle"  style="cursor:pointer" id="titlelist_<%=idx%>">
				<td  onclick="mx.input_edit(<%=idx%>)"><%=idx%></td>
				<td  onclick="mx.input_edit(<%=idx%>)" style="text-align:left;padding-left:10px;"><span class="red_font"><%=titleGrade%></span> <%=title%></td>
				<td  onclick="mx.input_edit(<%=idx%>)" style="color:#A43A1D;"><%=sdate%>~<%=edate%></td>
				<!-- <td  onclick="mx.input_edit(<%=idx%>)"><%=rcvs%>~<%=rcve%></td> -->
				<td  onclick="mx.input_edit(<%=idx%>)"><%=viewYN%><%=ViewState%> : <%=MatchYN%></td>


		<%If USER_IP = "118.33.86.240" then%>
			<%If CDbl(edate) > Date +150 then%>
			<td class="g_btn green_btn1"><a href="javascript:mx.vaccreset(<%=idx%>,'<%=title%>')">���¹�ȯ</a></td>
			<%else%>
			<td class="g_btn green_btn1"><a href="javascript:alert('��ȸ �����Ϸκ��� 15�ϵڿ� ���� �ʱ�ȭ�� ���� �մϴ�.')" style="background:orange;">������+15</a></td>
			<%End if%>
		<%End if%>

				<td class="g_btn green_btn1"><a href="javascript:mx.editor(<%=idx%>,'<%=title%>')">��ȸ�䰭</a></td>
				<td class="g_btn green_btn2"><a href="javascript:mx.golevel(<%=idx%>,'<%=title%>')">��(�������)����</a></td>
			</tr>
		<%else%>
			<tr class="gametitle"  style="cursor:pointer" id="titlelist_<%=idx%>" onmousedown="mx.golevel(<%=idx%>,'<%=title%>')"  style="background:#BAD6FA;">
				<td  ><%=idx%></td>
				<td   style="text-align:left;padding-left:10px;"><span class="red_font"><%=titleGrade%></span> <%=title%></td>
				<td   style="color:#A43A1D;"><%=sdate%>~<%=edate%></td>
			</tr>
		<%End if%>
	<%End if%>




<%else%>

	<%If CDbl(ADGRADE) > 500 then%>

		<tr id="titlelist_<%=idx%>">
			<td class="number" onclick="mx.input_edit(<%=idx%>)"><span><%=idx%></span></td>
			<td class="name" onclick="mx.input_edit(<%=idx%>)"><span class="red_font"><%=titleGrade%></span> <span><%=title%></span></td>
			<td class="date" onclick="mx.input_edit(<%=idx%>)"><span><%=sdate%>~<%=edate%></span></td>
			<td class="Exposure" onclick="mx.input_edit(<%=idx%>)"><span><%=viewYN%><%=ViewState%> : <%=MatchYN%></span></td>

		<%If USER_IP = "118.33.86.240" then%>
			<%If CDbl(edate) > Date +150 then%>
			<td class="g_btn green_btn1"><a href="javascript:mx.vaccreset(<%=idx%>,'<%=title%>')">���¹�ȯ</a></td>
			<%else%>
			<td class="g_btn green_btn1"><a href="javascript:alert('��ȸ �����Ϸκ��� 15�ϵڿ� ���� �ʱ�ȭ�� ���� �մϴ�.')" style="background:orange;">������+15</a></td>
			<%End if%>
		<%End if%>

			<td class="g_btn green_btn1"><a href="javascript:mx.editor(<%=idx%>,'<%=title%>')">��ȸ�䰭</a></td>
			<td class="g_btn green_btn2"><a href="javascript:mx.golevel(<%=idx%>,'<%=title%>')">��(�������)����</a></td>
		</tr>
	<%else%>
		<tr id="titlelist_<%=idx%>" onmousedown="mx.golevel(<%=idx%>,'<%=title%>')">
			<td class="number" onclick="mx.input_edit(<%=idx%>)"><span><%=idx%></span></td>
			<td class="name" onclick="mx.input_edit(<%=idx%>)"><span class="red_font"><%=titleGrade%></span> <span><%=title%></span></td>
			<td class="date" onclick="mx.input_edit(<%=idx%>)"><span><%=sdate%>~<%=edate%></span></td>
		</tr>
	<%End if%>

<%End if%>
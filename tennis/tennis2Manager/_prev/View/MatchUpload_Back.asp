<!--#include virtual="/Manager/Common/common_header.asp"-->
<!--#include virtual="/Manager/Library/config.asp"-->
<%
	StadiumNumber = fInject(Request("StadiumNumber"))
	
	If StadiumNumber = "" Then
		'StadiumNumber = "1"
	End If 

	GameDay = fInject(Request("GameDay"))

	If GameDay = "" Then 
		GameDay = "2017-05-16"
	End If 


  Search_GroupGameGb = fInject(Request("Search_GroupGameGb"))

	Search_TeamGb      = fInject(Request("Search_TeamGb"))


  Level              = fInject(Request("Level"))

 SQL = "SELECT B.PlayerResultIDX  AS PlayerResultIDX, B.RGameLevelidx, SportsDiary.dbo.FN_PlayerName(B.LPlayerIDX) AS LUserName, SportsDiary.dbo.FN_PlayerName(B.RPlayerIDX) AS RUserName, "
 SQL = SQL&" SportsDiary.dbo.FN_TeamNM(B.SportsGb, B.TeamGb, B.LTeam) AS LSchoolName, SportsDiary.dbo.FN_TeamNM(B.SportsGb, B.TeamGb, B.RTeam) AS RSchoolName, "
 SQL = SQL&" B.GroupGameNum, B.GameNum, B.LPlayerIDX, B.RPlayerIDX, "
 SQL = SQL&" B.LTeam, LTeamDtl, B.RTeam, B.RTeamDtl, B.LResult, B.RResult, B.GameStatus, " 
 SQL = SQL&" SportsDiary.dbo.FN_PubName(B.GroupGameGb) AS GroupGameGbNM, "
 SQL = SQL&" SportsDiary.dbo.FN_TeamGbNm(B.SportsGb, B.TeamGb) AS TeamGBNM, "
 SQL = SQL&" SportsDiary.dbo.FN_LevelNM(B.SportsGb, B.TeamGb, B.Level) AS LevelNM, "
 SQL = SQL&" B.Sex, B.GroupGameGb AS GroupGameGb "
 SQL = SQL&" ,B.MediaLink AS MediaLink"
 SQL = SQL&" ,B.Tmp_StadiumNumber AS StadiumNumber"
 SQL = SQL&" ,B.StartHour AS SHour "
 SQL = SQL&" ,B.StartMinute AS SMinute "
 SQL = SQL&" FROM SportsDiary.dbo.tblRgameLevel A "
 SQL = SQL&" INNER JOIN SportsDiary.dbo.tblPlayerResult B ON B.RGameLevelidx = A.RGameLevelidx "
 SQL = SQL&" AND B.GameTitleIDX = '53'"
 If GameDay <> "" Then 
 SQL = SQL&" AND A.GameDay = '"&GameDay&"'"
 End If 
 SQL = SQL&" AND A.DelYN = 'N'"
 SQL = SQL&" AND B.DelYN = 'N'"
	SQL = SQL&" AND ( B.RResult <> 'sd019006' AND B.LResult <> 'sd019006' AND B.RResult <> 'sd019021' AND B.LResult <> 'sd019021'  AND B.RResult <> 'sd019012' AND B.LResult <> 'sd019012')"
	'AND B.RResult <> 'sd019022' AND B.LResult <> 'sd019022'
'	SQL = SQL&" AND ( B.RResult <> 'sd019006' AND B.LResult <> 'sd019006' AND B.RResult <> 'sd019021' AND B.LResult <> 'sd019021')"


 '?????????
 If StadiumNumber <> "" Then 
 SQL = SQL&" AND B.Tmp_StadiumNumber = '"&StadiumNumber&"'"
 End If 


 '????????????
 If Search_GroupGameGb <> "" Then 
 SQL = SQL&" AND B.GroupGameGb = '"&Search_GroupGameGb&"'"
 End If 

 '
 If Search_TeamGb <> "" Then 
 SQL = SQL&" AND B.TeamGb = '"&Search_TeamGb&"'"
 End If 

 If Level <> "" Then 
 SQL = SQL&" AND B.Level = '"&Level&"'"
 End If 
 





 SQL = SQL&" AND (B.GroupGameGb = 'sd040001' OR (B.GroupGameGb = 'sd040002' AND (ISNULL(B.LPlayerIDX,'') = '' AND ISNULL(B.RPlayerIDX,'') = '' ))) "
 SQL = SQL&" ORDER BY B.StartHour+B.StartMinute "
'Response.Write SQL
'Response.End
 Set Rs = Dbcon.execute(SQL)
%>
<script type="text/javascript">
//?????????????????????????????????
make_box("sel_Search_GroupGameGb","Search_GroupGameGb","<%=Search_GroupGameGb%>","GroupGameGb")
make_box("sel_Search_TeamGb","Search_TeamGb","<%=Search_TeamGb%>","TeamGb2")


make_box_level("sel_Level","Level","<%=Level%>","Level_Check","<%=Search_TeamGb%>")	



//?????????????????????
function chk_level(){	
	if(document.getElementById("Search_TeamGb").value!=""){
		make_box_level("sel_Level","Level","","Level_Check",document.getElementById("Search_TeamGb").value)
	}
}

function copy_path(data){
	//alert(data);
	if (window.clipboardData.setData("text", data))
  	alert("???????????? ????????? ?????????????????????!");
  else
   alert("???????????? ????????? ?????????????????????!");	
}	


function chk_frm(){
 var f = document.search_frm;
 f.submit();
}



function chk_save(objno){
	var f = eval("document.media_frm"+objno)	
	var sf = document.search_frm;
	if(f.MediaLink.value==""){
		alert("?????????????????? ????????? ?????????");
		return false;
	}
	sf.H_MediaLink.value       = f.MediaLink.value
	sf.H_PlayerResultIDX.value = f.PlayerResultIDX.value
	sf.action = "MatchUpload_Ok.asp"
	sf.submit()
}
</script>
	<section>
		<div id="content">
		<form method="post" name="search_frm" id="search_frm" action="Matchupload.asp"> 
		<input type="hidden" name="GameTitleIDX" id="GameTitleIDX" value="47">
		<div class="sch">
			<table class="sch-table">
				<caption>???????????? ?????? ??? ??????</caption>
				<colgroup>
					<col width="80px" />
					<col width="*" />
					<col width="80px" />
					<col width="*" />
					<col width="80px" />
					<col width="*" />
					<col width="80px" />
					<col width="*" />
					<col width="80px" />
					<col width="*" />

				</colgroup>				 
				<tbody>
					<tr>
						<th scope="row"><label for="competition-name-2">????????????</label></th>
						<td id="sel_GameTitle">
							<select id="GameDay" name="GameDay">
								<option value="">??????</option>
								<option value="2017-03-28" <%If GameDay = "2017-03-28" Then %>selected <%End If %>>2017-03-28</option>
								<option value="2017-03-29" <%If GameDay = "2017-03-29" Then %>selected <%End If %>>2017-03-29</option>
								<option value="2017-03-30" <%If GameDay = "2017-03-30" Then %>selected <%End If %>>2017-03-30</option>
								<option value="2017-03-31" <%If GameDay = "2017-03-31" Then %>selected <%End If %>>2017-03-31</option>
								<option value="2017-04-01" <%If GameDay = "2017-04-01" Then %>selected <%End If %>>2017-04-01</option>
								<option value="2017-04-02" <%If GameDay = "2017-04-02" Then %>selected <%End If %>>2017-04-02</option>

								<option value="2017-04-10" <%If GameDay = "2017-04-10" Then %>selected <%End If %>>2017-04-10</option>
								<option value="2017-04-11" <%If GameDay = "2017-04-11" Then %>selected <%End If %>>2017-04-11</option>
								<option value="2017-04-12" <%If GameDay = "2017-04-12" Then %>selected <%End If %>>2017-04-12</option>
								<option value="2017-04-24" <%If GameDay = "2017-04-24" Then %>selected <%End If %>>2017-04-24</option>
								<option value="2017-04-25" <%If GameDay = "2017-04-25" Then %>selected <%End If %>>2017-04-25</option>
								<option value="2017-04-26" <%If GameDay = "2017-04-26" Then %>selected <%End If %>>2017-04-26</option>

								<option value="2017-05-16" <%If GameDay = "2017-05-16" Then %>selected <%End If %>>2017-05-16</option>
								<option value="2017-05-17" <%If GameDay = "2017-05-17" Then %>selected <%End If %>>2017-05-17</option>
								<option value="2017-05-18" <%If GameDay = "2017-05-18" Then %>selected <%End If %>>2017-05-18</option>
								<option value="2017-05-19" <%If GameDay = "2017-05-19" Then %>selected <%End If %>>2017-05-19</option>
							</select>
						</td>
						<th scope="row">???????????????</th>
						<td>
							<select id="StadiumNumber" name="StadiumNumber">
							<option value="">??????</option>
								<option value="1" <%If StadiumNumber = "1" Then %>selected <%End If %>>1?????????</option>
								<option value="2" <%If StadiumNumber = "2" Then %>selected <%End If %>>2?????????</option>
								<option value="3" <%If StadiumNumber = "3" Then %>selected <%End If %>>3?????????</option>
								<option value="4" <%If StadiumNumber = "4" Then %>selected <%End If %>>4?????????</option>
							</select>
						</td>						
						<th scope="row">????????????</th>
						<td id="sel_Search_GroupGameGb">
							<select id="Search_GroupGameGb" name="Search_GroupGameGb" onchange="change_GroupGameGb(this)">
								<option value="sd040001" <%If Search_GroupGameGb = "sd040001" Then %>selected <%End If %>>?????????</option>
								<option value="sd040002" <%If Search_GroupGameGb = "sd040002" Then %>selected <%End If %>>?????????</option>
							</select>
						</td>			
						<th scope="row">??????</th>
						<td id="sel_Search_TeamGb">
							<select id="Search_TeamGb" name="Search_TeamGb">
								<option value="">::??????????????????::</option>
							</select>
						</td>								
						<th scope="row">??????</th>
						<td id="sel_Level">

              <select id="Level" onclick="alert('?????? ?????? ????????? ????????? ????????? ?????????.');">
                <option value="">::????????????::</option>
              </select>
     								
						</td>
					</tr>
				</tbody>
			</table>
		</div>
		<input type="hidden" name="H_MediaLink" id="H_MediaLink">
		<input type="hidden" name="H_PlayerResultIDX" id="H_PlayerResultIDX">

		</form>
		<div class="btn-right-list">
			<a href="javascript:chk_frm();" class="btn" id="btnview" accesskey="s">??????(S)</a>
		</div>
		<!-- S : ????????? -->
		<table class="table-list">
			<caption>?????? ?????????</caption>
			<colgroup>
			<col width="*" />
				<col width="*" />
				<col width="*" />
				<col width="*" />
				<col width="*" />
				<col width="*" />
				<col width="*" />
				<col width="*" />
				<col width="50" />
			</colgroup>
			<thead>
				<tr>
				  <th scope="col">No</th>
				  <th scope="col">????????????</th>
					<th scope="col">?????????</th>
					<th scope="col">?????????</th>
					<th scope="col">??????</th>
					<th scope="col">??????</th>
					<th scope="col">????????????</th>
					<th scope="col">??????</th>
					<th scope="col">??????</th>
					
				</tr>
			</thead>
			<tbody>
				<%
					i = 1
					MediaLinkCnt = "0"
					NoMediaLinkCnt = "0"
					If Not (Rs.Eof Or Rs.Bof) Then
						Do Until Rs.Eof 
				%>
				<form method="post" name="media_frm<%=i%>" id="media_frm<%=i%>">
				<tr>
					<td><%=i%></td>
					<td><%=Rs("PlayerResultIDX")%></td>
					<td class="left">???<%=Rs("StadiumNumber")%>?????????</td>
					<td><%=Rs("LUserName")%>(<%=Rs("LSchoolName")%>) VS <%=Rs("RUserName")%>(<%=Rs("RSchoolName")%>)</td>
					<td class="left"><%=Rs("GroupGameGbNM")%></td>
					<td class="left"><%=Rs("TeamGBNM")%> <%=Rs("LevelNM")%></td>
					<td class="left"><%=Rs("SHour")%>??? <%=Rs("SMinute")%>???</td>
					<td><input type="text"  name="MediaLink" value="<%=Rs("MediaLink")%>"></td>
					<input type="hidden" name="PlayerResultIDX" value="<%=Rs("PlayerResultIDX")%>">
					<td class="left"><input type="button" value="??????" onclick="chk_save('<%=i%>');"></td>
				</tr>
					
				</form>
				<%
							If Rs("MediaLink")<>"" Then 
								MediaLinkCnt = MediaLinkCnt + 1
							Else
								NoMediaLinkCnt = NoMediaLinkCnt + 1
							End If 
				      i = i + 1
							Rs.MoveNext
						Loop 
					End If 
				%>
			</tbody>
		</table>
		<!-- E : ????????? -->
		</div>
	<section>
<!--?????????:<%=i-1%>	????????????:<%=MediaLinkCnt%>??? ???????????????:<%=NoMediaLinkCnt%> ?????????<%=(MediaLinkCnt/(i-1))*100%>%-->
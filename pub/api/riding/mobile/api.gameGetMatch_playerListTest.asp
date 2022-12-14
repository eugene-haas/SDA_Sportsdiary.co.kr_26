<%
'#############################################
'메인 뷰
'#############################################
	'request

  Set db = new clsDBHelper

  If hasown(oJSONoutput, "tidx") = "ok" then
    tidx = fInject(oJSONoutput.tidx)
  End if

  If hasown(oJSONoutput, "gno") = "ok" then
    gameno = fInject(oJSONoutput.gno)
  End if

  '경기진행state
  function gamestatus(val)
    Select Case CDbl(val)
      case 1
        gamestatus = "경기예정"
      case 2
        gamestatus = "경기중"
      case 3
        gamestatus = "경기종료"
    end select
  end function

  '마장마술지점state
  function majangstatus(val)
    Select Case CDbl(val)
      case 1
        majangstatus = "B"
      case 2
        majangstatus = "E"
      case 3
        majangstatus = "M"
      case 4
        majangstatus = "C"
      case 5
        majangstatus = "H"
    end select
  end function

  '기권state
  function givupstatus(val)
    if val="e" then
        givupstatus = "E"
    elseif val="r" then
        givupstatus = "R"
    elseif val="w" then
        givupstatus = "W"
    elseif val="d" then
        givupstatus = "D"
    else
        givupstatus = null
    end if
  end function

  '체전 및 장애물 일부 네임테그 state
  function nameTagstatus(val,val2,val3)
    teamnametag = ""
    if val = "Y" then
      if val3 = CONST_TYPEA1 or val3 = CONST_TYPEA2 or val3 = CONST_TYPEA_1 then
        if val2 = "1" then
          teamnametag = "1라운드"
        elseif val2 = "2" then
          teamnametag = "2라운드"
        elseif val2 = "3" then
          teamnametag = "결승"
        else
          teamnametag = "재경기"& (cint(val2)-3)
        end if
      end if
    else
      if val3 = CONST_TYPEA1 or val3 = CONST_TYPEA2 then
        if val2 = "1" then
          teamnametag = ""
        else
          teamnametag = "재경기"
        end if
      end if
    end if
    nameTagstatus = teamnametag
  end function

  '문자열 앞에 붙이기
  function strLenCheck(val,val2,val3)
    tempTXT = ""
    if isnull(val) then val = ""
    if len(val) < Cint(val3) Then
      for i=1 to Cint(val3) - len(val)
        tempTXT = tempTXT & val2
      next
      tempTXT = tempTXT & val
    else
      tempTXT = val
    end if
    strLenCheck = tempTXT
  end function

'######################
'객체스트링 만들기
'######################
Function dotstr(ddstr) '쌍타옴표 처리
	dotstr = """"&ddstr&""""
End Function

function keyvaluestr(objstr, keystr,valuestr, tag)
	Dim jsonstr
	If tag = "{" Or tag = "[" Or tag = "[{" Or tag = "{[" then
		If InStr(valuestr, "{") > 0 Or InStr(valuestr, "[") > 0 Then
			jsonstr = "," & tag & dotstr(keystr) & ":"  & valuestr
		else
			jsonstr = "," & tag & dotstr(keystr) & ":"  & dotstr(valuestr)
		End if
	Else
		If InStr(valuestr, "{") > 0 Or InStr(valuestr, "[") > 0 Then
			jsonstr = objstr & "," & dotstr(keystr) & ":"  & valuestr & tag
		else
			jsonstr = objstr & "," & dotstr(keystr) & ":"  & dotstr(valuestr) & tag
		End if
	End If
	keyvaluestr = jsonstr
End function
'######################


If tidx = "" Then
  response.write "{""jlist"": ""nodata""}"
  Response.end
End If

  selectCheck = "select stateno from sd_TennisTitle where GameTitleIDX = '"& tidx &"' and stateno = 1 "
  Set rsCheck = db.ExecSQLReturnRS(selectCheck , null, ConStr)
  if rsCheck.eof then
    response.write "{""jlist"": ""nodata""}"
    response.end
  end if
  set rsCheck = nothing

  'title 가져오기
  sqltitle = "select "_
          	&" AA.gameno, "_
          	&" DD.TeamGbNm +' '+ DD.levelNm +' '+ DD.ridingclass +' '+ DD.ridingclasshelp as titlename, "_
          	&" (select top 1 a.gametime from tblRGameLevel a where a.DelYN = 'N' and AA.gameno = a.gameno and CC.GameTitleIDX = a.GameTitleIDX order by a.RGameLevelidx) as sgametime, "_
          	&" (select top 1 b.gametimeend from tblRGameLevel b where b.DelYN = 'N' and AA.gameno = b.gameno and CC.GameTitleIDX = b.GameTitleIDX order by b.RGameLevelidx) as egametime "_
          	&" from sd_TennisTitle CC "_
          	&" inner join  tblRGameLevel AA on CC.GameTitleIDX = AA.GameTitleIDX "_
          	&" left join tblTeamGbInfo DD on AA.GbIDX = DD.TeamGbIDX "_
          	&" where CC.DelYN = 'N' and AA.DelYN = 'N' and CC.GameTitleIDX = '"& tidx &"' and AA.gameno = '"& gameno &"' "_
          	&" and AA.GameDay in (select top 1 GameDay from tblRGameLevel where delyn = 'N' and GameTitleIDX  = '"& tidx &"' and gameno = '"& gameno &"' group by GameDay order by gameday) "_
          	&" group by CC.GameTitleIDX,AA.gameno,AA.GbIDX,AA.GameDay,DD.TeamGbNm,DD.levelNm,DD.ridingclass,DD.ridingclasshelp "
  set rstitle = db.ExecSQLReturnRS(sqltitle , null, ConStr)

  toptitle = null
  if not rstitle.eof Then
    toptitle = rstitle.getrows()
  end if
  set rstitle = Nothing


  'title 제 i 경기 가져오기
  sqlCount = "select rank() over (order by (select top 1 a.gametime from tblRGameLevel a where a.DelYN = 'N' and AA.gameno = a.gameno and AA.GameTitleIDX = a.GameTitleIDX order by a.RGameLevelidx)) as ranks,gameno, "_
            &" (select top 1 a.gametime from tblRGameLevel a where a.DelYN = 'N' and AA.gameno = a.gameno and AA.GameTitleIDX = a.GameTitleIDX order by a.RGameLevelidx) as sgametime "_
            &" from tblRGameLevel AA "_
            &" where DelYN = 'N' and GameTitleIDX = '"& tidx &"' group by GameTitleIDX,gameno"
  set rscount = db.ExecSQLReturnRS(sqlCount , null, ConStr)

  titlecount = null
  if not rscount.eof Then
    titlecount = rscount.getrows()
  end if
  set rscount = nothing

  'player list 가져오기   필드끝값 6, 13, 28
  sql = "select "_
      &" AA.GameTitleIDX,AA.gameno,BB.PlayerIDX,BB.userName+' / '+CC.userName as userName,BB.noticetitle,BB.pubName+' '+BB.TeamANa as teaminfo,BB.gametime "_
      &" ,AA.judgecnt,AA.judgeshowYN,AA.GbIDX,DD.TeamGb,DD.TeamGbNm,DD.ridingclass,DD.ridingclasshelp "_
      &" ,BB.gamest,BB.[Round],BB.score_sgf,BB.score_1,BB.score_2,BB.score_3,BB.score_4,BB.score_5,BB.score_6,BB.score_total,BB.score_per,BB.boo_orderno,BB.total_order,BB.tryoutgroupno,BB.gubun "_
      &" ,(select kgame from sd_TennisTitle EE where AA.GameTitleIDX = EE.GameTitleIDX) as kgame "_
      &" ,AA.judgeB,AA.judgeE,AA.judgeM,AA.judgeC,judgeH,BB.per_1,BB.per_2,BB.per_3,BB.per_4,BB.per_5,tryoutresult,gamenostr "_

	  &" from tblRGameLevel AA "_
	  &" inner join sd_tennismember BB on AA.GbIDX = BB.gamekey3 and AA.GameTitleIDX = BB.GameTitleIDX "_
      &" LEFT JOIN sd_tennisMember_partner CC on BB.gameMemberIDX = CC.gameMemberIDX "_
      &" left join tblTeamGbInfo DD on AA.GbIDX = DD.TeamGbIDX "_
      &" where AA.DelYN = 'N' and BB.DelYN = 'N' and DD.DelYN = 'N' and AA.GameTitleIDX = '"& tidx &"' and AA.gameno = '"& gameno &"' "_
      &" group by AA.GameTitleIDX,AA.gameno,BB.PlayerIDX,BB.userName,CC.userName,BB.TeamANa,AA.judgecnt,AA.judgeshowYN,AA.GbIDX,DD.TeamGb,DD.TeamGbNm "_
      &" ,BB.gamest,BB.score_sgf,BB.score_1,BB.score_2,BB.score_3,BB.score_4,BB.score_5,BB.score_6,BB.score_total,BB.score_per,BB.boo_orderno,BB.total_order,BB.pubName,BB.gametime "_
      &" ,DD.ridingclass,DD.ridingclasshelp,BB.[Round],BB.tryoutsortNo,BB.tryoutgroupno,BB.gubun,BB.noticetitle "_
      &" ,AA.judgeB,AA.judgeE,AA.judgeM,AA.judgeC,judgeH,BB.per_1,BB.per_2,BB.per_3,BB.per_4,BB.per_5,tryoutresult,gamenostr "_
      &" order by BB.[Round],BB.tryoutsortNo,BB.tryoutgroupno"
  set rs = db.ExecSQLReturnRS(sql , null, ConStr)

	Dim fielddic
	Set fielddic = Server.CreateObject("Scripting.Dictionary") '필드를 좀더 쉽게 찾자.
	For i = 0 To Rs.Fields.Count - 1
		fielddic.Add LCase(Rs.Fields(i).name), i
	Next

	if rs.eof Then
	arrRS = ""
	Else
	arrRS = rs.getrows()
	end if
	set rs = Nothing





Function setJsonTorsA(arr, tidx)
	Dim rsObj,subObj, i
	Dim ar

	Dim Roundcheck,countno ,nameTag, nochk,sHour,sMinute,objstr,strJson,tabletype,scoreJson,judgeJson,ridingclass
	Dim roundno, gubun,kgame,ridingclasshelp,tryoutresult,gamest,gametime,noticetitle,TeamGb,userName,TeamGbNm,teaminfo,judgeshowYN,judgeB,judgeE,judgeM,judgeC,judgeH
	Dim per_1,per_2,per_3,per_4,per_5,score_per,boo_orderno,total_order
	Dim SQL , rs, fldnm, strwhere, arrRS

	Dim sortno, s1,s2,s3,total1, total2, b_order,t_order,roundno2,gamest2		,resultok, rowstart
	Dim fdic


		If IsArray(arr) Then

			TeamGb = arr(fielddic.Item("teamgb"), 0)
			ridingclass = arr(fielddic.Item("ridingclass"), 0)
			gbidx = arr(fielddic.Item("gbidx"), 0)

			if TeamGb = "20103" Then '복합마술


				If  InStr(ridingclass,"마장마술") > 0  Then	'Else '장애물
					'장애물 정보가져오기 (복합마술은 단체전 및 장애물 재경기가 없다)
					'결과가 있다면 결과 정보가져오기
					'tryoutgroupno 공지 100 기타 위아래 붙는숫자 (총비율 score_per,  소요시간 score_total, 시간감점 score_1 ,  장애감점 score_2, 감점합계 score_2, 순위(부) boo_orderno, 순위(총) total_order, 복합총정 score_total2
					fldnm = " tryoutsortno,   score_1,score_2,score_3, score_total,score_total2, score_per,boo_orderno,total_order  ,gamest,round "
					strwhere = "gametitleidx = " & tidx & " and delYN = 'N' and teamgb = '20103' and (( gamekey3 <> '"&gbidx&"' and round = 1) or (round = 2))  and gubun < 100 "
					SQL = "Select "&fldnm&" from SD_tennisMember where "&strwhere&" order by [round], tryoutsortno  "
					Set rs = db.ExecSQLReturnRS(SQL , null, ConStr)
					if rs.eof Then
						arrRS = ""
					Else

						Set fdic = Server.CreateObject("Scripting.Dictionary") '필드를 좀더 쉽게 찾자.
						For i = 0 To Rs.Fields.Count - 1
							fdic.Add LCase(Rs.Fields(i).name), i
						Next
						arrRS = rs.getrows()
						For ar = LBound(arrRS, 2) To UBound(arrRS, 2)
							roundno2 = arrRS(fdic.Item("round"), ar)
							If roundno2 = "2" Then '결과 있음..
								rowstart = ar
								'Response.write rowstart & "<br>"
								resultok = True
								Exit for
							End if
						next
					end if
					set rs = Nothing

				Else



					'장애물 정보가져오기 (복합마술은 단체전 및 장애물 재경기가 없다)
					'결과가 있다면 결과 정보가져오기
					'tryoutgroupno 공지 100 기타 위아래 붙는숫자 (총비율 score_per,  소요시간 score_total, 시간감점 score_1 ,  장애감점 score_2, 감점합계 score_2, 순위(부) boo_orderno, 순위(총) total_order, 복합총정 score_total2
					fldnm = " tryoutsortno,   score_1,score_2,score_3, score_total,score_total2, score_per,boo_orderno,total_order  ,gamest,round, username "
					strwhere = "gametitleidx = " & tidx & " and delYN = 'N' and teamgb = '20103' and (( gamekey3 <> '"&gbidx&"' and round = 1) or (round = 2))  and gubun < 100 "
					SQL = "Select "&fldnm&" from SD_tennisMember where "&strwhere&" order by [round], tryoutsortno  "
					Set rs = db.ExecSQLReturnRS(SQL , null, ConStr)
					if rs.eof Then
						arrRS = ""
					Else

						Set fdic = Server.CreateObject("Scripting.Dictionary") '필드를 좀더 쉽게 찾자.
						For i = 0 To Rs.Fields.Count - 1
							fdic.Add LCase(Rs.Fields(i).name), i
						Next
						arrRS = rs.getrows()
						For ar = LBound(arrRS, 2) To UBound(arrRS, 2)
							roundno2 = arrRS(fdic.Item("round"), ar)
							If roundno2 = "2" Then '결과 있음..
								rowstart = ar
								'Response.write rowstart & "<br>"
								resultok = True
								Exit for
							End if
						next
					end if
					set rs = Nothing
'Call getrowsdrow(arrrs)
				End if
			End if



		    Roundcheck = arr(fielddic.Item("round"), 0)
			countno = "0"
			nochk = 0
			row = 0

			For ar = LBound(arr, 2) To UBound(arr, 2)


						'쿼리 필드 값 지정
							roundno = arr(fielddic.Item("round"), ar)
							gubun = arr(fielddic.Item("gubun"), ar)
							kgame = arr(fielddic.Item("kgame"), ar)
							ridingclasshelp = arr(fielddic.Item("ridingclasshelp"), ar)
							ridingclass = arr(fielddic.Item("ridingclass"), ar)
							tryoutresult = arr(fielddic.Item("tryoutresult"), ar) '기권  : 기본 0 일반
							gamest = arr(fielddic.Item("gamest"), ar) '게임상태 화면표시용
							gametime = arr(fielddic.Item("gametime"), ar)
							noticetitle = arr(fielddic.Item("noticetitle"), ar)
							TeamGb = arr(fielddic.Item("teamgb"), ar)
							userName = arr(fielddic.Item("username"), ar)
							TeamGbNm = arr(fielddic.Item("teamgbnm"), ar)
							teaminfo = arr(fielddic.Item("teaminfo"), ar)
							judgeshowYN = arr(fielddic.Item("judgeshowyn"), ar)
							judgeB = arr(fielddic.Item("judgeb"), ar)
							judgeE = arr(fielddic.Item("judgee"), ar)
							judgeM = arr(fielddic.Item("judgem"), ar)
							judgeC = arr(fielddic.Item("judgec"), ar)
							judgeH = arr(fielddic.Item("judgeh"), ar)
							per_1 = arr(fielddic.Item("per_1"), ar)
							per_2 = arr(fielddic.Item("per_2"), ar)
							per_3 = arr(fielddic.Item("per_3"), ar)
							per_4 = arr(fielddic.Item("per_4"), ar)
							per_5 = arr(fielddic.Item("per_5"), ar)
							score_per = arr(fielddic.Item("score_per"), ar)

							boo_orderno = arr(fielddic.Item("boo_orderno"), ar)
							total_order = arr(fielddic.Item("total_order"), ar)


							s1 = arr(fielddic.Item("score_1"), ar) '시간감점
							If isnumeric(s1) = true then
							s1 = FormatNumber(s1,2)
							End if
							s2 = arr(fielddic.Item("score_2"), ar) '장애감점
							s3 = arr(fielddic.Item("score_3"), ar) '감점합계

							s4 = arr(fielddic.Item("score_4"), ar)
							If isnumeric(s4) = true then
							s4 = FormatNumber(s4,2)
							End if
							s5 = arr(fielddic.Item("score_5"), ar)
							s6 = arr(fielddic.Item("score_6"), ar)

							sortno = arr(fielddic.Item("tryoutsortno"), ar) '경기순서


							total1 = arr(fielddic.Item("score_total"), ar) '소요시간
						'쿼리 필드 값 지정


						if gubun <> "100" then
						if TeamGb = "20103" Then '복합마술
							If IsArray(arrRS) Then '선태안된 종목값.
								'총비율 score_per,  소요시간 score_total, 시간감점 score_1 ,  장애감점 score_2, 감점합계 score_2, 순위(부) boo_orderno, 순위(총) total_order, 복합총정 score_total2
								'sortno, s1,s2,s3,total1, total2, per, b_order,t_order,roundno2

								sortno = arrRS(fdic.Item("tryoutsortno"), row)
								gamest2 = arrRS(fdic.Item("gamest"), row)
								roundno2 = arrRS(fdic.Item("round"), row)

								If InStr(ridingclass,"마장마술") > 0 Then '선택된항목이 마장마술이면
									total1 = arrRS(fdic.Item("score_total"), row) '소요시간
									s1 = arrRS(fdic.Item("score_1"), row)
									s2 = arrRS(fdic.Item("score_2"), row)
									s3 = arrRS(fdic.Item("score_3"), row)
								Else
									score_per = arrRS(fdic.Item("score_per"), row)
								End if

								'결과가 생성되었으니 기존꺼 덥자.
								If resultok = True Then '결과가 생성된 상태라면
									sortno = arrRS(fdic.Item("tryoutsortno"), rowstart) '경기순서
									s1 = arrRS(fdic.Item("score_1"), rowstart) '시간감점
									s2 = arrRS(fdic.Item("score_2"), rowstart) '장애감점
									s3 = arrRS(fdic.Item("score_3"), rowstart) '감점합계
									total1 = arrRS(fdic.Item("score_total"), rowstart) '소요시간
									total2 = arrRS(fdic.Item("score_total2"), rowstart)  '복합마술 총점
									score_per = arrRS(fdic.Item("score_per"), rowstart) '총비율
									b_order = arrRS(fdic.Item("boo_orderno"), rowstart)
									t_order = arrRS(fdic.Item("total_order"), rowstart)
									rowstart = rowstart + 1
								End If

								row = row + 1

							End if
						End If
						End if


						nameTag = nameTagstatus(kgame, Roundno, ridingclasshelp)
						sHour = strLenCheck(Hour(gametime),"0",2)
						sMinute = strLenCheck(Minute(gametime),"0",2)

						If Roundcheck = roundno Then '라운드 변경여부 비교
							if gubun <> "100" then countno = countno + 1
						Else
					        if gubun <> "100" then countno = 1 else countno = 0 end if
					        Roundcheck = roundno
					        nochk = nochk + 1
							objstr = keyvaluestr(objstr,"gubun","1","{")
							objstr = keyvaluestr(objstr,"txt",nameTag,"")
							objstr = keyvaluestr(objstr,"tableinfo","","")
							objstr = keyvaluestr(objstr,"tabletype","","}")
							strJson = strJson & objstr
						End If

					    If nameTag <> "" then nameTag = nameTag & "-"

						if tryoutresult = "0" Or isNull(tryoutresult) = true Then	'기권이 아닐때.

							if gamest = "1" or gamest = "2" or gamest = "4" Then '경기종료가 아닐때

								if gubun = "100" Then '공지사항
									objstr = keyvaluestr(objstr,"time",sHour &":"& sMinute,"{")
									objstr = keyvaluestr(objstr,"name","공지사항","")
									objstr = keyvaluestr(objstr,"txt",noticetitle,"")
									objstr = keyvaluestr(objstr,"tabletype","","")
									objstr = keyvaluestr(objstr,"tableinfo","","")
									objstr = keyvaluestr(objstr,"no","","}")
									strJson = strJson & objstr
								else
									'마장마술일때
									if TeamGb = "20101" or TeamGb = "20201" Or  ( TeamGb = "20103" and InStr(ridingclass,"마장마술") > 0)  Then
										objstr = keyvaluestr(objstr,"time",sHour &":"& sMinute,"{")


										objstr = keyvaluestr(objstr,"sno",sortno,"")										

										objstr = keyvaluestr(objstr,"name",userName,"")
										objstr = keyvaluestr(objstr,"status",gamestatus(gamest),"")
										objstr = keyvaluestr(objstr,"event",TeamGbNm,"")
										objstr = keyvaluestr(objstr,"div",teaminfo,"")
										objstr = keyvaluestr(objstr,"tabletype","","")
										objstr = keyvaluestr(objstr,"tableinfo","","")
										objstr = keyvaluestr(objstr,"no",countno,"}")
										strJson = strJson & objstr
									else
										objstr = keyvaluestr(objstr,"time",toptitle(2,0),"{")

										objstr = keyvaluestr(objstr,"sno",sortno,"")
										
										objstr = keyvaluestr(objstr,"name",nameTag & userName,"")
										objstr = keyvaluestr(objstr,"status",gamestatus(gamest),"")
										objstr = keyvaluestr(objstr,"event",TeamGbNm,"")
										objstr = keyvaluestr(objstr,"div",teaminfo,"")
										objstr = keyvaluestr(objstr,"tabletype","","")
										objstr = keyvaluestr(objstr,"tableinfo","","")
										objstr = keyvaluestr(objstr,"no",countno,"}")
										strJson = strJson & objstr
									end if
								end if
							ElseIf  gamest = "3" Then  '경기 종료일때 #########
								if TeamGb = "20101" or TeamGb = "20201" or ( TeamGb = "20103" and InStr(ridingclass,"마장마술") > 0) Then '마장마술일때

									'점수노출을원할때
									if judgeshowYN = "Y" then
										tabletype = "MA"
										scoreJson = ""
										judgeJson = ""
										if judgeB = "Y" then scoreJson = scoreJson & ",{""location"": ""B"",""grade"": """& per_1 &"""}"
										if judgeE = "Y" then scoreJson = scoreJson & ",{""location"": ""E"",""grade"": """& per_2 &"""}"
										if judgeM = "Y" then scoreJson = scoreJson & ",{""location"": ""M"",""grade"": """& per_3 &"""}"
										if judgeC = "Y" then scoreJson = scoreJson & ",{""location"": ""C"",""grade"": """& per_4 &"""}"
										if judgeH = "Y" then scoreJson = scoreJson & ",{""location"": ""H"",""grade"": """& per_5 &"""}"

										judgeJson = "[{""judge"":["& mid(scoreJson,2) &"],""judgeall"": """& score_per &""",""rankingpart"": """& boo_orderno &""",""rankingall"": """& total_order &"""}]"
									Else  '점수노출을 원하지 않을때
										tabletype = "MB"
										judgeJson = "[{""judgeall"": """& score_per &""",""rankingpart"": """& boo_orderno &""",""rankingall"": """& total_order &"""}]"
									end If

										'복합마술 ###########
										If TeamGb = "20103" Then
											tabletype = "SUM"
											judgeJson = keyvaluestr(judgeJson,"judgeall", score_per ,"[{") '총비율
											judgeJson = keyvaluestr(judgeJson,"timeall",s1,"")	'총소요시간
											judgeJson = keyvaluestr(judgeJson,"timeminus",s2,"") '시간감점
											judgeJson = keyvaluestr(judgeJson,"disminus",s3,"") '장애감점
											judgeJson = keyvaluestr(judgeJson,"minusall",total1,"") '감점합계
											judgeJson = keyvaluestr(judgeJson,"totalscore",total2,"") '복합마술 총점
											judgeJson = keyvaluestr(judgeJson,"rankingpart",b_order, "")  '순위(부별)
											judgeJson = keyvaluestr(judgeJson,"rankingall",t_order, "}]") '순위(전체)
						                    judgeJson = mid(judgeJson,2)
										End If
										'복합마술 ###########

										objstr = keyvaluestr(objstr,"time", sHour &":"& sMinute ,"{")

										objstr = keyvaluestr(objstr,"sno",sortno,"")
										
										objstr = keyvaluestr(objstr,"name",userName,"")
										objstr = keyvaluestr(objstr,"status",gamestatus(gamest),"")
										objstr = keyvaluestr(objstr,"event",TeamGbNm,"")
										objstr = keyvaluestr(objstr,"div",teaminfo,"")
										objstr = keyvaluestr(objstr,"tabletype",tabletype,"")
										objstr = keyvaluestr(objstr,"tableinfo",judgeJson, "") '내부에서 파인트처리
										objstr = keyvaluestr(objstr,"no",countno,"}")
										strJson = strJson & objstr

								ElseIf TeamGb = "20102" or TeamGb = "20202" or ( TeamGb = "20103" and InStr(ridingclass,"장애물") > 0)  Then '장애물일때
									'장애물 타입별 구분
									if ridingclasshelp = CONST_TYPEA1 or ridingclasshelp = CONST_TYPEA2 then
										judgeJson = "[{""timeall"": """& s1 &""",""timeminus"": """& s2 &""",""disminus"": """& s3 &""",""minusall"": """& total1 &""",""rankingpart"": """& boo_orderno &""",""rankingall"": """& total_order &"""}]"
										tabletype = "A"

									elseif ridingclasshelp = CONST_TYPEB then
										judgeJson = "[{""timeall1"": """& s1 &""",""timeminus1"": """& s2 &""",""disminus1"": """& s3 &""",""minusall1"": """& total1 &""","
										judgeJson = judgeJson & """timeall2"": """& s4 &""",""timeminus2"": """& s5 &""",""disminus2"": """& s6 &""",""minusall2"": """& score_per &""","
										judgeJson = judgeJson & """rankingpart"": """& boo_orderno &""",""rankingall"": """& total_order &"""}]"
										tabletype = "2P"

									elseif ridingclasshelp = CONST_TYPEC then
										judgeJson = "[{""timeall"": """& s1 &""",""minustime"": """& s2 &""",""totaltime"": """& total1 &""",""rankingpart"": """& boo_orderno &""",""rankingall"": """& total_order &"""}]"
										tabletype = "C"

									elseif ridingclasshelp = CONST_TYPEA_1 then
										judgeJson = "[{""timeall"": """& s1 &""",""timeminus"": """& s2 &""",""disminus"": """& s3 &""",""minusall"": """& total1 &""",""rankingpart"": """& boo_orderno &""",""rankingall"": """& total_order &"""}]"
										tabletype = "A"

									End If

										'복합마술 ###########
										If TeamGb = "20103" Then
											tabletype = "SUM"
											judgeJson = keyvaluestr(judgeJson,"judgeall", score_per ,"[{") '총비율
											judgeJson = keyvaluestr(judgeJson,"timeall",s1,"")	'총소요시간
											judgeJson = keyvaluestr(judgeJson,"timeminus",s2,"") '시간감점
											judgeJson = keyvaluestr(judgeJson,"disminus",s3,"") '장애감점
											judgeJson = keyvaluestr(judgeJson,"minusall",total1,"") '감점합계
											judgeJson = keyvaluestr(judgeJson,"totalscore",total2,"") '복합마술 총점
											judgeJson = keyvaluestr(judgeJson,"rankingpart",b_order, "")  '순위(부별)
											judgeJson = keyvaluestr(judgeJson,"rankingall",t_order, "}]") '순위(전체)
						                    judgeJson = mid(judgeJson,2)
										End If
										'복합마술 ###########

										objstr = keyvaluestr(objstr,"time", toptitle(2,0) ,"{")

										objstr = keyvaluestr(objstr,"sno",sortno,"")

										objstr = keyvaluestr(objstr,"name",nameTag & userName,"")
										objstr = keyvaluestr(objstr,"status",gamestatus(gamest),"")
										objstr = keyvaluestr(objstr,"event",TeamGbNm,"")
										objstr = keyvaluestr(objstr,"div",teaminfo,"")
										objstr = keyvaluestr(objstr,"tabletype",tabletype,"")
										objstr = keyvaluestr(objstr,"tableinfo",judgeJson, "") '내부에서 파인트처리
										objstr = keyvaluestr(objstr,"no",countno,"}")
										strJson = strJson & objstr
								Else
									'이외의 경기방식 추가 사항
									'경기가 추가되면 이곳에 정리.
								End if
							End if

						Else '기권 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
							judgeJson = ""
							scoreJson = ""
							tabletype = ""
							if gubun = "100" Then '공지사항
								objstr = keyvaluestr(objstr,"time",sHour &":"& sMinute,"{")

								objstr = keyvaluestr(objstr,"sno",sortno,"")

								objstr = keyvaluestr(objstr,"name","공지사항","")
								objstr = keyvaluestr(objstr,"txt",noticetitle,"")
								objstr = keyvaluestr(objstr,"tabletype","","")
								objstr = keyvaluestr(objstr,"tableinfo","","")
								objstr = keyvaluestr(objstr,"no","","}")
								strJson = strJson & objstr
							Else
							'마장마술일때
							if TeamGb = "20101" or TeamGb = "20201" or ( TeamGb = "20103" and InStr(ridingclass,"마장마술") > 0) Then
								if judgeshowYN = "Y" then
										tabletype = "MA"
										if judgeB = "Y" then scoreJson = scoreJson & ",{""location"": ""B"",""grade"": ""-""}"
										if judgeE = "Y" then scoreJson = scoreJson & ",{""location"": ""E"",""grade"": ""-""}"
										if judgeM = "Y" then scoreJson = scoreJson & ",{""location"": ""M"",""grade"": ""-""}"
										if judgeC = "Y" then scoreJson = scoreJson & ",{""location"": ""C"",""grade"": ""-""}"
										if judgeH = "Y" then scoreJson = scoreJson & ",{""location"": ""H"",""grade"": ""-""}"
										judgeJson = "[{""judge"":["& mid(scoreJson,2) &"],""judgeall"": """& givupstatus(tryoutresult) &""",""rankingpart"": """& boo_orderno &""",""rankingall"": """& total_order &"""}]"
								Else
									  tabletype = "MB"
									  judgeJson = "[{""judgeall"": """& givupstatus(tryoutresult) &""",""rankingpart"": """& boo_orderno &""",""rankingall"": """& total_order &"""}]"
								end If

								'복합마술 ###########
								If TeamGb = "20103" Then
									tabletype = "SUM"
									judgeJson = keyvaluestr(judgeJson,"judgeall", "-" ,"[{") '총비율
									judgeJson = keyvaluestr(judgeJson,"timeall","-","")	'소요시간
									judgeJson = keyvaluestr(judgeJson,"timeminus","-","") '시간감점
									judgeJson = keyvaluestr(judgeJson,"disminus","-","") '장애감점
									judgeJson = keyvaluestr(judgeJson,"minusall","-","") '감점합계
									judgeJson = keyvaluestr(judgeJson,"totalscore","-","") '복합마술 총점
									judgeJson = keyvaluestr(judgeJson,"rankingpart",b_order, "")  '순위(부별)
									judgeJson = keyvaluestr(judgeJson,"rankingall",t_order, "}]") '순위(전체)
                  judgeJson = mid(judgeJson,2)
								End If
								'복합마술 ###########

								objstr = keyvaluestr(objstr,"time", sHour &":"& sMinute ,"{")

								objstr = keyvaluestr(objstr,"sno",sortno,"")

								objstr = keyvaluestr(objstr,"name",userName,"")
								objstr = keyvaluestr(objstr,"status",givupstatus(tryoutresult),"")
								objstr = keyvaluestr(objstr,"event",TeamGbNm,"")
								objstr = keyvaluestr(objstr,"div",teaminfo,"")
								objstr = keyvaluestr(objstr,"tabletype",tabletype,"")
								objstr = keyvaluestr(objstr,"tableinfo",judgeJson, "") '내부에서 파인트처리
								objstr = keyvaluestr(objstr,"no",countno,"}")
								strJson = strJson & objstr

							'장애물
							elseif TeamGb = "20102" or TeamGb = "20202" or ( TeamGb = "20103" and InStr(ridingclass,"장애물") > 0) Then
								if ridingclasshelp = CONST_TYPEA1 or ridingclasshelp = CONST_TYPEA2 then
									judgeJson = "[{""timeall"": ""-"",""timeminus"": ""-"",""disminus"": ""-"",""minusall"": """& givupstatus(tryoutresult) &""",""rankingpart"": """& boo_orderno &""",""rankingall"": """& total_order &"""}]"
									tabletype = "A"
								elseif ridingclasshelp = CONST_TYPEB then
									judgeJson = "[{""timeall1"": ""-"",""timeminus1"": ""-"",""disminus1"": ""-"",""minusall1"": ""-"","
									judgeJson = judgeJson & """timeall2"": ""-"",""timeminus2"": ""-"",""disminus2"": ""-"",""minusall2"": """& givupstatus(tryoutresult) &""","
									judgeJson = judgeJson & """rankingpart"": """& boo_orderno &""",""rankingall"": """& total_order &"""}]"
									tabletype = "2P"

								elseif ridingclasshelp = CONST_TYPEC then
									judgeJson = "[{""timeall"": ""-"",""minustime"": ""-"",""totaltime"": """& givupstatus(tryoutresult) &""",""rankingpart"": """& boo_orderno &""",""rankingall"": """& total_order &"""}]"
									tabletype = "C"

								elseif ridingclasshelp = CONST_TYPEA_1 then
									judgeJson = "[{""timeall"": ""-"",""timeminus"": ""-"",""disminus"": ""-"",""minusall"": """& givupstatus(tryoutresult) &""",""rankingpart"": """& boo_orderno &""",""rankingall"": """& total_order &"""}]"
									tabletype = "A"
								else
								  '이외 장애물 경기 추가
								end If

								'복합마술 ###########
								If TeamGb = "20103" Then
									tabletype = "SUM"
									judgeJson = keyvaluestr(judgeJson,"judgeall", "-" ,"[{") '총비율
									judgeJson = keyvaluestr(judgeJson,"timeall","-","")	'소요시간
									judgeJson = keyvaluestr(judgeJson,"timeminus","-","") '시간감점
									judgeJson = keyvaluestr(judgeJson,"disminus","-","") '장애감점
									judgeJson = keyvaluestr(judgeJson,"minusall","-","") '감점합계
									judgeJson = keyvaluestr(judgeJson,"totalscore","-","") '복합마술 총점
									judgeJson = keyvaluestr(judgeJson,"rankingpart",b_order, "")  '순위(부별)
									judgeJson = keyvaluestr(judgeJson,"rankingall",t_order, "}]") '순위(전체)
                  judgeJson = mid(judgeJson,2)
								End If
								'복합마술 ###########

								objstr = keyvaluestr(objstr,"time", toptitle(2,0) ,"{")

								objstr = keyvaluestr(objstr,"sno",sortno,"")
								
								objstr = keyvaluestr(objstr,"name",nameTag & userName,"")
								objstr = keyvaluestr(objstr,"status",givupstatus(tryoutresult),"")
								objstr = keyvaluestr(objstr,"event",TeamGbNm,"")
								objstr = keyvaluestr(objstr,"div",teaminfo,"")
								objstr = keyvaluestr(objstr,"tabletype","A","")
								objstr = keyvaluestr(objstr,"tableinfo",judgeJson, "") '내부에서 파인트처리
								objstr = keyvaluestr(objstr,"no",countno,"}")
								strJson = strJson & objstr


							else
								'그외 경기
							end If

							end if
						End if
			Next

			setJsonTorsA = strJson
		Else
			setJsonTorsA = ""
		End if
End Function

'############################################################

titlecounttxt = "제"& arrRS(41,0) & "경기"				 '경기
titletimetxt = toptitle(2,0) &" - "& toptitle(3,0)   '경기시간
titletoptxt = toptitle(1,0)								 '경기 타이틀 전체
jsondata =  setJsonTorsA(arrRS, tidx)


'Response.write mid(jsondata,2)
'Response.write "<br><br>"

If jsondata = "" Then
   response.write "{""jlist"": ""nodata""}"
   Response.end
End if


Set JsonA = JSON.Parse("{}")
Set JsonB = JSON.Parse("{}")
	Call JsonB.Set("no", titlecounttxt )
	Call JsonB.Set("time", titletimetxt )
	Call JsonB.Set("title", titletoptxt )
	Call JsonB.Set("list", array("*REPLACESTR*") ) '스트링으로 변화후 문자열을 생성된 문자열로 치환

arrA = array( JsonB )
Call JsonA.Set("jlist", arrA )

strjson = JSON.stringify(JsonA)
strjson = Replace(strjson, """*REPLACESTR*""", mid(jsondata,2) )
Response.Write strjson


%>

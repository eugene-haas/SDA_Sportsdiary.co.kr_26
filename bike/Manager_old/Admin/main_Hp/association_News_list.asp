<!--#include file="../dev/dist/config.asp"-->
<!--METADATA TYPE="typelib"  NAME="ADODB Type Library" UUID= "00000205-0000-0010-8000-00AA006D2EA4" -->
<object runat="Server" PROGID="ADODB.Command" Id="objCmd" VIEWASTEXT></object>
<%
    '===================================================================================================================================
    'PAGE : /Main_HP/association_News_list.asp
    'DATE : 2018년 04월 18일
    'DESC : [관리자] 협회소식 목록
    '===================================================================================================================================
    Dim iTotalCount, NowPage, iTotalPage, PagePerData, BlockPage
    Dim iDivision, KeyField1, KeyField2, KeyField3, KeyWord
    Dim gRow, i, ry, intNum, Buff, Cnt, SysBuff, SysCnt
    Dim CSeq, Code
    Dim MSeq, Division, SubType, SubTypeName, Name, Subject, FileYN, NoticeYN, ViewCnt, InsDate
    Dim PSeq, FileName, FilePath, FileExt
    Dim ListPage, ViewPage, WritePage

    ' 로그인 체크
    Check_AdminLogin()

    PagePerData = global_PagePerData            ' 한화면에 출력할 갯수
    BlockPage = global_BlockPage                ' 페이징수, 5면 1,2,3,4,5 까지 나오고 다음페이지 나옴

    iDivision = "4"                             ' 현재 페이지 구분값

    ListPage    = "/Main_HP/association_News_list.asp"
    ViewPage    = "/Main_HP/association_News_write.asp"
    WritePage   = "/Main_HP/association_News_write.asp"

    If Request.Form("NowPage") = "" Or IsNumeric(Trim(Request.Form("NowPage"))) = false Then NowPage = 1 Else NowPage = Cdbl(Request.Form("NowPage"))
    If Request.Form("KeyField1") = "" Then KeyField1 = "" Else KeyField1 = fInject(Trim(Request.Form("KeyField1")))
    If Request.Form("KeyField2") = "" Then KeyField2 = "" Else KeyField2 = fInject(Trim(Request.Form("KeyField2")))
    If Request.Form("KeyField3") = "" Then KeyField3 = "" Else KeyField3 = fInject(Trim(Request.Form("KeyField3")))
    If Request.Form("KeyWord") = "" Then KeyWord = "" Else KeyWord = Cstr(fInject(Replace(Trim(Request.Form("KeyWord")),"'","")))

    With objCmd
		.ActiveConnection = DBCon
		.CommandType  = adCmdStoredProc

		.CommandText  = "Community_Board_S"

        .Parameters.Append .CreateParameter("@NowPage", adInteger, adParamInput, 4, NowPage)
		.Parameters.Append .CreateParameter("@PagePerData", adInteger, adParamInput, 4, PagePerData)
		.Parameters.Append .CreateParameter("@BlockPage",adInteger, adParamInput, 4, BlockPage)
        .Parameters.Append .CreateParameter("@iType",adVarChar, adParamInput, 10, "1")              ' 1:조회, 2:총갯수
        .Parameters.Append .CreateParameter("@iDivision",adVarChar, adParamInput, 5, iDivision)
        .Parameters.Append .CreateParameter("@iSubType",adVarChar, adParamInput, 10, KeyField2)
        .Parameters.Append .CreateParameter("@iSearchCol",adVarChar, adParamInput, 5, KeyField3)
        .Parameters.Append .CreateParameter("@iSearchText",adLongVarWChar, adParamInput, 1073741823, KeyWord)
        .Parameters.Append .CreateParameter("@iYear", adVarChar, adParamInput, 5, "")
        .Parameters.Append .CreateParameter("@iNoticeYN", adVarChar, adParamInput, 2, KeyField1)
        .Parameters.Append .CreateParameter("@iLoginID", adVarChar, adParamInput, 30, "")
        .Parameters.Append .CreateParameter("@iNoticeCnt", adVarChar, adParamInput, 5, "")
        .Parameters.Append .CreateParameter("@ipdsgroup", adVarChar, adParamInput, 5, "")
        .Parameters.Append .CreateParameter("@iDayGubun", adVarChar, adParamInput, 5, "")
        .Parameters.Append .CreateParameter("@iColumnistIDX", adLongVarChar, adParamInput, 1073741823, "")
        .Parameters.Append .CreateParameter("@iSearchCol1", adVarChar, adParamInput, 5, "S2N")     'S2Y : 최신순, S2C : 많이본순, S2N: 공지글 우선
        .Parameters.Append .CreateParameter("@Temp1", adVarChar, adParamInput, 1, "")
        .Parameters.Append .CreateParameter("@Temp2", adVarChar, adParamInput, 1, "")
        .Parameters.Append .CreateParameter("@Temp3", adVarChar, adParamInput, 1, "")
        .Parameters.Append .CreateParameter("@Temp4", adVarChar, adParamInput, 1, "")
        .Parameters.Append .CreateParameter("@Temp5", adVarChar, adParamInput, 1, "")

		Set gRow = .Execute

		For ry = .Parameters.Count - 1 to 0 Step -1
            .Parameters.Delete(ry)
        Next
	End With

    If gRow.eof Or gRow.bof Then
		SysBuff	= Null
		SysCnt	= 0
	Else
		SysBuff	= gRow.getrows
		SysCnt	= UBound(SysBuff,2)
	End If

    Set gRow = gRow.NextRecordSet
	iTotalCount     = CDbl(gRow(0))
	iTotalPage      = CDbl(gRow(1))

    Set gRow = gRow.NextRecordSet
    If gRow.eof Or gRow.bof Then
		Buff	= Null
		Cnt		= 0
	Else
		Buff	= gRow.getrows
		Cnt		= UBound(Buff,2)
	End If
    Set gRow = Nothing
%>
<!--#include file="../include/head.asp"-->
<script type="text/javascript">
<!--
	var locationStr = "association_News_list.asp"
												   
    function PagingLink(i2) {
        var KeyField1 = $("#KeyField1").val();
        var KeyField2 = $("#KeyField2").val();
        var KeyField3 = $("#KeyField3").val();
        var KeyWord = $("#KeyWord").val();

        post_to_url('<%=ListPage%>', {'NowPage': i2, 'KeyField1': KeyField1, 'KeyField2': KeyField2, 'KeyField3': KeyField3, 'KeyWord': KeyWord});
    }

    function fn_selSearch() {
        var KeyField1 = $("#KeyField1").val();
        var KeyField2 = $("#KeyField2").val();
        var KeyField3 = $("#KeyField3").val();
        var KeyWord = $("#KeyWord").val();    

        post_to_url('<%=ListPage%>', {'NowPage': 1, 'KeyField1': KeyField1, 'KeyField2': KeyField2, 'KeyField3': KeyField3, 'KeyWord': KeyWord});
    }

    function ReadLink(i1, i2) {
        var KeyField1 = $("#KeyField1").val();
        var KeyField2 = $("#KeyField2").val();
        var KeyField3 = $("#KeyField3").val();
        var KeyWord = $("#KeyWord").val();

        post_to_url('<%=ViewPage%>', {idx: i1, 'pType': 'M', 'NowPage': i2, 'KeyField1': KeyField1, 'KeyField2': KeyField2, 'KeyField3': KeyField3, 'KeyWord': KeyWord});
    }
//-->
</script>
<!-- S : content association_News_list -->
<div id="content">
    <div class="page_title clearfix">
        <h2>협회소식</h2>

        <!-- S: 네비게이션 -->
        <div  class="navigation_box">
            <span class="ic_deco">
            <i class="fas fa-angle-right fa-border"></i>
            </span>
            <ul>
                <li>홈페이지관리</li>
                <li>협회소식</li>
                <li><a href="<%=ListPage%>">협회소식</a></li>                    
            </ul>
        </div>
        <!-- E: 네비게이션 -->

        <!-- S : sch 검색조건 선택 및 입력 -->
        <form name="s_frm" method="post">
        <div class="search_top community">
            <!-- S: search_box -->
            <div class="search_box" >
                <select name="KeyField1" id="KeyField1" class="title_select">
                    <option value="">:: 공지구분 선택 ::</option>
                    <option value="Y" <%IF KeyField1 = "Y" Then response.write "selected" End IF%>>공지글</option>
                    <option value="N" <%IF KeyField1 = "N" Then response.write "selected" End IF%>>일반글</option>  
                </select>
                <select name="KeyField2" id="KeyField2" class="title_select">
                    <option value="">:: 구분 선택 ::</option>
                    <%
                    If IsNull(SysBuff) = False Then 
                        For i=0 to SysCnt
                            CSeq    = CDbl(SysBuff(0, i))
                            Name    = Trim(SysBuff(1, i))
                            Code    = Trim(SysBuff(2, i))
                    %>
                    <option value="<%=Code%>" <%IF KeyField2 = Code Then response.write "selected" End IF%>><%=Name%></option>
                    <%
                        Next
                    End If
                    %>
                </select>
                <select name="KeyField3" id="KeyField3" class="title_select">
                    <option value="">:: 선택 ::</option>
                    <option value="S" <%IF KeyField3 = "S" Then response.write "selected" End IF%>>제목</option>
                    <option value="C" <%IF KeyField3 = "C" Then response.write "selected" End IF%>>내용</option>                        
                    <option value="T" <%IF KeyField3 = "T" Then response.write "selected" End IF%>>제목+내용</option>
                </select>

                <input type="text" id="KeyWord" name="KeyWord" placeholder="검색어를 입력해주세요" value="<%=KeyWord%>" class="title_input ipt-word">
                <a href="javascript:;" onClick="fn_selSearch();" class="btn btn-search">검색</a>
                <a href="<%=ListPage%>" class="btn btn-blue-empty">전체목록</a>
                <a href="<%=WritePage%>" class="btn btn-add" >협회소식 등록</a>
            </div>
            <!-- E: search-box -->
            <div class="total_count"><span>전체: <%=iTotalCount%></span>, <span><%=NowPage%> page / <%=iTotalPage%> pages</span></div>
        </div>

        <div class="community">
            <!-- S : 리스트형 20개씩 노출 -->   
            <div id="board-contents" class="table-list-wrap">
                <!-- S : table-list -->
                <table class="table-list">
                    <caption class="sr-only">협회소식 리스트</caption>
                    <thead>
                        <tr>
                            <th scope="col" width="60">순번</th>
                            <th scope="col" width="100">구분</th>
                            <th scope="col">제목</th>
                            <th scope="col" width="100">공지유무</th>
                            <th scope="col" width="100">첨부파일</th>
                            <th scope="col" width="100">작성자</th>
                            <th scope="col" width="100">작성일</th>
                            <th scope="col" width="100">조회수</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                        If IsNull(Buff) = True Then 
                            Response.Write "<tr><td colspan=""8"">등록된 게시물이 없습니다.</td></tr>"
                        Else
                            For i=0 To Cnt
                                intNum			= iTotalCount - ((NowPage-1) * PagePerData) - i
                                MSeq			= CDbl(Buff(0, i))
                                Division		= Trim(Buff(1, i))
                                SubType			= Trim(Buff(2, i))
                                SubTypeName     = Trim(Buff(3, i))
                                Name            = Trim(Buff(4, i))
                                Subject         = Trim(Buff(5, i))
                                FileYN          = Trim(Buff(6, i))
                                NoticeYN        = Trim(Buff(7, i))
                                ViewCnt         = CDbl(Buff(8, i))
                                InsDate         = Trim(Buff(9, i))
                                PSeq            = CDbl(Buff(10, i))
                                FileCnt         = CDbl(Buff(10, i))

                                If FileYN = "Y" And FileCnt > 0 Then
                                    FileYN_VAL = "<img src=""/DocImg/Doc/doc_other.png"">"
                                Else
                                    FileYN_VAL = ""
                                End If

								If NoticeYN = "Y" Then
									intNum ="공지"
								End If 
                        %>
                        <tr style="cursor:pointer" onClick="javascript:ReadLink('<%=crypt.EncryptStringENC(MSeq) %>','<%=NowPage %>');">
                            <td><%=intNum %></td>
                            <td><%=SubTypeName %></td>
                            <td class="name"><%=Subject %></td>
                            <td><%=NoticeYN %></td>
                            <td><%=FileYN_VAL%></td>
                            <td><%=Name %></td>
                            <td><%=InsDate %></td>
                            <td><%=ForMatNumber(ViewCnt, 0) %></td>
                        </tr>
                        <%
                            Next
                        End If
                        %>
                    </tbody>
                </table>
                <!-- E : table-list -->

                <%If IsNull(Buff) = False Then%>
                <!-- S: page_index -->
                <div class="page_index">
                <!--#include file="../dev/dist/Paging_Admin.asp"-->
                </div>
                <!-- E: page_index -->
                <%End If%>
            </div>
            <!-- E : 리스트형 20개씩 노출 -->    
        </div>
		</form>						
    </div>
</div>
<!-- E : content association_News_list -->
<!--#include file="../include/footer.asp"-->
<%DBClose()%>
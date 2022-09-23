<!-- S: config -->
<!-- #include file="../include/config.asp" -->
<!-- E: config -->
<%
	'===============================================================================================
	'내정보관리 페이지
	'===============================================================================================
	Check_Login()
	'===============================================================================================
  	'선수 보호자 회원의 경우
  	'MemberIDX 쿠키 교체되었기 때문에 선수보호자 MemberIDX로 교체
	'===============================================================================================
'  	dim MemberIDX   : MemberIDX = decode(request.Cookies("MemberIDX"),0)
	SELECT CASE decode(request.Cookies("PlayerReln"), 0)
		CASE "A","B","Z"  	: MemberIDX = decode(request.Cookies("P_MemberIDX"),0) 	'부모MemberIDX
		CASE ELSE     		: MemberIDX = decode(request.Cookies("MemberIDX"),0) 	'선수MemberIDX
	END SELECT
	'===============================================================================================

	dim chk_IMG : chk_IMG = FALSE '이미지첨부유무
	dim CSQL, CRs


	CSQL = "        SELECT T.TeamNm "
	CSQL = CSQL & " 	,CASE M.PlayerReln WHEN 'T' THEN L.PersonNum ELSE P.PersonCode END PersonCode "
	CSQL = CSQL & "   	,M.SportsType, M.PlayerIDX, M.UserID, M.UserName, M.UserEnName, M.UserPhone, M.Job, M.Interest, M.Birthday, M.SEX "
	CSQL = CSQL & "   	,M.PlayerStartYear, M.PlayerLevel, M.Tall, M.Weight, M.BloodType, M.Email, M.PhotoPath, M.ZipCode, M.Address  "
	CSQL = CSQL & "   	,M.AddressDtl, M.WriteDate, M.Auth_YN, M.PlayerRelnMemo, M.UserGuainNm, M.UserGuainPhone, M.EmailYn, M.SmsYn, M.Team "
	CSQL = CSQL & "   	,CASE WHEN M.PlayerReln IS NULL OR M.PlayerReln = '' THEN 'R' ELSE PlayerReln END PlayerReln "
	CSQL = CSQL & "   	,M.LeaderType "
	CSQL = CSQL & " 	,SportsDiary.dbo.FN_PubName('sd03900'+M.LeaderType) LeaderTypeNm "
	CSQL = CSQL & " FROM [Sportsdiary].[dbo].[tblMember] M "
	CSQL = CSQL & "     left join [Sportsdiary].[dbo].[tblPlayer] P on P.PlayerIDX = M.PlayerIDX "
	CSQL = CSQL & "       AND P.DelYN = 'N' "
	CSQL = CSQL & "       AND P.SportsGb = '"&SportsGb&"' "
	CSQL = CSQL & "     left join [Sportsdiary].[dbo].[tblLeader] L on L.LeaderIDX = M.LeaderIDX "
	CSQL = CSQL & "       AND L.DelYN = 'N' "
	CSQL = CSQL & "       AND L.SportsGb = '"&SportsGb&"' "
	CSQL = CSQL & "     left join [Sportsdiary].[dbo].[tblTeamInfo] T on M.Team = T.Team "
	CSQL = CSQL & "       AND T.DelYN = 'N' "
	CSQL = CSQL & "       AND T.SportsGb = '"&SportsGb&"' "
	CSQL = CSQL & " WHERE M.DelYN = 'N' "
	CSQL = CSQL & "     AND M.SportsType = '"&SportsGb&"' "
	CSQL = CSQL & "     AND M.MemberIDX = "&MemberIDX

'  response.Write CSQL

	SET CRs = Dbcon.Execute(CSQL)
	IF CRs.eof or CRs.bof Then
		response.Write "<script>alert('일치하는 정보가 없습니다.'); history.back();</script>"
		response.End()
	Else
		SportsType      = CRs("SportsType")
		TeamNm          = CRs("TeamNm")
		PlayerIDX       = CRs("PlayerIDX")
		LeaderType		= CRs("LeaderType")
		LeaderTypeNm	= CRs("LeaderTypeNm")
		UserID          = CRs("UserID")
		UserName        = ReplaceTagReText(CRs("UserName"))
		UserEnName      = ReplaceTagReText(CRs("UserEnName"))
		UserPhone       = CRs("UserPhone")
		Job             = CRs("Job")
		Interest        = CRs("Interest")
		Birthday        = CRs("Birthday")
		SEX             = CRs("SEX")
		PlayerStartYear = CRs("PlayerStartYear")
		PlayerLevel     = CRs("PlayerLevel")
		Tall            = CRs("Tall")
		Weight          = CRs("Weight")
		BloodType       = CRs("BloodType")
		Email           = ReplaceTagReText(CRs("Email"))
		PhotoPath       = CRs("PhotoPath")
		ZipCode         = CRs("ZipCode")
		Address         = ReplaceTagReText(CRs("Address"))
		AddressDtl      = ReplaceTagReText(CRs("AddressDtl"))
		WriteDate       = CRs("WriteDate")
		Auth_YN         = CRs("Auth_YN")
		PlayerReln      = CRs("PlayerReln")
		PlayerRelnMemo  = CRs("PlayerRelnMemo")
		UserGuainNm     = CRs("UserGuainNm")
		UserGuainPhone  = CRs("UserGuainPhone")
		EmailYn         = CRs("EmailYn")
		SmsYn           = CRs("SmsYn")
		Team            = CRs("Team")
		PersonCode      = CRs("PersonCode")

		IF UserPhone <> "" Then
			CUserPhone = split(UserPhone, "-")
			UserPhone1 = CUserPhone(0)
			UserPhone2 = CUserPhone(1)
			UserPhone3 = CUserPhone(2)
		End IF

		IF Email <>"" Then
			CEmail = split(Email, "@")
			Email1 = CEmail(0)
			Email2 = CEmail(1)
		End IF

		IF len(PhotoPath)>1 Then
			chk_IMG = TRUE
			PhotoPath   = "../"& mid(PhotoPath, 4, len(PhotoPath))
		Else
		  	PhotoPath = ImgDefault
		End IF

	  	TeamGb = left(PlayerLevel, 2)

	End IF
		CRs.Close
	SET CRs = Nothing


' response.write "Len="&len(PlayerReln)&"<br>"
' response.write "PlayerReln="&PlayerReln&"<br>"

%>
<body>
<script type="text/javascript">
  //회원정보 수정항목 체크
    function chk_frm(){

    <%
    '선수/관원(R)
    IF PlayerReln = "R" Then
    %>
    //체급체크
    if(!$('#PlayerLevel').val()){
        alert("본인의 체급을 선택해 주세요");
        $('#PlayerLevel').focus();
        return;
    }
    <%
    End IF
    %>

    //영문이름 체크
    if(!$('#UserEnName').val()){
        alert("영문이름을 입력해 주세요.");
        $('#UserEnName').focus();
        return;
    }
    else{

        // /[0-9]|[^\!-z]/gi 영문만 공백포함(\s)
        var regexp = /[0-9]|[^\!-z\s]/gi;

        if(regexp.test($('#UserEnName').val())){
          alert('영문만 입력 가능합니다.');
          $('#UserEnName').focus();
          $('#UserEnName').val($('#UserEnName').val().replace(/[0-9]|[^\!-z\s]/gi,""));
          return;
        }
    }

    //휴대폰번호체크
    if(!$('#UserPhone1').val()){
        alert("휴대폰 번호를 선택해 주세요.");
        $('#UserPhone1').focus();
        return;
    }
    if(!$('#UserPhone2').val()){
        alert("휴대폰 번호를 입력해 주세요.");
        $('#UserPhone2').focus();
        return;
    }
    if(!$('#UserPhone3').val()){
        alert("휴대폰 번호를 입력해 주세요.");
        $('#UserPhone3').focus();
        return;
    }

    //SMS인증체크
    if($('#Hidden_UserPhone1').val()+$('#Hidden_UserPhone2').val()+$('#Hidden_UserPhone3').val()==$('#UserPhone1').val()+$('#UserPhone2').val()+$('#UserPhone3').val()){
        $('#Hidden_SMS').val('Y');
    }

    if($('#Hidden_SMS').val()=="N"){
        alert("휴대폰 번호가 변경되었습니다.\n휴대폰 인증을 진행해 주세요.");
        $('#sms_button').focus();
        return;
    }


    //SMS인증 후 휴대폰 번호가 변경되었는지 검증
    if($('#UserPhone1').val()!=$('#Hidden_UserPhone1').val() || $('#UserPhone2').val()!=$('#Hidden_UserPhone2').val() || $('#UserPhone3').val()!=$('#Hidden_UserPhone3').val()) {
        alert("휴대폰 번호가 변경되었습니다. 재인증을 받아주세요.");
        $('#Hidden_SMS').val("N");
        $('#Auth_Num').val("");
        $('#Re_Auth_Num').val("");

        return;
    }


    //이메일체크
    if(!$('#UserEmail1').val()){
        alert("이메일을 입력해 주세요");
        $('#UserEmail1').focus();
        return;
    }

    if(!$('#UserEmail2').val()){
        alert("이메일을 입력해 주세요");
        $('#UserEmail2').focus();
        return;
    }

    var email = $('#UserEmail1').val() +"@" + $('#UserEmail2').val();
    var regex=/^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/;

    if(!regex.test(email)){
        alert("잘못된 이메일 형식입니다.\n\n입력된 이메일을 확인해주세요");
        return;
    }

    //주소체크
    if(!$('#ZipCode').val()){
        alert("주소를 입력해 주세요");
        return;
    }

    if(!$('#UserAddr').val()){
        alert("주소를 입력해 주세요");
        return;
    }

    //휴대폰인증이 끝났다면 휴대폰 번호 변경이 되었는지 체크
    if($('#Hidden_SMS').val()=="Y"){
        var a = $('#UserPhone1').val() + $('#UserPhone2').val() + $('#UserPhone3').val();
        var b = $('#Hidden_UserPhone1').val() + $('#Hidden_UserPhone2').val() + $('#Hidden_UserPhone3').val();

        if(a!=b){
          //휴대폰번호가 변경이 됐다면 재진행
          alert("휴대폰 번호가 변경되었습니다.\n다시 인증절차를 진행해주세요");
          $('#Hidden_SMS').val("N");
          $('#Auth_Num').val("");
          $('#Re_Auth_Num').val("");

          return;
        }
    }

    var SmsYn = "";
    var EmailYn = "";
    var IntArr = "";

    var strAjaxUrl    	= "../Ajax/join_mod_OK.asp";
    var UserID        	= $('#UserID').val();
    var PlayerIDX     	= $('#PlayerIDX').val();
    var MemberIDX     	= $('#MemberIDX').val();
    var UserEnName    	= $('#UserEnName').val();
    var SEX           	= $('input:radio[name=SEX]:checked').val();
    var PlayerStartYear = $('#PlayerStartYear').val();
    var PlayerTall    	= $('#PlayerTall').val();
    var PlayerWeight  	= $('#PlayerWeight').val();
    var BloodType     	= $('#BloodType').val();
    var UserPhone     	= $('#UserPhone1').val() + "-" + $('#UserPhone2').val() + "-" + $('#UserPhone3').val();
    var UserEmail     	= $('#UserEmail1').val() + "@" + $('#UserEmail2').val();
    var Hidden_SmsYn  	= $('#Hidden_SmsYn').val();
    var Hidden_EmailYn 	= $('#Hidden_EmailYn').val();
    var ZipCode       	= $('#ZipCode').val();
    var UserAddr      	= $('#UserAddr').val();
    var UserAddrDtl   	= $('#UserAddrDtl').val();
    var PlayerLevel   	= $('#PlayerLevel').val();
    var PlayerReln     	= $("#PlayerReln").val();
	var LeaderType     	= $("#LeaderType").val();


    if($("#AgreeSMS").is(":checked") == true){ SmsYn = "Y"}
    else{ SmsYn = "N"}
    if($("#AgreeEmail").is(":checked") == true){ EmailYn = "Y"}
    else{ EmailYn = "N"}

    $.ajax({
      url: strAjaxUrl,
      type: 'POST',
      dataType: 'html',
      data: {
          UserID          	: UserID
          ,PlayerIDX      	: PlayerIDX
          ,MemberIDX      	: MemberIDX
          ,UserEnName     	: UserEnName
          ,SEX            	: SEX
          ,PlayerStartYear 	: PlayerStartYear
          ,PlayerTall      	: PlayerTall
          ,PlayerWeight    	: PlayerWeight
          ,BloodType      	: BloodType
          ,UserPhone     	: UserPhone
          ,UserEmail      	: UserEmail
          ,SmsYn        	: SmsYn
          ,EmailYn     	 	: EmailYn
          ,Hidden_SmsYn    	: Hidden_SmsYn
          ,Hidden_EmailYn  	: Hidden_EmailYn
          ,ZipCode        	: ZipCode
          ,UserAddr       	: UserAddr
          ,UserAddrDtl    	: UserAddrDtl
          ,PlayerLevel    	: PlayerLevel
          ,PlayerReln     	: PlayerReln
		  ,LeaderType     	: LeaderType
        },
      success: function(retDATA) {
        if(retDATA){
          if (retDATA=="TRUE") {

            alert("정보를 업데이트 하였습니다.");

            $('form[name=s_frm]').attr('action',"./myinfo_type2.asp");
            $('form[name=s_frm]').submit();


            //location.href="../Mypage/myinfo_type2.asp"
          }
          else{
            alert('잘못된 접근입니다.\n아이디/비밀번호 정보를 확인해 주세요.');
            return;
          }
        }
      },
      error: function (xhr, status, error) {
               	if (error!='') {
					alert ("조회중 에러발생 - 시스템관리자에게 문의하십시오!"+' ['+xhr+']'+' ['+status+']'+' ['+error+']');
				}
            }
    });
    }

  //이메일 도메인 선택입력
  function chk_Email(){
    if(!$('#EmailList').val()){
      $('#UserEmail2').val("");
    }else{
      $('#UserEmail2').val($('#EmailList').val());
    }
  }

  //SMS인증
  function chk_sms(){
    //휴대폰번호체크
    if(!$('#UserPhone1').val()){
      alert("휴대폰 번호를 선택해 주세요.");
      $('#UserPhone1').focus();
      return;
    }

    if(!$('#UserPhone2').val()){
      alert("휴대폰 번호를 입력해 주세요.");
      $('#UserPhone2').focus();
      return;
    }

    if(!$('#UserPhone3').val()){
      alert("휴대폰 번호를 입력해 주세요.");
      $('#UserPhone3').focus();
      return;
    }

    //휴대폰인증체크 여부
    if($('#Hidden_SMS').val()=="N"){
      //인증진행
      var strAjaxUrl = "../Ajax/Check_AuthNum.asp";
      var UserPhone1 = $('#UserPhone1').val();
      var UserPhone2 = $('#UserPhone2').val();
      var UserPhone3 = $('#UserPhone3').val();

      $.ajax({
        url: strAjaxUrl,
        type: 'POST',
        dataType: 'html',
        data: {
            UserPhone1   : UserPhone1
            ,UserPhone2   : UserPhone2
            ,UserPhone3   : UserPhone3
          },
        success: function(retDATA) {
          if(retDATA){

            var strcut = retDATA.split("|");

            if (strcut[0]=="TRUE") {
              $('#Auth_Num').val(strcut[1]);
              $('#Hidden_UserPhone1').val(strcut[2]);
              $('#Hidden_UserPhone2').val(strcut[3]);
              $('#Hidden_UserPhone3').val(strcut[4]);

              $('#CHK_REAUTH').show();
              $('#chk_Agree').show();
              $('#chk_Agree').text("※인증번호가 발송되었습니다.");
              $('#Re_Auth_Num').focus();
            }
            else{
              alert('인증번호가 발송되지 않았습니다.\n휴대폰 번호를 확인해 주세요');
              return;
            }
          }
        },
        error: function (xhr, status, error) {
               	if (error!='') {
					alert ("조회중 에러발생 - 시스템관리자에게 문의하십시오!"+' ['+xhr+']'+' ['+status+']'+' ['+error+']');
				}
            }
      });
    }
  }

  //인증번호 체크
  function chk_Auth_Num(){
    if(!$('#Re_Auth_Num').val()){
      alert("인증번호를 입력해 주세요.");
      $('#Re_Auth_Num').focus();
      return;
    }
    else{

      var a = $('#Auth_Num').val();
      var b = $('#Re_Auth_Num').val();

      $('#chk_Agree').text("");
      $('#chk_Agree').css("display", "none");

      if(a!=b){
        alert("인증번호가 일치하지 않습니다\n다시 인증절차를 진행하세요");
        $('#Hidden_SMS').val("N");
        //$('#Auth_Num').val("");
        $('#Re_Auth_Num').val("");

        return;
      }
      else{
        alert("인증이 성공하였습니다.");
        $('#CHK_REAUTH').hide();
        $('#Hidden_SMS').val("Y");
        return;
      }
    }
  }

    //회원프로필 이미지 업로드
    function Chk_Write(){
    /*
    if(!$('#b_upFile').val()){
      alert("첨부할 이미지를 선택해주세요.");
      return;
    }
    */

    var strAjaxUrl    = "../Ajax/join_mod_imgOK.asp";
    var formData = new FormData();

    formData.append("MemberIDX", $("#MemberIDX").val());
    formData.append("PlayerIDX", $("#PlayerIDX").val());
    formData.append("b_upFile", $("input[name=b_upFile]")[0].files[0]);

    $.ajax({
      url: strAjaxUrl,
      type: 'POST',
      data: formData,
      processData: false,
      contentType: false,
      success: function(retDATA) {

        var strcut = retDATA.split("|");

        if(strcut[0]=="TRUE"){

          $("#imgMyinfo").attr("src", strcut[1]);
          $("#imgGnb").attr("src", strcut[1]);
          $("#imgDel").css("display",""); //삭제버튼 활성화
          $("#b_upFile").val("");     //input[file] 최기화
          // alert("첨부이미지를 업데이트 하였습니다");
        }
        else{
          switch(strcut[1]) {
            case 1:
              alert("이미지파일만 업로드 가능합니다");
              return;
            case 2:
              alert("첨부할 이미지파일을 선택하세요");
              return;
            case 3:
              alert("일치하는 정보가 없습니다");
              return;
            default:
          }
        }
      },
      error: function (xhr, status, error) {
               	if (error!='') {
					alert ("조회중 에러발생 - 시스템관리자에게 문의하십시오!"+' ['+xhr+']'+' ['+status+']'+' ['+error+']');
				}
            }
    });
  }

  //첨부파일 선택
  function fnUpload(){
    $('#b_upFile').click();
  }

  //다이얼로그에서 이미지 선택시 바로 Save
  $('#b_upFile').live('change', function(){
    Chk_Write();
  });


    //회원프로필 등록된 이미지 삭제와 프로필이미지 기본이미지로 변경
  function Chk_Del_Image(){

    if(confirm("프로필 이미지를 삭제하시겠습니까?")){

      var strAjaxUrl = "../Ajax/join_mod_imgDEL.asp";
      var MemberIDX = $('#MemberIDX').val();
      var PlayerIDX = $('#PlayerIDX').val();

      $.ajax({
        url: strAjaxUrl,
        type: 'POST',
        dataType: 'html',
        data: {       },
        success: function(retDATA) {
          var strcut = retDATA.split("|");

          if(strcut[0]=="TRUE"){
            $("#imgDel").css("display","none");     //삭제버튼 비활성화
            $("#imgGnb").attr("src", "../images/include/gnb/profile@3x.png"); //기본이미지로 초기화
            $("#imgMyinfo").attr("src", "../images/include/gnb/profile@3x.png"); //기본이미지로 초기화
            alert("프로필 이미지를 삭제하였습니다.");
            return;
          }
          else{
            $("#imgDel").css("display","");

            switch(strcut[1]) {
              case 1:
                alert("일치하는 정보가 없습니다.");
                return;
              case 2:
                alert("잘못된 접근입니다.");
                return;
              default:
            }
          }
        }, error: function (xhr, status, error) {
               	if (error!='') {
					alert ("조회중 에러발생 - 시스템관리자에게 문의하십시오!"+' ['+xhr+']'+' ['+status+']'+' ['+error+']');
				}
            }
      });
    }
    else{
      return;
    }
  }

  // label 밑의 input 실행
  function inputExc($this){
    var ipt = $this.find('input');

    if ($this.hasClass('on')) {
      ipt.prop('checked', false);
    }
    else {
      ipt.prop('checked', true);
    }
  }


  //선수데이터 열람동의 History
  function CHK_AgreeHistory(){

    var strAjaxUrl = "../Ajax/myinfo_AgreeHistory_A.asp";
    var PlayerIDX = $('#PlayerIDX').val();
    var PlayerReln = $('#PlayerReln').val();
    var Team = $('#Team').val();

    $.ajax({
      url: strAjaxUrl,
      type: 'POST',
      dataType: 'html',
      data: {
          PlayerIDX   : PlayerIDX
          ,Team       : Team
          ,PlayerReln : PlayerReln

        },
      success: function(retDATA) {

        console.log(retDATA);

        $("#AgrHistory").html(retDATA);

      },
      error: function (xhr, status, error) {
               	if (error!='') {
					alert ("조회중 에러발생 - 시스템관리자에게 문의하십시오!"+' ['+xhr+']'+' ['+status+']'+' ['+error+']');
				}
            }
    });
  }


  function profile_appreceive(str){
    //$("#Hidden_Profile").val(str);
    if (str.match("/FALSE_")){
      alert("사진등록에 실패하였습니다.");
      return;
    }
    else{

      var strAjaxUrl = "../AppConnect/Profilepath.asp";

      $("#imgMyinfo").attr("src","../upload/../upload/" + str);
      $("#imgGnb").attr("src","../upload/../upload/" + str);
      $("#imgMyinfoBig").attr("src","../upload/../upload/" + str);


      $.ajax({
        url: strAjaxUrl,
        type: 'POST',
        dataType: 'html',
        data: {
            str : str
          },
        success: function(retDATA) {
          alert("사진이 등록되었습니다.");
          $("#imgDel").css("display","");     //삭제버튼 활성화

        }, error: function (xhr, status, error) {
               	if (error!='') {
					alert ("조회중 에러발생 - 시스템관리자에게 문의하십시오!"+' ['+xhr+']'+' ['+status+']'+' ['+error+']');
				}
            }
      });
    }
  }


    $(document).ready(function(){

		//회원프로필 첨부이미지 미리보기
		function readURL(input) {
			if (input.files && input.files[0]) {
				//파일을 읽기 위한 FileReader객체 생성
				var reader = new FileReader();

				reader.onload = function (e) {

					//파일 읽어들이기를 성공했을때 호출되는 이벤트 핸들러
					$('#imgMyinfo').attr('src', e.target.result);
					//이미지 Tag의 SRC속성에 읽어들인 File내용을 지정
					//(아래 코드에서 읽어들인 dataURL형식)
				}

			reader.readAsDataURL(input.files[0]);
			//File내용을 읽어 dataURL형식의 문자열로 저장
			}
		}

      //file 양식으로 이미지를 선택(값이 변경) 되었을때 처리하는 코드
      $("#b_upFile").change(function() {
          //alert(this.value); //선택한 이미지 경로 표시
          readURL(this);
      });

	<%
	SELECT CASE PlayerReln
		CASE "R"	'등록선수
		%>
			//선수데이터 열람동의 History
			CHK_AgreeHistory();
			make_box("sel_PlayerLevel","PlayerLevel","","myinfo_PlayerLevel_A");  //체급
			<%
		CASE "A", "B", "Z"  '부모
		'
		%>
			//선수데이터 열람동의 History
			CHK_AgreeHistory();
	<%
	END SELECT
	%>



		if(isMobile.iOS()){
		  $("#btn_Profile_iOS").css("display","");
		  $("#btn_Profile_Android").css("display","none");
		  $("#btn_Profile_PC").css("display","none");
		}
		else if(isMobile.Android()){
		  $("#btn_Profile_iOS").css("display","none");
		  $("#btn_Profile_Android").css("display","");
		  $("#btn_Profile_PC").css("display","none");
		}
		else{
		  $("#btn_Profile_iOS").css("display","none");
		  $("#btn_Profile_Android").css("display","none");
		  $("#btn_Profile_PC").css("display","");
		}

    });

</script>
<!--S: 다음 주소찾기 API-->
<div id="wrap" style="display: none; border:1px solid #000; width:100%; height:100%; margin:48px 0; position: absolute; z-index:1000;"> <img src="//t1.daumcdn.net/localimg/localimages/07/postcode/320/close.png" id="btnFoldWrap" style=" width:17px;cursor:pointer;position:absolute;right:0px;top:-1px;z-index:1" onClick="foldDaumPostcode()" alt="접기 버튼"> </div>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script>
    // 우편번호 찾기 찾기 화면을 넣을 element
    var element_wrap = document.getElementById('wrap');

    function foldDaumPostcode() {
        // iframe을 넣은 element를 안보이게 한다.
        element_wrap.style.display = 'none';
    }

    function execDaumPostCode() {
        // 현재 scroll 위치를 저장해놓는다.
        var currentScroll = Math.max(document.body.scrollTop, document.documentElement.scrollTop);
        new daum.Postcode({
            oncomplete: function(data) {
                // 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var fullAddr = data.address; // 최종 주소 변수
                var extraAddr = ''; // 조합형 주소 변수

                // 기본 주소가 도로명 타입일때 조합한다.
                if(data.addressType === 'R'){
                    //법정동명이 있을 경우 추가한다.
                    if(data.bname !== ''){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있을 경우 추가한다.
                    if(data.buildingName !== ''){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
                    fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('ZipCode').value = data.zonecode; //5자리 새우편번호 사용
                document.getElementById('UserAddr').value = fullAddr;
            	document.getElementById('UserAddrDtl').focus();


                // iframe을 넣은 element를 안보이게 한다.
                // (autoClose:false 기능을 이용한다면, 아래 코드를 제거해야 화면에서 사라지지 않는다.)
                element_wrap.style.display = 'none';

                // 우편번호 찾기 화면이 보이기 이전으로 scroll 위치를 되돌린다.
                document.body.scrollTop = currentScroll;
            },
            // 우편번호 찾기 화면 크기가 조정되었을때 실행할 코드를 작성하는 부분. iframe을 넣은 element의 높이값을 조정한다.
            onresize : function(size) {
                element_wrap.style.height = size.height+'px';
            },
            width : '100%',
            height : '100%'
        }).embed(element_wrap);

        // iframe을 넣은 element를 보이게 한다.
        element_wrap.style.display = 'block';
    }

    var isMobile = {
            Android: function () {
                     return navigator.userAgent.match(/Android/i);
            },
            BlackBerry: function () {
                     return navigator.userAgent.match(/BlackBerry/i);
            },
            iOS: function () {
                     return navigator.userAgent.match(/iPhone|iPad|iPod/i);
            },
            Opera: function () {
                     return navigator.userAgent.match(/Opera Mini/i);
            },
            Windows: function () {
                     return navigator.userAgent.match(/IEMobile/i);
            },
            any: function () {
                     return (isMobile.Android() || isMobile.BlackBerry() || isMobile.iOS() || isMobile.Opera() || isMobile.Windows());
            }
    };

</script>
<!--E: 다음 주소찾기 API-->

<!-- S: sub-header -->
<div class="sub-header flex">
  <!-- S: sub_header_arrow -->
  <!-- #include file="../include/sub_header_arrow.asp" -->
  <!-- E: sub_header_arrow -->
  <h1>내 정보 관리</h1>
  <!-- S: sub_header_gnb -->
  <%
		SELECT CASE request.Cookies("EnterType")
			CASE "E"
	%>
  <!-- #include file="../include/sub_header_gnb.asp" -->

  <%
		'생활체육의 경우 메뉴 출력 OFF
		'생활체육 컨텐츠 사용 기획 이후 제거해야함
		CASE ELSE
	%>
        <!-- S: 로그아웃 버튼 -->
        <div class="sub-logout login-btn">
          <!-- logout start -->
          <a href="javascript:chk_logout();" role="button" class="log-out">
            <span class="link-deco"><i class="fa fa-power-off" aria-hidden="true"></i></span>
            <span class="txt">로그아웃</span>
          </a>
          <!-- logout end -->
        </div>
        <!-- E: 로그아웃 버튼 -->
        <%
	END SELECT
	%>

  <!-- E: sub_header_gnb -->
</div>
<!-- E: sub-header -->
<!-- S: sub -->
<div class="sub mypage">
  <form name="s_frm" method="post">
    <input type="hidden" name="MemberIDX" id="MemberIDX" value="<%=MemberIDX%>" />
    <input type="hidden" name="PlayerIDX" id="PlayerIDX" value="<%=PlayerIDX%>" />
    <input type="hidden" name="Team" id="Team" value="<%=Team%>" />
    <input type="hidden" name="PlayerReln" id="PlayerReln" value="<%=PlayerReln%>" />
    <input type="hidden" name="Hidden_SmsYn" id="Hidden_SmsYn" value="<%=SmsYn%>" />
    <input type="hidden" name="Hidden_EmailYn" id="Hidden_EmailYn" value="<%=EmailYn%>" />
    <input type="hidden" name="SEX" id="SEX" value="<%=SEX%>" />
    <input type="hidden" name="TeamGb" id="TeamGb" value="<%=TeamGb%>">
    <!--체육인번호 조회 START-->
    <input type="hidden" name="SportsType" id="SportsType" value="<%=SportsType%>" />
    <input type="hidden" name="AthleteNum" id="AthleteNum" />
    <input type="hidden" name="AthleteYN" id="AthleteYN" value="N" />
    <input type="hidden" name="UserName" id="UserName" value="<%=UserName%>" />
    <input type="hidden" name="Birthday" id="Birthday" value="<%=Birthday%>" />
    <!--체육인번호 조회 END-->
    <fieldset>
      <legend>마이페이지 내정보 관리</legend>
      <h2>주기적으로 나의 정보를 관리해주세요.</h2>
      <div class="myinfo clearfix">
        <p class="img-myinfo">
          <!-- <a href="javascript:fnUpload();"> -->
          <a href="#" data-toggle="modal" data-target=".show-prof-img"><img id="imgMyinfo" src="<%=PhotoPath%>" alt="" /></a></p>
        <input type="file" name="b_upFile" id="b_upFile" style="display: none;" />
        <div class="txt-myinfo"> <strong><%=UserName %></strong> 자신만의 사진으로 나를 표현해보세요.
          <div class="btn-myinfo"> <a id="imgDel" href="javascript:Chk_Del_Image();" class="btn-gray2" style="display:<%IF chk_IMG = FALSE Then response.Write "none" End IF%>">삭제</a>
            <!--PC버전 사진올리기-->
            <a href="javascript:fnUpload();" class="btn-skyblue" id="btn_Profile_PC">사진 올리기</a>
            <!--안드로이드 사진올리기-->
            <a href="javascript:Android.profileUpload('<%=MemberIDX%>');" class="btn-skyblue" id="btn_Profile_Android">사진올리기</a>
            <!--IOS 사진올리기-->
            <a href="interface://widline.co.kr/?action=profile&memcode=<%=MemberIDX%>" class="btn-skyblue" id="btn_Profile_iOS">사진올리기</a> </div>
        </div>
      </div>
      <!-- 추후 사용예정임 -->
      <!-- S: 등록된 정보가 없을 경우 텍스트 노출

        <h2 class="h30">신규 체육인번호 등록</h2>
        <p class="txt-myinfo-number">대한체육회에 신규 체육인번호를 발급받은 선수는 본인의 개인번호를 등록해 주시기 바랍니다.</p>

        <!--// E : 등록된 정보가 없을 경우 텍스트 노출
        <ul class="join-form">
          <!-- 등록된 정보가 있을 때
          <li>
            <p>체육인번호</p>
            <p><a href="#" class="point-or">20031218010001</a></p>
          </li>
          <!-- 등록된 정보가 없을 때
          <li>
            <p>체육인번호</p>
            <p><a href="#" class="btn-or" data-toggle="modal" data-target="#import-number">체육인번호 불러오기</a></p>
          </li>
        </ul>
        -->
      <ul class="join-form">
        <li>
          <p>종목</p>
          <p>::
            <%
      SELECT CASE SportsType
        CASE "judo" : response.Write "유도"
        CASE ELSE
      END SELECT
      %>
            ::</p>
        </li>
        <%
    '선수보호자 가입회원
    SELECT CASE PlayerReln
		CASE "A", "B", "Z"
      %>
        <li>
          <p>선수와의 관계</p>
          <p>
            <%
          SELECT CASE PlayerReln
          	CASE "A" : response.Write "부"
			CASE "B" : response.Write "모"
			CASE "Z" : response.Write PlayerRelnMemo
          END SELECT
          %>
          </p>
        </li>
        <%
  	'선수(R)
    	CASE "R", "T"
		%>
        <li>
          <p>소속</p>
          <p>:: <%=TeamNm%> ::</p>
        </li>
        <li class="uniq_n">
          <p><span class="tit-box">팀코드</span></p>
          <p><%=Team%></p>
        </li>
        <%
	    	IF PlayerReln = "T" Then
      	%>
        <li class="manager-divn">
          <p>관리자구분<span class="compulsory">＊</span></p>
          <p class="manager-sel">
            <label>
              <input type="radio" name="LeaderType" id="LeaderType" <%IF LeaderType = "5" Then response.Write "checked" End IF%> value="5">
              <span>관장</span></label>
            <label>
              <input type="radio" name="LeaderType" id="LeaderType" <%IF LeaderType = "6" Then response.Write "checked" End IF%> value="6">
              <span>사범</span></label>
            <label>
              <input type="radio" name="LeaderType" id="LeaderType" <%IF LeaderType = "7" Then response.Write "checked" End IF%> value="7">
              <span>지도자(기타)</span></label>
          </p>
        </li>
        <%
		End IF

  	END SELECT
    %>
    	<li>
          <p>아이디</p>
          <p><%=UserID%></p>
        </li>
        <li>
          <p>이름</p>
          <p><%=UserName %></p>
        </li>
        <li>
          <p>영문이름<span class="compulsory">＊</span></p>
          <p>
            <input type="text" name="UserEnName" id="UserEnName" placeholder="Hong Gil Dong" value="<%=UserEnName%>" />
          </p>
        </li>
        <li>
          <p>성별</p>
          <p>
            <%IF Sex = "Man" Then response.Write "남자" Else response.Write "여자" End IF%>
          </p>
        </li>
        <li>
          <p>생년월일</p>
          <p><%=Birthday%></p>
        </li>
        <li class="uniq_n">
          <p><span class="tit-box">체육인번호</span></p>
          <p><%=PersonCode%></p>
        </li>
        <li class="line-none phone-line">
          <p>휴대폰<span class="compulsory">＊</span></p>
          <div class="phone-input">
            <select name="UserPhone1" id="UserPhone1" >
              <option value="010" <%IF UserPhone1 = "010" Then response.Write "selected" End IF%>>010</option>
              <option value="011" <%IF UserPhone1 = "011" Then response.Write "selected" End IF%>>011</option>
              <option value="016" <%IF UserPhone1 = "016" Then response.Write "selected" End IF%>>016</option>
              <option value="017" <%IF UserPhone1 = "017" Then response.Write "selected" End IF%>>017</option>
              <option value="018" <%IF UserPhone1 = "018" Then response.Write "selected" End IF%>>018</option>
              <option value="019" <%IF UserPhone1 = "019" Then response.Write "selected" End IF%>>019</option>
            </select>
            <span class="bar-phone">-</span>
            <input type="number" name="UserPhone2" id="UserPhone2" maxlength="4" value="<%=UserPhone2%>" onKeyUp="if($('#UserPhone2').val().length==4){$('#UserPhone3').focus();}"/>
            <span class="bar-phone">-</span>
            <input type="number" name="UserPhone3" id="UserPhone3" maxlength="4" value="<%=UserPhone3%>" />
            <a href="javascript:chk_sms();" class="btn-gray" id="sms_button">인증</a>
            <!--휴대폰번호 변경 체크를 위한 hidden data-->
            <!--SMS인증여부-->
            <input type="hidden" name="Hidden_SMS" id="Hidden_SMS" value="N">
            <input type="hidden" name="Hidden_UserPhone1" id="Hidden_UserPhone1" value="<%=UserPhone1%>" />
            <input type="hidden" name="Hidden_UserPhone2" id="Hidden_UserPhone2" value="<%=UserPhone2%>" />
            <input type="hidden" name="Hidden_UserPhone3" id="Hidden_UserPhone3" value="<%=UserPhone3%>" />
            <input type="hidden" name="Auth_Num" id="Auth_Num" value="" />
            <!--휴대폰번호 변경 체크를 위한 hidden data-->
            <!--//<input type="button" class="btn-gray" value="인증" />-->
          </div>
        </li>
        <li class="phone-check">
          <p><span class="hidden">휴대폰 인증번호 입력</span></p>
          <p id="CHK_REAUTH" style="display:none;">
            <input type="number" name="Re_Auth_Num" id="Re_Auth_Num" placeholder="인증번호 입력" />
            <a href="javascript:chk_Auth_Num()" class="btn-gray">확인</a> <span id="chk_Agree" style="display:none;"></span> </p>
        </li>
        <li class="agree">
          <p><span class="hidden">휴대폰 수신동의</span></p>
          <p>
            <label for="AgreeSMS" class="img-replace sms <%IF SmsYn = "Y" Then response.Write "on" End IF%>" onClick="inputExc($(this));">수신동의
              <input type="checkbox" name="AgreeSMS" id="AgreeSMS" <%IF SmsYn = "Y" Then response.Write "checked" End IF%> />
            </label>
          </p>
        </li>
        <li class="line-none mail-line">
          <p>이메일<span class="compulsory">＊</span></p>
          <p>
            <input type="text" name="UserEmail1" id="UserEmail1" placeholder="sample123456" class="email-input" value="<%=Email1%>" />
            @
            <input type="text" name="UserEmail2" id="UserEmail2" placeholder="hanmail.net" class="email-input" value="<%=Email2%>" />
            <select name="EmailList" id="EmailList" onChange="chk_Email();">
              <option value="">직접입력</option>
              <option value="gmail.com" <%IF Email2 = "gmail.com" Then response.Write "selected" End IF%>>gmail.com</option>
              <option value="hanmail.net" <%IF Email2 = "hanmail.net" Then response.Write "selected" End IF%>>hanmail.net</option>
              <option value="hotmail.com" <%IF Email2 = "hotmail.com" Then response.Write "selected" End IF%>>hotmail.com</option>
              <option value="naver.com" <%IF Email2 = "naver.com" Then response.Write "selected" End IF%>>naver.com</option>
              <option value="nate.com" <%IF Email2 = "nate.com" Then response.Write "selected" End IF%>>nate.com</option>
            </select>
          </p>
        </li>
        <li class="agree">
          <p><span class="hidden">이메일 수신동의</span></p>
          <p>
            <label for="AgreeEmail" class="img-replace sms <%IF EmailYn = "Y" Then response.Write "on" End IF%>" onClick="inputExc($(this));">수신동의
              <input type="checkbox" name="AgreeEmail" id="AgreeEmail" <%IF EmailYn = "Y" Then response.Write "checked" End IF%> />
            </label>
          </p>
        </li>
        <li>
          <p>주소<span class="compulsory">＊</span></p>
          <p class="address-input">
            <input type="text" readonly name="ZipCode" id="ZipCode" value="<%=ZipCode%>" />
            <a href="javascript:execDaumPostCode();" class="btn-gray">우편번호 검색</a>
            <input type="text" readonly name="UserAddr" id="UserAddr"  value="<%=Address%>" />
            <input type="text" name="UserAddrDtl" id="UserAddrDtl" placeholder="나머지 주소 입력" value="<%=AddressDtl%>" />
          </p>
        </li>
        <%
      IF PlayerReln = "R" Then   '등록선수(R)가입회원
        %>
        <li class="hang-deco">
          <p>운동시작년도</p>
          <p class="over-txt">
            <input type="number" name="PlayerStartYear" id="PlayerStartYear" placeholder="1990" value="<%=PlayerStartYear%>" />
          </p>
          <span class="txt-deco">년도</span> </li>
        <li class="hang-deco">
          <p>키</p>
          <p class="over-txt">
            <input type="number" name="PlayerTall" id="PlayerTall" placeholder="180" value="<%=Tall%>" />
          </p>
          <span class="txt-deco">cm</span> </li>
        <li class="hang-deco">
          <p>체중</p>
          <p class="over-txt">
            <input type="number" name="PlayerWeight" id="PlayerWeight" placeholder="67" value="<%=Weight%>" />
          </p>
          <span class="txt-deco">kg</span> </li>
        <li>
          <p>체급<span class="compulsory">＊</span></p>
          <p id="sel_PlayerLevel">
            <select name="PlayerLevel" id="PlayerLevel">
              <option>체급선택</option>
            </select>
          </p>
        </li>
        <li>
          <p>혈액형</p>
          <p>
            <select name="BloodType" id="BloodType">
              <option value="">혈액형 선택</option>
              <option value="A" <%IF BloodType="A" Then response.Write "selected" End IF%>> A</option>
              <option value="B" <%IF BloodType="B" Then response.Write "selected" End IF%>> B</option>
              <option value="AB" <%IF BloodType="AB" Then response.Write "selected" End IF%>>AB</option>
              <option value="O" <%IF BloodType="O" Then response.Write "selected" End IF%>> O</option>
            </select>
          </p>
        </li>
        <%
       END IF
      %>
      </ul>

      <!-- E: fav-list -->
    </fieldset>
  </form>
	<%
  SELECT CASE PlayerReln
  	'선수/선수보호자
  	CASE "T"
	CASE ELSE
  %>
  <!-- S : 2017-01-04 선수훈련 데이터 열람 동의 -->
  <div class="parent-data-wrap panel-title clearfix"> <a href=".fold" class="tit-parent-data" data-toggle="collapse" aria-expanded="false" aria-controls=".fold" tabindex="1">
    <h2>선수 데이터공유 대상<span class="icon"><span class="caret"></span></span></h2>
    </a>
    <div class="collapse fold" aria-expanded="false">
      <div class="parent-data well">
        <ul id="AgrHistory">
          <!--
            <li>
              <p>(부)이길동님(010-1234-5678)</p>
              <p>열람 승인일 : 2017.01.04</p><em></em>
            </li>
           -->
        </ul>
        <span>(상담문의 : <span onClick="callNumber('<%=global_num2%>');"><%=global_num2%></span>)</span> </div>
    </div>
  </div>
  <%
  End SELECT
    %>
  <!-- E : 2017-01-04 선수훈련 데이터 열람 동의 -->
  <!-- S: warn-pha -->
  <div class="warn-pha">
    <p>소속이 변경되면 본인의 모든 경기데이터 기록에 차질이 생길 수 있습니다. <br>소속이 변경이 될 경우, 스포츠다이어리에 연락하셔서 변경요청을 해주시기 바랍니다. <br>(스포츠다이어리 담당 : <span onClick="callNumber('<%=global_num2%>');"><%=global_num2%></span>)</p>
  </div>
  <!-- E: warn-pha -->
  <div class="btn-center">

  <a href="./mypage.asp" class="btn-left">수정취소</a>
  <a href="javascript:chk_frm();" class="btn-right">수정완료</a>
  </div>

  <!-- S: show-prof-img -->
  <div class="modal fade show-prof-img confirm-modal" tabindex="-1" role="dialog" aria-labelledby="" aria-hidden="true">
    <div class="modal-dialog">
      <div class="modal-content modal-small">
        <div class="modal-header">프로필 사진<a href="#" data-dismiss="modal" class="close">&times;</a></div>
        <div class="modal-body">
          <p class="prof-img"> <img id="imgMyinfoBig" src="<%=PhotoPath%>" alt=""> </p>
        </div>
        <!-- <div class="modal-footer"> <a href="#" role="button" class="btn btn-modal-close" data-dismiss="modal">닫기</a></div> -->
      </div>
      <!-- ./ modal-content -->
    </div>
    <!-- ./modal-dialog -->
  </div>
  <!-- E: show-prof-img -->
</div>
<!-- E : sub -->
<!-- S: footer -->
<div class="footer">
  <!-- S: bottom-menu -->
  <!-- #include file="../include/bottom_menu.asp" -->
  <!-- E: bottom-menu -->
</div>
<!-- E: footer -->
<!-- S: bot-config -->
<!-- #include file= "../include/bot_config.asp" -->
<!-- E: bot-config -->
</body>
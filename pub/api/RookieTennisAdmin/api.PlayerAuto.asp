<%
Response.end
'#############################################


'#############################################
	'request
	autono = oJSONoutput.AutoNo

	Function ran_name_func()
		Dim HTable_ChoSung,HTable_JungSung,choarr,jungarr,rnd_value,cho,jung,player
		'성 
		HTable_ChoSung = "김,이,박,최,정,강,조,윤,장,임,한,오,서,신,권,황,안,송,전,홍,유,고,문,양,손,배,조,백,허,유,남,심,노,정,하,곽,성,차,주,우,구,신,임,전,민,유,류,나,진,지,엄,채,원,천,방,공,강,현,함,변,염,양,변,여,추,노,도,소,신,석,선,설,마,길,주,연,방,위,표,명,기,반,라,왕,금,옥,육,인,맹,제,모,장,남,탁,국,여,진,어,은,편"

		'이름
		HTable_JungSung = "가든,가람,가람,가람슬기,가람휘,가림,가온,가온길,가온누리,가온들찬빛,가온뫼,가온해,가이,가자,가장,갈,거늘,거울,겨라,겨레,겨루,겨슬,겨슬,그리,그린나래,글고운,글길,기쁨해,길,길가온,꽃가람,꽃내,꽃내,꽃내음,꽃샘,꽃채운,꽃초롱,꽃큰,나길,나나,나라빛,나라우람,나라찬,나래,나래,나래울,나려,나로,나루해오름,나봄,나빛,나샘,나슬,나예,나오,난길,난새,난슬,날샘,날애,남,남은,내길,내꽃,내담,노아,노을,노을,누리,누리보듬,누리봄,누리알찬,누림,눈꽃,눈솔,뉘,늘다,늘봄,늘봄,늘빈,늘솔길,늘솜,늘예솔,늘찬,다가,다빈,다스리,다슬,다온,다올,다옴,다와,다은,다이,다참,다한,다흰,다힘,도담,도도,도란,도래,도손,도움,동이,두나,두동,두루,두메꽃,두바다찬솔,두빛나래,두온,두힘,드리,드리,든솔,든해,든해솔,들샘,들찬,들찬길,라,라라,라미,라별,라와,란새,렁찬,로다,로와,로운,로지,루다,루라,루리,리네,리라,리리,마디,마루,마루,마루나,마루한,마리,마음,마음새,말근,말글,맑은,맑은가람,맑은누리,매디,모두가람,모두다,모드니,모든,모람,모아,모은,모이,모해,무들,무슬,무지개,물맑,물보라,미나,미나래,미드미,미라,미리별,바다,바로찬글,바론,바름,밝은빛누리예,밝음이,범한,벼리,벼리,별,별글,별솔,별하,보나,보늬,보단,보담,보라나,보람,보르미,보미,보미나,보슬,보아라,보예,봄나,봄시내,봄해,부루,불꾼,비사벌,비치,비치나,빈길,빛글,빛길,빛다,빛솔,빛초롱,새길,새꽃,새나,새난,새누,새늘,새론,새밝,새솔,새얀,세련,세리,세움,세이,세찬,소리,소미,소아,소예,솔관,솔길,솔빛길,솔잎,솔찬,수련,수리,슬기,슬아,슬아라,슬예,슬옹,슬우,슬찬,승아,승아,시내,시원,아라,아라,아란,아련나래,아롱별,아름나,아리솔,아리알찬,안찬,알,알찬마루,알찬바로,알찬해,얀,얀별,얀새,얼,엄지,에가득,에다,여름,영글,예님,예다움,외솔,외솔,우람늘,우솔,움찬,으뜸,은새,은소라,은솔,은솜,은송이,이든샘,이루리,이루리라,이룩,이솔,이송이,이플,잎새,자랑,자올,잔디,재마루,재미,재바우,재찬,제나,제철,조롱목,조은,조히,종달,주나,주리,주미,지나,지니,지은,지음,진나,진달래,진샘,진솔,진이,차나,차미,차분,차분나래,차오름,착히,찬,찬내,찬놀,찬누리,찬늘,찬늘봄,찬들,찬들,찬솔,찬솔나라,찬솔큰,찬슬,찬슬기,참,참이,참이삭,채움늘,초고리,초롬,초롱,초롱,초롱꽃,치리,크나,크심,큰가람,큰길,큰깃,큰꽃,큰꽃늘,큰꽃들,큰나라,큰나래,큰돌찬,큰돛,큰마루,큰말,큰맘,큰모듬,큰모음,큰뫼,큰솔,큰아,큰애,큰재,큰힘,클,키움,키클,타고나,터전,터큰,텃골,텃골돌샘터,토리,통꽃,튼동,튼싹,튼트나,튼튼,틀큰,티나,파라,파라나,파라미,파란,파랑,파랑새,퍼리,펴라,푸르,푸르나,푸르내,푸르니,푸른나래,푸른나무,푸른들,푸른마을,풀잎,풀큰,풋내,피네,피라,피리,피어나,핀아,하나,하늬,하람,하랑,하련솔,하예라,하예진,한,한가람,한결,한길찬,한내,한내,한누리,한별나라,한봄찬,한빛,한빛,한샘가온,한울,해가빛,해긴,해길,해나,해늘,해님꽃,해련,해비치,해사랑해,해샘찬,해솔,해찬나래,해찬솔,환찬,환히찬,횃불,희라,흰가람,흰꽃,힘차,힘찬,월일,다날,부날,무날,남날,쇠날,흙날,해날,해오름달,시샘달,물오름달,잎새달,푸른달,누리달,견우직녀달,타오름달,열매달,하늘연달,미틈달,매듭달,하루,이틀,사흘,열하루,열이틀,스무하루,스무이,순우리말,가납사니,가년스럽다,가늠,가라사니,가람,가래다,가래톳,가론,가루다,가말다,가멸다,가무리다,가분하다·가붓하다,가살,가시버시,가온길,가온누리,가우리,가위춤,가장이,가재기,가직하다,가축,가탈,각다분하다,간동하다,간정되다,갈개꾼,갈래다,갈마보다,갈무리,감잡히다,강짜를부리다,강파르다,갖바치,갖추다,개골창,개구멍받이,개맹이,개사망,개어귀,개차반,개평,객쩍다,거니채다,거레,거우다,건목,건잠머리,걸싸다,걸쩍거리다,걸태질,게염,게정,겨끔내기,겨르로이,겨리,겯고틀다,결곡하다,결두리,결딴,고거리,고거이,고빗사위,고뿔,고삿,고수련,고수머리,고타야,곧추다,골갱이,골막하다,곰비임비,곰살궂다,곰상스럽다,곰파다,곱살끼다,공성이나다,공중제비,공치하다,괴덕,구다라,구듭,구메농사,구쁘다,구성없다,구성지다,구순하다,구실,구어박다,구완,구유,국으로,굴레,굴침스럽다,굴타리먹다,굴통이,굼닐다,굽도리,굽바자,궁따다,귀살쩍다,그느다,그느르다,그루잠,그루터기,그린나래,그린내,그린비,그미,그악하다,금새,기를,기이다,길가온,길라잡이,길마,길미,길섶,길제,길품,김바리,까대기,까막과부,까막까치,까미,깔죽없다,깜냥,깜부기,깨단하다,꺼병이,꺽지다,꼬꼬지,꼬두람이,꼬리별,꼲다,꽃가람,꽃내음,꽃샘,꽃샘바람,꽃잠,꾀꾀로,꿰미,끄나풀,끄느름하다,끌끌하다,나래,나르샤,나린,나릿물,나부대다,나비잠,난든집,난이,남새,남우세,남진계집,낫잡다,낳이,내남없이,내숭,너널,너비,너울,넉가래,넉장거리,넌더리,널출지다,노가리,노고지리,노닥이다,노드매기,노량으로,노루잠,노적가리,노총,놀금,높새,눈거칠다,눈바래기,눈비음,눈썰미,눈엣가시,느껍다,느루,느루먹다,는개,늘비하다,늘솔길,늘해랑,늠그다,능,능갈치다,늦,늦마,늦사리,다님길,다따가,다락같다,다랑귀,다소니,다소다,다솜,다원,다직해야,다흰,닦아세우다,단물나다,단미,달구치다,달랑쇠,달보드레하다,달포,답치기,당나발붙다,당도리,닻별,대갚음,대두리,댓바람,댕기다,더껑이,더께,더치다,더펄이,덖다,던적스럽다,덜퍽지다,덤받이,덤터기,덧거칠다,덧게비,덧두리,덩둘하다,덩저리,도거리,도닐다,도담도담,도두보다,도드미:,도란도란,도래솔,도린결,도사리,도섭,도스르다,도투락,도파니,돈바르다,돈사다,돌개바람,동곳빼다,동그마니,동뜨다,동아리,동이닿다,동자아치:,동티,되모시,되술래잡히다,되지기,되퉁스럽다,된바람,됫바람,된바람,될성부르다,두남두다,두동지다,두례,두멍,둔치,둥개다,뒤란,뒤스르다,뒤웅박,뒤통수(를)치다,뒨장질,뒷갈망,뒷귀,드난,드레,드림흥정,드티다,들거지,들마,들메,들썽하다,들입다,들피,듬쑥하다,따리꾼,딸각발이,떠세,떡심이풀리다,떨거지,뚜쟁이,뚝벌씨,뚱기다,뜨께질,뜨악하다,뜯게,라온제나,라온하제,라온힐조,마고자,마닐마닐,마디다,마뜩하다,마루,마름,마름질,마소두래기,마수걸다,마장스럽다,마전,마파람,말결,말재기,말코지,맛조이,매개,매골,매나니,매지구름,매캐하다,맨드라미,맨드리,맨망,맵자하다,맷가마리,맹문,머드러기,머줍다,먼산바라기,메꿎다,메지,멧부리,멱차다,모가비,모꼬지,모람모람,모래톱,모르쇠,모주망태,모집다,모춤하다,목매기,몽구리,몽니,몽따다,몽종하다,몽짜,몽태치다,무꾸리,무녀리,무드럭지다,무람없다,무릎마춤,무서리,무수다,무싯날,무텅이,묵새기다,물강스럽다,물꼬,물마,물보낌,물부리,물비늘,물수제비뜨다,물초,뭉근하다,미대다,미르,미리내,미립,미쁘다,미투리,민낯,민둥산,민충하다,민틋하다,민패,밀막다,밀절미,바오,바자위다,바장이다,바투,반거들충이,반기,반살미,반색,반자받다,반지빠르다,받내다,발림,발발다,발쇠,방물,방자,방자고기,방짜,방패막이,배갯잇,배내,배냇짓,배때벗다,배메기,버겁다,버금,버덩,버력,버르집다,버름하다,벋대다,벌충,벗,베돌다,벼리,벼리,베리,벼리다,변죽,별찌,볏가리,보깨다,보꾹,보드기,보쟁이다,보짱,본치,볼멘소리,볼모,볼우물,부넘기,부닐다,부대끼다,부라퀴,부르터나다,부아나다,부지깽이,북새,북새바람,붓날다,붓방아,붙박이,비나리,비나리치다,비를긋다,비마중,비말,비설거지,비커리,빌미,빌붙다,빗물이,빙충맞다,빚지시,뻑뻑이,뿌다구니,사그랑이,사금파리,사나래,사달,사람멀미,사로자다,사부랑사부랑,사시랑이,사위다,사재기,사태,사품,삭신,삭정이,삯메기,산다라,산돌림,살갑다,살강,살거리,살붙이,살소매,살손(을)붙이다,살피,삼짇날,삼태기,삼하다,상고대,새,하,마,노,새경,새라,새룽이,새물내,샘바리,샛바람,샛별,생무지,생인손,생채기,생청,생화,서름하다,서릊다,서리서리,섟,섟삭다,선겁다,선바람,선불걸다,선술집,선웃음,섣부르다,설멍하다,설면하다,설피다,섬돌,섬서하다,성금,성기다,성마르다,세나다,셈나다,셈차리다,소담하다,소댕,소두,소드락질,소래기,소롱하다,소마,소마소마,소소리바람,소수나다,소양배양하다,소태같다,속종,솎다,손맑다,손대기,손떠퀴,손바람,손방,손사래,손타다,손포,수발,수지니,수채,수피아,숙수그레하다,숙지다,숨베,숯,숱,슈룹,스스럼,습습하다,승겁들다,시게,시나브로,시뜻하다,시래기,시르죽다,시름없다,시먹다,시쁘다,시설궂다,시세,시앗,시역,시위,시적거리다,시치다,신망스럽다,실랑이,실큼하다,실터,실팍하다,심드렁하다,심마니,심사미,싸개통,싸도둑,싹수,쌩이질,쏘개질,쓰레질,쓸까스르다,쓿다,아가씨,아귀차다,아기똥하다,아니리,아띠,아라,아라가야,아람,아람치,아련하다,아름드리,아리수,아리아,아리잠작하다,아미,아사,아스라이,아우르다,아이서다,아주버니,아퀴,아퀴짓다,아토,악도리,안날,안다미,안다미로,안를다,안차다,안팎장사,알섬,알심,알짬,알천,암상,암팡지다,앙금,앙달머리,앙세다,앙증하다,앙짜,앞바람,애면글면,애물,애벌갈이,애성이,애오라지,애옥살이,앤생이,앵돌아지다,야바위,야발,야비다리,야수다,야지랑스럽다,야짓,약비나다,얌생이,양지머리,어거리풍년,어니눅다,어엿하다,어줍다,언걸,언구럭,언막이,얼렁장사,얼레,얼레살풀다,업시름,엇부루기,엉거능축하다,엉겁,엉구다,엉리,엉세판,에끼다,에다,에멜무지로,에우다,에움길,여낙낙하다,여남은,여루다,여리꾼,여우별,여우비,여정하다,여줄가리,역성,열고나다,열없다,영바람,영절스럽다,영판,예그리나,예제없이,옛살비,오금,오달지다,오례쌀,오릇하다,오비다,오쟁이지다,오지랖넓다,옥셈,온,온누리,온새미로,올되다,올리사랑,올무,올케,옴니암니,옷깃차례,옹골지다,옹아리,옹추,옹춘마니,왕청되다,왜골,왜자하다,왜장치다,욕지기,용수,용심,용지,용천하다,용춤,용트림,우금,우꾼하다,우두망찰하다,우듬지,우렁잇속,우멍하다,우선하다,우세,우수리,우접다,울대,울력,움딸,웁쌀,웃날들다,웃비,워낭,윗바람,윤슬,으르다,은가람,은가비,은결들다,은사죽음,의초,이내,이든,이르집다,이물,이악하다,이울다,이지다,임,입찬말,잇바디,자귀,자닝하다,자리끼,자리끼숭늉,자리보전,자맥질,자발없다,자부지,자빡대다,자투리,잔다리밟다,잔달음,잔질다,잡도리,잡을손,장돌림,장맞이,장족박,잦히다,재강,재우치다,저어하다,적바람(뒤에들추어보,적바르다,점지,정수리,제키다,조라떨다,조리차하다,조치개,족대기다,졸가리,졸들다,좁쌀여우,종요롭다,좆다,주니,주럽,주릅,주저롭다,주저리,주전부리,주접,줏대잡이,중절거리다,쥐락펴락,쥘손,즈믄,지다위,지돌이,지망지망히,지실,지위,지청구,직수굿하다,진번질하다,진솔,질통,짐짓,집알이,짜개,짜발량이,짜장,짝자꿍이,째다,째마리,쭉정이,찌그렁이,찜부럭,차돌박이,차반,척(隻)을짓다,천둥벌거숭이,천둥지기,천세나다,첫밗,초들다,초라떼다,초아,추레하다,추지다,치사람,치신없다,커나다,켕기다,코뚜레,코숭이,콩케팥케,큰상물림,킷값,타끈하다,타니,타래,타래버선,타울거리다,터럭,터알,톡탁치다,투미하다,튀하다,트레바리,틋,파니,파임내다,판들다,판수,퍼르퍼르,포롱거리다,푸네기,푸닥거리,푸르미르,푸실,푸접없다,푹하다,푼더분하다,푼푼하다,풀무,품앗이,풍년(豊年)거지,피새,피천,하나린,하냥다짐,하늬,하늬바람,하람,하르르하다,하릅,하리놀다,하리다,하리들다,하릴없다,하마하마,하비다,하슬라,하야로비,하제,한겻,한둔,한별,한사리,한울,한풀,할경,함진아비,함초롬하다,함함하다,핫아비,핫어미,핫옷,해거름,해껏,해소수,해찰,해찰하다,행짜,허구리,허닥하다,허대다,허드레,허룩하다,허룽거리다,허릅숭이,허물하다,허발,허방,허벅지다,허섭쓰레기,허수하다,허출하다,헛물켜다,헛장,헤먹다,헤살,헤식다,헤윰,호다,호드기,호락질,홀앗이,홀지다,화수분,확,홰,회두리,훈감하다,휘들램,흐노니,흐드러지다,흥글방망이놀다,희나리,희떱다,희치희치,힐조,나온곳"
		'종성 리스트

		choarr = Split(HTable_ChoSung,",")
		jungarr = Split(HTable_JungSung,",")

		Randomize
		rnd_value = clng( ((UBound(choarr)-1) * Rnd) + 0 )
		cho = choarr(rnd_value)

		Randomize
		rnd_value = clng( ((UBound(jungarr)-1) * Rnd) + 0 )
		jung = jungarr(rnd_value)

		'좌우 바꿈
		Randomize
		rnd_value = clng( (10 * Rnd) + 1 )
		If rnd_value > 2 Then
			player = cho & jung
		Else
			player = jung & cho
		End if

		Randomize
		rnd_value = clng( (Len(player) * Rnd) + 2 )
		ran_name_func = Left(player, rnd_value)
	End Function

	Function make_random_func(ByVal sno, ByVal eno, ByVal minno, ByVal maxno, ByVal typedt)
			Dim rnd_value, makevalue
			
			For i = sno To eno
				Randomize
				rnd_value = clng( ((2017- 1900) * Rnd) + 1900 )

				rnd_value = clng( ((maxno - minno) * Rnd) + minno )
				If typedt = "type_datetime" then
				If Len(rnd_value) = 1 Then
					rnd_value = "0" & rnd_value
				End If
				End if
				makevalue = makevalue & rnd_value
			Next
			make_random_func = makevalue
	End Function 


	Set db = new clsDBHelper

		SQL = " Select top 1 Team,TeamNm from tblTeamInfo where SportsGb = 'tennis' and DelYN = 'N'  ORDER BY NEWID() "
		Set rs = db.ExecSQLReturnRS(SQL , null, ConStr)
		
		Function make_player_func()
			Dim i, uphone,ubirth,sex,unm,insertfield,insertvalue,pidx,rankpoint,pcode,userLevel,abc,birthsyear,birtheyear
			Dim teamno(2)
			Dim teamnm(2)
	
				'PersonCode 테니스는 2억부터 시작
				SQL = "select MAX(PersonCode) from tblPlayer where SportsGb = 'tennis' and DelYN = 'N'"
				Set rs = db.ExecSQLReturnRS(SQL , null, ConStr)
				If isNumeric(rs(0)) = False  then
					pcode = 200000000
				Else
					If CDbl(rs(0)) < 200000000 Then
						pcode = 200000000
					else
						pcode = CDbl(rs(0)) + 1
					End if
				End if

				'등급
				Randomize
				userLevel = clng((5 * Rnd) + 0 )
				abc = array("A","B","C","D","E","F")
				userLevel = abc(userLevel)

				'랭킹포인트
				Randomize
				rankpoint = clng((20000 * Rnd) + 0 )
				If  clng((100 * Rnd) + 1 ) > 40 Then
					rankpoint = 0
				ElseIf clng((100 * Rnd) + 1 ) > 20 Then
					rankpoint = CInt(rankpoint/10)
				End if

				'생년월일
				birtheyear = CDbl(Replace(year(date),"-","")) -8
				birthsyear = birtheyear - 120
				uphone = "010" & make_random_func(1, 8 , 0, 9 ,"")
				ubirth = make_random_func(1, 1 , birthsyear,birtheyear , "") & make_random_func(1, 1 , 1, 12, "type_datetime") & make_random_func(1, 1 , 1, 31 , "type_datetime")
				sex = "Man"

				'유저명
				unm = ran_name_func()
				i = 1
				Do Until i > 100 
					SQL = "select UserName from tblPlayer where UserName = '"&unm&"'"
					Set rs = db.ExecSQLReturnRS(SQL , null, ConStr)

					If rs.eof Then
						i = 1000
					Else
						unm = ran_name_func()						
					End if
				i = i + 1
				loop

				'팀명
				SQL = " Select top 2 Team,TeamNm from tblTeamInfo where SportsGb = 'tennis' and DelYN = 'N'  ORDER BY NEWID() "
				Set rs = db.ExecSQLReturnRS(SQL , null, ConStr)

				i = 0
				Do Until rs.eof 
					teamno(i) = rs("Team")
					teamnm(i) = rs("TeamNm")
				i = i + 1
				rs.movenext
				loop

				insertfield = " SportsGb,PlayerGb,UserName,UserPhone,Birthday,Sex,Level,EnterType,Team,TeamNm,Team2,Team2Nm,RankingPoint,userLevel,PersonCode "
				insertvalue = " 'tennis','te045001','"&unm&"','"&uphone&"','"&ubirth&"','"&sex&"','null','A','"&teamno(0)&"','"&teamnm(0)&"','"&teamno(1)&"','"&teamnm(1)&"',"&rankpoint&",'"&userLevel&"','"&pcode& "' "
				SQL = "SET NOCOUNT ON INSERT INTO tblPlayer ( "&insertfield&" ) VALUES " 
				SQL = SQL & "( "&insertvalue&" ) SELECT @@IDENTITY"

				Set rs = db.ExecSQLReturnRS(SQL , null, ConStr)
				pidx = rs(0)
				make_player_func = array(pidx,unm,ubirth,sex,teamnm(0),teamnm(1),uphone,rankpoint,userLevel)
		End Function

		Function make_rankingpoint_func(idx)
			Dim teamCnt : teamCnt = 0
			Dim teamCntMin : teamCntMin = 1
			Dim teamCntMax : teamCntMax = 1
			Dim pointMin : pointMin = 0
			Dim pointMax : pointMax = 1000
			Dim point : point = 0
			SQL = " select Count(*) as TeamCnt from tblTeamGbInfo where SportsGb = 'tennis' and PTeamGb in ('200', '201', '202') and DelYN = 'N'  "
			Set rs = db.ExecSQLReturnRS(SQL , null, ConStr)
			Do Until rs.eof 
				teamCntMax = rs("TeamCnt")
			rs.movenext
			loop

			' 팀 만들 램덤 개수 
			Randomize()
			takeTeamCnt = Int((Rnd * teamCntMax) + teamCntMin)
			SQL = " select Top " & takeTeamCnt & " TeamGB from tblTeamGbInfo where SportsGb = 'tennis' and PTeamGb in ('200', '201', '202') and DelYN = 'N'  ORDER BY NEWID() "
			Set rs = db.ExecSQLReturnRS(SQL , null, ConStr)
			
			IF Not rs.EOF Then 
				arrRS = rs.GetRows()
			End if

			insertfield = " PlayerIDX,rankpoint,teamGb "
			IF IsArray(arrRS) Then
				For ar = LBOUND(arrRS, 2) To UBound(arrRS, 2)
					TeamGb = arrRS(0, ar)
					' 랭킹 램덤 점수 
					Randomize()
					point = Int((Rnd * pointMax) + pointMin)

					insertvalue = " '"&idx&"','"&point&"','"&TeamGb&"' "
					SQL = "SET NOCOUNT ON INSERT INTO sd_TennisRPoint ( "&insertfield&" ) VALUES " 
					SQL = SQL & "( "&insertvalue&" ) SELECT @@IDENTITY"
					Set rs = db.ExecSQLReturnRS(SQL , null, ConStr)
					
				Next
			END IF
			


		END Function

		userinfo = make_player_func()

		make_rankingpoint_func(userinfo(0))

'타입 석어서 보내기
Call oJSONoutput.Set("result", "0" )
oJSONoutput.AutoNo = CDbl(autono) - 1
strjson = JSON.stringify(oJSONoutput)
Response.Write strjson
Response.write "`##`"

pidx = userinfo(0)
pname =  userinfo(1)
pbirth =  userinfo(2)
psex =  userinfo(3)
pteam1 =  userinfo(4)
pteam2 =  userinfo(5)
pphone =  userinfo(6)
prankno =  userinfo(7)
pgrade =  userinfo(8)
writeday = Date()



  Set rs = Nothing
  db.Dispose
  Set db = Nothing
%>
<!-- #include virtual = "/pub/html/RookietennisAdmin/PlayerList.asp" -->
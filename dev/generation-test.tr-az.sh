#!/bin/bash

if [[ $# -lt 1 ]]; then
	echo "Not enough arguments to generation-test.sh";
	echo "bash generation-test.sh <corpus>";
	exit;
fi

if [[ $1 == "-r" ]]; then
	if [[ $# -lt 2 ]]; then 
		echo $#;
		echo "Not enough arguments to generation-test.sh -r";
		echo "bash generation-test.sh -r <corpus>";
		exit;
	fi
	args=("$@")
	echo "Corpus in: "`dirname $2`;
	echo -n "Processing corpus for generation test... ";
	rm -f /tmp/tr-az.corpus.txt
	for i in `seq 1 $#`; do 
		if [[ ${args[$i]} != "" && -f ${args[$i]} ]]; then 
			cat ${args[$i]} >> /tmp/tr-az.corpus.txt
		fi
	done
	echo "done.";
	echo -n "Translating corpus for generation test (this could take some time)... ";
	cat /tmp/tr-az.corpus.txt | apertium -d ../ tr-az-transfer | sed 's/[µµ____ɡʧˌɡˈɡɪ_ʊʂˈʹˈʃʀⁿℓℓ_ˈʀにゃɑːˌމލʃɑˌܕܝܪܐܕܡܪܝܓܒܪܐܝܠダホメ트란스요르단አማርኛஸ்ரீஜயவர்த்தனபுரம்கோட்டேɾɐˈɲɐธงฉาน아비시니아네덜란드령기아나ວຽງຈນオートボルタวุฒิสภาトクマルシューゴธงราชนาวีธงไตรรงค์กรุงเทพมหานครˈˇゃˈɡはぁศาลひらがなウィキペディアபொங்கல்สภาผู้แทนราษฎรºăååååÅÅÅãããąāāảÅåÃªāĀġāææÆÆææðʼĂḥāņążḃććčččČċĆćČččěđĐḓððððḍāʾÐðĐồếếễệěẽẽėėęęĘēḗēēʻẻɛəəˈˈʎɛˈɛʁɛˈɛʃˌɛəəˌəˈɡʀəˈɛʧɛěłěŕěŕěžėžɛʁˈʒġĠģīħĦḥḫĩīīĪķĶľŀłłŁḷłąłęłłłŻńńńňņʉŋŋņģēŃńņšṇšŏốồộǒőŐõøøøːØØōṓōŌớʁɔɔɔʁººœœõõøøØøřŘŘřṛṣṇśśŚšššŠŠṣśćśćšćščšČšėṣīßßţŢŭǔůűũųųūʻūūūʻừườươūšŮůÿźžžŽŽŽżŻŻþþþþÞÞÞþʒʒʒɛʒɔأبوظبياحمدشاهمسعودایراناردواسلامآبادالجمهريةالتونسيةالخرطومالخرطومبحريالخلافةالراشدةالدارالبيضاءالرباطالرياضالصحراءالغربيةالصحراءالغربيةالعباسيونالعربيةالفاطميونالمدينةالمنورةالمغربالعربيالمملكةالعربيةالسعوديةالمنامةأمدرمانأميرالمؤمنينبغدادبندرسريبڬاوانبيارأمينالجميلپاکستانتهرانجالكعيوجدةجمهوریاسلامیایرانحزباللهخشایارشاخلافةخوروشوفدارالسلامداغستاندولةالكويترخزرنيخزنگبارستادالملكفهدالدوليسيحونشاهصدامحسينعبدالمجيدالتكريتيصنعاءعثمانبنعفانعربʻعشقآبادعكاعلممصرعليبنأﺑﻲطالبعمربنالخطابغارويفاسقطاعغزةلبنانليلىخالدمحموداحمدینژادمدينةالكويتمراكشمسقطمشهدمیشودومیتوانیممكةمكةالمكرمةمنظمةالتحريرالفلسطينيةمورونينداآقاسلطاننیشابورنواكشوطهرجيساههریمىكوردستانڤوتراجايوديعسعادةאביסיניעאליאפללוארגענטינעבנימיןנתניהוגיוראאפשטייןגילהגמליאלדודיסלעווילנעחבשחרושציהודהעמיטליהוהיוחנןוולךיידישעקאמףארגאניזאציעיעקבישועמלךהמשיחנאווארעדאקנירברקתסיירתמטכלעבריתעיטורהמופתעכופױזןראובןראשהשנהרצועתעזהשבתשטאטשטעטלשטעטלעךשלמהשערלמתחילתשעהבאבΑΑʹααααΑβυσσινίαὙάδεςΑεροπόςΑΑθηναιΑἰθήρΆΐδηςΑὐλωνιάςΆνωΒόλταΑραχνοφοβίαΑργαίοςΆρηςΑριστοτέληςΆρχιμήδηςΆσπενδοςαστρολογιαάστρονἸάσωνΒʹββββακτηριονβάροςἭβηβιβλιαβιβλιονβίοςβοῦςβουλήΒριάρεωςβρωμοςΒυζαντινήΑυτοκρατορίαΒυζάντιογΓαῖαγαλαξίαςἈγαμέμνωνΓανυμήδηςΓεώργιοςΓεώργιοςΑʹΓεώργιοςΡουμπάνηςγηγράφεινγραφιςΓύγηςΔΔδΔαίδαλοςΔήλοςΔημήτηρΔημήτρηςΠᾍδηςδιασποράΔιόνυσοςδρομοςδυναμιςὈδυσσεύςῬέαεγκύκλιοςπαιδείαειςτήνπόλινΕξωστρακισμόςΕπικόςΚύκλοςἹεράπολιςἈέροποςΒεὐρύςΕὐρώπηηΉραθθθΘαλῆςὁΜιλήσιοςΘάνατοςΘείαΘέμιςΘεοδόσιοςθεοίχθόνιοιθεοςΘεοςτουΜετροΘέτιςἈθηνᾶΘησεύςΘουκυδίδηςὌθωνΙαξάρτηςἍιδηςΊησουςιπποςιτηςκαδμείαΚάδμοςκαθέδραΚαλλίπολιςΚαππαδοκίαΚάρανοςΚαρίαἼκαροςἙκατόγχειρεςἑκατόνὨκεανίδεςὨκεανίςΚένταυροιΚεντρικόΣχολείοΚεϋλάνηΚλήμηςΑλεξανδρεύςκλίμαΚοίνοςΚοῖοςΚόττοςκρέαςΚρεῖοςΚρηναῖαιΚρόνοςκρυπτόςΚυκλάδεςκυκλάςΚωνσταντίνοςΠαπαρρηγόπουλοςΚωνσταντῖνοςΑʹΚωνσταντῖνοςΒʹλλΛαμπάδεςλαόςΛειμενίδεςἤλεκτρονἈλέξανδροςἈλέξανδροςΒἈλέξανδροςὁΜακεδώνΛητώἸλιάςΛιβύηἈλικαρνασσόςἉλικαρνᾱσσόςἭλιοςἈλκέταςἈλκέταςὁΜακεδὼνλογοςλόγοςὅλοςἈλσηΐδεςμμμἈμαζόνεςΜακεδονίαΜέδουσαΜελίαιΜενοίτιοςἩμέραΜέστριοςΠλούταρχοςμετρονΜίλμισθοφορίαΜολώνλαβέμοῖραΜοῖραιμυϑολογεινμυϑολογίαμυϑοςἈμύνταςἈμύνταςΓἈμύνταςΔνννἈναξαγόραςἈναξιμήνηςναπαῖαιΝέαΠόλιςνεράϊδανημοσύνηΝηρηΐδεςξενοςΞέρξηςόοΑρχέλαοςΟἰδίπουςοιμούσεςΟὐρανόςοἱἈργεάδαιοΤέωςοτέωςβασιλιάςππππππΠαῦλοςΠάνΠαναίτιοςπαραβολήΠαυσανίαςἈπέλλωνὑπερβολήΠερδίκκαςΒΠερδίκκαςΓΠερικλῆςπεριμετροςὙπερίωνΠερσεύςΠηγαῖαιΠηλεύςΠηνελόπειαΠηνελόπηπλπλανήτηςΠλειάδεςπλεῖνΠλούταρχοςποίησιςἈπόλλωνΠόντοςπόροςΠοσειδῶνΠοταμοίἽππαρχοςἱπποπόταμοςΠριγκηπονήσιαΠριγκήπωννήσοιΠτολεμαῖοςὉΠυθαγόραςὉΠυθαγόραςὁΣάμιοςἘπώνυμοςἄρχωνρἜρεβοςὈρέστηςὀρθόςἈριάμνηςἈριαράθηςἈριαράθηςἈριαράθηςΕὐσεϐήςἈριαράθηςΕὐσεϐήςΦιλάδελφοςἈριαράθηςΕὐσεβήςΦιλοπάτωρἈριαράθηςΕὐσεϐήςΦιλοπάτωρἈριαράθηςἘπιφανήςἈριαράθηςἘπιφανήςΦιλοπάτωρἈριαράθηςΦιλομήτωρἘρινύεςἈριοϐαρζάνηςΕὐσεϐήςΦιλορώμαιοςἈριοϐαρζάνηςΦιλοπάτωρἈριοϐαρζάνηςΦιλορώμαιοςἈρίσταρχοςροδανόςἀρχἈρχέλαοςΑἄρχοντεςἄρχωνΡώμηἜρωςσΣάτυροισεισάχθειαΣελάναΣίσυφοςἈσκληπιόςΣπάρτηἙσπερίδεςσπέρμαἙστίαστοιχειονστροςΣτύξτΤάνταλοςταΠριγκηπόνησαΤάρταροςτετραγράμματονΤηθύςΤιτάνΤιτᾶνεςΤῶνἈράτουκαὶΕὐδόξουφαινομένωνἐξήγησιςΤόχαροιΤραπεζούντατυραννίςτύραννοςἭφαιστοςΦανάριἘφιάλτηςΦιλαδέλφειαΦίλιπποςΑφιλολογίαφοβοςφυσικόςφύσιςφωςΧαοςχείρΧείρωνχθώνἈχιλλεύςἄχοςΧριστόςΧρόνοςὄψΩΩΏἨώςАбазаБызшваАбисинијаАбисинияАбиссинияавтмАдамМіцкевічадыгАзиатскАйзекАзимвАлександрАлександрАлександрИльичУльянвАлександрвскийдврецАлександрЯрславичНевскийАлёшаПпвичАлисаЗинвьевнаРзенбаумАлтайскийкрайАляксандрІгаравічРыбакАмурАмурскаябластьАмурскийкрайАнастасияРманвнаЗахарьинаАндрейИванвичКбылаАндрейКасайАндрейЯрславичАничквдврецАннаИаннвнаАрсенальнаяУглваябашняАрхипелагГУЛАГАстанаАхматАбдулхамидвичКадырвБабаБабаЯгаБабаЯґаБарнаулБашБеклемишевскаябашняБеларусьБеоградбесБишкекблагимматомБлаговещенскаябашняБгатыриБльшевикиБльшйГатчинскийдврецБльшйслварьматаБрисФёдрвичГдунвБрвицкаябашняБратБратваБратскБратьяКарамазвыБританскийГндурасБританскиХндурасБургасбуряадхэлэнбългарскиезиквВВалерийЛентьевВарнаВасилийВасилийЯрславичВелесвакнигавеликаякнягинявеликийкнязьвеликийкнязьВеликеКняжествМсквскеВенераВиктрМихайлвичВаснецвВильнаВильнюсВильнюсВіліяВільнявлагаВладивсткВладимирВладимирВладимирвичМаяквскийВладимирВладимирвичПутинВладимирВльфвичЖиринвскийВладимирИльичЛенинВладимирскийдврвдитьводкаполухлебноговинаводкахлебноговинаВодовзводнаябашняВодянаябашняВолгаВолгаВолгоградВолодимирВоскресенскиеворотаВостокВосточнаяАзияВостраяБрамаВосходврагинародавредителиВсеволодВсеволодвсеяРусиВтораяБезымяннаябашняГавриилГаллейГеройРоссииГеройРоссийскойФедерацииГеройСоветскогоСоюзаГІалгІаймоттГлавноеуправлениеисправительноГлавныйУниверсальныйМагазинГледенГЛОбальнаяНАвигационнаяСпутниковаяСистемаГорячиескалыГорячиеСкалыГосударственныйИсторическиймузейГосударственныйИсторическиймузейГосударственныйУниверсальныйМагазинГригорийЕфимовичРаспутинГригорийЕфимовичНовыйгромитьгрупповщинаГубернскоеправлениеГУЛАГДДавидФёдоровичОйстрахДагомеяДажбогДальнийВостокРоссииДворецБелосельскихДворецтрудаДедМороздждзДзвДимаБиланДмитрийДонскойДмитрийМихайловичПожарскийДмитрийМихайловичТверДобрыняНикитичДондругДушанбеебатьебатьменявротЕвгенийВикторовичВучетичЕвгенийГорбуновЕкатеринаЕкатеринаВеликаяЕкатеринбургЕкатерингофЕкатерининскийдворецЕлагиндворецЕлизаветаПетровнаЕрмакТимофеевичетитьёёёбтвоюматьЖаргонпадонковЗабайкальскийкрайЗавоссеЗападнаяДвинаЗвёздныйгородокЗемщинаЗенитЗимнийдворецЗондѕИвИванИванГрозныйИванЦаревичИванЯковлевичБилибинИверскиеворотаИгорьИдиотиздательствоИзяславИзяславЯрославичИльяМуромецимператоримператрицаИнженерныйзамокИоаннИркутскИсаакОзимовискусственныйспутникЗемлиИсследованиемировыхпространствреактивнымиприборамиїҚазақстанРеспубликасыКазанскийсоборКамчатскийкрайКемеровоКёнигКёнигсбергКёнигсбергКижиКиївкняжествоМосковскоекнязьГеоргийЛьвовКоломенскоеКомендантскаябашняКомратКонстантинокопейкакопьёКораблькорольКосмоскраснаяКраснаямафияКраснаяплКраснодарКраснодарскийкрайКрасноярскийкрайКрасныйЯрКремлькрошитьКузнецкКурильскиеостроваКуршскийзаливКутафьябашняКучумКъарачайЛЛенаЛетнийдворецЛжедимитрийЛобноеместоЛобноеместолубокЛуноходМавзолейВМавзолейВМакедонскиМариинмариййылмеМарияФёдоровнамарыйлмыматматьМеньшевикимечМикоянМиГМихаилВасильевичНестеровМихаилГорбачёвМихаилТимофеевичКалашниковМихаилФёдоровичРомановМихайловскийзамокМихалкоМолниямолокМонголУлсМоскваМоскваМоскваМоскворецкаябашняМосковскийгосударственныйуниверситетимениММосковскийКремльМосковскиймеждународныйделовойцентрМраморныйдворецМстиславВладимировичВеликийМынабатНабатнаябашняНавагрудакнадцатьНаркотикинаследникцесаревичНеваНекропольуКремлёвскойстеныНеманНёманНижегородскаяобластьНиколаевскийдворецНиколайНикольскаябашнянихуясебеНовгородскаяобластьНовиХебридиНовогрудокНовокузнецкНовосибирскНовосибирскаяобластьНовосибирскиеостроваНовыйНохчийнмоттообластьОгопьОдессаОдинденьИванаДенисовичаОкаОкрошкаоктябрьскаяреволюцияОмскопенгагенОпричнинаопричьОраниенбаумОрдэзэнОрловскаяобластьОружейнаябашняОткрытыйСанктОхотскоемореОхотскоемореПавелПавелПетровичПавловскПагоняПамятникМининуиПожарскомуПамятникМининуиПожарскомуПерваяБезымяннаябашняПермскийкрайПермьПерсијаПетергофПетергофскийпраздникПетровскаябашняПетропавловскПётрПётрИльичЧайковскийпогромподонкиПокровскийсоборПокровскийСоборПравдапредтечаПреступлениеинаказаниеПриамурьеПриморскийкрайПриморьепролетарскаякультураПростейшийСпутникПушкинРаврасколрасколраскольникираспутникраспутныйРепубликаМакедонијаРеспубликаДагестанРеспубликаКомиРеспубликаМарийЭлрокнакостяхРоманРоманКутновРомановРомановРоссийскаяСоветскаяФедеративнаяСоциалистическаяРеспубликаРоссийскиенемцыРостоврублейрубльрубльрубляРусланаСтепанівнаЛижичкоРусскаямафияРусскиеРусскийКовчегрусскийязыкРѣчъпосполитаяѡбоиганародовъСавезнаРепубликаЈугославијаСалютсамСамараСамиздатСарајевоСвибловабашняСвятополкСвятополкОкаянныйСвятославСвятославСвятославЯрославичСеверныйморскойпутьСемёнИвановичГордыйСенатскаябашняСергейЛедовскийСергейЮльевичВиттеСибирскиетраппыСибирскийТрактСибирьСибирьиДальнийВостокСИТИСихотэСоборКазанскойиконыБожиейМатериСоборПокровачтонаРвуСодружествоНезависимыхГосударствСофияСпасскаябашняСпутникСрбијаиЦрнаГораСредняяАрсенальнаябашняСтавропольскийкрайСталинабадСталинскСталинскиевысоткистароверыСтароверыСтрсубъектыСучьявойнаСырдарьяТаврическийдворецТайницкаябашняТашкентТираспольТихийДонТобольскТомскаяобластьтоҷикӣТранссибТранссибирскаямагистральТранссибирскаямагистральТриумфТриумфТроицеТроицкаябашняТуваТунгускаТываТывадылудмурткылУльяновУльяновскаяобластьУральскиегорыустьеУстюгУфаФаддейФаддеевичБеллинсгаузенФедеральнаяслужбабезопасностиРоссийскойФедерациифедеральныеокругаФедерацияФерапонтовмонастырьФёдорФёдорБорисовичГодуновФёдорВладимировичЕмельяненкоФобосФормозаФутбольныйклубКубаньКраснодарХабаровскХабаровскийкрайХакастіліХальмгкелнХантыхантыясангХеладахлебХождениепомукамХоландскаГвајанахорошоХрамВасилияБлаженногоХрамХристаСпасителяХрущёвцаревичцаревнацарицаЦарскаябашняЦарскоеселоЦарствоРусскоецарьцарьЦейлонЦејлонЦентральнопромышленнаяобластьцесаревичцесаревнаЦрвеназвездаЧернивръхЧёрнаяАкулаЧумнойбунтшестнадцатьшквалщыьээрзянькельююгюгЮлЮрийАлексеевичГагариняядернаявключеннаясубмаринаЯмалоЯнаЯнтарныйКрайЯрополкЯрославЯрославльЯрославМудрыйԷրեբունիՀայաստանՀայերենլեզուՀայքՊարսկաստանასოასომთავრულიაჭარაბათუმითბილისიმთავარიმხედრულინუსხურიქართულიენაइंदिराप्रियदर्शिनीगांधीकानपुरकृष्णजटायूजयपुरजैनधर्मजंगलजंगलबातचलीहैदिल्लीनेपालअधिराज्यपटनापुणेपुरमोहनदासकरमचन्दगांधीवंदनाशिवासिंहहिन्दीસુરત上海京城京都内蒙古北京北千島北方領土北海南京南京市南千島南千島周树人周樹人和橋鎮唐国家体育场國家體育場地区级地级大和대한민국大韓民國天津市奉天孔夫子小琉球川端康成平仮名ひらがな広島市府廣州成都市数独新幹線早川俊夫木簡東京東京柔道スズキ株式会社水木一郎汉武帝沈阳オホーツク海深圳市漢字漢字漢字かんじ漢武帝片仮名カタカナ狩野元信玉白話皇居県篪蔡英文裕仁西安西安市象象棋道都都道府県鄭和重庆市金星長安長野市骨魯]//g' | sed 's/\$\W*\^/$\n^/g' > /tmp/tr-az.gentest.transfer
	echo "done.";
fi

if [[ ! -f /tmp/tr-az.gentest.transfer ]]; then
	echo "Something went wrong in processing the corpus, you have no output file.";
	echo "Try running:"
	echo "   sh generation-test.sh -r <corpus>";
	exit;
fi

cat /tmp/tr-az.gentest.transfer | sed 's/^ //g' | grep -v -e '@' -e '*' -e '[0-9]<num>' -e '#}' -e '#{' | sed 's/\$>/$/g' | sed 's/^\W*\^/^/g' | sort -f | uniq -c | sort -gr > /tmp/tr-az.gentest.stripped
cat /tmp/tr-az.gentest.stripped | grep -v '\^\W<' | hfst-proc -d ../tr-az.autogen.hfst > /tmp/tr-az.gentest.surface
cat /tmp/tr-az.gentest.stripped | grep -v '\^\W<'  | sed 's/^ *[0-9]* \^/^/g' > /tmp/tr-az.gentest.nofreq
paste /tmp/tr-az.gentest.surface /tmp/tr-az.gentest.nofreq  > /tmp/tr-az.generation.errors.txt
cat /tmp/tr-az.generation.errors.txt  | grep -v '#' | grep '\/' > /tmp/tr-az.multiform
cat /tmp/tr-az.generation.errors.txt  | grep '[0-9] #.*\/' > /tmp/tr-az.multibidix 
cat /tmp/tr-az.generation.errors.txt  | grep '[0-9] #' | grep -v '\/' > /tmp/tr-az.tagmismatch 

echo "";
echo "===============================================================================";
echo "Multiple surface forms for a single lexical form";
echo "===============================================================================";
cat /tmp/tr-az.multiform

echo "";
echo "===============================================================================";
echo "Multiple bidix entries for a single source language lexical form";
echo "===============================================================================";
cat /tmp/tr-az.multibidix

echo "";
echo "===============================================================================";
echo "Tag mismatch between transfer and generation";
echo "===============================================================================";
cat /tmp/tr-az.tagmismatch

echo "";
echo "===============================================================================";
echo "Summary";
echo "===============================================================================";
wc -l /tmp/tr-az.multiform /tmp/tr-az.multibidix /tmp/tr-az.tagmismatch

; Макробиблиотека команд битового сопроцессора для
; вычисления логических функций методом тестирования бит
;*********************************************************
; Тестирование бита в регистре ЦПУ по его номеру
		MACRO
		TST_Bit $R,$N
		TST $R,#(1<<$N)
		MEND
;*********************************************************
;*********************************************************
; Установка бита в регистре ЦПУ по его номеру
		MACRO
		SET_Bit $R,$N
		ORR $R,#(1<<$N)
		MEND
;*********************************************************	
;*********************************************************
; Сброс бита в регистре ЦПУ по его номеру
		MACRO
		CLR_Bit $R,$N
		BIC $R,#(1<<$N)
		MEND
;*********************************************************	
; Конец ассемблерного текста
		END
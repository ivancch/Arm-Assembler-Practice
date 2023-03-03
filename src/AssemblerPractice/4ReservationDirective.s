; Объявить кодовую секцию MyCode
			AREA MyCode, CODE, ReadOnly
; Объявить точку входа в программу приложения	
				ENTRY
; Объвить точку входа глобальной переменной
				EXPORT ReservationDirective
ReservationDirective
; Загрузка регистров ЦПУ из предварительно
; проинициализированной кодовой памяти
; Псевдокоманды загрузки слов по известным 
; адресам их расположения	
			LDR r0, Const_0
			LDR r1, Const_1
			LDR r2, Const_2
			LDR r3, Const_3
			LDR r4, Const_4
			
			BLX LR
			
			ALIGN
; Инициализация констант в кодовой памяти
Const_0		DCD 0x7788ffaa
Const_1		DCD	0x22221111
Const_2		DCW 34,35
Const_3		DCB	1,2,3,4
Const_4		DCB 5,6
; Конец ассемблерного текста
			END
				
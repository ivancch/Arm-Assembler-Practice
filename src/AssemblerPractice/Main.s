; Объявление кодовой секции
		AREA MyCode, CODE, ReadOnly
; Основная программа
; Объявление основной программы общедоступной
		EXPORT Main
; Начало основной процедуры
Main
; Импорт и переход к подпрограммам 
; по мере изучения Arm Assembler
		
	; Изучение основ Assembler, первые операции
		IMPORT SimpleOperations
;		LDR r0, =SimpleOperations
;		BLX r0
	
	; Загрузка 32-битных констант при помощи
	; команды LDR, нюансы работы
		IMPORT _32bitConst
;		LDR r0, =_32bitConst
;		BLX r0
		
	; Принудительное размещение литеральных пулов
	; при помощи директивы LTORG
		IMPORT ForcedReservationLTORG
;		LDR r0, = ForcedReservationLTORG
;		BLX r0

	; Загрузка данных из кодовой памяти
	; по адресам размещения данных
	; при помощи Define Code
		IMPORT ReservationDirective
;		LDR r0, =ReservationDirective
;		BLX r0

	; Косвенная адресация операндов в памяти
		IMPORT IndirectAddressing
;		LDR r0, =IndirectAddressing
;		BLX r0

	; Копирование данных из ПЗУ в ОЗУ
	; При помощи цикла с пост-проверкой
		IMPORT CopyRomRamWithLoop
		LDR r0, =CopyRomRamWithLoop
		BLX r0

Stop	
 		B Stop

		ALIGN
; Конец ассемблерного текста
		END
					
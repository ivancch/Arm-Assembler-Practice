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
;		LDR r0, =CopyRomRamWithLoop
;		BLX r0

	; Операции сложения и вычитания 
	; в различных вариациях
	; с сохранением результата в ОЗУ
		IMPORT OperationsAddAndSub
;		LDR r0, =OperationsAddAndSub
;		BLX r0
	
	; Cложение и вычитание двойного слова
	; в том числе с использованием макрокоманды
		IMPORT AddAndSubDWord
;		LDR r0, =AddAndSubDWord
;		BLX r0

	; Множественная загрузка и выгрузка,
	; умножение и деление в том числе
	; в 64-х битном формате
		IMPORT ArithmeticOpWithLDM_STM
;		LDR r0, =ArithmeticOpWithLDM_STM
;		BLX r0
		
	; Побитовые операции в том числе
	; с применением логических сдвигов
	; Реализация логического контроллера по таблице 
	; истинности
		IMPORT BitwiseOpAndShifts
;		LDR r0, =BitwiseOpAndShifts
;		BLX r0
		
	; Реализация логического контроллера с использованием
	; макробиблиотеки функций битового сопроцессора
		IMPORT LogicController
;		LDR r0, =LogicController
;		BLX r0
	
	
	; Реализация логического контроллера методом
	; тестирования входных битовых переменных
		IMPORT LogicContrTestBits
;		LDR r0, =LogicContrTestBits
;		BX r0

	; Программная реализация дискретного управляющего 
	; автомата (главный привод продольно-строгального станка)
		IMPORT DiscreteContrMachine
;		LDR r0, =DiscreteContrMachine
;		BX r0
		
	; Программирование битового сопроцессора.
	; Битовые ленты (Bit_Mapping) в памяти данных 
	; и в памяти периферийных устройств
		IMPORT BitAddressableRegisters_V1
;		LDR r0, =BitAddressableRegisters_V1
;		BX r0
		
	; Программирование битового сопроцессора.
	; Битовые ленты (Bit_Mapping) в памяти данных 
	; и в памяти периферийных устройств
	; методом тестирования битовых переменных.
		IMPORT BitAddressableRegisters_V2
;		LDR r0, =BitAddressableRegisters_V2
;		BX r0
		
	; Дискретный автомат управления продольно-строгальным 
	; станком (второй вариант решения 
	; с использованием "семафорной памяти")
		IMPORT DiscreteContrMachine_V2
		LDR r0, =DiscreteContrMachine_V2
		BX r0
		
Stop	
 		B Stop

		ALIGN
; Конец ассемблерного текста
		END
					
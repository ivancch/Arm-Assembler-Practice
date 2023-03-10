; Подключить файл с макробиблитекой функций
; битового сопроцессора
				INCLUDE MacroBit.s
; Объявить кодовую секцию MyCode
				AREA MyCode11, CODE, ReadOnly
; Объявить точку входа в программу приложения	
				ENTRY
; Объвить точку входа глобальной переменной
				EXPORT LogicController
LogicController
LOG_CONTR
; Реализация логического контроллера с использованием
; макробиблиотеки функций битового сопроцессора
; Загрузить вектор входа X из памяти
				LDR r5, =X
				LDR r1, [r5]
				
; Расчет Функции y0
				L_Bit r0, r1, 6
				EOR_Bit r0, r1, 9
				NOT_A r0
				MOV r10, r0
				
				L_Bit r0, r1, 31
				ORN_Bit r0, r1, 2
				AND r10, r0, r10
				
				L_Bit r0, r1, 0
				AND_Bit r0, r1, 5
				ANDN_Bit r0, r1, 7
				
; Не забываем установить флаги
				ORRS r0, r10
				S_Bit r0, r2, 0
				
; Расчет функции y23
				L_Bit r0,r1,0
				NOT_A r0
				ORN_Bit r0,r1,3
				S_Bit r0,r2,23
				
; Расчет функция y24
				L_Bit r0,r1,0
				AND_Bit r0,r1,3
				NOT_A r0
				S_Bit r0,r2,24

; Вывести управляющие воздействия в порт вывода
				LDR r5,=Y
				STR r2,[r5]
; Повторить цикл логического контроллера
				B LOG_CONTR

; Останов
				BX lr
				ALIGN
; Объявление секции данных в памят данных
				AREA MyData11, DATA, ReadWrite
; Резервирование 2-х слов под 
; вектор входа X и вектор выхода Y
X		SPACE 4
Y		SPACE 4

; Конец ассемблерного текста
				END
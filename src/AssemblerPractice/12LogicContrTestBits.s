; Подключить файл с макробиблитекой битового 
; сопроцессора для вычисления  логических
; функций методом тестирования бит
				INCLUDE MacroTestBit.s

; Объявить кодовую секцию MyCode
				AREA MyCode11, CODE, ReadOnly
; Объявить точку входа в программу приложения	
				ENTRY
; Объвить точку входа глобальной переменной
				EXPORT LogicContrTestBits
LogicContrTestBits
LOG_CONTR
; Реализация логического контроллера методом
; тестирования входных битовых переменных
; Загрузить вектор входа X из памяти
				LDR r5, =X
				LDR r1, [r5]
; Вызвать подпрограмму расчета функции y0
				BL CALC_y0
; Вызвать подпрограммы расчета других функций
;				...
; Вывести управляющие воздействия в порт вывода
				LDR r5, =Y
				STR r2, [r5]
; Повторить цикл логического контроллера
				B LOG_CONTR

; Останов
Stop	
			B Stop
				
; Подпрограмма расчета Функции y0
CALC_y0
				TST_Bit r1, 0
				BNE	S_y0
				TST_Bit r1, 5
				BEQ C_y0
				TST_Bit r1, 1
				BEQ S_y0
C_y0
				CLR_Bit r2, 0
				BX lr
S_y0
				SET_Bit r2, 0
				BX lr
				
				ALIGN
; Объявление секции данных в памят данных
				AREA MyData12, DATA, ReadWrite
; Резервирование 2-х слов под 
; вектор входа X и вектор выхода Y
X				SPACE 4
Y				SPACE 4

; Конец ассемблерного текста
				END
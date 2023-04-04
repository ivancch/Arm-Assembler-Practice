; Работа со стеком

; Объявить кодовую секцию MyCode
				AREA MyCode15, CODE, ReadOnly
; Объявить точку входа в программу приложения	
				ENTRY
; Объвить точку входа глобальной переменной
				EXPORT StackTesting
StackTesting

		; Работа со стеком с использованием команд 
		; PUSH, POP
;				B version1
				
		; Работа со стеком с использованием команд 
		; PUSH, POP вариация 2
;				B version2
				
		; Работа со стеком с использованием команд 
		; множественной загрузки/сохранения данных в памяти
;				B version3
				
		; Работа со стеком с использованием команд 
		; множественной загрузки/сохранения данных в памяти
		; вариация 3
				B version4
		
********************************************
version1
; Инициализация трех регистров ЦПУ начальными данными
				MOV r1,#1
				MOV r2,#2
				MOV r3,#3
; Сохранить значения регистров в стеке
LOOP1
				PUSH {r1,r2,r3}
;				... 
; Использование регистов r1,r2,r3 (для примера, обнуление) 
				MOV r1,#0
				MOV r2,#0
				MOV	R3,#0
;				...
; Восстановить значения регистров из стека
				POP {r1,r2,r3}
; Повторить цикл сохранения/восстановления данных
; в стеке для других значений в регистрах
				B LOOP1
********************************************
version2
; Инициализация трех регистров ЦПУ начальными данными
				MOV r1,#1
				MOV r2,#2
				MOV r3,#3
; Сохранить значения регистров в стеке
LOOP2
				PUSH {r1}
				PUSH {r2}
				PUSH {r3}
;				... 
; Использование регистов r1,r2,r3 (для примера, обнуление) 
				MOV r1,#0
				MOV r2,#0
				MOV	R3,#0
;				...
; Восстановить значения регистров из стека
				POP {r1}
				POP {r2} ; Обратный порядок выгрузки по сравнию
				POP {r3} ; с прошлым примером
; Повторить цикл сохранения/восстановления данных
; в стеке для других значений в регистрах
				B LOOP2
********************************************
version3
; Инициализация трех регистров ЦПУ начальными данными
				MOV r1,#1
				MOV r2,#2
				MOV r3,#3
; Сохранить значения регистров в стеке
LOOP3
				STMDB SP!,{r1-r3}			
;				... 
; Использование регистов r1,r2,r3 (для примера, обнуление) 
				MOV r1,#0
				MOV r2,#0
				MOV	r3,#0
;				...
; Восстановить значения регистров из стека
				LDMIA SP!,{r1-r3}
; Повторить цикл сохранения/восстановления данных
; в стеке для других значений в регистрах
				B LOOP3
********************************************
version4
MyProg
; Инициализация трех регистров ЦПУ начальными данными
				MOV r1,#1
				MOV r2,#2
				MOV r3,#3
; Сохранить значения регистров в стеке
LOOP4
				STMFD SP!,{r1-r3}			
;				... 
; Использование регистов r1,r2,r3 (для примера, обнуление) 
				MOV r1,#0
				MOV r2,#0
				MOV	R3,#0
;				...
; Восстановить значения регистров из стека
				LDMFD SP!,{r1-r3}
; Повторить цикл сохранения/восстановления данных
; в стеке для других значений в регистрах
				B LOOP4

; Конец ассемблерного текста
				END
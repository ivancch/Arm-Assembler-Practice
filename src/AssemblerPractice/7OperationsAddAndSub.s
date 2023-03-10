; Объявить кодовую секцию MyCode
			AREA MyCode7, CODE, ReadOnly
; Объявить точку входа в программу приложения	
			ENTRY
; Объвить точку входа глобальной переменной
			EXPORT OperationsAddAndSub
OperationsAddAndSub
			
	; Первая вариация программы
	; простейшего сложение и вычитания
	; Данные в память вводятся вручную
			B Variation_1

;Выход из подпрограммы 
Back
			BX LR

Variation_1
; Операции сложения/вычитания слов
; Выполнить попарное сложение/вычитание 
; 32-разрядных слов из массива Array_W. 
; Сохранить суммы в памяти по адресу Sum_W
; Сохранить разности в памяти по адресу Sub_W
	; Инициализация указателей
			LDR r0, =Array_W
			LDR r1, =Sum_W
			LDR r2, =Sub_W
			MOV r3, #2 ; Число итераций
Loop
	; Проверка условия выхода и выход
			MOVS r3, r3
			BEQ Back
	; Тело функции
			LDR r4, [r0], #4
			LDR r5, [r0], #4
			ADDS r6, r4, r5
			STR r6, [r1], #4
			SUBS r6, r4, r5
			STR r6, [r2], #4
	; Вычитаем шаг из цикла и зацикливаем программу
			SUB r3, #1
			B Loop
; Выход из подпрограммы				
			B Back


			ALIGN
; Объявить секцию данных в оперативной памяти
			AREA MyData7, DATA, ReadWrite
; Зарезервировать в ней 4-е 32-разрядных слова
; источников данных (без инициализации)
Array_W		SPACE 4*4
; Зарезервировать в ОЗУ место для размещения 
; результов сложения и вычитания слов
Sum_W		SPACE 4*2
Sub_W		SPACE 4*2
; Конец ассемблерного текста
			END

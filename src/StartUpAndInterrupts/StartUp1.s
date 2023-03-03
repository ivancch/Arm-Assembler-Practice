; Программый модуль стартового файла StartUp_1
; Определить переменную "Размер стека" (1 К байт)
Stack_Size      EQU     0x00000400
; Объявить секцию данных для размещения стека системы
; без инициализации памяти, с атрибутом выравнивания 
; по 8 байтам
				AREA STACK, NOINIT, READWRITE, ALIGN=3
; Зарезервировать область памяти под стек 
; с числом байт Stack_Size            
Stack_Mem       SPACE   Stack_Size		; (1 К байт)
; Метка вершины стека (авто-декрементный стек)
__initial_sp

; Vector Table 
; Объявить секцию для размещения таблицы векторов 
; прерываний/исключений
; Для компановщика определяется как область памяти 
; данных RESET. Будет автоматически размещена компоновщиком 
; в начале памяти программ
                AREA    RESET, DATA, READONLY
; Объявить параметры таблицы векторов - глобальными именами
                EXPORT  __Vectors
                EXPORT  __Vectors_End
                EXPORT  __Vectors_Size
; Инициализация векторов обработчиков 
; прерываний/исключений
__Vectors       DCD     __initial_sp 	; Вершина стека - Top of Stack 
				DCD     Reset_Handler 	; Точка выхода в обработчик исключения
										; по сбросу процессора Reset Handler
				DCD     NMI_Handler   	; Точка входа в обработчик
										; немаскируемого прерывания NMI
;								...
; Далее по аналогии могут быть объявлены и остальные 
; вектора обработчиков прерываний/исключений
__Vectors_End
__Vectors_Size  EQU     __Vectors_End - __Vectors

; Объявление кодовой секции для размещения 
; подпрограмм обработчиков прерываний/исключений
                AREA    |.text|, CODE, READONLY
									
; Обработчик прерывания по сбросу процессора Reset
Reset_Handler   PROC
; Объявить процедуру Reset_Handler общедоступной
; Она может быть перепрограммирована в последующем
; Поэтому - используется опция WEAK ("Слабая метка")
                EXPORT  Reset_Handler [WEAK]
; Иницализация процессора (через регистр CONTROL)
;								...
; В данной версии стартового файла не выполняется
; Процессор будет работать по умолчанию 
; в режиме потока (Thread Mode) 
; с привилегированным доступом ко всем ресурсам (Privilegied)
; с пока выключенным сопроцессором FPU

; Передать управление пользовательской программе MyProg
; Объявление точки входа в программу пользователя 
; (внешняя метка)  
                IMPORT  Main
; Псевдо-команда: загрузить адрес MyProg в регистр r0
				LDR     r0, =Main		; r0 <- адрес точки входа  
; Косвенная передача управления программе пользователя								
                BX      r0						; PC <- (r0)
                ENDP			; Конец процедуры Reset_Handler

; "Пустой" обработчик немаскируемого прерывания NMI ("шаблон")
NMI_Handler     PROC
; Объявить процедуру NMI_Handler общедоступной
; В дальнейшем может быть перепрограммирована, 
; использована опция WEAK ("Слабая метка")
                EXPORT  NMI_Handler [WEAK]
; Зациклить программу обработчика 
                B       .
                ENDP		; Конец процедуры NMI_Handler
; Выровнять кодовую секцию по 4-х байтовому слову
				ALIGN
; Конец ассемблерного текста стартового модуля									
				END					
; Объявить кодовую секцию MyCode
				AREA MyCode13_2, CODE, ReadOnly
; Объявить точку входа в программу приложения	
				ENTRY
; Объвить точку входа глобальной переменной
				EXPORT DiscreteContrMachine_V2
DiscreteContrMachine_V2
; Дискретный автомат управления продольно-строгальным 
; станком (второй вариант решения 
; с использованием "семафорной памяти")
; Зарезервируем под порты ввода X, вывода Y и состояние 
; автомата N три слова в "семафорной памяти" 
; с адреса 0x20000000
Port_X		EQU	0x20000000
Var_N		EQU 0x20000004	
Port_Y		EQU 0x20000008
				
; Определение псевдо-адресов доступа к 
; битовым компонентам вектора X в "битовой ленте"
; (в текущей задаче используются только x0-x5)
x0			EQU 0x22000000
x1			EQU 0x22000004
x2			EQU 0x22000008
x3			EQU 0x2200000c	
x4			EQU 0x22000010	
x5			EQU 0x22000014	

; Объявление псевдо-адресов доступа к битам вектора Y
; (в текущей задаче не используются, так как вектор
; управляющих воздействий выводится целиком Y)
; y0			EQU 0x22000100
; y1			EQU 0x22000104
; y2			EQU 0x22000108

 
; Инициализация автомата
; Установить начальное состояние автомата N=0 
; Вывести управляющее воздействие Y = 0
				LDR r0,=N
				MOV r1,#0
				STRD r1, r1,[r0]	; Сохранить сразу два слова N,Y

; Основная программа дискретного управляющего автомата 
; Вызывается с частотой дискретизации системы управления
DISK_AVT
; Получить текущий вектор входных битовых переменных X 
; из "семафорной памяти" и сохранить
; каждый бит в отдельном регистре ЦПУ r0,r1,r2,r3,r4,r5
				LDR r6,=x0			; Загрузить псевдо-адрес бита x0
				LDM r6,{r0-r5}	; Считать биты в регистры r0-r5
; Получить текущий номер состояния автомата N
; и сохранить в регистре r7
				LDR r6,=N
				LDR r7,[r6]		
				
; Загрузить в регистр r6 адрес таблицы точек входа
; в подпрограммы - интерпретаторы вершин графа
				ADR r6, TAB_ADDR
; Считать из таблицы адрес интерпретатора, номер которого
; уже загружен в регистр r7 (номер вершины графа)
; Попутный авто-расчет смещения по таблице offset=(r7)*4
				LDR r8,[r6, r7, LSL #2]
; Косвенный вызов подпрограммы по ее начальному адресу
				BLX r8
;				...
; Повторить цикл дискретного управляющего автомата
				B DISK_AVT

; Подпрограмма интерпретатора вершины 0 графа
INT_0

; Проверить все условия перехода в порядке приоритета
; Компоненты вектора X сохранены в регистрах r0-r5
; Использовать в качестве аккумулятора регистр r10
; Условие 1: (x0+x2)∙(/x5) ∙(/x1) ∙(/x3)
				ORR r10,r0,r2		;(x0+x2
				BIC r10,r5			; ∙(/x5
				BIC r10,r1			; ∙(/x1)
				BIC r10,r3			; ∙(/x3)
				TST r10,#1			; Протестировать Bit[0]

; Если условие истинно, сменить номер состояния N=1
; и выдать управляющее воздействие Y=4
				LDRNE r6,=N
				MOVNE r7,#1
				MOVNE r8,#4
				STRDNE r7,r8,[r6]	; Сохранить сразу два слова N,Y
; Досрочный выход из подпрограммы INT_0				
				BXNE lr				; Остальные условия не проверять!
									
; Условие 2: x1∙(/x5) ∙(/x2) ∙(/x4)
				BIC r10,r1,r5
				BIC r10,r2
				BIC r10,r4
				TST r10,#1			; Протестировать Bit[0]
				
; Если условие истинно, сменить номер состояния N=2
; и выдать управляющее воздействие Y=2
				LDRNE r6,=N
				MOVNE r7,#2
				STRDNE r7,r7,[r6]	; Сохранить сразу два слова N,Y
				
; Больше условий перехода нет, завершить подпрограмму
				BX lr				
				
; Подпрограмма интерпретатора вершины 1 графа
INT_1

; Проверить все условия перехода в порядке приоритета
; Все компоненты вектора входа сохранены в регистрах r0-r5
; Условие перехода 1: x3+x1∙x2
				AND r10,r1,r2
				ORR r10,r3
				TST r10,#1					; Протестировать Bit[0]
				
; Если условие истинно, сменить номер состояния N=3
; и выдать управляющее воздействие Y=1
				LDRNE r6,=N
				MOVNE r7,#3
				MOVNE r8,#1
				STRDNE r7,r8,[r6]	; Сохранить сразу два слова N,Y
; Досрочный выход из подпрограммы INT_1				
				BXNE lr				; Остальные условия не проверять!
						
; Условие перехода 2: x1+x5			
				ORR r10,r1,r5
				TST r10,#1					; Протестировать Bit[0]
				
; Если условие истинно, сменить номер состояния N=0
; и выдать управляющее воздействие Y=0
				LDRNE r6,=N
				MOVNE r7,#0
				STRDNE r7,r7,[r6]	; Сохранить два слова N,Y
				
; Больше условий перехода нет, завершить подпрограмму
				BX lr					
								
; Подпрограмма интерпретатора вершины 2 графа
INT_2

; Проверить все условия перехода в порядке приоритета
; Условие перехода 1: x4+x1∙x2
				AND r10,r1,r2
				ORR r10,r4
				TST r10,#1					; Протестировать Bit[0
				
; Если условие истинно, сменить номер состояния N=3
; и выдать управляющее воздействие Y=1
				LDRNE r6,=N
				MOVNE r7,#3
				MOVNE r8,#1
				STRDNE r7,r8,[r6]	; Сохранить сразу два слова N,Y
; Досрочный выход из подпрограммы INT_2				
				BXNE lr				; Остальные условия не проверять!
				
; Условие перехода 2: x2+x5
				ORR r10,r2,r5
				TST r10,#1					; Протестировать Bit[0]
				
; Если условие истинно, сменить номер состояния N=0
; и выдать управляющее воздействие Y=0
				LDRNE r6,=N
				MOVNE r7,#0
				STRDNE r7,r7,[r6]	; Сохранить сразу два слова N,Y
			
; Больше условий перехода нет, завершить подпрограмму
				BX lr				
				
; Подпрограмма интерпретатора веришны 3 графа
INT_3

; Проверить единственное условие перехода x5
				TST r5,#1

; Если условие истинно, сменить номер состояния N=0
; и выдать управляющее воздействие Y=0
				LDRNE r6,=N
				MOVNE r7,#0
				STRDNE r7,r7,[r6]	; Сохранить сразу два слова N,Y
				
; Больше условий перехода нет, завершить подпрограмму
				BX lr			

; Выравнивание кодовой памяти по границе полного слова
; для размещения начальных адресов подпрограмм
				ALIGN
; Таблица начальных адресов интерпретаторов вершин графа
TAB_ADDR
				DCD INT_0
				DCD INT_1	
				DCD INT_2
				DCD INT_3

				ALIGN
; Секция данных 
				AREA MyData13_2, DATA, ReadWrite
; Резервирование основных переменных автомата
; в области "семафорной памяти", начиная с адреса 0x20000000
X				SPACE 4
N				SPACE 4
Y				SPACE 4
; Объявление этих переменных "глобальными" для возможности
; включения в окно наблюдаемых переменных Watch при отладке
				EXPORT	X
				EXPORT  Y
				EXPORT  N

; Конец ассемблерного текста
				END
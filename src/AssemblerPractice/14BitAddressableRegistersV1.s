; Возможности битового сопроцессора
; Битовые ленты (Bit_Mapping) в памяти данных 
; и в памяти периферийных устройств

; Объявить кодовую секцию MyCode
				AREA MyCode14_1, CODE, ReadOnly
; Объявить точку входа в программу приложения	
				ENTRY
; Объвить точку входа глобальной переменной
				EXPORT BitAddressableRegisters_V1
BitAddressableRegisters_V1
; Объявление адресов регистров входных битовых переменных X
; и выходных управляющих воздействий Y
; в области по-битово, по-байтово адресуемой памяти ПУ
Port_X	EQU	0x40000000
Port_Y	EQU 0x40000004
; Объявление псевдо-адресов доступа к битам вектора X
x0			EQU 0x42000000
x1			EQU 0x42000004
x2			EQU 0x42000008
x3			EQU 0x4200000c	
x4			EQU 0x42000010	
x5			EQU 0x42000014	
x6			EQU 0x42000018	
x7			EQU 0x4200001C
; Объявление псевдо-адресов доступа к битам вектора Y
y0			EQU 0x42000080
y1			EQU 0x42000084
y2			EQU 0x42000088
y3			EQU 0x4200008c	
y4			EQU 0x42000090	
y5			EQU 0x42000094	
y6			EQU 0x42000098	
y7			EQU 0x4200009C	
	
; Считать битовые компоненты вектора X в соответствующие 
; регистры процесора x0-> r0;... x7->r7
Load_Bit
; Инициализация базового регистра r10 адресом x0
;				MOV r10, #x0
; Получить очередной бит в одноименный регистр с пост-смещением
; содержимого указателя на 4
;				LDR r0,[r10],#4
;				LDR r1,[r10],#4
;				LDR r2,[r10],#4
;				LDR r3,[r10],#4
;				LDR r4,[r10],#4
;				LDR r5,[r10],#4
;				LDR r6,[r10],#4
;				LDR r7,[r10]
				
; Более эффективна групповая загрузка регистров ЦПУ
; Инициализация базового регистра r10 адресом x0
				MOV r10, #x0
; Загрузка всех 8-и регистров ЦПУ битовыми переменными
				LDM r10,{r0-r7}
; Все компоненты вектора X загужены в одноименные регистры ЦПУ	
; и выровнены по младшему биту с авто-очиской всех старших бит
; Пример вычисления двух битовых управляющих воздействий
; Расчет y0=(x0+x1)*/x7 (битовый аккумулятор r11)
				ORR r11,r0,r1
				BIC r11,r7
; Вывод управляющего воздействия y0
				LDR r10,=y0
				STR r11, [r10]
; Расчет y1=(x0*x1*/x2)+ x6 (битовый аккуумулятор r11)
				AND r11,r0,r1
				BIC r11,r2
				ORR r11,r6
; Вывод управляющего воздействия y1
				LDR r10,=y1
				STR r11, [r10]
				
				B Load_Bit
; Останов
Stop			B Stop	
; Конец ассемблерного текста
				END
					
; add "0x40000000, 0x4000FFFF" to memory map for correct work
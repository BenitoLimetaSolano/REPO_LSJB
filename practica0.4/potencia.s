#Programa que ejemplifica cómo trabajan las funciones
#Este programa calculará el valor de
#2³ + 5²
#
#El programa principal se almacena en registros, por lo que la
#sección de datos no tiene nada.

.section .data
.section .text
.globl _start
_start:
pushl $3	#Segundo argumento
pushl $2	#Primer argumento
call power	#Llama a la función
addl $8, %esp	#Mueve hacia atrás el puntero de la pila (stack pointer)
pushl %eax	#Guarda el primer resultado antes de llamar
		#a la siguiente función
pushl $2	#Segundo argumento (potencia)
pushl $5	#Primer argumento (base)
call power	#llama a la función
addl $8, %esp	#Retrocede el stack pointer
popl %ebx	#El segundo resultado ya están en el
		#registro %eax. Guardamos el primer resultado
		#en la pila (stack), ahora podemos sacarlo a %ebx
addl %eax, %ebx	#Los sumamos
		#El resultado final está en %ebx
movl $1, %eax	#Salimos (%ebx es devuelto)
int $0x80

#Función power
#Próposito: Esta función se utiliza para calcular
#el valor de un número elevado a una potencia.
#
#Entrada: Primer argumento - el número base
#	  Segundo argumento - la potencia a la que es elevado
#
#Salida: Dará el resultado como un valor de retorno
#
#Importante: La potencia debe ser mayor o igual que 1
#
#Variables: %ebx - contiene el número base
#	    %ecx - contiene la potencia
#
# -4(%ebp) - contiene el resultado actual
# %eax es usado para almacenamiento temporal
#
# %ecx - contiene la potencia
#
# -4(%ebp) - contiene el resultado actual
# %eax es usado para almacenamiento temporal
#
.type power, @function
power: 
pushl %ebp	#Guarda el viejo puntero base (base pointer)
movl %esp, %ebp	#Hace el stack pointer el nuevo base pointer
subl $4, %esp	#Reserva espacio para el almacenamiento local
movl 8(%ebp), %ebx	#Coloca el primer argumento en %ebx
movl 12(%ebp), %ecx	#Coloca el segundo argumento en %ecx
movl %ebx, -4(%ebp)	#Almacenca el resultado actual
power_loop_start:
cmpl $1, %ecx		#Si la potencia es 1, hemos terminado
je end_power
movl -4(%ebp), %eax	#Mueve el resultado actual a  %eax
imull %ebx, %eax	#multiplica el resultado actual por
			#el número base
movl %eax, -4(%ebp)	#Almacena el resultado actual
decl %ecx		#Decrece la potencia una unidad
jmp power_loop_start	#Ejecuta para la siguiente potencia
end_power:
movl -4(%ebp), %eax	#el valor devuelto va en %eax
movl %ebp, %esp		#Se restaura el stack pointer
popl %ebp		#Restauramos el base pointer
ret 

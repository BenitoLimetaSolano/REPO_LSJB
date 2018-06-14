# Esté programa calcula el cuadrado de un número 
#
# El programa principal se almacena en registros, por lo que la
# sección de datos no tiene nada.

.section .data
.section .text
.globl _start
_start:
pushl $2    	# Segundo argumento (potencia)
pushl $12	    # Primer argumento (base)
call power	    # llama a la función
addl $8, %esp	# Retrocede el stack pointer
popl %ebx	    # El segundo resultado ya están en el
		        # registro %eax. Guardamos el primer resultado
		        # en la pila (stack), ahora podemos sacarlo a %ebx
movl %eax, %ebx # El resultado de la función power está en %eax,
                # así que lo movemos a %ebx.
movl $1, %eax	# Salimos (%ebx es devuelto)
int $0x80

# Función power
# Esta función se utiliza para calcular
# el valor de un número elevado a una potencia.
#
# Entrada: Primer argumento - el número base
#	  Segundo argumento - la potencia a la que es elevado
#
# Salida: Dará el resultado como un valor de retorno
#
# La potencia debe ser mayor o igual que 1
#
# Variables: %ebx - contiene el número base
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
pushl %ebp	        # Guarda el viejo puntero base (base pointer)
movl %esp, %ebp	    # Hace el stack pointer el nuevo base pointer
subl $4, %esp	    # Reserva espacio para el almacenamiento local
movl 8(%ebp), %ebx	# Coloca el primer argumento en %ebx
movl 12(%ebp), %ecx	# Coloca el segundo argumento en %ecx
movl %ebx, -4(%ebp)	# Almacenca el resultado actual

power_loop_start:
cmpl $1, %ecx		# Si la potencia es 1, hemos terminado
je end_power
movl -4(%ebp), %eax	# Mueve el resultado actual a  %eax
imull %ebx, %eax	# multiplica el resultado actual por
			        # el número base
movl %eax, -4(%ebp)	# Almacena el resultado actual
decl %ecx		    # Decrementa la potencia una unidad
jmp power_loop_start# Ejecuta para la siguiente potencia

end_power:
movl -4(%ebp), %eax	# El valor devuelto va en %eax
movl %ebp, %esp		# Se restaura el stack pointer
popl %ebp		    # Restauramos el base pointer
ret 

# Programa que sale y devuelve un código
#            de estado al núcleo Linux.
#
# in: Un código de estado.
#
# out: Devuelve el código de estado. 
#
# Variables: %eax guarda el número de llamada del sistema.
#            %ebx guarda el estado de retorno.
.section .data

.section .text
.globl _start
.globl salir
_start:
salir:
pushl %ebp
movl %esp,%ebp
movl 8(%ebp),%ebx       # Lee el único argumento de esta función.
movl $1, %eax           # Éste es el número de comando del núcleo Linux
                        # para salir de un programa.
int $0x80               # Esto despierta a el núcleo para ejecutar el
                        # comando de salida.



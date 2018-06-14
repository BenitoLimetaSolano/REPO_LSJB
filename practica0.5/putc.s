.code32         # Hace uso del modo de 32 bit
.section .text  # El código debe residir en la sección .text en GCC.
.globl putc     # Declaración de putc() como una función pública.
putc:
pushl %ebp      # Recuerda %ebp.
movl %esp, %ebp # Prepara el marco de pila (stack frame).
                # Ahora %ebp apunta al %ebp guardado.
                # y 4(%ebp) apunta a la dirección de retorno.
                # Tenemos que preservar los registros 
                # a excepción de %eax, %ecx y %edx.
pushl %ebx      # Guardamos %ebx. El primer argumento aparece
                # en 8(%ebp) y el segundo en 12(%ebp).
movl 12(%ebp), %eax # Obtiene un código de carácter (segundo argumento)
movb %al, (msgbuf)  # y lo guarda.
movl $1, %edx       # Se configura el conteo de carácteres.
movl $msgbuf, %ecx  # Configuración del puntero del buffer.
movl 8(%ebp), %ebx  # Se obtiene el descriptor de archivo 
                    # y se establece STDOU. (Primer argumento)
movl $4, %eax       # Llamado a sys_write().
int $0x80
popl %ebx           # Recuperación de %ebx.
movl %ebp, %esp     # Ejecutamos %esp = %ebp
popl %ebp           # y ebp = pop()-
ret
                    # Área de almacenamiento para las variable comienza aquí.
.section .data      # Las variables deben residir en la sección .data en GCC.
msgbuf:
.byte 0             # Buffer de mensajes.


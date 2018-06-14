#            Este programa calcula el factorial de un número.
#            
# Este programa muestra como llamar a una función recursiva.

.section .data # Este programa no hace uso de datos globales.

.section .text
.globl _start
.globl factorial    # Esta declaración no es necesaria a menos
                    # que queramos compartir esta función con
                    # otros programas.
_start:
push $5             # El factorial toma un argumento -el número
                    # del que queremos el factorial-. Entonces,
                    # se agrega.
call factorial      # Ejecutamos la función factorial.
addl $5, %esp       # Limpia el parámetro que se agregaron a
                    # la fila.
movl %eax, %ebx     # La función regresa el resultado en %eax,
                    # pero lo queremos en %ebx para enviarlo como
                    # nuestro estado de salida.
movl $1, %eax       # Llamamos la función de salida del kernel.
int $0x80

# Esta es la definición real de la función
.type factorial,@function
factorial:
push %ebp           # Tenemos que restaurar %ebp a su estado anterior
                    # antes de regresa, así que debemos de agregarlo.
movl %esp, %ebp     # Esto se debe a que no queremos modificar el puntero
                    # de la pila, así que usamos %ebp.
movl 8(%ebp), %eax  # Esto mueve el primer argumento a %eax
                    # 4(%ebp) contiene la dirección de retorno, y
                    # 8(%ebp) contiene el primer parámetro.
cmpl $1, %eax       # Si el número es 1, que es nuestro caso base,
                    # simplemente regresamos (1 ya está en %eax como valor
                    # de retorno).
je end_factorial
decl %eax           # Si no, disminuimos el valor.
pushl %eax          # Lo agregamos para nuestra llamada a la funcion factorial.
call factorial      # Llamamos a factorial
movl 8(%ebp), %ebx  # %eax contiene el valor de retorno, así que recargamos
                    # nuestro parámetro en %ebx.
imull %ebx, %eax    # Multiplicamos por el resultado de la última llamada a
                    # factorial (en %eax), la respuesta es almacenada en %eax,
                    # lo cual es bueno ya que ahí es donde van los valores
                    # de retorno.
end_factorial:
movl %ebp, %esp     # Tenemos que restaurar %ebp y %esp a donde estaban antes
popl %ebp           # de que comenzara la función.
ret                 # Regreso a la función (esto también muestra 
                    # el valor de retorno). 

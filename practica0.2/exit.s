.section .data #Secciona el programa 

.section .text 
.globl _start  
_start:	       #Se indica el inicio del programa a ensamblador 
movl $1, %eax  #mueve el valor de uno a el registro eax

movl $3, %ebx  #Al cargar 0 al registro ebx sese
               #se le infdica al programa que se cierre

int $0x8     #interrupcion del flujo del programa 
               #Permite hacer los llamados al sistema 


#Al cargar otro valor al registro ebx, como por ejemplo el 1 o el 2 
#se produce una violacion de segmento, y el programa devuelve un valor de 139

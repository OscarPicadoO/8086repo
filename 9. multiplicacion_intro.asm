.MODEL SMALL
.STACK 100H
.DATA      
    numero db 5
           db 5 ;Multiplicar 5x5
           db 6
           db 7 ;Multiplicar 6x6
           
    
    caracter1 db "$"
    caracter2 db "$"
    mensaje  DB "El resultado es:$"
.CODE        
    inicio:
    mov ax,@DATA
    mov ds,ax
    
    programa:
    mov al,[numero]
    mov ah,[numero+1]
    MUL al              ;Se multiplica el contenido de AH por un operando. El resultado queda en AX SIEMPRE
    AAM                 ;Convertir de HEX a BCD. IMPORTANTE PARA TODO TIPO DE OPERACION!!
    
    mov caracter1,ah    ;Almaceno el resultado en una variable
    mov caracter2,al    ;Almaceno el resultado en una variable
       
    lea dx,mensaje
    call println()
    
    
    mov dl,caracter1    ;Rutinas para imprimir ambos caracteres por pantalla
    call getchr()
    mov dl,caracter2
    call getchr()
    
    call readkey()
    
    call clear()
    
    xor  ax,ax          ;Limpiar por completo el registro AX
    xor dx,dx 
    
    lea dx, mensaje
    call println()
    
    mov al, [numero+2]
    mov ah, [numero+3]  
    
    MUL al
    AAM
    
    mov caracter1,ah
    mov caracter2,al
    
    mov dl,caracter1
    call getchr()
    mov dl,caracter2
    call getchr()
    
    call readkey()
    
    ;*** REVISAR LAS NOTAS DE LA CASE Y EL DEBUGGER PARA REFERENCIAS ***
    ;Link: https://uhispano-my.sharepoint.com/:o:/g/personal/jeremy_zelaya_uhispano_ac_cr/EkBBSdqcY2NPol1iWTXnXosBImLRqw6bp-EDCXonp56ZOQ?e=WtdPCz
    ;Clase: 09
    
    mov al,[numero+4]
    mov ah,[numero+5]   ;Cargar ambos numeros
    
    IMUL ah             ;Multiplicacion con numeros negativos, SI toma en cuenta el signo introducido
    
    ;Queda FFFA en AX, el cual es el resultado de multiplicar -1*6
    ;En el futuro implementare una funcion para convertir de hex negativo a decimal pero por el
    ;momento solo imprimo...
    
    mov caracter1,ah
    mov caracter2,al    ;Guardado 
    
    xor ax,ax           ;Limpiar a AX
    
    mov ah,caracter2
    AAM
    
    lea dx,mensaje
    call println()
    
    mov dl,caracter1
    call getchr()
    mov dl,caracter2
    call getchr()
    
    call readkey()
       
    halt:
    mov ah,4ch
    int 21h
;**** METODOS ****
println() proc
    mov ah,09h
    int 21h
    ret
endp
readkey() proc
    mov ah,01h
    int 21h
    ret
endp
getchr() proc
    mov ah,02h
    add dl,30h
    int 21h
    ret
endp
clear() proc
    mov ah,00h
    mov al,03h
    int 10h
    ret
endp
end 

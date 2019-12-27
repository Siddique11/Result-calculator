include "emu8086.inc"

.model small
.stack 100h

.data
msg0   db 10,13, '                     Result calculator',10,13 
       db 10,13, '              Developed by Abu Bakar Siddique ',10,13
       db 10,13, '                      Sourav Podder',10,13
       db 10,13, '                      Hasib Ahasan',10,13
       db 10,13, '                      Yousuf Miah',10,13
       db 10,13, '                         Ontor ',10,13
       db '$'
 
msg1 db 10, 13, ' -----------------------------------------------------------'
     db 10, 13, '                            RESULT'   
     db 10, 13, ' -----------------------------------------------------------'
     db ' $'

msg2 db 10, 13, ' -----------------------------------------------------------', 10, 13
     db 10, 13, '               INPUT EVERY SUBJECT NUMBER' ,10,13 
     db 10, 13, '     AND SHOW YOUR EVERY SUBJECT RESULT AND TOTAL RESULT' ,10,13   
     db 10, 13, ' -----------------------------------------------------------', 10, 13
     db '$' 
     
msg3 db 10,13, '     Sub.Name      Mark    Grade Point    Grade     ',10,13 
     db ' $'
msg4 db 'enter 1 for display,',10,13,'enter 2 for print,',10,13
     db 'enter 3 for exit,',10,13,'enter 4 for re-input marks ',10,13
     db '$'
msg5 db 10,13,'invalid input!!! please input 1-4  $'

sps db '     $'
msg_end db 0 

fg db '0.00          F$'
dg db '1.00          D$'
cg db '2.00          C$'
bg db '3.00          B$'
amg db '3.50          A-$'
ag db '4.00          A$'      
apg db '5.00          A+$'    
                
           
B DB 'Bangla       $'
bn db '$' 
bn2 db '$'
E DB 'English      $' 
en db '$'
en2 db '$'
M DB 'MATH         $'
mn db '$'
mn2 db '$'
P DB 'PHYSICS      $'
pn db '$'
pn2 db '$'
C DB 'CHAMISTRY    $' 
cn db '$'
cn2 db '$'
BI DB 'BIOLOGY      $' 
bin db '$'
bin2 db '$'
HM DB 'HIGHER MATH  $' 
hmn db '$'
hmn2 db '$'


.code
main proc
    mov ax,@data
    mov ds,ax

    lea dx, msg2
call disp1 

;bangla          
lea dx, B
call disp1
call input1
mov bn,cl
mov bn2,ch
call newline 

;english
lea dx, E
call disp1
call input1
mov en,cl
mov en2,ch
call newline

;math
lea dx, M
call disp1
call input1
mov mn,cl
mov mn2,ch
call newline

;physics
lea dx, P
call disp1
call input1
mov pn,cl
mov pn2,ch
call newline

;chamistry
lea dx, c
call disp1
call input1
mov cn,cl
mov cn2,ch
call newline

;biology
lea dx, BI
call disp1
call input1
mov bin,cl
mov bin2,ch
call newline

;higher math
lea dx, HM
call disp1
call input1
mov hmn,cl
mov hmn2,ch 
call newline
 
    call clear_screen
    call want
   
    
clear_screen proc near
        mov ah,0
        mov al,3
        int 10h        
        ret
        clear_screen endp
   
   
   
    
    
  display proc
    call clear_screen
    lea dx, msg1
    call disp1 
    call newline
    call newline
    
    lea dx,msg3
    call disp1
    call newline    
    call space
    call result
    call want
    ret
    display endp
   
   
   ;compare section 1 
  want proc
   lea dx,msg4
   call disp1
   mov ah,1
   int 21h
   call camp
   
   ret   
   want endp
   
     ;invalid input
   invalid proc
     lea dx,msg5
     call disp1 
     mov ah,1
     int 21h
     call camp
    
    ret
   invalid endp
   
    ;compare user input after input marks process
  camp proc
   
   cmp al,'1'
   jl invalid
   je  display
   cmp al,'2'
   je print_d
   cmp al,'3'
   je  credit1
   cmp al,'4'
   je  main1
   jg  invalid
   
   call newline 
   call newline
   ret
   
   camp endp
    
    ;re-enter marks
   main1 proc
    call clear_screen
    call main
    ret 
    main1 endp
    
    ;print function section1
  print_d proc
    
     
    mov dl, [si]
    call space 
    mov ah, 5       ; MS-DOS print function.
    int 21h
    inc si	        ; next char.
    loop print_d
    
    mov dx, offset msg2
    mov ah, 9
    int 21h  

    ret
        
  print_d endp
  
    ;print function section2 
  print_a proc
    mov dl, 12      ; form feed code. new page.
    mov ah, 5
    int 21h
    
    mov si,offset msg3
    add si,offset bn
    add si,offset bn2
    mov cx,offset msg_end-(msg3 + a+b)
    call print_d
    
    ret 
    print_a endp 
 
  ;print developers name
 credit1 proc
    call clear_screen
    lea dx,msg0
    mov ah,9
    int 21h
    
    
    call end_progm
    ret
    
 credit1 endp
    
    
 
    ;exit program
 end_progm proc
    
    
    mov ah,4ch
    int 21h
    
    ret
    end_progm endp
    
    
    ;calculation grade, grade point    
calculation proc
    
    cmp bl,52
    jl fail
    je dgr
    jmp lvl2
    fail:
    lea dx,fg
    call disp1
    ret
    
    dgr:
    lea dx,dg
    call disp1
    ret
    lvl2:
    cmp bl,53
    je cgr
    jmp lvl3
    cgr:
    lea dx,cg
    call disp1
    ret
    lvl3:
    cmp bl,54
    je bg2
    jmp lvl4
    bg2:
    lea dx,bg
    call disp1
    ret
    lvl4:
    cmp bl,55
    je ag2
    jmp lvl5
    ag2:
    lea dx,ag
    call disp1
    ret
    
    
    lvl5:
    cmp bl,56
    lea dx,apg
    call disp1
    ret
    apg2:
    lea dx,apg
    call disp1
    
    
    ret
calculation endp 

    ;this section output the result
result:    	  
    lea dx,B
    call disp1
    call space    
    mov ah,02h
    mov dl,bn
    int 21h
    mov dl,bn2
    int 21h
    call space
    mov bl,bn
    call calculation 
    call newline
    
    call space
    lea dx,E
    call disp1
    call space    
    mov ah,02h
    mov dl,en
    int 21h
    mov dl,en2
    int 21h
    call space
    mov bl,en
    call calculation 
    call newline
    
    call space
    lea dx,M
    call disp1
    call space    
    mov ah,02h
    mov dl,mn
    int 21h
    mov dl,mn2
    int 21h
    call space
    mov bl,mn
    call calculation
    call newline 
    
    call space
    lea dx,P
    call disp1
    call space    
    mov ah,02h
    mov dl,pn
    int 21h
    mov dl,pn2
    int 21h
    call space
    mov bl,pn
    call calculation 
    call newline
    
    call space
    lea dx,C
    call disp1
    call space    
    mov ah,02h
    mov dl,cn
    int 21h
    mov dl,cn2
    int 21h
    call space
    mov bl,cn
    call calculation 
    call newline
    
    call space
    lea dx,BI
    call disp1
    call space    
    mov ah,02h
    mov dl,bin
    int 21h
    mov dl,bin2
    int 21h
    call space
    mov bl,bin
    call calculation 
    call newline
    
    call space
    lea dx,HM
    call disp1
    call space    
    mov ah,02h
    mov dl,hmn
    int 21h
    mov dl,hmn2
    int 21h
    call space 
    mov bl,hmn
    call calculation 
    call newline
    
    call newline
    call newline
    call want
    
  
 
input1 proc
    mov ah,01
    int 21h
    mov cl,al
    mov ah,01
    int 21h 
    mov ch,al
    ret
    input1 endp



newline proc
    mov ah,02h
    mov dl,0dh
    int 21h
    mov dl,0ah
    int 21h
    ret
    newline endp


disp1 proc                ; module for display of
	  mov ah, 09h             ; a string on screen
	  int 21h
	  ret
disp1 endp 

space proc
    lea dx,sps
    call disp1
space endp


ret   

  
end main
    



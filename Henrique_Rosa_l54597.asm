.globl main
.data
PRINT1:       .string "Qual o nome do ficheiro(não se esqueça do .rgb!)?"
PRINT2:       .string "Qual o nome do personagem?"
PRINT3:       .string "Qual o nome que quer dar ao ficheiro(não se esqueça do .rgb!)?"
FILENAME:     .space 30
PERSONAGEM:   .space 30
FILE:         .space 30
YODA1:        .string "Yoda"
YODA2:        .string "yoda"
MANDALORIAN1: .string "Mandalorian"
MANDALORIAN2: .string "mandalorian"
DARTH1:       .string "DarthMaul"
DARTH2:       .string "darthmaul"
ERROR:	      .string "ERRO"
FOTO:	      .space  172800
IMAGE:        .space  57600
.word
.text
CONVERT:
	addi sp, sp, -8
	sw a0, 4(sp)
	sw a1, 0(sp) 
	li t1, 172800
	li t6, 60
	FOR:
		li a6, 120
		lbu t2, 0(a0)#R
		lbu t3, 1(a0)#G
		lbu t4, 2(a0)#B
		bgt t2, t3, LVR #R>G
		beq t2, t3, VVa #R=G
		blt t2, t3, VsA #R<G
	       LVR:
	        bgt t3, t4,LARANJA 
	        beq t3, t4,LARANJA  
	        blt t3, t4,VR      
	       VVa:
	        bgt t3, t4,V_AMAR  
	        blt t3, t4,VIOLETA 
	       VsA:
	        bgt t3, t4,Vs   
	        beq t3, t4,AZUL 
	        blt t3, t4,AZUL 
	       VR:
	        bgt t2, t4,ROSA 
	        beq t2, t4,ROSA 
	        blt t2, t4, VIOLETA
	       Vs:
	        bgt t2, t4,V_AMAR
	        beq t2, t4,V_PRIMA 
	        blt t2, t4,V_PRIMA 
		
	      V_AMAR:
	        sub t5, t2, t4
	        sub t0, t3, t4
	        mul t5, t5, t6
	        div t0, t5, t0
	        sub t0, a6, t0 
	        j END  
	      
	      ROSA:
	        sub t5, t4, t3
	        sub t0, t2, t3
	        mul t5, t5, t6
	        div t0, t5, t0
	        addi a6, a6, 240
	        sub t0, a6, t0 
	        j END  
	        	
	      V_PRIMA:
	        sub t5, t4, t2
	        sub t0, t3, t2
	        mul t5, t5, t6
	        div t0, t5, t0
	        add t0, a6, t0 
	        j END  
	        
	      VIOLETA:
	        sub t5, t2, t3
	        sub t0, t4, t3
	        mul t5, t5, t6
	        div t0, t5, t0
	        addi a6, a6, 120
	        add t0, a6, t0 
	        j END  
	      
	      LARANJA:
	        sub t5, t3, t4
	        sub t0, t2, t4
	        mul t5, t5, t6
	        div t0, t5, t0
	        j END  
	            
	      AZUL:
	        sub t5, t3, t2
	        sub t0, t4, t2
	        mul t5, t5, t6
	        div t0, t5, t0
	        addi a6, a6, 120
	        sub t0, a6, t0 
	        j END   
	         
	      END:
	        sb t0, 0(a1)
	        addi a1, a1, 1
	        addi a0, a0, 3
	        addi t1, t1, -3 
	        bnez t1, FOR
	        lw a0, 4(sp)
		lw a1, 0(sp)
		addi sp, sp, 8
	        ret

READ:
	addi sp, sp, -8
	sw a1, 4(sp)
	sw a0, 0(sp)
	
	li a1, 0
	li a7, 1024
	ecall # fopen
	blt a0, zero, ERRO
	
	lw a1, 4(sp)
	li a2, 172800
	li a7, 63
	ecall #fread
	blt a0, zero, ERRO
	
	
	lw a0, 0(sp)
	li a7, 57
	ecall #fclose
	addi sp, sp, 8
	ret
       
       ERRO:
        la a0, ERROR
        li a7, 4
        ecall
        li a7, 10
        ecall
        
REMOVE:
	li t2, 10
	lb t1, 0(a0)
	beq t1, zero, end0
	bne t1, t2, else
	mv t1, zero
	sb t1, 0(a0)
  else: 
	addi a0, a0, 1
	j REMOVE
 end0:
	ret

        
INDICATOR:
	li t3, 57600
	la t0, YODA1
	lbu t1, 0(t0)
	lbu t2, 0(a0)
	beq t2, t1, YODA
	la t0, YODA2
	lbu t1, 0(t0)
	beq t2, t1, YODA
	la t0, MANDALORIAN1
	lbu t1, 0(t0)
	beq t2, t1, MAND
	la t0, MANDALORIAN2
	lbu t1, 0(t0)
	beq t2, t1, MAND
	la t0, DARTH1
	lbu t1, 0(t0)
	beq t2, t1, DARTH
	la t0, DARTH2
	lbu t1, 0(t0)
	beq t2, t1, DARTH
	beqz zero ERR
    
    YODA:
    	beqz t1, CYODA
    	addi t0, t0, 1
    	addi a0, a0, 1
        lbu t1, 0(t0)
	lbu t2, 0(a0)
	beq t2, t1, YODA
	beqz zero, ERR
	
   MAND:
	beqz t1, CMAND
    	addi t0, t0, 1
    	addi a0, a0, 1
        lbu t1, 0(t0)
	lbu t2, 0(a0)
	beq t2, t1, MAND
	beqz zero, ERR
	
   DARTH:
       beqz t1, CDARTH
    	addi t0, t0, 1
    	addi a0, a0, 1
        lbu t1, 0(t0)
	lbu t2, 0(a0)
	beq t2, t1, DARTH
	beqz zero, ERR
	
	CYODA:
	    	li t1, 40
	    	li t2, 80
	    FORYO:
	    	lbu t0, 0(a1)
	    	blt t0, t1, NPY
	    	bgt t0, t2, NPY
	    	li t0, 1
	    	sb t0, 0(a1)
	    	addi a1, a1, 1
	    	addi t3, t3, -1
	    	bnez t3, FORYO
	    	ret
	    NPY:
	    	sb zero, 0(a1)
	    	addi a1, a1, 1
	    	addi t3, t3, -1
	    	bnez t3, FORYO
	    	ret 
	    	
	CMAND:
	    	li t1, 160
	    	li t2, 180
	    FORC:
	    	lbu t0, 0(a1)
	    	blt t0, t1, NPM
	    	bgt t0, t2, NPM
	    	li t0, 1
	    	sb t0, 0(a1)
	    	addi a1, a1, 1
	    	addi t3, t3, -1
	    	bnez t3, FORC
	    	ret
	    NPM:
	    	sb zero, 0(a1)
	    	addi a1, a1, 1
	    	addi t3, t3, -1
	    	bnez t3, FORC
	    	ret 
	    	
	CDARTH:
	    	li t1, 1
	    	li t2, 15
	    FORD:
	    	lbu t0, 0(a1)
	    	blt t0, t1, NPD
	    	bgt t0, t2, NPD
	    	li t0, 1
	    	sb t0, 0(a1)
	    	addi a1, a1, 1
	    	addi t3, t3, -1
	    	bnez t3, FORD
	    	ret
	    NPD:
	    	sb zero, 0(a1)
	    	addi a1, a1, 1
	    	addi t3, t3, -1
	    	bnez t3, FORD
	    	ret 
    	
	ERR:
	   	la a0, ERROR
	        li a7, 4
	        ecall
	        li a7, 10
	        ecall

CENTRO:        
	li t0, 0 #X
	li t1, 0 #Y
	li t2, 0 #N
	li t3, 1
	li t4, 1
	li a5, 180
	li a4, 320
	addi sp, sp, -4
        sw a0, 0(sp)
	
       FORY:
        li t5, 1
        FORX:
	 lb t6, 0(a1)
	 beqz t6, end
	 add t0, t0, t5
	 add t1, t1, t3
	 addi t2, t2, 1
	 
    end: 
	 addi a1, a1, 1
	 addi t5, t5, 1
	 bge a4, t5, FORX
	 addi t3, t3, 1
	 bge a5, t3, FORY #fim do ciclo
         div t0, t0, t2 #PMx
         div t1, t1, t2 #PMy
         li t2, 3
         li t3, 960
         mul t0, t0, t2
         mul t1, t1, t3
         add t0, t0, t1 #PM
         addi t1, t0, -15
         addi t2, t0, 15
         li t3, 255
         add a0, a0, t1
         
         
         FORR:
           sb t3, 0(a0)
           sb zero, 1(a0)
           sb zero, 2(a0)
           addi t1, t1, 3
           addi a0, a0, 3
           bge t2, t1, FORR
           li t1, -4800
           add t1, t0, t1
           li t2, 4800
           add t2, t0, t2
           lw a0, 0(sp)
           addi sp, sp, 4
           add a0, t1, a0
            
         FORG:
          sb zero, 0(a0)
           sb t3, 1(a0)
           sb zero, 2(a0)
           addi t1, t1, 960
           addi a0, a0, 960
           bge t2, t1, FORG
           ret
       
WRITE: 
	addi sp, sp, -4
	sw a1, 0(sp)
	li a1, 1
	li a7, 1024
	ecall #fopen
	
	lw a1, 0(sp)
	sw a0, 0(sp)
	li a2, 172800
	li a7, 64
	ecall # WRITE
	
	lw a0, 0(sp)
	li a7, 57
	ecall # CLOSE
	addi sp, sp, 4
	ret

main:
	la a0, PRINT1
	la a1, FILENAME
	li a2, 29
	li a7, 54
	ecall #puts e scanf do nome do fichiero
	la a0, FILENAME
	jal REMOVE
	
	la a0, FILENAME
	la a1, FOTO
	jal READ
	
	la a0, FOTO
	la a1, IMAGE
	jal CONVERT
	
	la a0, PRINT2
	la a1, PERSONAGEM
	li a2, 29
	li a7, 54
	ecall #puts e scanf do nome do personagem
	la a0, PERSONAGEM
	jal REMOVE
	
	la a0, PERSONAGEM
	la a1, IMAGE 
	jal INDICATOR
	
	la a0, FOTO
	la a1, IMAGE
	jal CENTRO
	
	la a0, PRINT3
	la a1, FILE
	li a2, 29
	li a7, 54
	ecall #puts e scanf do nome do ficheiro
	la a0, FILE
	jal REMOVE
	
	la a0, FILE
	la a1, FOTO
	jal WRITE

#TRABALHO REALIZADO POR: HENRIQUE ROSA NUMERO L54597
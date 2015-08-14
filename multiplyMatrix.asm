	SECTION .data

l:	DB	0
addr1:	DW	0
addr2:	DW	0

	SECTION .text

	global	multiply_asm

%macro multiply	2
	push	eax
	push	ecx

	pop	ecx
	pop	eax
%endmacro

multiply_asm:

	push	ebp
	mov	ebp, esp

	mov	eax, 0

	push	eax ;posicao 24
	push	eax ;posicao 28
	push	eax ;posicao 32

	mov	eax, [ebp + 8] ;matriz 1
	mov	[addr1], eax

	mov	ebx, [ebp + 12] ;matriz 2
	mov	[addr2], ebx

	mov	edx, [ebp + 16] ;matriz resultante

	mov	ecx, [ebp + 20] ;tamanho das matrizes
	mov	[l], cl

	;contadores
	mov	ecx, 0
	mov	esi, 0


loop_comp1:
	mov	eax, [ebp + 24]
	cmp	eax, [l]
	je	end

loop1:
	loop_comp2:
		mov	eax, [ebp + 28]
		cmp	eax, [l]
		je	end2

	loop2:
		;acumulador
		mov	ebx, 0

		loop_comp3:
			mov	eax, [ebp + 32]
			cmp	eax, [l]
			je	end3

		loop3:
			push	edx
			push	ebx

			mov	ebx

			multiply	cl, [l]
			add	ebx, esi
			mov	edx, [addr1]
			mov	al, [edx + ebx]

			multiply	esi, [l]
			add	ebx, ch
			mov	edx, [addr2]
			mov	ah, [edx + ebx]

			pop	ebx
			pop	edx

			mul	ah
			add	edx, eax

			inc	esi
			jmp	loop_comp3

		end3:


	end2:
end:
	ret

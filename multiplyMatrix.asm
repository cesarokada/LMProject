	SECTION .data

l:	DB	0
addr1:	DW	0
addr2:	DW	0

	SECTION .text

	global	multiply_asm

%macro multiply	2
	push	eax
	push	ecx

	mov	eax, %1
	mov	ecx, %2
	mul	cl

	mov	ebx, eax

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

			mov	ebx, [ebp + 24]
			mov	edx, [l]

			multiply	ebx, edx
			add	ebx, [ebp + 32]
			mov	edx, [addr1]
			mov	al, [edx + ebx]

			mov	ebx, [ebp + 32]
			mov	edx, [l]

			multiply	ebx, edx
			add	ebx, [ebp + 28]
			mov	edx, [addr2]
			mov	ah, [edx + ebx]

			pop	ebx
			pop	edx

			mul	ah
			add	ebx, eax

			push	eax
			mov	eax, [ebp + 32]
			inc	eax
			mov	[ebp + 32], eax
			pop	eax
			
			jmp	loop_comp3

		end3:
			
		push	eax
		push	ecx

		mov	eax, [ebp + 24]
		mov	ecx, [l]
		push	ebx
		multiply	eax, ecx
		mov	eax, ebx
		pop	ebx

		add	eax, [ebp + 28]

		add	eax, edx

		mov	[eax], ebx

		pop	ecx
		pop	eax

		mov	ebx, 0

		jmp	loop_comp2

	end2:

	jmp	loop_comp1
end:
	mov	eax, edx
	mov	esp, ebp
	pop	ebp
	ret

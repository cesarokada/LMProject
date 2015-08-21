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

	push	eax ;posicao -4
	push	eax ;posicao -8
	push	eax ;posicao -12

	;mov	eax, [ebp + 8] ;matriz 1
	;mov	[addr1], eax

	;mov	ebx, [ebp + 12] ;matriz 2
	;mov	[addr2], ebx

	mov	edx, [ebp + 16] ;matriz resultante

	mov	ecx, [ebp + 20] ;tamanho das matrizes
	mov	[l], cl

	;contadores
	mov	ecx, 0
	mov	esi, 0

loop_comp1:
	mov	eax, [ebp - 4]
	cmp	al, [l]
	je	end

loop1:
	loop_comp2:
		mov	eax, [ebp - 8]
		cmp	al, [l]
		je	end2

	loop2:
		;acumulador
		mov	ebx, 0

		loop_comp3:
			mov	eax, [ebp - 12]
			cmp	al, [l]
			je	end3

		loop3:
			push	edx
			push	ebx

			mov	ebx, [ebp + 8]
			add	ebx, [ebp - 4]

			mov	ebx, [ebx]
			add	ebx, [ebp - 12]

			mov	ebx, [ebx]

			mov	edx, [ebp + 12]
			add	edx, [ebp - 12]

			mov	edx, [edx]
			add	edx, [ebp - 8]

			mov	edx, [edx]

			multiply	ebx, edx
			mov	eax, ebx

			pop	ebx
			pop	edx

			add	ebx, eax

			push    eax
			mov     eax, [ebp - 12]
			inc     eax
			mov     [ebp - 12], eax
			pop     eax

			jmp	end
			jmp	loop_comp3

		end3:
		
		push	eax
		mov	eax, 0
		mov	[ebp - 12], eax
		pop	eax

		push	eax
		push	ecx

		mov	eax, [ebp + 16]
		add	eax, [ebp - 4]
		
		mov	eax, [eax]
		add	eax, [ebp - 8]

		mov	[eax], ebx

		pop	ecx
		pop	eax

		mov	ebx, 0

		push    eax
		mov     eax, [ebp - 8]
		inc     eax
		mov     [ebp - 8], eax
		pop     eax

		jmp	loop_comp2

	end2:

	push	eax
	mov	eax, 0
	mov	[ebp - 8], eax
	pop	eax

	push    eax
	mov     eax, [ebp - 4]
	inc     eax
	mov     [ebp - 4], eax
	pop     eax

	jmp	loop_comp1
end:
	mov	eax, [ebp - 12]
	mov	esp, ebp
	pop	ebp
	ret

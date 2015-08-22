	SECTION .data

l:	DB	0

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

	mov	edx, [ebp + 20] ;matriz resultante

	mov	ecx, [ebp + 28] ;tamanho das matrizes

	add	cl, cl
	add	cl, cl
	mov	[l], cl

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
			add     eax, 4
			mov     [ebp - 12], eax
			pop     eax

			jmp	loop_comp3

		end3:
		
		push	eax
		mov	eax, 0
		mov	[ebp - 12], eax
		pop	eax

		push	eax
		push	ecx

		mov	eax, [ebp + 20]
		add	eax, [ebp - 4]
		
		mov	eax, [eax]
		add	eax, [ebp - 8]

		mov	ecx, [ebp + 16]
		add	ecx, [ebp - 4]

		mov	ecx, [ecx]
		add	ecx, [ebp - 8]

		mov	ecx, [ecx]
		add	ecx, ebx

		mov	[eax], ecx

		push	eax
		push	ebx

		mov	eax, [ebp - 4]
		mov	ebx, [ebp - 8]

		cmp	eax, ebx
		jne	not_d

		mov	eax, [ebp + 24]
		mov	ebx, [eax]
		add	ebx, ecx
		mov	[eax], ebx

not_d:		pop	ebx
		pop	eax

		pop	ecx
		pop	eax

		mov	ebx, 0

		push    eax
		mov     eax, [ebp - 8]
		add     eax, 4
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
	add     eax, 4
	mov     [ebp - 4], eax
	pop     eax

	jmp	loop_comp1
end:
	mov	eax, edx
	mov	esp, ebp
	pop	ebp
	ret

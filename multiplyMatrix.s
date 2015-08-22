        .data

l:      .byte 0

        .text

        .global multiply_gas

.macro multiply num1, num2
        push   %eax
        push   %ecx

        mov    \num1, %eax
        mov    \num2, %ecx
        mul    %cl

        mov    %eax,%ebx

        pop    %ecx
        pop    %eax
.endm

multiply_gas: 

        push   %ebp
        mov    %esp,%ebp

        mov    $0,%eax

        push   %eax #posicao -4
        push   %eax #posicao -8
        push   %eax #posicao -12

        mov    20(%ebp),%edx   #matriz resultante

        mov    28(%ebp),%ecx   #tamanho das matrizes

        add    %cl,%cl
        add    %cl,%cl
        mov    %cl,l

loop_comp1: 
        mov    -4(%ebp),%eax
        cmp    l,%al
        je      end

loop1: 
        loop_comp2: 
                mov    -8(%ebp),%eax
                cmp    l,%al
                je      end2

        loop2: 
                #acumulador
                mov    $0,%ebx

                loop_comp3: 
                        mov    -12(%ebp),%eax
                        cmp    l,%al
                        je      end3

                loop3: 
                        push   %edx
                        push   %ebx

                        mov    8(%ebp),%ebx
                        add    -4(%ebp),%ebx

                        mov    (%ebx),%ebx
                        add    -12(%ebp),%ebx

                        mov    (%ebx),%ebx

                        mov    12(%ebp),%edx
                        add    -12(%ebp),%edx

                        mov    (%edx),%edx
                        add    -8(%ebp),%edx

                        mov    (%edx),%edx

		        multiply        %ebx, %edx
                        mov    %ebx,%eax

                        pop    %ebx
                        pop    %edx

                        add    %eax,%ebx

                        push   %eax
                        mov    -12(%ebp),%eax
                        add    $4,%eax
                        mov    %eax,-12(%ebp)
                        pop    %eax

                        jmp     loop_comp3

                end3: 

                push   %eax
                mov    $0,%eax
                mov    %eax,-12(%ebp)
                pop    %eax

                push   %eax
                push   %ecx

                mov    20(%ebp),%eax
                add    -4(%ebp),%eax

                mov    (%eax),%eax
                add    -8(%ebp),%eax

                mov    16(%ebp),%ecx
                add    -4(%ebp),%ecx

                mov    (%ecx),%ecx
                add    -8(%ebp),%ecx

                mov    (%ecx),%ecx
                add    %ebx,%ecx

                mov    %ecx,(%eax)

                push   %eax
                push   %ebx

                mov    -4(%ebp),%eax
                mov    -8(%ebp),%ebx

                cmp    %ebx,%eax
                jne     not_d

                mov    24(%ebp),%eax
                mov    (%eax),%ebx
                add    %ecx,%ebx
                mov    %ebx,(%eax)

not_d:          pop    %ebx
                pop    %eax

                pop    %ecx
                pop    %eax

                mov    $0,%ebx

                push   %eax
                mov    -8(%ebp),%eax
                add    $4,%eax
                mov    %eax,-8(%ebp)
                pop    %eax

                jmp     loop_comp2

        end2: 

        push   %eax
        mov    $0,%eax
        mov    %eax,-8(%ebp)
        pop    %eax

        push   %eax
        mov    -4(%ebp),%eax
        add    $4,%eax
        mov    %eax,-4(%ebp)
        pop    %eax

        jmp     loop_comp1
end: 
        mov    %edx,%eax
        mov    %ebp,%esp
        pop    %ebp
        ret


.intel_syntax noprefix
.text
.globl main

main:
	push ebp
	mov ebp, esp 		/*esp wskazuje na wierzcholek stosu, przekazujemy esp do ebp żeby ebp (rejestr adresowania) wskazywał na stos*/
	mov ebx, [ebp+12]
	mov eax, [ebx+4]
	mov esi, [ebx+8]
	mov edx, 0
	mov ecx, [esi]
check:					/*check sprawdza czy nie doszliśmy do końca pierwszego argumetu*/
	cmp byte ptr [eax], 0
	jz exit
first:					/*first ustawia ecx na pierwszą literę z drugiego argumentu, porównuje ją z pierwszą literą pierwszego argumentu*/
	mov esi, [ebx+8]
	mov ecx, [esi]	
	cmp byte ptr [eax], cl
	jz second
	inc eax
	jmp check
second:					/*second pobiera kolejną literę z pierwszego i drugiego argumentu, po czym porównuje je*/
	inc eax
	inc esi
	mov ecx, [esi]	
	cmp byte ptr [eax], cl
	jz increase
	jmp check
increase:				/*jump2 zlicza wystąpienia*/
	inc edx
	jmp check 		
				
exit:					/*exit pushuje wiadomość oraz ilość wystąpień*/
	push edx
	push offset msg
	call printf
	add esp, 8	
	pop ebp
	mov eax, 0
	ret

.data
msg:   .asciz "Ilosc: %d \n"

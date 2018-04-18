.intel_syntax noprefix
	.text
	.globl _start

_start:
	mov edx,[esp+8]
	cmp edx,0
	jz koniec

	mov edx,[esp+12]
	cmp edx,0
	jz koniec
	//esp+8 to 1 arg, esp+12 to 2 . na przyklad ./zad4 ad adye
	xor edx, edx
	mov eax, 4
	mov ebx, 1
	mov ecx, offset msx
	mov edx, 2
	int 0x80
	//eax zawsze 4, ebx - 1, ecx to wiadomosc, edx to dlugosc, int zawsze 0x80
	
	xor edx,edx
	mov ecx, [esp+8]
	petla:
	inc edx
	cmp byte ptr [ecx+edx-1], 0
	jnz petla
	//dlugosc arg
	mov eax, 4
	mov ebx, 1
	int 0x80
	
	mov eax, 4
	mov ebx, 1
	mov ecx, offset msy
	mov edx, 3
	int 0x80
	
	mov ecx, [esp+12]
	xor edx,edx
	loop:
	inc edx
	cmp byte ptr [ecx+edx-1], 0
	jnz loop
	mov esi,edx
	
	mov eax, 4
	mov ebx, 1
	int 0x80
	
	mov eax, 4
	mov ebx, 1
	mov ecx, offset msg
	mov edx, 1
	int 0x80

	//teraz to gorsze *,...,*
	xor edx,edx
	xor ecx,ecx
	mov ecx,[esp+8]
	mov ah,byte ptr[ecx+0]
	mov al,byte ptr[ecx+1]
	xor ecx,ecx
	mov ebx,[esp+12]
	
	gorsze:
	cmp ah, byte ptr[ebx+edx]
	jz dalej
	inc edx
	konty:
	cmp edx,esi
	jz koniec
	jmp gorsze
	
	dalej:
	inc edx
	cmp edx,esi
	jz koniec
	cmp al, byte ptr[ebx+edx]
	jz jest
	cmp al,0
	jz jj
	jmp konty
	
	jest:
	inc ecx
	inc edx
	jmp konty
	
	jj:
	dec edx
	jmp jest
	
	//wypisanie liczby 2 cyfrowej:
	kkk:
	sub ecx,10
	inc ebx
	cmp ecx,9
	ja kkk
	mov esi,ecx
	mov edx,48
	add edx, ebx
	push edx
	mov eax, 4      
	mov ebx, 1      
	mov ecx, esp
	mov edx, 1      
	int 0x80
	pop edx 
	mov ecx,esi
	
	koniec:
	//wynik
	mov edx,48
	xor ebx,ebx
	
	cmp ecx,9
	ja kkk
	
	add edx, ecx
	push edx
	mov eax, 4      
	mov ebx, 1      
	mov ecx, esp
	mov edx, 1      
	int 0x80
	pop edx 
	// \n
	mov eax, 4
	mov ebx, 1
	mov ecx, offset msg
	mov edx, 2
	int 0x80
	//koniec, wylacza program
	mov eax, 1
	mov ebx, 0
	int 0x80
	
	

	.data
msg:	.ascii "\n"
msx:	.ascii "x="
msy:	.ascii "\ny="

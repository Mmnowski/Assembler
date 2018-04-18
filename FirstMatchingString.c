#include <stdio.h>
int main () 
{
	int x, y;
	char *s = "p";
	asm volatile 
	(
	".intel_syntax noprefix;"
	"mov eax,%2;" //eax - rejestr z ciągiem
	"xor ebx,ebx;" //ebx - pozycja pierwszego poprawnego ciągu
	"xor ecx,ecx;" //ecx - ilość znaków w łańcuchu
	"xor edx,edx;"
	
	"start:"  // pętla
	"mov edx,byte ptr[eax + ebx];"
    "cmp edx,0x00;"
    "je clear;"
    "inc ebx;"
    "cmp ecx,0;"
    "je a3;"
    "cmp ecx,1;"
    "je a0;"
	"jmp nexta;"
    
    "a3:"
    "cmp edx, 'p';"
    "je nxt;"
    "cmp edx, 'q';"
    "je nxt;"
    "jmp start;"
	
	"a0:"
	"cmp edx, 'a';"
	"je a2;"
    "jmp nxt;"
	
	"nexta:"
    "cmp edx, 'a';"
    "jne nxt;"
    "jmp end;"

    "a2:"
	"xor ecx,ecx;"
    "jmp start;"
    
	"nxt:"
	"inc ecx;"
	"jmp start;"
	
	"clear:"
	"xor ecx,ecx;"
	"jmp wyjscie;"
	
	"end:"
	"inc ecx;"
	"sub ebx,ecx;"
	"inc ebx;"
	    
	"wyjscie:"
	"mov %0,ebx;"
    "mov %1,ecx;"
	
	".att_syntax prefix;"
	:"=r" (x), "=r" (y)
	:"r" (s)
	:"eax","ebx","ecx","edx"
	);
	printf("Pozycja:%hd\nDlugosc:%hd\n",x,y);
return 0;
}

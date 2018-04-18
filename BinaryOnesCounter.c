#include <stdio.h>
int main () 
{
	int x=0xF0FF0F, x2;
	asm volatile 
	(
	".intel_syntax noprefix;"
	"mov eax,%1;" //podana liczba
	"xor ebx,ebx;" //ebx to max
	"xor ecx,ecx;"
	"xor edx,edx;" //licznik 1 pod rzad
	
	"petla:"
	"shl eax;"
	"jnc a0;" //jesli nie ma przenisienia to skacze do a0 i zeruje licznik
	"inc edx;"
	"cmp edx,ebx;" //porownanie z max
	"ja a2;" //skok jesli wieksze
	"jmp a1;"
	
	"a0:"
	"xor edx,edx;"
	"jmp a1;"
	
	"a2:"
	"inc ebx;"
	
	"a1:"
	"cmp ecx,31;" // odejmowanie bez odejmowania (sub to zwykle odejmowanie)
	"jz koniec;" //sprawdzanie czy wynik poprzedniej operacji to 0
	"inc ecx;"
	"jmp petla;" // bezwarunkowy skok do etykiety
	
	"koniec:"
	"mov %0,ebx;"
	
	".att_syntax prefix;"
	:"=r" (x2)
	:"r" (x)
	:"eax","ebx","ecx","edx"
	);
	printf("Sprawdzana liczba = %d\nMaksymalna ilosc jedynek obok siebie w zapisie binarnym = %d\n",x,x2);
return 0;
}

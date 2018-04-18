#include <stdio.h>
int main () 
{
	char *s = "aqr  b qabxx xryc pqr";
	int x, y;
	asm volatile 
	(
	".intel_syntax noprefix;"
	"mov ebx,;" 
	
	"petla:"
    "shl ebx;"
    "cmp ebx, 'p';"
    "jne a0;"
	"jmp a1;"
	
	"a0:"
	"cmp ebx, 'q';"
	"jne reset;"
	"jmp dalej;"
	
	"dalej:"
	"cmp ebx 
	

    "cmp al,'p'"
    "je HitQ"

    "inc ebx"   // point to next byte
    "jmp loop"
	
	".att_syntax prefix;"
	:"=r" (x), "=r" (y)
	:"r" (s)
	:"eax","ebx","ecx"
	);
	printf("%hd,%hd\n",x,y);
return 0;
}

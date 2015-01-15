SECTION .data
radians	dd	1.0,2.0,3.0,4.0,5.0
format	db	'%d',10,0 
SECTION .bss
surfaces	resd	5	;we use double, since it's min size of data that we'll use
volumes		resd	5

SECTION .text
global main
main:
push ebp
mov ebp,esp
push ebx
push esi
push edi

mov ecx,5
mov esi,0
iterate:
  fld	dword[radians+esi]	;put on tos first radian
  fmul	st0,st0		;mul value on tos (rad*rad); result is in ST0
  fldpi			;put PI on tos
  fmul				;on tos is now PI*2*r
  fstp	dword[surfaces+esi]
  fld 	dword[radians+esi]		;put r again on tos
  fldpi
  fmul					;PI*r is on tos
  fstp	dword[volumes+esi]
  add 	esi,4				;because we use dword! 
  loop 	iterate
 
pop edi
pop esi
pop ebx
mov esp,ebp
pop ebp

mov eax,1
mov ebx,0
int 80h
#include "SymServer.h"
// #include "MyStaticLib.h"
#include <stdio.h>
#include<windows.h>

void Foo(int a, int b) {
	int c = a + b;
}

//*****************************************************************
void main()
{
	Foo(5,6);
	exit(0);
}
//*****************************************************************

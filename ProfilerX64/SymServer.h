#ifndef __SYMSERVERDLL__
#define __SYMSERVERDLL__


#ifdef SYMBOLSERVER_EXPORTS
	#define MYEXPORT __declspec( dllexport )
#else
	#define MYEXPORT __declspec( dllimport )
#endif


// ���뺯��
void MYEXPORT FunEnter( void* pa );
// ��������
void MYEXPORT FunExit( void* pa);


#endif

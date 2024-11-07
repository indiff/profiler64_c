#ifndef __SYMSERVERDLL__
#define __SYMSERVERDLL__


#ifdef SYMBOLSERVER_EXPORTS
	#define MYEXPORT __declspec( dllexport )
#else
	#define MYEXPORT __declspec( dllimport )
#endif


// 进入函数
void MYEXPORT FunEnter( void* pa );
// 结束函数
void MYEXPORT FunExit( void* pa);


#endif

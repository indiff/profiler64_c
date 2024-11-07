#include <Windows.h>
#include <stdio.h>
#include "SymServer.h"


//*********************************************************************************************
//Dll entry point function
BOOL APIENTRY DllMain( HMODULE hModule,
                       DWORD  ul_reason_for_call,
                       LPVOID lpReserved
					 )
{
	

	switch (ul_reason_for_call)
	{
	case DLL_PROCESS_ATTACH:
		{
			//Intitalize the critical section
			//Loads the symbols of the module
			printf("DllMain attach\n");
			break;
		}
	case DLL_THREAD_ATTACH:
	case DLL_THREAD_DETACH:
		{
			break;
		}
	case DLL_PROCESS_DETACH:
		{
			//At the end, when the dll is detached from the process
			//dump all the profiled data

			//Clean-up the symbols
			printf("DllMain detach\n");
			break;
		}
		break;
	}
	return TRUE;
}

//*********************************************************************************************
void FunEnter( void* pCallee )
{
		printf("开始执行函数 %p \n", pCallee);
}
//*******************************************************************************
void FunExit( void* pCallee )
{
		printf("结束执行函数 %p \n", pCallee);
}

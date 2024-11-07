@echo off
set cur_path=%CD%
rem call "C:\Program Files (x86)\Microsoft Visual Studio 10.0\VC\vcvarsall.bat" x86
rem call "C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\VC\Auxiliary\Build\vcvarsall.bat" x86
call "C:\Program Files\Microsoft Visual Studio\2022\Community\Common7\Tools\VsDevCmd.bat" -arch=x64

rmdir /s /q E:\svn\profiler64_c\x64\Release\
mkdir E:\svn\profiler64_c\x64\Release\

echo ml Assem.asm
ml64.exe /c /nologo /Zi /Fo"x64\Release\Assem.obj" /W3 /errorReport:prompt /TaProfilerX64\Assem.asm

rem remove /RTC1
rem 可选 /EHsc 
echo cl main.c
CL.exe /c /Zi /JMC /nologo /W3 /WX- /diagnostics:column /sdl /O2 /Oi /GL /D WIN32 /D NDEBUG /D _CONSOLE /D _UNICODE /D UNICODE /Gm- /MDd /GS /fp:precise /Zc:wchar_t /Zc:forScope /Zc:inline /Fo"x64\Release\\" /Fd"x64\Release\vc143.pdb" /external:W3 /Gd /TC /FC /errorReport:queue /GH /Gh ProfilerX64\main.c

rem remove /RTC1
echo cl SymServer.c
CL.exe /c /Zi /JMC /nologo /W3 /WX- /diagnostics:column /O2 /Oi /GL /D WIN32 /D NDEBUG /D _WINDOWS /D _USRDLL /D SYMBOLSERVER_EXPORTS /D _WINDLL /D _UNICODE /D UNICODE /Gm- /EHsc /MDd /GS /fp:precise /Zc:wchar_t /Zc:forScope /Zc:inline /Fo"x64\Release\\" /Fd"x64\Release\vc143.pdb" /external:W3 /Gd /TC /FC /errorReport:queue SymbolServer\SymServer.c

rem /DEBUG
echo link SymbolServer.dll
link.exe /ERRORREPORT:QUEUE /OUT:"E:\svn\profiler64_c\x64\Release\SymbolServer.dll" /INCREMENTAL:NO /NOLOGO Dbghelp.lib imagehlp.lib kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /MANIFEST /MANIFESTUAC:"level='asInvoker' uiAccess='false'" /manifest:embed  /SUBSYSTEM:WINDOWS /TLBID:1 /DYNAMICBASE /NXCOMPAT /IMPLIB:"E:\svn\profiler64_c\x64\Release\SymbolServer.lib" /MACHINE:X64 /DLL x64\Release\SymServer.obj

rem /DEBUG
echo link main.c
link.exe /ERRORREPORT:QUEUE /OUT:"E:\svn\profiler64_c\x64\Release\ProfilerX64.exe" /INCREMENTAL:NO /NOLOGO /LIBPATH:./x64/Release "E:\svn\profiler64_c\x64\Release\SymbolServer.lib" kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /MANIFEST /MANIFESTUAC:"level='asInvoker' uiAccess='false'" /manifest:embed   /SUBSYSTEM:CONSOLE /TLBID:1 /DYNAMICBASE /NXCOMPAT /IMPLIB:"E:\svn\profiler64_c\x64\Release\ProfilerX64.lib" /MACHINE:X64 x64\Release\main.obj x64\Release\Assem.obj

pause
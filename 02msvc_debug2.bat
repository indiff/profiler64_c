@echo off
set cur_path=%CD%
rem call "C:\Program Files (x86)\Microsoft Visual Studio 10.0\VC\vcvarsall.bat" x86
rem call "C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\VC\Auxiliary\Build\vcvarsall.bat" x86
call "C:\Program Files\Microsoft Visual Studio\2022\Community\Common7\Tools\VsDevCmd.bat" -arch=x64
rem 在dll中 link Assem.obj, 在 exe 调用 dll。 这种方式测试不能执行正常效果


rmdir /s /q E:\svn\profiler64_c\x64\Debug\
mkdir E:\svn\profiler64_c\x64\Debug\

echo ml Assem.asm
ml64.exe /c /nologo /Zi /Fo"x64\Debug\Assem.obj" /W3 /errorReport:prompt /TaProfilerX64\Assem.asm

echo cl main.c
CL.exe /c /ZI /JMC /nologo /W3 /WX- /diagnostics:column /sdl /Od /D WIN32 /D _DEBUG /D _CONSOLE /D _UNICODE /D UNICODE /Gm- /EHsc /RTC1 /MDd /GS /fp:precise /Zc:wchar_t /Zc:forScope /Zc:inline /Fo"x64\Debug\\" /Fd"x64\Debug\vc143.pdb" /external:W3 /Gd /TC /FC /errorReport:queue ProfilerX64\main.c


echo cl SymServer.c
CL.exe /c /ZI /JMC /nologo /W3 /WX- /diagnostics:column /Od /D WIN32 /D _DEBUG /D _WINDOWS /D _USRDLL /D SYMBOLSERVER_EXPORTS /D _WINDLL /D _UNICODE /D UNICODE /Gm- /EHsc /RTC1 /MDd /GS /fp:precise /Zc:wchar_t /Zc:forScope /Zc:inline /Fo"x64\Debug\\" /Fd"x64\Debug\vc143.pdb" /external:W3 /Gd /TC /FC /errorReport:queue /GH /Gh SymbolServer\SymServer.c


echo link SymbolServer.dll
link.exe /ERRORREPORT:QUEUE /OUT:"E:\svn\profiler64_c\x64\Debug\SymbolServer.dll" /INCREMENTAL /ILK:"x64\Debug\SymbolServer.ilk" /NOLOGO Dbghelp.lib imagehlp.lib kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /MANIFEST /MANIFESTUAC:"level='asInvoker' uiAccess='false'" /manifest:embed /DEBUG /PDB:"E:\svn\profiler64_c\x64\Debug\SymbolServer.pdb" /SUBSYSTEM:WINDOWS /TLBID:1 /DYNAMICBASE /NXCOMPAT /IMPLIB:"E:\svn\profiler64_c\x64\Debug\SymbolServer.lib" /MACHINE:X64 /DLL x64\Debug\SymServer.obj  x64\Debug\Assem.obj


echo link main.c
link.exe /ERRORREPORT:QUEUE /OUT:"E:\svn\profiler64_c\x64\Debug\ProfilerX64.exe" /INCREMENTAL /ILK:"x64\Debug\ProfilerX64.ilk" /NOLOGO /LIBPATH:./x64/Debug "E:\svn\profiler64_c\x64\Debug\SymbolServer.lib" kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /MANIFEST /MANIFESTUAC:"level='asInvoker' uiAccess='false'" /manifest:embed /DEBUG /PDB:"E:\svn\profiler64_c\x64\Debug\ProfilerX64.pdb" /SUBSYSTEM:CONSOLE /TLBID:1 /DYNAMICBASE /NXCOMPAT /IMPLIB:"E:\svn\profiler64_c\x64\Debug\ProfilerX64.lib" /MACHINE:X64 x64\Debug\main.obj

echo 启动 x64\Debug\ProfilerX64.exe
pause

x64\Debug\ProfilerX64.exe
pause


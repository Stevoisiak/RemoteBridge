@ECHO OFF
IF NOT "%VCINSTALLDIR%" == "" GOTO do_process
IF "%VS110COMNTOOLS%" == "" GOTO show_err

:do_process
REM We build x64 samples first becuase devenv deletes the x86 exe's
SETLOCAL
CALL "%VS110COMNTOOLS%\..\..\VC\vcvarsall.bat" x64
IF "%VS110COMNTOOLS%" == "" GOTO err_cantsetupvs_x64
DEVENV CSharp\ComDemo\CSharpComDemo.sln /rebuild "Release|x64"
IF NOT %ERRORLEVEL% == 0 goto bad_compile
DEVENV CSharp\IExplorer\CSharpIE.sln /rebuild "Release|x64"
IF NOT %ERRORLEVEL% == 0 goto bad_compile
DEVENV CSharp\JavaDemo\CSharpJavaDemo.sln /rebuild "Release|x64"
IF NOT %ERRORLEVEL% == 0 goto bad_compile
DEVENV CSharp\JavaTest\CSharpJavaTest.sln /rebuild "Release|x64"
IF NOT %ERRORLEVEL% == 0 goto bad_compile
ENDLOCAL

SETLOCAL
CALL "%VS110COMNTOOLS%\..\..\VC\vcvarsall.bat" x86
IF "%VS110COMNTOOLS%" == "" GOTO err_cantsetupvs_x86
DEVENV CSharp\ComDemo\CSharpComDemo.sln /rebuild "Release|x86"
IF NOT %ERRORLEVEL% == 0 goto bad_compile
DEVENV CSharp\IExplorer\CSharpIE.sln /rebuild "Release|x86"
IF NOT %ERRORLEVEL% == 0 goto bad_compile
DEVENV CSharp\JavaDemo\CSharpJavaDemo.sln /rebuild "Release|x86"
IF NOT %ERRORLEVEL% == 0 goto bad_compile
DEVENV CSharp\JavaTest\CSharpJavaTest.sln /rebuild "Release|x86"
IF NOT %ERRORLEVEL% == 0 goto bad_compile
ENDLOCAL
GOTO end

:show_err
ECHO Please ensure Visual Studio 2012 is installed
PAUSE
GOTO end

:err_cantsetupvs_x86
ENDLOCAL
ECHO Cannot initialize Visual Studio x86 Command Prompt environment
PAUSE
GOTO end

:err_cantsetupvs_x64
ENDLOCAL
ECHO Cannot initialize Visual Studio x64 Command Prompt environment
PAUSE
GOTO end

:bad_compile
ENDLOCAL
ECHO Errors detected while compiling project
PAUSE
GOTO end

:end

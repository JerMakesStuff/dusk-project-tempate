@echo off

set build_mode=%1
set run=0

echo %1
if %1.==. (
    set build_mode=test
)

if %build_mode% equ test (
    set build_mode=debug
    set run=1
) 

if %build_mode% equ debug (
    set flags=-debug -vet -strict-style
) else (
    if %build_mode% equ release (
        set flags=-o:speed -vet -strict-style
    ) else (
        echo Build mode %build_mode% unsupported!
    )
)

if not exist .\build (
    mkdir build
)

if not exist .\build\%build_mode% (
    pushd build
        mkdir %build_mode%
    popd
)

odin build ./ -out:./build/%build_mode%/game.exe %flags%

if %errorlevel% neq 0 (
    goto EOF
)

if exist .\build\%build_mode%\data (
    pushd build
        pushd %build_mode%
            rmdir %build_mode% /s /q
        popd
    popd
)

xcopy .\settings.ini .\build\%build_mode%\ /y
xcopy .\data .\build\%build_mode%\data /y /s /i

if %run% equ 1 (
    pushd build
        pushd %build_mode%
            game.exe
        popd
    popd
)

:EOF
set ZIP="C:\Program Files\7-Zip\7z.exe"
set VER=v0.x
set OUT="%~dp0%VER%"

md "%VER%"
for /d %%i in (build\*) do (
    pushd "%%i"
    %ZIP% a "%OUT%\%%~ni - %VER%.zip" *
    popd
)
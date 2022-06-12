@echo off
>nul chcp 65001

setlocal DisableDelayedExpansion
pushd "%~dp0"
setlocal EnabledelayedExpansion

if defined href_path (
    set href_path=
)
set "sp= "
if exist "Bookmarks Toolbar\" (
    rd /s /q "Bookmarks Toolbar"
)
for /f "tokens=1,2*" %%A in ('python "D:\Téléchargements\Python Stuff\IS.bookmarks\bookmarks_parser.py" -e --folders-path "D:\Git\Illegal_Services\IS.bookmarks.html"') do (
    set "data=%%C"
    if defined data (
        set "data=!data:"=`!"
        for /f "tokens=1,3,5delims=`" %%D in ("!data!") do (
            if "%%B_!href_path!"=="0_" (
                set "href_path=Bookmarks Toolbar"
                if not exist "!href_path!\" (
                    md "!href_path!" && (
                        call :WRITE_HEADER %%B
                    )
                )
            ) else (
                set "href_path=%%D"
                set "href_name=%%E"
                set "name=%%E"
                set "href_path=!href_path:?=z!"
                set "href_path=!href_path:\/=z!"
                set "href_path=!href_path:\\=z!"
                set "href_name=!href_name:?=z!"
                set "href_name=!href_name:\/=z!"
                set "href_name=!href_name:\\=z!"
                set "name=!name:\/=/!"
                set "name=!name:\\=\!"
                set "name=!name:&#39;='!"
                if not exist "!href_path!\" (
                    md "!href_path!" && (
                        call :WRITE_HEADER %%B
                    )
                )
                if "%%A"=="PATH" (
                    >>"!href_path!/index.html" (
                        echo         ^<a href="!href_name!/index.html"^>^<i class="fa fa-folder-o"^>^</i^> !name!^</a^>
                    ) || (
                        echo ERROR ^(PATH^): "!href_path!/index.html"
                        pause
                        exit /b 0
                    )
                    echo "[%%A] [!href_path!] [!name!]"
                ) else if "%%A"=="LINK" (
                    set "href_link=%%F"
                    >>"!href_path!/index.html" (
                        echo         ^<a href="!href_link!" target="_blank"^>^<i class="fa fa-globe"^>^</i^> !name!^</a^>
                    ) || (
                        echo ERROR ^(LINK^): "!href_path!/index.html"
                        pause
                        exit /b 0
                    )
                    echo "[%%A] [!href_path!] [!name!] [!href_link!]"
                )
            )
        )
    )
)
for /f "delims=" %%A in ('2^>nul dir "Bookmarks Toolbar\*index.html" /b /a:-d /s') do (
    set "href_path=%%~dpA"
    if defined href_path (
        set "href_path=!href_path:~0,-1!"
        if defined href_path (
            call :WRITE_FOOTER
        )
    )
)

popd
endlocal
exit /b 0

:WRITE_HEADER
if defined @display_path (
    set @display_path=
)
set tmp_path_href_path="!href_path!"
set "tmp_path_href_path=!tmp_path_href_path:/=" "!"
if defined path_href_path (
    set path_href_path=
)
for %%A in (!tmp_path_href_path!) do (
    if defined path_href_path (
        set "path_href_path=!path_href_path!/%%~A"
    ) else (
        set "path_href_path=%%~A"
    )
    set @display_path=!@display_path!^<a href^="/Illegal_Services/!path_href_path!/index.html"^>%%~A^</a^> ^>!sp!
)
if defined @display_path (
    set "@display_path=!@display_path!index.html"
)
>>"!href_path!\index.html" (
    echo ^<!DOCTYPE html^>
    echo ^<html lang="en-US"^>
    echo:
    echo ^<head^>
    echo     ^<meta charset="UTF-8"^>
    echo     ^<meta name="viewport" content="width=device-width, initial-scale=1"^>
    echo     ^<meta name="description" content="Illegal Services Bookmarks"^>
    echo     ^<meta name="keywords" content="Illegal, Services, Bookmarks, website"^>
    echo     ^<meta name="author" content="IB_U_Z_Z_A_R_Dl"^>
    echo     ^<title^>IS Bookmarks - Illegal Services^</title^>
    echo     ^<link rel="shortcut icon" href="/Illegal_Services/icons/favicon.ico" type="image/x-icon"^>
    echo     ^<link rel="icon" href="/Illegal_Services/icons/favicon.ico" type="image/x-icon"^>
    echo     ^<link rel="stylesheet" href="/Illegal_Services/css/styles.css"^>
    echo     ^<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css"^>
    echo ^</head^>
    echo:
    echo ^<body^>
    echo     ^<nav^>
    echo         ^<div class="navbar"^>
    echo             ^<a href="/Illegal_Services/index.html"^>^<i class="fa fa-home"^>^</i^>Home^</a^>
    echo             ^<a href="/Illegal_Services/tutorial.html"^>^<i class="fa fa-life-ring"^>^</i^> Tutorial^</a^>
    echo             ^<a href="/Illegal_Services/faq.html"^>^<i class="fa fa-question-circle"^>^</i^> FAQ^</a^>
    echo             ^<a href="/Illegal_Services/downloads.html"^>^<i class="fa fa-cloud-download"^>^</i^> Downloads^</a^>
    echo             ^<a href="/Illegal_Services/Bookmarks%%20Toolbar/Illegal%%20Services/index.html" class="active"^>^<i class="fa fa-bookmark-o"^>^</i^>^<u^> IS Bookmarks^</u^>^</a^>
    echo             ^<a href="/Illegal_Services/IS.bookmarks.html" target="_blank"^>^<i class="fa fa-bookmark-o"^>^</i^>^</i^> IS.bookmarks.html^</a^>
    echo         ^</div^>
    echo     ^</nav^>
    echo     ^<br^>
    echo:
    echo     ^<div class="pathbar"^>
    echo         !@display_path!
    echo     ^</div^>
    echo     ^<br^>
    echo:
    echo     ^<div class="vertical-menu"^>
) || (
    echo ERROR ^(WRITE_HEADER^): "!href_path!/index.html"
    pause
    exit /b 0
)
exit /b

:WRITE_FOOTER
>>"!href_path!\index.html" (
    echo     ^</div^>
    echo     ^<br^>
    echo:
    echo     ^<footer^>
    echo         ^<a href="https://illegal-services.github.io/Illegal_Services/"^>^<img src="/Illegal_Services/svgs/internet.svg" title="https://illegal-services.github.io/Illegal_Services/" target="_blank"^>^</a^>
    echo         ^<a href="https://github.com/Illegal-Services/Illegal_Services"^>^<img src="/Illegal_Services/svgs/github.svg" title="https://github.com/Illegal-Services/Illegal_Services" target="_blank"^>^</a^>
    echo         ^<a href="https://t.me/illegal_services_forum"^>^<img src="/Illegal_Services/svgs/telegram.svg" title="https://t.me/illegal_services_forum" target="_blank"^>^</a^>
    echo         ^<a href="https://t.me/illegal_services"^>^<img src="/Illegal_Services/svgs/telegram.svg" title="https://t.me/illegal_services" target="_blank"^>^</a^>
    echo         ^</br^>
    echo         © 2020-2022 IB_U_Z_Z_A_R_Dl. All rights reserved.
    echo     ^</footer^>
    echo:
    echo ^</body^>
    echo ^</html^>
) || (
    echo ERROR ^(WRITE_FOOTER^): "!href_path!/index.html"
    pause
    exit /b 0
)
exit /b

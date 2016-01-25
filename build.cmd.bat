::=========================================================================================
:: Build application APL WS using AplBuilder. It can even build itself from the sources 
::=========================================================================================
:: Project C:\Data\SoftForge\AplBuilder\aplbuilder.exe
::aplbuilder.exe appname="house-calc"  bldroot="C:\Data\SoftForge\HouseCalc" srcroot="C:\Data\SoftForge\HouseCalc" 
aplbuilder.exe appname="house-calc"  bldroot="C:\Softforge\HouseCalc"  srcroot="C:\Softforge\HouseCalc"  

:: Released 
::C:\Data\Builds\aplbuilder.exe appname="house-calc"  bldroot="c:\Data\Builds" srcroot="C:\Data\SoftForge\HouseCalc" 

::"C:\Program Files (x86)\Dyalog\Dyalog APL 14.1 Unicode\dyalog.exe" "C:\Data\SoftForge\AplBuilder\aplbuilder.dws" appname="newapldskapp" bldroot="c:\Data\Builds" srcroot="C:\Data\SoftForge\NewAplAppDsk" 
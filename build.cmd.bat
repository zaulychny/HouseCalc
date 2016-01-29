::=========================================================================================
:: Build application WS using AplBuilder. It can even build itself from the sources 
::=========================================================================================

:: Build WS using central installation of AplBuilder and fixed build and source roots
::C:\Data\SoftForge\AplBuilder\aplbuilder.exe appname="house-calc"  bldroot="C:\Data\SoftForge\HouseCalc" srcroot="C:\Data\SoftForge\HouseCalc"

:: Build WS using current project AplBuilder installation and project path as build and source roots "%~dp0"
@ECHO OFF
SET root=%~dp0
ECHO ON
@aplbuilder.exe appname="house-calc"  bldroot=%root%  srcroot="%root%src"

:: Debug build procedure with AplBuilder WS instead of executable
::"C:\Program Files (x86)\Dyalog\Dyalog APL 14.1 Unicode\dyalog.exe" -x "C:\Data\SoftForge\AplBuilder\aplbuilder.dws" appname="newapldskapp" bldroot="c:\Data\Builds" srcroot="C:\Data\SoftForge\NewAplAppDsk" 
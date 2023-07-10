# WinIBW-OAI-Harvest
This repository contains JavaScript / XUL / XSLT Code for WinIBW (> 3.7) application to harvest OAI interfaces via http and transform data from xMetaDissPlus format into Pica format.

## Installation

This script is for installation on a local WinIBW (3.7 or later) instance on Windows OS.

The ZDV of University Mainz is rolling out WinIBW as VApp. Please check your organisations way of installing WinIBW.

The newest version "**WinIBW hebis2022**" is installed in the directory:

C:\Users\\*[username]*\AppData\Local\Microsoft\AppV\Client\VFS\D44E0DE6-5863-44AE-AF3A-4956B43A3E16\APPV_ROOT\WinIBW3 hebis2022\
 
The files in this repository must be copied into that "root"-directory to install it on a local WinIBW instance.

Therefore replace *[username]* with the users name who shall use the script on his computer. If several users shall use the script on the same computer the files need to be copied into each "root"-directory.

The file defaults\pref\\*[WinIBW version]*\setup.js overrides the setup file which is captured in the WinIBW-VApp that is originally provided by the ZDV and must be copied into the folder defaults\pref\ .

If necessary, the continues numbering in setup.js must be adapted (in case of additional scripts).

### Main function

The main function OAIHarvest() is located in the file scripts\oaiharvest.js and  must be provided inside WinIBW after copying/installing these project files to the "root"-directory.

The function can be found afterwards in WinIBW-Menu:

    Optionen -> Werkzeugleiste anpassen...
    
Therefore select "Standard-Funktionen" in "Kategorien:" and then choose "OAIHarvest" in "Kommandos". With the left mouse button you can move the script to the menu bar of WinIBW.

## Configuration

The script can be configured in chrome\ibw\content\xul\DSpaceConfig.js (e.g. URL of the repository to be harvested, or debug mode on/off).

The dialog to request a handle from the user can be configured in chrome\ibw\content\xul\getDSpaceItem.xul



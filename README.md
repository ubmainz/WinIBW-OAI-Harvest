# WinIBW-OAI-Harvest
This repository contains JavaScript / XUL / XSLT Code for WinIBW (> 3.7) application to harvest [OAI](http://www.openarchives.org/OAI/openarchivesprotocol.html) interfaces via http and transform data from
[xMetaDissPlus](https://www.dnb.de/DE/Professionell/Sammeln/Unkoerperliche_Medienwerke/_content/xMetaDissPlus_akk.html) format into
[Pica](https://www.hebis.de/arbeitsmaterialien/erfassungsleitfaden/gesamtliste-der-kategorien-in-titelaufnahmen/) format.

## Installation

This script is for installation on a local **WinIBW** (3.7 or later) instance on Windows OS.

The [ZDV](https://www.zdv.uni-mainz.de/) of University Mainz is rolling out WinIBW as VApp. Please check your organisations way of installing WinIBW.

The newest version [WinIBW hebis2022](https://www.hebis.de/uploads/2022/06/winibw3.7_hebis2022_V4_2022-10-05.pdf) is installed in the directory:

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

## Editing the metadata crosswalk process

After downloading metadata from a repository via OAI interface it is saved on disk in [xMetaDissPlus](https://www.dnb.de/DE/Professionell/Sammeln/Unkoerperliche_Medienwerke/_content/xMetaDissPlus_akk.html) format.

The transformation process into [Pica](https://www.hebis.de/arbeitsmaterialien/erfassungsleitfaden/gesamtliste-der-kategorien-in-titelaufnahmen/) format happens in two steps. 

#### Step 1: Transformation via XSLT-Stylesheet

The main transformation step will be executed by an external XSLT-Processor (xmetadissplus/xsltproc.exe) not in WinIBW itself.

Therefore you can edit the XSLT-Stylesheet (xmetadissplus/xmetadissplus2pica.xsl).

The output of this transformation is a textfile that contains the metadata in Pica format.

#### Step 2: Preparation for presentation on screen via JavaScript

For presentation on screen in the WinIBW-Window "CBS Hauptbestand" the Pica format will be read from disk by the read_pica3() function in file scripts/oaiharvest.js

Further editions to the Pica format are made in this function via JavaScript. You may need to edit some proprietary informations about your organisation here.

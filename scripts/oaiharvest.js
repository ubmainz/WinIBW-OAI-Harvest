/** ___________
 * |  _   _ _  |
 * | | ) (   / |
 * | |_) _) /_ |
 * |___________|
 *
 * @author      Zehra Atay
 * @author      Stefan Freudenberg
 * @copyright   2006 Bibliotheksservice-Zentrum Baden-Wuerttemberg
 * @version
 * @author      Matthias Genzmehr
 * @copyright   2022 Universitätsbibliothek Mainz
 * @version     Update for harvest of DSpace Repository of University Mainz
 *
 * This file contains the utility script for conversion of XMetaDissPlus format
 * into PICA3 presentation data model.
 * Anpassungen GBV: Karen Hachmann
 * GBV 2008.04: Scripte umbenannt (sprechende Bezeichnungen!)
 *             open_dialog entfernt, kommt schon in standard_utility.js vor.
        2011.09: - Für Windows7 wird xsltproc.exe verwendet. Diese Datei und weitere dazugehörige werden zum Download
                bereitgestellt unter:
                http://www.gbv.de/bibliotheken/verbundbibliotheken/02Verbund/02Verbundsystem/02WinIBW/WinIBW3/download-opus-dateien/xmetadissplus.zip
                - Für frühere Windowsversionen wird XMLTransform.exe verwendet (diese Datei und die zugehörigen
                befinden sich im Setup von WinIBW 3.3.7)
 */

var eingabeMeldung = "";

/**
 * function transform(processor, inFile, stylesheet, outFile)
 * 
 * Startet den externen XSLT-Prozessor (Config.Files.XSLTProcessor)
 * mit dem XSLT-Stylesheet Config.Files.XWalk und wandelt damit die Daten aus
 * Config.Files.Download um ins Pica-Format. Das Ergebnis wird in die
 * Datei Config.Files.Pica geschrieben.
 *
 * Siehe DSpaceConfig.js für die Konfiguration der Dateien/Dateinamen
 *
 * processor  = Config.Files.XSLTProcessor
 * inFile     = Config.Files.Download
 * stylesheet = Config.Files.XWalk
 * outFile    = Config.Files.Pica
 *
 * Die Daten in Config.Files.Pica werden anschließend in der Funktion
 * read_pica3() für die Anzeige im CBS-Fenster der WinIBW weiter aufbereitet.
 *
 */
function transform(processor, inFile, stylesheet, outFile)
{
    if(Debug){with(Config.Messages.Debug){
        application.messageBox(Title, transform, Icon);
    }}

    var argList = new Array("-o", outFile, stylesheet, inFile);

    var theXMLTransformerFile = Components.classes[Config.Classes.nsILocalFile]
                .createInstance(Components.interfaces.nsILocalFile);

    theXMLTransformerFile.initWithPath(processor);

    if (!theXMLTransformerFile.exists() || !theXMLTransformerFile.isExecutable()) {
        with (Config.Messages.Error) {
            application.messageBox(Title, NoXSLTProcessor, Icon);
        }
        return 0;
    }

    // XWalk Config.Files.Download to Config.Files.Pica
    var process = Components.classes[Config.Classes.nsIProcess]
                .createInstance(Components.interfaces.nsIProcess);

    process.init(theXMLTransformerFile);
    process.run(true, argList, argList.length);

    if (process.exitValue != 0) {
        if(Debug){with(Config.Messages.Debug){
            application.messageBox(Title, XWalkingFailed, Icon);
        }}
        
        // Xwalk process failed
        return false;
    } else {
        if(Debug){with(Config.Messages.Debug){
            application.messageBox(Title, XWalkingSucceeded, Icon);
        }}
        
        // Xwalk process succeeded
        return true;
    }
}

/**
 * function read_pica3(tmpName)
 * 
 * Aufbereitung der transformierten Daten aus Config.Files.Pica
 * für die Anzeige im CBS-Fenster.
 *
 */
function read_pica3(tmpName)
{
    if(Debug){with(Config.Messages.Debug){
        application.messageBox(Title, readPica3, Icon);
    }}

    //Anpassungen GBV: Es wird die URN aus 2050 gesucht.
    //Ist die Suche erfolgreich, wird kein neuer Datensatz angelegt
    var inFile = utility.newFileInput();
    var content;
    var zeile="";
    var prompter = utility.newPrompter();
    var frage1, frage2;
    var str0500="";
    var str1140="";
    var str2050="";
    var str3000="";
    var str3010="";
    var str4000="";
    var beschr = "";
    var strTitelmeldung="";
    var setsize=0;
    var titel = "";
    var schoepfer = "";
    var aktDatum = new Date();
    var sekjahr = aktDatum.getFullYear();
    var diss = false;

    if (inFile.open(tmpName)) { //Anfang file
        for (content = ""; !inFile.isEOF(); ) {
            zeile = inFile.readLine()
                if(zeile.substr(0,5)== "0500 ") str0500 = zeile.substr(5);
                if(zeile.substr(0,5)== "1100 ") var jahr =  zeile;
                if(zeile.substr(0,5)== "1500 "){
                    zeile = zeile.replace("1fra", "1fre")
                    zeile = zeile.replace("1nld", "1dut")
                }

                if(zeile.substr(0,5)== "4030 ") var str4030 = zeile;
                if(zeile.substr(0,5)== "1140 ") str1140 = zeile.substr(5);
                if(zeile.substr(0,5)== "2050 ") {
                    str2050 = zeile.substr(10);
                    
                    // Hier wird entschieden, ob es sich um einen frei zugänglichen Titel oder einen mit Zugriffsbeschränkung handelt.
                    if (zeile.substr(5,5)!= "##0##"){
                        beschr = "\n4801 Zugriffsbeschränkung: Bestandssicherung, Zugriff nur im internen UB-Netz" + "\n7136 " + zeile.substr(5)
                    }
                }
                if(zeile.substr(0,5)== "3000 ") schoepfer =  zeile.substr(5, zeile.indexOf("$B")-5);
                if(zeile.substr(0,5)== "3010 ") str3010 = zeile.substr(5);
                if(zeile.substr(0,5)== "4000 ") {

                    zeile = zeile.replace(" ; "," : ")
                    titel = zeile.substr(5)
                    titel = titel.replace("@", "")

                       if(titel.indexOf(" / ")>-1){
                       titel = titel.substr(0,titel.indexOf(" / "))
                        }

                        if(titel.indexOf(" : ")>-1){
                        titel = titel.substr(0,titel.indexOf(" : "))
                        }

                }
                
                // Propritäres Format der Universität Mainz aus xMetaDissPlus <dc:source>
                if(zeile.substr(0,5)== "4070 ") {
                    var dcSourceParts = zeile.substring(5, zeile.length);
                    dcSourceParts = dcSourceParts.split('. ');
                    zeile = "4070 ";
                    
                    if(dcSourceParts[3] != "-") //publisherYear
                        zeile += "/j" + dcSourceParts[3];
                    
                    if(dcSourceParts[1] != "-") //journalVolume (Bandzählung)
                        zeile += "/v" + dcSourceParts[1];
                    
                    if(dcSourceParts[2] != "-") //journalIssue (Heftzählung)
                        zeile += "/a" + dcSourceParts[2];
                    
                    if(dcSourceParts[4] != "-") { //pagesStart
                        zeile += "/p" + dcSourceParts[4];
                        if(dcSourceParts[5] != "-") //pagesEnd
                            zeile += "-" + dcSourceParts[5];
                    }
                    
                    if(dcSourceParts[6] != "-") //pagesAlternative (enthält die Artkel ID)
                        zeile += "/i" + dcSourceParts[6];
                }

                content += "\n" + zeile;
        }
        
        inFile.close();

        var k5050 = "\n5050 ";

        if (content.indexOf("5050 ")>-1) {
            k5050 = ""
        }

        if(content.indexOf("4030 ")==-1 && content.indexOf("0500 Oa")>-1 && content.indexOf("4204 ")==-1 ){
            content = content.replace("4060 ", "4030 Mainz\n4060 ")
        }

        if (content.indexOf("0500 Oo")>-1) {

            content = content.replace(str4030, "")
            if(content.indexOf("4241 ") == -1){
                content = content + "\n4241 Enthalten in"
            }
        }

        content = content + "\n4034 Mainz : Johannes Gutenberg-Universität Mainz\n";

        contentA = content.split("\n");
        contentA.sort();
        
        content = contentA.join("\n");
        content = content.replace(/###/g, "\n");
        content = content.replace(/\n\n/g, "\n");
        content = content.replace(/\n\n0500/g, "0500");
        
        TitelEingeben(content);

    }
    else {
        with (Config.Messages.Error) {
            application.messageBox(Title, FileNotOpen + "\r\n\r\n" + tmpName, Icon);
        }
    }
}
/**
 * Function TitelEingeben vom BSZ fehlte, neu eingefuegt:
 */
function TitelEingeben(content)
{
    application.activeWindow.command("e", false);
    if (application.activeWindow.status != "OK" ) {
        with (Config.Messages.Error) {
            alert(hebisError);
        }
        return;
    }
    application.activeWindow.showMessage(eingabeMeldung, 3);
    application.activeWindow.title.insertText(content);
}

/**
 * Helper function _getWindow()
 */
function _getWindow (regExp) {

    var numOfWindows = application.windows.count;

    for (var i = 0; i < numOfWindows; i++) {
        win = application.windows.item(i);
        win.activate();

        if(Debug){with(Config.Messages.Debug){
            application.messageBox(Title, win.text, Icon);
        }}

        if (regExp.test(win.text)) {
            return win;
        }
    }
    return false;
}

/**
 * !!!!!!!!!!!!!!!!!!!!!!!!!!!!
 * !!!!!       MAIN       !!!!!
 * !!!!! !!!!!!!!!!!!!!!!!!!!!!
 *
 * This function will be executed in WinIBW to start the OAI harvest functionality
 *
 * - Check whether user is logged in to "CBS Hauptbestand" or not
 * - Open dialog to get handle from user
 *   -- Validate handle
 *   -- Use handle to harvest the OAI interface of the repository via http
 *   -- Write download result to disk
 * - Crosswalk downloaded data (e.g. xMetaDissPlus format) into Pica format via XSLT (using external XSLTProcessor)
 * - Show data in Pica format in CBS Window for further use
 *
 */
function OAIHarvest(){

    if (Debug){with(Config.Messages.Debug){
        application.messageBox(Title, OAIHarvest, Icon);
    }}

    var harvestSuccess = 0;

    /*
     * This Macro can be executed only in CBS Hauptbestand!
     */

    var cbsWindow = _getWindow(new RegExp("Hauptbestand"));

    // Quit, if user is not logged in to CBS Hauptbestand.
    if (!cbsWindow) {
        with (Config.Messages.Alert){
            application.messageBox(Title, LoginToCBS, Icon);
        }
        return;
    }

    cbsWindow.activate();

    // Prompt dialog to get handle and harvest OAI Interface
    with (Config.XUL) {
        open_xul_dialog(Dialog, Features);
    }

    // Check whether harvest was successfull => Result is saved on disk in file Config.Files.Download
    with (Config.Vars) {
        harvestSuccess = application.getProfileInt(Section, HarvestSuccess, 0);
    }

    if (Debug){with(Config.Messages.Debug){
        application.messageBox(Title, typeof(harvestSuccess) + " " + harvestSuccess, Icon);
    }}

    if (!harvestSuccess){
        return;
    }

    var file = utility.newFileInput();

    with (Config) {
        // Get the users name for local installation of the script.
        // Path.UserName == 2 means the 2nd directory is the users name. e.g.: "C:\Users\genzmehr\AppData"

        var profileDirectory = file.getSpecialPath(Vars.ProfDir, Files.Profile); //Files.Profile contains just a dummy name to execute the function correctly.
        var directories = profileDirectory.split('\\');

        var transformerPath = Path.Drive + Path.Users + directories[Path.UserName] + Path.App + Files.XSLTProcessor;
        var stylesheetPath  = Path.Drive + Path.Users + directories[Path.UserName] + Path.App + Files.XWalk;

        var inputPath  = file.getSpecialPath(Vars.ProfDir, Files.Download);
        var outputPath = file.getSpecialPath(Vars.ProfDir, Files.Pica);
    }

    if (Debug){with(Config.Messages.Debug){
        application.messageBox(Title, ProfileDirectory + profileDirectory, Icon);
        application.messageBox(Title, TransformerPath + transformerPath.replace(/\\/g,"\r\n"), Icon);
        application.messageBox(Title, StylesheetPath + stylesheetPath.replace(/\\/g,"\r\n"), Icon);
        application.messageBox(Title, InputPath + inputPath.replace(/\\/g,"\r\n"), Icon);
        application.messageBox(Title, OutputPath + outputPath.replace(/\\/g,"\r\n"), Icon);
    }}

    // Crosswalk download result (xMetaDissPlus format) into Pica format and make it up for presentation on screen
    if (transform(transformerPath, inputPath, stylesheetPath, outputPath)) {
        read_pica3(outputPath);
    } else {
        return;
    }

    if (file.open(inputPath)) {
        //file.remove();
    }

    if (file.open(outputPath)) {
        //file.remove();
    }
}

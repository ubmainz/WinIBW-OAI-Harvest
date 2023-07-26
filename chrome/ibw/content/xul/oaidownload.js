/** ___________
 * |  _   _ _  |
 * | | ) (   / |  
 * | |_) _) /_ | 
 * |___________|
 *
 * @author      Stefan Freudenberg
 * @copyright   Bibliotheksservice-Zentrum Baden-Wuerttemberg, 2007
 *
 * @author      Matthias Genzmehr
 * @copyright   Universitätsbibliothek Mainz, 2022
 * @version 
 *
 * This file contains the JavaScript-Event functions for the XUL dialog.
 */

application = Components.classes[Config.Classes.IApplication]
        .getService(Components.interfaces.IApplication);

serializer = Components.classes[Config.Classes.nsIDOMSerializer]
        .getService(Components.interfaces.nsIDOMSerializer);


/**
 * Initialize OAI Client
 */
var oaiClient = new OaiClient();

/**
 * Initialize Utility
 */
const utility = 
{
    newFileInput: function() {
        return Components.classes[Config.Classes.IInputTextFile]
                                .createInstance(Components.interfaces.IInputTextFile);
    },

     newFileOutput: function() {
        return Components.classes[Config.Classes.IOutputTextFile]
                                 .createInstance(Components.interfaces.IOutputTextFile);
    },

    newPrompter: function() {
         return Components.classes[Config.Classes.IPromptUtilities]
                                  .createInstance(Components.interfaces.IPromptUtilities);
   },
   
    getSpecialDirectory: function(name) {
        const nsIProperties = Components.interfaces.nsIProperties;
        var dirService = Components.classes[Config.Classes.nsIProperties]
                        .getService(nsIProperties);

        return dirService.get(name, Components.interfaces.nsIFile);
    }
};

/**
 * XULDialog::onload = onLoad()
 */

function onLoad()
{
    if (Debug){with (Config.Messages.Debug) {
        application.messageBox(Title, onLoad, Icon);
    }}

    try {
        with (Config.OAI.Connection) {
            oaiClient.setRepositoryUrl(Protocol + Domain + Interface);
        }
    } catch (e) {
        with (Config.Messages.Error) {
            application.messageBox(Title, e.message, Icon);
        }
    }
}

/**
 * XULDialog::ondialogcancel = onCancel()
 */

function onCancel()
{
    if (Debug){with (Config.Messages.Debug) {
        application.messageBox(Title, onCancel, Icon);
    }}

    /*
     * Indicate abortion for usage outside of the dialog
     */
    with (Config.Vars){
        return application.writeProfileInt(Section, HarvestSuccess, 0);
    }
}

/**
 * XULDialog::ondialogaccept = oaiDownload()
 *
 * This function uses the oaiClient to download metadata from the repository
 * and writes it to disk.
 *
 */

function oaiDownload()
{
    if (Debug){with (Config.Messages.Debug) {
        application.messageBox(Title, oaiDownload, Icon);
    }}
    
    var handle = "",
        oaiQueryParams = "",
        response = "",
        xMetaDissPlus = "";

    /*
     * get handle from user (XUL dialog)
     */
    handle = document.getElementById(Config.XUL.Nodes.HANDLE).value;

    if (Debug){with (Config.Messages.Debug){
        application.messageBox(Title, Handle + handle, Icon);
    }}

    /*
     * validate handle string.
     *
     * handle must:
     *   - not be empty
     *   - at least one digit
     *   - digits only
     *   - greater than zero
     */
    if (!(handle != "" && (/^\d{1,}$/).test(handle) && Number(handle) > 0)){
        with (Config.Messages.Alert){
            alert(InsertHandle);
        }
        /*
         * quit if no valid handle has been entered. The dialog will be shown again.
         */
        return false;
    }

    /*
     * insert handle into URL parameters
     */
    with (Config.OAI.Params){
        oaiQueryParams = Prefix + Identifier + handle;
    }

    if (Debug){with (Config.Messages.Debug){
        application.messageBox(Title, QueryParams + oaiQueryParams, Icon);
    }}

    try {
        
        /*
         * request item data from repository
         */
        response = oaiClient.getRecord(oaiQueryParams);

        if (Debug){with (Config.Messages.Debug){
            application.messageBox(Title, Response + response, Icon);
        }}
        
    } catch (e) {

        with (Config.Messages.Error){
            application.messageBox(Title, e.message, Icon);
        }

        return false;
    }
    
    /*
     * get data from XML Object
     */
    if (response.getElementsByTagName(Config.XML.Nodes.ERROR).item(0) != null){

        with (Config.Messages.Error){
            alert(UnvalidHandle + handle);
        }
        /*
         * quit because an OAI error occurred. The dialog will be shown again.
         */
        return false;

    } else {
        xMetaDissPlus = response.getElementsByTagName(Config.XML.Nodes.SCHEME).item(0);
    }

    if (Debug){with (Config.Messages.Debug){
        application.messageBox(Title, XMetaDissPlus + xMetaDissPlus, Icon);
    }}

    var file = Components.classes[Config.Classes.IOutputTextFile]
            .createInstance(Components.interfaces.IOutputTextFile);

    file.setTruncate(true);

    if (!file.createSpecial(Config.Vars.ProfDir, Config.Files.Download)) {

        with (Config.Messages.Error){
            application.messageBox(Title, FileNotOpen + file.getPath(), Icon);
        }

    } else {
        /*
         * Write download result to disk. Result will be written to Config.Files.Download
         */
        file.write(serializer.serializeToString(xMetaDissPlus))
    }

    file.close();

    /*
     * Indicate success for usage outside of the dialog => Result is written on disk to Config.Files.Download
     */
    with (Config.Vars){
        application.writeProfileInt(Section, HarvestSuccess, 1);
    }

    window.close();
}
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
 * This file contains the client for quering OAI-Repositories.
 */

function OaiClient() {

    var repositoryUrl = "";

    /**
     * OaiClient::setRepositoryUrl()
     */
    this.setRepositoryUrl = function(url) {
        
        var channel;
        var request = url;

        with (Config.OAI.Verbs) {
            request += Identify;
        }
        
        if (Debug){with (Config.Messages.Debug){
            application.messageBox(Title, setRepositoryUrl, Icon);
            application.messageBox(Title, HttpRequest + request, Icon);
        }}
        
        var ioService = Components.classes[Config.Classes.nsIIOService]
            .getService(Components.interfaces.nsIIOService);

        try {
            channel = ioService.newChannel(request, Config.OAI.Connection.CHARSET, null);    
            channel.QueryInterface(Components.interfaces.nsIHttpChannel);
            channel.open();
        } catch (e) {
            with(Config.Messages.Error){
                throw new OaiException(url + UnvalidURL);
            }
        }

        if (Debug){with (Config.Messages.Debug){
            application.messageBox(Title, ResponseStatus + channel.responseStatus, Icon);
        }}

        if (channel.responseStatus == 200) {

            repositoryUrl = url;

            if (Debug){with (Config.Messages.Debug) {
                application.messageBox(Title, RepositoryUrl + repositoryUrl, Icon);
            }}

        } else {
            with(Config.Messages.Error){
                throw new OaiException(UnableToConnect);
            }
        }
    };

    /**
     * OaiClient::getRecord()
     */
    this.getRecord = function(params) {

        var channel;
        var url_query = "";

        if (repositoryUrl == "") {
            with (Config.Messages.Error){
                throw new OaiException(NotConnected);
            }
        }

        with (Config.OAI.Verbs){
            url_query = repositoryUrl + GetRecord + params;
        }

        var ioService = Components.classes[Config.Classes.nsIIOService]
                .getService(Components.interfaces.nsIIOService);

        try {
            if (Debug){with (Config.Messages.Debug){
                application.messageBox(Title, QueryUrl + url_query, Icon);
            }}

            with (Config.OAI.Connection){
                channel = ioService.newChannel(url_query, CHARSET, null);
            }

        } catch (e) {
            with(Config.Messages.Error){
                throw new OaiException(url_query + UnvalidURL);
            }
        }

        var loader = Components.classes[Config.Classes.nsISyncLoadDOMService]
                .getService(Components.interfaces.nsISyncLoadDOMService);

        return loader.loadDocument(channel, null);
    };
};

/**
 * function OaiException(message)
 */
function OaiException(message)
{
    this.message = message;
};

/**
 * @author      Matthias Genzmehr
 * @copyright   Universitätsbibliothek Mainz, 2022
 * @version 
 *
 * This file contains the configuration information 
 * for harvesting repositories via OAI interface with
 * application WinIBW 3.7 or later
 *
 */

const Debug = false;

const Config = {

	Classes:{
		IApplication:"@oclcpica.nl/kitabapplication;1",
		IInputTextFile:"@oclcpica.nl/scriptinputfile;1",
		IOutputTextFile:"@oclcpica.nl/scriptoutputfile;1",
		IPromptUtilities:"@oclcpica.nl/scriptpromptutility;1",
		nsIIOService:"@mozilla.org/network/io-service;1",
		nsIProperties:"@mozilla.org/file/directory_service;1",
		nsISyncLoadDOMService:"@mozilla.org/content/syncload-dom-service;1",
		nsIDOMSerializer:"@mozilla.org/xmlextras/xmlserializer;1",
		nsIProcess:"@mozilla.org/process/util;1",
		nsILocalFile:"@mozilla.org/file/local;1"
	},

	XUL:{
		Dialog:"chrome://ibw/content/xul/getDSpaceItem.xul",
		Features:"centerscreen, chrome, close, titlebar, resizable, modal=yes,dependent=yes, dialog=yes",
		Nodes:{
			HANDLE:"handle"
		}
	},

	XML:{
		Nodes:{
			ERROR:"error",
			SCHEME:"xMetaDiss"
		}
	},

	OAI:{

		Connection:{
			Protocol:"http://",
			Domain:"openscience.ub.uni-mainz.de",
			Interface:"/oai/request",
			CHARSET:"UTF-8"
		},

		Verbs:{
			Identify:"?verb=Identify",
			GetRecord:"?verb=GetRecord"
		},

		Params:{
			Prefix:"&metadataPrefix=xMetaDissPlus",
			Identifier:"&identifier=oai:openscience.ub.uni-mainz.de:20.500.12030/"
		}
	},

	Path:{
		Drive:"C:\\",
		Users:"Users\\",
		UserName:2,
		App:"\\AppData\\Local\\Microsoft\\AppV\\Client\\VFS\\D44E0DE6-5863-44AE-AF3A-4956B43A3E16\\APPV_ROOT\\WinIBW3 hebis2022\\",
		AppData:"\\AppData\\Roaming\\Pica\\WinIBW30\\"
	},

	Files:{
		Item:"item.txt",
		Profile:"profile.txt",
		Download:"download.xml",
		Pica:"pica.txt",
		XWalk:"xmetadissplus\\xmetadissplus2pica.xsl",
		XSLTProcessor:"xmetadissplus\\xsltproc.exe"
	},

	Vars:{
		ProfDir:"ProfD",
		Section:"OAIHarvest",
		HarvestSuccess:"HarvestSuccess"
	},

	Messages:{

		Error:{
			Title:"Fehler",
			Icon:"error-icon",
			UnableToConnect:"Kann keine Verbindung zum Repository herstellen!",
			NotConnected:"Es besteht keine Verbindung zu einem Repository.",
			FileNotOpen:"Die Datei konnte nicht geöffnet werden!",
			Request:"Abfrage \"",
			BeginString:"\"",
			UnvalidURL:" ist keine gültige URL.",
			UnvalidHandle:"Die Publikation mit dem folgenden Handle existiert nicht:\r\n\r\n20.500.12030/",
			hebisError:"Datensatz kann nicht angelegt werden, evtl. Befugnisse nicht ausreichend!",
			NoXSLTProcessor:"XML Konverter nicht gefunden, oder keine ausführbare Datei!"
		},

		Alert:{
			Title:"Meldung",
			Icon:"alert-icon",
			Insert:"",
			InsertHandle:"Bitte geben Sie einen gültigen Handle ein:\r\n\r\nEine Ganzzahl größer 0.",
			InsertIdentifier:"Bitte geben Sie einen Identifier ein.",
			LoginToCBS:"Bitte melden Sie sich im CBS an, und wechseln Sie in den Hauptbestand, um dieses Makro zu nutzen!\r\n\r\nVielen Dank!"
		},

		Debug:{
			Title:"Entkäfern",
			Icon:"message-icon",
			onLoad:"onLoad()",
			onCancel:"onCancel()",
			oaiDownload:"oaiDownload()",
			getDSpaceItem:"getDSpaceItem()",
			OAIHarvest:"OAIHarvest()",
			transform:"transform()",
			readPica3:"read_pica3()",
			setRepositoryUrl:"OaiClient::setRepositoryUrl()",
			getRepositoryName:"OaiClient::getRepositoryName()",
			query:"OaiClient::query()",
			HttpRequest:"HTTP Request: ",
			Response:"Response: ",
			ResponseStatus:"Response Status: ",
			QueryUrl:"Query URL:\r\n    ",
			QueryParams:"Query Parameter:\r\n    ",
			RepositoryUrl:"OaiClient::repositoryUrl =\r\n    ",
			XMetaDissPlus:"xMetaDissPlus:\r\n\r\n",
			Handle:"Handle: ",
			XWalkingFailed:"und tschüss...",
			XWalkingSucceeded:"yeah...",
			ProfileDirectory:"ProfileDirectory: ",
			TransformerPath:"TransformerPath:\r\n ",
			StylesheetPath:"StylesheetPath:\r\n ",
			InputPath:"InputPath:\r\n ",
			OutputPath:"OutputPath:\r\n " 
		}
	}
};

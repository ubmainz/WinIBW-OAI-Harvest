<?xml version="1.0" encoding="UTF-8" ?>
<!-- 
	Stylesheet for conversion of 4204 format into PICA3 presentation data 
	model. Output to UTF8-encoded text.
	
	Copyright   Bibliotheksservice-Zentrum Baden-Wuerttemberg, 2006
	Author      Zehra Atay, Stefan Freudenberg
	Fuer GBV angepasst: Karen Hachmann
    Fuer UB Mainz angepasst: Matthias Genzmehr 2023
	Version     $Id$
 -->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://www.d-nb.de/standards/xmetadissplus/" 
    xmlns:xMetaDiss="http://www.d-nb.de/standards/xmetadissplus/" 
    xmlns:cc="http://www.d-nb.de/standards/cc/" 
    xmlns:dc="http://purl.org/dc/elements/1.1/" 
    xmlns:dcmitype="http://purl.org/dc/dcmitype/" 
    xmlns:dcterms="http://purl.org/dc/terms/" 
    xmlns:pc="http://www.d-nb.de/standards/pc/" 
    xmlns:urn="http://www.d-nb.de/standards/urn/" 
    xmlns:hdl="http://www.d-nb.de/standards/hdl/" 
    xmlns:doi="http://www.d-nb.de/standards/doi/" 
    xmlns:thesis="http://www.ndltd.org/standards/metadata/etdms/1.0/" 
    xmlns:ddb="http://www.d-nb.de/standards/ddb/" 
    xmlns:dini="http://www.d-nb.de/standards/xmetadissplus/type/" 
    xsi:schemaLocation="http://www.d-nb.de/standards/xmetadissplus/ http://www.d-nb.de/standards/xmetadissplus/xmetadissplus.xsd" 
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">

    <xsl:output method="text" indent="no" encoding="UTF-8"/>
    <xsl:strip-space elements="*"/>
    <xsl:template match="/">
        <xsl:apply-templates select="xMetaDiss:xMetaDiss/dc:type"/>
        <!--<xsl:apply-templates select="xMetaDiss:xMetaDiss/dcterms:dateAccepted"/>-->
        <xsl:apply-templates select="xMetaDiss:xMetaDiss/dcterms:issued"/>
        <xsl:apply-templates select="xMetaDiss:xMetaDiss/dcterms:created"/>
        <xsl:apply-templates select="xMetaDiss:xMetaDiss" mode="_4204"/>
        <xsl:apply-templates select="xMetaDiss:xMetaDiss/dc:language"/>
        <xsl:apply-templates select="xMetaDiss:xMetaDiss/dc:identifier"/>
		<xsl:apply-templates select="xMetaDiss:xMetaDiss/ddb:identifier" mode="_2051"/>
		<xsl:apply-templates select="xMetaDiss:xMetaDiss/ddb:identifier" mode="_2052"/>
        <xsl:apply-templates select="xMetaDiss:xMetaDiss/dc:creator/pc:person" mode="_30xx"/>
        <xsl:apply-templates select="xMetaDiss:xMetaDiss/dc:contributor" mode="_3010"/>
        <xsl:apply-templates select="xMetaDiss:xMetaDiss/thesis:degree/thesis:level" mode="_3110"/>
        <xsl:apply-templates select="xMetaDiss:xMetaDiss/dc:creator" mode="_3120"/>
        <xsl:apply-templates select="xMetaDiss:xMetaDiss/dc:contributor" mode="_3120"/>
        <xsl:apply-templates select="xMetaDiss:xMetaDiss/dc:title" mode="_4000"/>
        <xsl:apply-templates select="xMetaDiss:xMetaDiss/dcterms:extent" mode="_4060"/>
        <xsl:apply-templates select="xMetaDiss:xMetaDiss/dcterms:extent" mode="_4061"/>
        <xsl:apply-templates select="xMetaDiss:xMetaDiss/dc:source" mode="_4070"/>
		<xsl:apply-templates select="xMetaDiss:xMetaDiss/ddb:identifier" mode="_4085"/>
		<xsl:apply-templates select="xMetaDiss:xMetaDiss/dc:identifier" mode="_4085"/>
        <xsl:apply-templates select="xMetaDiss:xMetaDiss/dcterms:tableOfContents"/>
        <!--<xsl:apply-templates select="xMetaDiss:xMetaDiss/dc:thesis" mode="_4204"/>-->
        <xsl:apply-templates select="xMetaDiss:xMetaDiss/dcterms:abstract"/>
        <xsl:apply-templates select="xMetaDiss:xMetaDiss/dc:title" mode="_4213"/>
        <xsl:apply-templates select="xMetaDiss:xMetaDiss/dc:source" mode="_4241"/>
        <xsl:apply-templates select="xMetaDiss:xMetaDiss/dc:creator" mode="_4243"/>
        <xsl:apply-templates select="xMetaDiss:xMetaDiss/dcterms:isPartOf"/>
        <xsl:apply-templates select="xMetaDiss:xMetaDiss/dc:subject" mode="_5050"/>
        <xsl:apply-templates select="xMetaDiss:xMetaDiss/dc:subject" mode="_5030"/>
        <xsl:call-template name="_5045"/>
        <xsl:apply-templates select="xMetaDiss:xMetaDiss/dc:subject" mode="_5051"/>
        <xsl:apply-templates select="xMetaDiss:xMetaDiss/dc:subject" mode="_5090"/>
        <xsl:apply-templates select="xMetaDiss:xMetaDiss/dc:subject" mode="_5500"/>
        <xsl:apply-templates select="xMetaDiss:xMetaDiss/dc:subject" mode="_5510"/>
        <xsl:apply-templates select="xMetaDiss:xMetaDiss/dc:subject" mode="_5550"/>
        <xsl:apply-templates select="xMetaDiss:xMetaDiss/dc:subject" mode="_5580"/>
        <!--<xsl:apply-templates select="xMetaDiss:xMetaDiss/ddb:identifier" mode="_7133"/>-->
		<xsl:apply-templates select="xMetaDiss:xMetaDiss/ddb:licence" mode="_422x"/>
    </xsl:template>
  
    <xsl:template match="dc:type">
        <xsl:if test="@xsi:type='dini:PublType'">
           <xsl:choose>
                <xsl:when test="../dc:type/.='article' or ../dc:type/.='bookPart' or ../dc:type/.='preprint' or ../dc:type/.='review' or ../dc:type/.='contributionToPeriodical'">
                    <xsl:text>0500 Oou &#xA;</xsl:text>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:text>0500 Oau</xsl:text>
                   <xsl:text>&#xA;</xsl:text>
                   <xsl:apply-templates select="../dc:publisher" mode="_4030"/>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:text>&#xA;</xsl:text>
            <xsl:text>0501 Text$btxt$2rdacontent&#xA;</xsl:text>
            <xsl:text>0502 Computermedien$bc$2rdamedia&#xA;</xsl:text>
            <xsl:text>0503 Online-Ressource$bcr$2rdacarrier&#xA;</xsl:text>
			<xsl:text>1505 $erda&#xA;</xsl:text>
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="dcterms:issued|dcterms:created">
        <xsl:text>1100 </xsl:text>
        <xsl:value-of select="substring(., 0, 5)"/>
        <xsl:text>&#xA;</xsl:text>
    </xsl:template>
    
    <xsl:template match="xMetaDiss:xMetaDiss" mode="_4204">
            <xsl:if test="contains(dc:type, 'Thesis')">
            <xsl:text>1131 !085338818!</xsl:text>
			<xsl:text>&#xA;</xsl:text>  
			
			<xsl:text>4204 </xsl:text>
                <xsl:text>$d</xsl:text>
                <xsl:choose>
                    <xsl:when test="dc:type='doctoralThesis'">
					    <xsl:if test="contains(thesis:degree/thesis:level, 'doctoral')">
						<xsl:text>Dissertation</xsl:text>
                        </xsl:if>
						<xsl:if test="contains(thesis:degree/thesis:level, 'habilitation')">
						<xsl:text>Habilitationsschrift</xsl:text>
                        </xsl:if>
                    </xsl:when>
					<xsl:when test="dc:type='StudyThesis'">
                        <xsl:text>Studienarbeit</xsl:text>
                    </xsl:when>
                    <xsl:when test="dc:type='bachelorThesis'">
                        <xsl:text>Bachelorarbeit</xsl:text>
                    </xsl:when>
                    <xsl:when test="dc:type/.='masterThesis'">
                        <xsl:if test="contains(thesis:degree/thesis:level, 'M.A.')">
						<xsl:text>Magisterarbeit</xsl:text>
                        </xsl:if>
                        <xsl:if test="contains(thesis:degree/thesis:level, 'master')">
						<xsl:text>Masterarbeit</xsl:text>
                        </xsl:if>
						  <xsl:if test="contains(thesis:degree/thesis:level, 'Diplom')">
						<xsl:text>Diplomarbeit</xsl:text>
                        </xsl:if>
                    </xsl:when>
                    <xsl:when test="dc:type/.='ElectronicThesisandDissertation'">
                        <xsl:text>Dissertation</xsl:text>
                    </xsl:when>
                    <xsl:when test="dc:type/.='habilitationThesis'">
                        <xsl:text>Habilitationsschrift</xsl:text>
                    </xsl:when>
                </xsl:choose>
				<xsl:text>$e</xsl:text>
                <xsl:value-of select="thesis:degree/thesis:grantor/cc:universityOrInstitution/cc:name"/>
				<xsl:text>$f</xsl:text>
				<xsl:value-of select="substring(dcterms:issued, 0, 5)"/>
                <xsl:text>&#xA;</xsl:text>
        </xsl:if>
    </xsl:template>

	<xsl:template match="ddb:licence" mode="_422x">
		<xsl:if test="@ddb:licenceType='cc'">
			<xsl:if test=".='CC BY'">
				<xsl:text>4228 Namensnennung 4.0 International$fCC BY 4.0$uhttps://creativecommons.org/licenses/by/4.0/$qDE-77$2cc</xsl:text>
			</xsl:if>
			<xsl:if test=".='CC BY-SA'">
				<xsl:text>4228 Namensnennung - Weitergabe unter gleichen Bedingungen 4.0 International$fCC BY-SA 4.0$uhttps://creativecommons.org/licenses/by-sa/4.0/$qDE-77$2cc</xsl:text>
			</xsl:if>
			<xsl:if test=".='CC BY-NC'">
				<xsl:text>4228 Namensnennung - Nicht kommerziell 4.0 International$fCC BY-NC 4.0$uhttps://creativecommons.org/licenses/by-nc/4.0/$qDE-77$2cc</xsl:text>
			</xsl:if>
			<xsl:if test=".='CC BY-ND'">
				<xsl:text>4228 Namensnennung - Keine Bearbeitungen 4.0 International$fCC BY-ND 4.0$uhttps://creativecommons.org/licenses/by-nd/4.0/$qDE-77$2cc</xsl:text>
			</xsl:if>
			<xsl:if test=".='CC BY-NC-SA'">
				<xsl:text>4228 Namensnennung - Nicht kommerziell - Weitergabe unter gleichen Bedingungen 4.0 International$fCC BY-​NC-SA 4.0$uhttps://creativecommons.org/licenses/by-​nc-sa/4.0/$qDE-77$2cc</xsl:text>
			</xsl:if>
			<xsl:if test=".='CC BY-NC-ND'">
				<xsl:text>4228 Namensnennung - Nicht kommerziell - Keine Bearbeitungen 4.0 International$fCC BY-​NC-ND 4.0$uhttps://creativecommons.org/licenses/by-​nc-nd/4.0/$qDE-77$2cc</xsl:text>
			</xsl:if>
			<xsl:text>&#xA;</xsl:text>
		</xsl:if>

		<xsl:if test="@ddb:licenceType='otherScheme'">
			<xsl:text>4228 </xsl:text>
			<xsl:if test=".='in Copyright'">
				<xsl:text>Urheberrechtsschutz 1.0$uhttps://rightsstatements.org/vocab/InC/1.0/$qDE-77$2rs</xsl:text>
			</xsl:if>
			<xsl:if test=".='InCopyright'">
				<xsl:text>Urheberrechtsschutz 1.0$uhttps://rightsstatements.org/vocab/InC/1.0/$qDE-77$2rs</xsl:text>
			</xsl:if>
			<xsl:text>&#xA;</xsl:text>
	    </xsl:if>

		<xsl:if test="@ddb:licenceType='access'">
            <xsl:if test=".='OA'">
				<xsl:text>4229 </xsl:text>
                <xsl:text>Open Access$fUnrestricted online access$uhttps://purl.org/coar/access_right/c_abf2$qDE-77$2star</xsl:text>
				<xsl:text>&#xA;</xsl:text>
            </xsl:if>
			<xsl:if test=".='nOA'">
				<xsl:text>4229 </xsl:text>
                <xsl:text>Kein Open Access$fOnline access with authorization$uhttps://purl.org/coar/access_right/c_16ec$qDE-77$2star</xsl:text>
				<xsl:text>&#xA;</xsl:text>
            </xsl:if>
        </xsl:if>
    </xsl:template>

    <xsl:template match="dc:language">
        <xsl:if test="not(preceding-sibling::node()[name()='dc:language'])">
            <xsl:text>1500 /1</xsl:text>
        </xsl:if>
        <xsl:value-of select="."/>
        <xsl:choose>
            <xsl:when test="following-sibling::node()[name()='dc:language']">
                <xsl:text>/1</xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>&#xA;</xsl:text>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
	
    <xsl:template match="dc:identifier">
        <xsl:if test="@xsi:type='urn:nbn'">
            <xsl:text>2050 </xsl:text>
            <xsl:value-of select="."/>
            <xsl:text>&#xA;</xsl:text>
        </xsl:if>
	</xsl:template>
	<xsl:template match="ddb:identifier" mode="_2051">
		<xsl:if test="@ddb:type='DOI'">
            <xsl:text>2051 ##0##</xsl:text>
            <xsl:value-of select="substring-after(., 'doi.org/')"/>
            <xsl:text>&#xA;</xsl:text>
        </xsl:if>
	</xsl:template>

    <xsl:template match="dc:creator/pc:person" mode="_30xx">
            <xsl:text>30</xsl:text>
            <xsl:choose>
                <xsl:when test="position()=1">
                    <xsl:text>00</xsl:text>
                </xsl:when>
         
				 <xsl:otherwise>
                    <xsl:text>10</xsl:text>
                </xsl:otherwise>
				
            </xsl:choose>
            <xsl:text> </xsl:text>
            <xsl:apply-templates select="./pc:name"/>
            <xsl:text>$BVerfasser$4aut###</xsl:text>
    </xsl:template>
    
    <xsl:template match="dc:contributor" mode="_3010">
        <xsl:if test="@xsi:type='pc:MetaPers' and not(@thesis:role)">
            <xsl:choose>
                <xsl:when test=".//pc:name/@type='nameUsedByThePerson'">
                    <xsl:text>3010 </xsl:text>
                    <xsl:apply-templates select=".//pc:name"/>
                    <xsl:text>###</xsl:text>
                </xsl:when>
                <xsl:when test=".//pc:name/@type='otherName'">
                    <xsl:text>8910 $c</xsl:text>
                    <xsl:apply-templates select=".//pc:name"/>
                    <xsl:text>&#xA;</xsl:text>
                </xsl:when>
            </xsl:choose>
        </xsl:if>
        
        <xsl:if test="@thesis:role='advisor'">
            <xsl:choose>
                <xsl:when test=".//pc:name/@type='nameUsedByThePerson'">
                    <xsl:text>3010 </xsl:text>
                    <xsl:apply-templates select=".//pc:name"/>
                    <xsl:text>$BAkademischer Betreuer$4dgs###</xsl:text>
                </xsl:when>
            </xsl:choose>
        </xsl:if>
    </xsl:template>
   
    <xsl:template match="thesis:degree/thesis:level" mode="_3110">
        <xsl:if test=".='thesis.doctoral'">
            <xsl:text>3110 !042777143!$BGrad-verleihende Institution$4dgg</xsl:text>
        </xsl:if>
    </xsl:template> 
    
    <xsl:template match="dc:creator|dc:contributor" mode="_3120">
        <xsl:if test="not(@xsi:type='pc:MetaPers' or @xsi:type='pc:Contributor')">
            <xsl:text>3120 </xsl:text>
            <xsl:apply-templates/>
            <xsl:text>&#xA;</xsl:text>
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="dc:title" mode="_4000">
        <xsl:if test="not(@ddb:type='translated')">
            <xsl:text>&#xA;4000 </xsl:text>
            <xsl:call-template name="non-sorting-articles">
                <xsl:with-param name="title">
				<xsl:if test="not(contains(., ' : '))">
				<xsl:value-of select="normalize-space(.)"/>
				</xsl:if>
				<xsl:if test="contains(., ' : ')">
					<xsl:value-of select="substring-before(., ' : ')"/>
					<xsl:text> : </xsl:text>
					<xsl:value-of select="substring-after(., ' : ')"/>
                 </xsl:if>
				
                </xsl:with-param>
			 </xsl:call-template>
			
            <xsl:text></xsl:text>
            <xsl:if test="../dcterms:alternative[not(@ddb:type='translated')]">
                <xsl:text> : </xsl:text>
                <xsl:value-of
                    select="normalize-space(../dcterms:alternative[not(@ddb:type='translated')])"/>
            </xsl:if>
			
            <xsl:if test="../dc:creator/pc:person">
				<xsl:text> / </xsl:text>
			</xsl:if> 
			
            <xsl:for-each select="../dc:creator">
                <xsl:choose>
                    <xsl:when test="@xsi:type='pc:MetaPers'">
                        <xsl:choose>
                            <xsl:when test="pc:person/pc:name/pc:personEnteredUnderGivenName">
                                <xsl:value-of
                                    select="pc:person/pc:name/pc:personEnteredUnderGivenName"/>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:value-of select="pc:person/pc:name/pc:foreName"/>
                                <xsl:text> </xsl:text>
                                <xsl:value-of select="pc:person/pc:name/pc:surName"/>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="."/>
                    </xsl:otherwise>
                </xsl:choose>
                <xsl:if test="position()!=last()">
                    <xsl:text>, </xsl:text>
                </xsl:if>
            </xsl:for-each>
            
            <xsl:for-each select="../dc:contributor">
                <xsl:if test="../dc:contributor/@thesis:role='advisor'">
                    <xsl:choose>
                        <xsl:when test="position()=1">
                            <xsl:text> ; Betreuer: </xsl:text>
                            <xsl:value-of select="../dc:contributor/pc:person/pc:name/pc:surName"/>
                            <xsl:text> </xsl:text>
                            <xsl:value-of select="../dc:contributor/pc:person/pc:name/pc:foreName"/>
                        </xsl:when>
                        <xsl:when test="not(position()=1)">
                            <xsl:text>, </xsl:text>
                            <xsl:value-of select="../dc:contributor/pc:person/pc:name/pc:surName"/>
                            <xsl:text> </xsl:text>
                            <xsl:value-of select="../dc:contributor/pc:person/pc:name/pc:foreName"/>
                        </xsl:when>
                    </xsl:choose>
                </xsl:if>
            </xsl:for-each>
            
            <xsl:text>&#xA;</xsl:text>
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="dc:publisher" mode="_4030">
        <xsl:if test="@xsi:type='cc:Publisher'">
            <xsl:text>4030 </xsl:text>
            <xsl:for-each select="cc:universityOrInstitution/cc:place">
                <xsl:value-of select="."/>
                <xsl:if test="position()!=last()">
                    <xsl:text>; </xsl:text>
                </xsl:if>
            </xsl:for-each>
            <xsl:if test="not(contains(../dc:type, 'Thesis'))">
                <xsl:text> : </xsl:text>
                <xsl:value-of select="cc:universityOrInstitution/cc:name"/>
            </xsl:if>
            <xsl:text>&#xA;</xsl:text>
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="dcterms:extent" mode="_4060">
        <xsl:if test=".!=''">
            <xsl:choose>
                <xsl:when test="contains(., ' ; ')">
                    <xsl:text>4060 1 Online-Ressource (</xsl:text>
                    <xsl:value-of select="substring-before(., ' ; ')"/>
                    <xsl:text>)&#xA;</xsl:text>
                </xsl:when>
                <xsl:when test="not(contains(., ' ; '))">
                    <xsl:text>4060 1 Online-Ressource (</xsl:text>
                    <xsl:value-of select="."/>
                    <xsl:text>)&#xA;</xsl:text>
                </xsl:when>
            </xsl:choose>
        </xsl:if>
	</xsl:template>
    
    <xsl:template match="dcterms:extent" mode="_4061">
        <xsl:if test="contains(., '; ')">
            <xsl:text>4061 </xsl:text>
            <xsl:value-of select="substring-after(., '; ')"/>
            <xsl:text>&#xA;</xsl:text>
        </xsl:if>
	</xsl:template>
    
    <xsl:template match="dc:source" mode="_4070">
        <xsl:text>4070 </xsl:text>
        <xsl:value-of select="."/>
        <xsl:text>&#xA;</xsl:text>
	</xsl:template>
    
    <xsl:template match="ddb:identifier" mode="_4085">
		<xsl:if test="@ddb:type='DOI'">
            <xsl:text>4085 </xsl:text>
			<xsl:text>=u </xsl:text>
            <xsl:value-of select="."/>
			<xsl:text>=x R</xsl:text>
            <xsl:text>&#xA;</xsl:text>
        </xsl:if>
        <xsl:if test="@ddb:type='URL'">
            <xsl:text>4085 </xsl:text>
            <xsl:if test="starts-with(., 'https://openscience.ub.uni-mainz.de')">
                <xsl:text>##0##</xsl:text>
            </xsl:if>
			<xsl:text>=u </xsl:text>
            <xsl:value-of select="."/>
			<xsl:text>=x H</xsl:text>
            <xsl:text>&#xA;</xsl:text>
        </xsl:if>
    </xsl:template>
	
	<xsl:template match="dc:identifier" mode="_4085">
		<xsl:if test="@xsi:type='urn:nbn'">
            <xsl:text>4085 </xsl:text>
			<xsl:text>=u </xsl:text>
            <xsl:value-of select="concat('https://nbn-resolving.org/',.)"/>		
			<xsl:text>=x R</xsl:text>
            <xsl:text>&#xA;</xsl:text>
        </xsl:if>
	</xsl:template>
	
    <xsl:template match="dcterms:tableOfContents">
        <xsl:choose>
            <xsl:when test="@ddb:type='dcterms:URI'">
                <xsl:text>4089 </xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>4207 </xsl:text>
            </xsl:otherwise>
        </xsl:choose>
        
        <xsl:if test="@ddb:type='noScheme'">
            <xsl:value-of select="."/>
        </xsl:if>
        
        <xsl:if test="@xsi:type='ddb:contentISO6392'">
            <xsl:text>. </xsl:text>
            <xsl:value-of select="@lang"/>
        </xsl:if>
        
        <xsl:text> Inhaltsverzeichnis</xsl:text>
        <xsl:if test="@ddb:type='dcterms:URI'">
            <xsl:text>. </xsl:text>
            <xsl:value-of select="."/>
            <xsl:text> Inhaltsverzeichnis</xsl:text>
        </xsl:if>
        <xsl:text>&#xA;</xsl:text>
    </xsl:template>
    
    <xsl:template match="thesis:degree" mode="_4204">
        <xsl:text>4204 </xsl:text>
        <xsl:text>$d</xsl:text>
        
        <xsl:choose>
            <xsl:when test=".='doctoralThesis'">
                <xsl:text>Dissertation</xsl:text>
            </xsl:when>
            <xsl:when test=".='StudyThesis'">
                <xsl:text>Studienarbeit</xsl:text>
            </xsl:when>
            <xsl:when test="thesis:level/.='bachelor'">
                <xsl:text>Bachelorarbeit</xsl:text>
            </xsl:when>
            <xsl:when test="../dc:type/.='masterThesis'">    
                <xsl:text>Magisterarbeit</xsl:text>
            </xsl:when>
            <xsl:when test="../dc:type/.='ElectronicThesisandDissertation'">
                <xsl:text>Dissertation</xsl:text>
            </xsl:when>
            <xsl:when test="../dc:type/.='habilitationThesis'">
                <xsl:text>Habilitationsschrift</xsl:text>
            </xsl:when>
        </xsl:choose>
        
        <xsl:text>$e</xsl:text>
        <xsl:value-of select="cc:universityOrInstitution/cc:name"/>
        <xsl:value-of select="cc:universityOrInstitution/cc:place"/>
       
        <xsl:text>$f</xsl:text>
        <xsl:value-of select="substring(../dcterms:issued, 0, 5)"/>
        <xsl:text>&#xA;</xsl:text>
    </xsl:template>
    
    <xsl:template match="dcterms:abstract">
        <xsl:choose>
            <xsl:when test="@ddb:type='dcterms:URI'">
                <xsl:text>4089 </xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>4207 </xsl:text>
            </xsl:otherwise>
        </xsl:choose>
        <xsl:if test="@ddb:type='noScheme'">
            <xsl:apply-templates select="text()"/>
        </xsl:if>
        <xsl:text>&#xA;</xsl:text> 
    </xsl:template>
    
    <xsl:template match="dcterms:isPartOf">
    </xsl:template>
    
    <xsl:template match="dc:title" mode="_4213">
        <xsl:if test="@ddb:type='translated'">
            <xsl:text>4213 Übers. des Hauptsacht.: </xsl:text>
            <xsl:apply-templates select="text()"/>
            <xsl:if test="../dcterms:alternative[@ddb:type='translated']">
                <xsl:text> : </xsl:text>
                <xsl:value-of
                    select="normalize-space(../dcterms:alternative[@ddb:type='translated'])"/>
            </xsl:if>
            <xsl:text>&#xA;</xsl:text>
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="dc:source" mode="_4241">
        <xsl:text>4241 </xsl:text>
        <xsl:value-of select="substring-before(., '. ')"/>
        <xsl:text>&#xA;</xsl:text>
    </xsl:template>
    
    <xsl:template match="dc:creator" mode="_4243">
        <xsl:if test="../thesis:degree/thesis:level='thesis.doctoral'">
            <xsl:choose>
                <xsl:when test="position()=1">
                    <xsl:text>4243 Erscheint auch als$nDruck-Ausgabe$l</xsl:text>
                    <xsl:value-of select="./pc:person/pc:name/pc:surName"/>
                    <xsl:text>, </xsl:text>
                    <xsl:value-of select="./pc:person/pc:name/pc:foreName"/>
                    <xsl:text>$t</xsl:text>
                    <xsl:if test="not(contains(../dc:title, ' : '))">
                        <xsl:value-of select="../dc:title"/>
                    </xsl:if>
                    <xsl:if test="contains(../dc:title, ' : ')">
                        <xsl:value-of select="substring-before(../dc:title, ' : ')"/>
                    </xsl:if>
                    <xsl:text>$f</xsl:text>
                    <xsl:value-of select="../dcterms:issued"/>
                    <xsl:text>&#xA;</xsl:text>
                </xsl:when>
            </xsl:choose>
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="xMetaDiss:xMetaDiss" mode="_4700">
        <xsl:text>4700 --- Metadaten ---: </xsl:text>
        <xsl:apply-templates select="." mode="copy"/>
        <xsl:text>&#xA;</xsl:text>
    </xsl:template>
    
    <xsl:template match="dc:subject" mode="_5050">
        <xsl:if test="@xsi:type='xMetaDiss:DDC-SG'">
            <xsl:text>5050 |</xsl:text>
            <xsl:value-of select="substring(., 0, 3)"/>
            <xsl:text>0&#xA;</xsl:text>
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="dc:subject" mode="_5030">
        <xsl:if test="@xsi:type='dcterms:LCC'">
            <xsl:text>5030 </xsl:text>
            <xsl:apply-templates select="text()"/>
            <xsl:text>&#xA;</xsl:text>
        </xsl:if>
    </xsl:template>
    
    <xsl:template name="_5045">
        <xsl:for-each select="/xMetaDiss:xMetaDiss/dc:subject[starts-with(@xsi:type, 'MSC')]">
            <xsl:if test="position()=1">
                <xsl:text>5045 </xsl:text>
            </xsl:if>
            <xsl:apply-templates select="text()"/>
            <xsl:choose>
                <xsl:when test="position()!=last()">
                    <xsl:text>; </xsl:text>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:text>&#xA;</xsl:text>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template match="dc:subject" mode="_5051">
        <xsl:if test="@xsi:type='DDC-SG'">
            <xsl:text>5051 </xsl:text>
            <xsl:apply-templates select="text()"/>
            <xsl:text>&#xA;</xsl:text>
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="dc:subject" mode="_5090">
        <xsl:if test="@xsi:type='RVK'">
            <xsl:text>5090 </xsl:text>
            <xsl:apply-templates select="text()"/>
            <xsl:text>&#xA;</xsl:text>
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="dc:subject" mode="_5500">
        <xsl:if test="@xsi:type='dcterms:LCSH'">
            <xsl:text>5500 </xsl:text>
            <xsl:apply-templates select="text()"/>
            <xsl:text>&#xA;</xsl:text>
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="dc:subject" mode="_5510">
        <xsl:if test="@xsi:type='dcterms:MESH'">
            <xsl:text>5510 </xsl:text>
            <xsl:apply-templates select="text()"/>
            <xsl:text>&#xA;</xsl:text>
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="dc:subject" mode="_5550">
        <xsl:if test="@xsi:type='SWD'">
            <xsl:text>5550 </xsl:text>
            <xsl:apply-templates select="text()"/>
            <xsl:text>-Q--Opus&#xA;</xsl:text>
            <xsl:if test="not(following-sibling::node()[@xsi:type='SWD'])">
                <xsl:text>5550 !248012134!</xsl:text>
                <xsl:text>&#xA;</xsl:text>
            </xsl:if>
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="dc:subject" mode="_5580">
        <xsl:if test="@xsi:type='noScheme'">
            <xsl:text>5580 </xsl:text>
            <xsl:apply-templates select="text()"/>
            <xsl:text>-Q--Opus&#xA;</xsl:text>
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="ddb:identifier" mode="_7133"> 
        <xsl:if test="@ddb:type='URL'">
            <xsl:text>7133 </xsl:text>
            <xsl:text> =A </xsl:text> 
            <xsl:value-of select="."/>
            <xsl:if test="../ddb:rights/@ddb:kind='free'"> 
            <xsl:text> =4 LF</xsl:text>
        </xsl:if> <xsl:text>&#xA;</xsl:text> </xsl:if> 
    </xsl:template>
    
    <xsl:template match="pc:name">
        <xsl:if test="pc:personEnteredUnderGivenName!=''">
            <xsl:text>@</xsl:text>
            <xsl:value-of select="pc:personEnteredUnderGivenName"/>
            <xsl:text>"</xsl:text>
        </xsl:if>
        <xsl:if test="pc:surName!=''">
            <xsl:value-of select="pc:surName"/>
			<xsl:text>, </xsl:text>
			<xsl:value-of select="pc:foreName"/>
        </xsl:if>
        <xsl:if test="pc:prefix!=''">
            <xsl:text> /</xsl:text>
            <xsl:value-of select="pc:prefix"/>
        </xsl:if>
        <xsl:if test="pc:titleOfNobility!=''">
            <xsl:text> [</xsl:text>
            <xsl:value-of select="pc:titleOfNobility"/>
            <xsl:text>]</xsl:text>
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="*" mode="copy">
        <xsl:text><![CDATA[<]]></xsl:text>
        <xsl:value-of select="name()"/>
        <xsl:if test="local-name()='xMetaDiss:xMetaDiss'">
            <xsl:for-each select="namespace::node()">
                <xsl:text> xmlns</xsl:text>
                <xsl:if test="string(.)!='http://www.bsz-bw.de/xmetadissplus/1.3'">
                    <xsl:text>:</xsl:text>
                </xsl:if>
                <xsl:value-of select="name()"/>
                <xsl:text>="</xsl:text>
                <xsl:value-of select="."/>
                <xsl:text>"</xsl:text>
            </xsl:for-each>
        </xsl:if>
        <xsl:for-each select="attribute::node()">
            <xsl:text> </xsl:text>
            <xsl:value-of select="name()"/>
            <xsl:text>="</xsl:text>
            <xsl:value-of select="normalize-space(.)"/>
            <xsl:text>"</xsl:text>
        </xsl:for-each>
        <xsl:text><![CDATA[>]]></xsl:text>
        <xsl:value-of select="normalize-space(text())"/>
        <xsl:apply-templates select="*" mode="copy"/>
        <xsl:text><![CDATA[</]]></xsl:text>
        <xsl:value-of select="name()"/>
        <xsl:text><![CDATA[>]]></xsl:text>
    </xsl:template>
    
    <xsl:template match="text()">
        <xsl:value-of select="normalize-space(.)"/>
    </xsl:template>
    
    <xsl:template name="non-sorting-articles">
        <xsl:param name="title"/>
        <xsl:variable name="article" select="substring-before($title, ' ')"/>
        <xsl:choose>
            <xsl:when
                test="$article=&quot;De&quot; or $article=&quot;Den&quot; or $article=&quot;Det&quot; or
                $article=&quot;En&quot; or $article=&quot;Et&quot; or $article=&quot;Das&quot; or $article=&quot;Dem&quot; or 
                $article=&quot;Den&quot; or $article=&quot;Der&quot; or $article=&quot;Des&quot; or 
                $article=&quot;Die&quot; or $article=&quot;Ein&quot; or $article=&quot;Eine&quot; or 
                $article=&quot;Einem&quot; or $article=&quot;Einen&quot; or $article=&quot;Einer&quot; or
                $article=&quot;The&quot; or $article=&quot;A&quot; or $article=&quot;An&quot; or 
                $article=&quot;L&apos;&quot; or $article=&quot;La&quot; or $article=&quot;Le&quot; or 
                $article=&quot;Les&quot; or $article=&quot;Un&quot; or $article=&quot;Une&quot; or 
                $article=&quot;Gli&quot; or $article=&quot;I&quot; or $article=&quot;Il&quot; or 
                $article=&quot;L&apos;&quot; or $article=&quot;La&quot; or $article=&quot;Le&quot; or 
                $article=&quot;Li&quot; or $article=&quot;Lo&quot; or $article=&quot;Un&quot; or 
                $article=&quot;Un&apos;&quot; or $article=&quot;Una&quot; or $article=&quot;Uno&quot; or 
                $article=&quot;D&apos;&quot; or $article=&quot;De&quot; or $article=&quot;Den&quot; or 
                $article=&quot;Der&quot; or $article=&quot;Des&quot; or $article=&quot;Het&quot; or 
                $article=&quot;&apos;S&quot; or $article=&quot;&apos;T&quot; or $article=&quot;Een&quot; or 
                $article=&quot;Eene&quot; or $article=&quot;Eener&quot; or $article=&quot;Eens&quot; or 
                $article=&quot;Ene&quot; or $article=&quot;&apos;N&quot; or $article=&quot;De&quot; or 
                $article=&quot;Den&quot; or $article=&quot;Det&quot; or $article=&quot;Ei&quot; or $article=&quot;En&quot; or
                $article=&quot;Et&quot; or $article=&quot;A&quot; or $article=&quot;As&quot; or $article=&quot;O&quot; or
                $article=&quot;Os&quot; or $article=&quot;Um&quot; or $article=&quot;Uma&quot; or 
                $article=&quot;Umas&quot; or  $article=&quot;Uns&quot; or $article=&quot;De&quot; or 
                $article=&quot;Den&quot; or $article=&quot;Det&quot; or $article=&quot;En&quot; or 
                $article=&quot;Ett&quot; or $article=&quot;El&quot; or $article=&quot;La&quot; or $article=&quot;Las&quot; or 
                $article=&quot;Lo&quot; or $article=&quot;Los&quot; or $article=&quot;Un&quot; or $article=&quot;Una&quot; or
                $article=&quot;Unas&quot; or $article=&quot;Unos&quot; or $article=&quot;A&quot; or 
                $article=&quot;Az&quot; or $article=&quot;Egy&quot;">
                <xsl:value-of select="$article"/>
                <xsl:text> @</xsl:text>
                <xsl:value-of select="substring-after($title, ' ')"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$title"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
</xsl:stylesheet>

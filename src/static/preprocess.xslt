<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xmlns:r="urn:net.yxney.boligselskapsregler" xmlns="urn:net.yxney.boligselskapsregler"
    xsi:schemaLocation="urn:net.yxney.boligselskapsregler ..\boligselskapsregler.xsd" exclude-result-prefixes="r" version="2.0">

    <xsl:param name="outfilename" required="yes"/>
    <xsl:param name="outdirectory" required="yes"/>

    <xsl:preserve-space elements="*"/>
    <!-- <xsl:strip-space elements="*" /> -->
    <xsl:output method="xml" indent="no" encoding="utf-8" omit-xml-declaration="yes"/>

    <xsl:template match="/r:regelsett/r:versjoner/r:versjon">
        <xsl:variable name="versjon" select="@gyldig-fra"/>
        <xsl:variable name="dokumentId" select="@dokument-id"/>
        <xsl:message>
            <xsl:value-of select="$outfilename"/>
            <xsl:value-of select="$outdirectory"/>
        </xsl:message>
        <xsl:message><xsl:text>Fant versjon: </xsl:text><xsl:value-of
                select="$versjon"/></xsl:message>
                <xsl:message><xsl:text>Fant dokumentId: </xsl:text><xsl:value-of select="@dokument-id"/></xsl:message>
        <xsl:result-document
            href="{$outdirectory}/{$outfilename}-{$versjon}.xml" method="xml" omit-xml-declaration="yes" validation="lax">
            <xsl:apply-templates select="/" mode="file">
                <xsl:with-param name="versjon" select="$versjon"/>
            </xsl:apply-templates>
        </xsl:result-document>
    </xsl:template>

    <xsl:template match="@* | node() | comment()" mode="file">
        <xsl:copy>
            <xsl:apply-templates select="@* | node() " mode="file"/>
        </xsl:copy>
    </xsl:template>

    <!-- <xsl:template match="@*" mode="file">
        <xsl:copy>
            <xsl:apply-templates select="@*" mode="file"/>
        </xsl:copy>
    </xsl:template>

    <xsl:template match="node()" mode="file">
        <xsl:param name="versjon"/>
        <xsl:copy>
            <xsl:comment>VERSJON: $versjon</xsl:comment>
            <xsl:apply-templates select="@*" mode="file">
                <xsl:with-param name="versjon" select="$versjon"/>
            </xsl:apply-templates>
        </xsl:copy>
    </xsl:template> -->

</xsl:stylesheet>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xmlns:r="urn:net.yxney.boligselskapsregler" xmlns="urn:net.yxney.boligselskapsregler"
    xsi:schemaLocation="urn:net.yxney.boligselskapsregler ..\boligselskapsregler.xsd" exclude-result-prefixes="r" version="2.0">

    <xsl:preserve-space elements="*"/>
    <!-- <xsl:strip-space elements="*" /> -->
    <xsl:output method="xml" indent="no" encoding="utf-8" omit-xml-declaration="yes"/>

    <xsl:template match="/r:dokument">
        <xsl:apply-templates select="@* | node()"/>
    </xsl:template>

    <xsl:template match="@* | node() | comment()">
        <xsl:copy>
            <xsl:apply-templates select="@* | node() "/>
        </xsl:copy>
    </xsl:template>

    <xsl:template match="r:paragraf">
        <xsl:apply-templates select="r:p" mode="paragraf"/>
    </xsl:template>

</xsl:stylesheet>
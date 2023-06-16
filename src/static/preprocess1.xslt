<!--java.exe -jar ..\lib\saxon-he-12.2.jar -s:vedtekter.xml -xsl:.\preprocess1.xslt -o:output/vedtekter.xml -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xmlns:r="urn:net.yxney.boligselskapsregler" xmlns="urn:net.yxney.boligselskapsregler"
    xsi:schemaLocation="urn:net.yxney.boligselskapsregler ..\boligselskapsregler.xsd" exclude-result-prefixes="r" version="2.0">

    <xsl:preserve-space elements="*"/>
    <!-- <xsl:strip-space elements="*" /> -->
    <xsl:output method="xml" indent="no" encoding="utf-8" omit-xml-declaration="yes"/>

    <xsl:template match="r:dokument|r:paragraf|r:kapittel|r:ledd|r:ledd-p|r:punktliste|r:punkt|r:punkt-p">
        <xsl:param name="gyldig-fra" select="if (@gyldig-fra) then @gyldig-fra else '1900-01-01'"/>
        <xsl:param name="gyldig-til" select="if (@gyldig-til) then @gyldig-til else '9999-12-31'"/>
        <xsl:copy>
            <xsl:attribute name="gyldig-fra" select="$gyldig-fra"/>
            <xsl:attribute name="gyldig-til" select="$gyldig-til"/>
            <xsl:apply-templates
                select="@* | node() ">
                <xsl:with-param name="gyldig-fra" select="$gyldig-fra"/>
                <xsl:with-param name="gyldig-til" select="$gyldig-til"/>
            </xsl:apply-templates>
        </xsl:copy>
    </xsl:template>

    <xsl:template match="@* | node() | comment()">
        <xsl:copy>
            <xsl:apply-templates select="@* | node() "/>
        </xsl:copy>
    </xsl:template>

    <!-- <xsl:template match="@*" mode="file"> <xsl:copy> <xsl:apply-templates select="@*" mode="file"/> </xsl:copy> </xsl:template>
    <xsl:template match="node()" mode="file"> <xsl:param name="versjon"/> <xsl:copy> <xsl:comment>VERSJON: $versjon</xsl:comment>
    <xsl:apply-templates select="@*" mode="file"> <xsl:with-param name="versjon" select="$versjon"/> </xsl:apply-templates> </xsl:copy>
    </xsl:template> -->

</xsl:stylesheet>
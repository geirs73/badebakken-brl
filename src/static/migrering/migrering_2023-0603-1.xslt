<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
                xmlns:s="urn:no.badebakken.regelsett"
                xmlns="urn:no.badebakken.regelsett"
                exclude-result-prefixes="#all"
                expand-text="yes"
                version="3.0"
                xsi:schemaLocation="urn:no.badebakken.regelsett ../schema/boligselskapsregler.xsd"
    >
    <!--
         xmlns:map="http://www.w3.org/2005/xpath-functions/map"
         xmlns:math="http://www.w3.org/2005/xpath-functions/math"
         xmlns:array="http://www.w3.org/2005/xpath-functions/array"

         xmlns:xs="http://www.w3.org/2001/XMLSchema"

    -->


    <xsl:output method="xml" indent="yes" />
    <xsl:mode on-no-match="shallow-copy"/>

    <xsl:template match="/*" mode="#all">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()"/>
        </xsl:copy>
    </xsl:template>

    <xsl:template match="s:paragraf">
        <parregraf>
            <xsl:apply-templates select="@*|node()" />
        </parregraf>
    </xsl:template>



</xsl:stylesheet>
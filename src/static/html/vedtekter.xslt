<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xmlns:r="urn:net.yxney.boligselskapsregler" xmlns="http://www.w3.org/1999/xhtml"
    xsi:schemaLocation="urn:net.yxney.boligselskapsregler ..\boligselskapsregler.xsd
                        http://www.w3.org/1999/XSL/Transform https://www.w3.org/2007/schema-for-xslt20.xsd
                        http://www.w3.org/1999/xhtml https://www.w3.org/MarkUp/SCHEMA/xhtml11.xsd"
    exclude-result-prefixes="r xsi" version="2.0">
    <xsl:preserve-space elements="*"/>
    <!-- <xsl:strip-space elements="*" /> -->
    <xsl:output method="html" indent="yes" encoding="utf-8" omit-xml-declaration="yes"/>

    <!-- <xsl:variable name="rot" select="/r:dokument"/> -->
    <!-- <xsl:variable name="versjoner" select="/r:dokument/r:versjoner"/> -->

    <!-- <xsl:template match="$rot"> <xsl:apply-templates select="@* | node()"/> </xsl:template> <xsl:template match="@* | node() |
    comment()"> <xsl:copy> <xsl:apply-templates select="@* | node() "/> </xsl:copy> </xsl:template> -->

    <!-- rot-node -->
    <xsl:template match="/r:regelsett">
        <xsl:apply-templates select="r:versjoner"/>
    </xsl:template>
    <xsl:template match="r:versjon">
        <xsl:variable name="versjon" select="@ikrafttredelse"/>
        <xsl:variable name="dokumentId" select="@dokument-id"/>

        <xsl:message><xsl:text>Fant versjon: </xsl:text><xsl:value-of
                select="@ikrafttredelse"/></xsl:message>
                <xsl:message><xsl:text>Fant dokumentId: </xsl:text><xsl:value-of select="@dokument-id"/></xsl:message>
        <xsl:result-document
            href="../output/html/vedtekter-{@ikrafttredelse}.html" method="html" omit-xml-declaration="yes" validation="lax">
            <html>
                <xsl:apply-templates select="/r:regelsett/r:dokumenter/*">
                    <xsl:with-param name="ikrafttredelse" select="@ikrafttredelse"/>
                    <xsl:with-param name="dokumentId" select="@dokument-id"/>
                </xsl:apply-templates>
            </html>
        </xsl:result-document>
    </xsl:template>

    <!-- r:dokument node -->
    <xsl:template match="r:dokument">
        <xsl:param name="ikrafttredelse"/>
        <xsl:param name="dokumentId"/>
        <head>
            <meta name="dokument-versjon" content="{$ikrafttredelse}"/>
            <meta name="dokument-id" content="{$dokumentId}"/>
        </head>
            <body>
            <xsl:apply-templates select="*" mode="dokument"/>
        </body>
    </xsl:template>

    <xsl:template match="*" mode="dokument">
        <xsl:apply-templates select="*"/>
    </xsl:template>

    <xsl:template match="r:tittel" mode="dokument">
        <h1 style="text-align: center">
            <xsl:apply-templates select="*" mode="dokument"/>
        </h1>
    </xsl:template>

    <xsl:template match="r:linje" mode="dokument">
        <xsl:value-of select="."/>
        <br/>
    </xsl:template>

    <!-- r:kapittel node -->
    <xsl:template match="r:kapittel" mode="dokument">
        <xsl:apply-templates select="*" mode="kapittel">
            <xsl:with-param name="number">
                <xsl:number format="1. " level="any" count="r:kapittel"/>
            </xsl:with-param>
        </xsl:apply-templates>
    </xsl:template>

    <xsl:template match="r:tittel" mode="kapittel">
        <xsl:param name="number"/>
        <h2>
            <xsl:value-of select="$number"/>
            <xsl:value-of select="."/>
        </h2>
    </xsl:template>

    <!-- r:paragraf node -->
    <xsl:template match="r:paragraf" mode="kapittel">
        <xsl:apply-templates select="*" mode="paragraf">
            <xsl:with-param name="number">
                <xsl:number format="1." level="any" count="r:kapittel" from="r:dokument"/>
                <xsl:number format="1. " level="any"
                    count="r:paragraf"/>
            </xsl:with-param>
        </xsl:apply-templates>
    </xsl:template>

    <xsl:template match="r:tittel" mode="paragraf">
        <xsl:param name="number"/>
        <h3>
            <xsl:number format="1." level="any" count="r:kapittel"/>
            <xsl:number format="1. " level="single" count="r:paragraf"/>

            <!-- <xsl:value-of select="$number"/> -->
            <xsl:value-of select="."/>
        </h3>
    </xsl:template>

    <xsl:template match="r:p" mode="paragraf">
        <p>
            <xsl:value-of select="."/>
        </p>
    </xsl:template>

    <xsl:template match="r:ledd-p"></xsl:template>

</xsl:stylesheet>
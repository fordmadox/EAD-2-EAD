<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:ead="urn:isbn:1-931666-22-9"
    exclude-result-prefixes="xs xsl xd ead xlink" version="2.0">
    <xd:doc scope="stylesheet">
        <xd:desc>
            <xd:p><xd:b>Created on:</xd:b> Aug 18, 2012</xd:p>
            <xd:p><xd:b>Author:</xd:b> Mark Custer</xd:p>
            <xd:p>A simple transformation to convert enumerated EAD component elements to 'c' elements.</xd:p>
        </xd:desc>
    </xd:doc>
    <xsl:template match="@*|node()">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()"/>
        </xsl:copy>
    </xsl:template>
    <xsl:template match="ead:c01|ead:c02|ead:c03|ead:c04|ead:c05|ead:c06|ead:c07|ead:c08|ead:c09|ead:c10|ead:c11|ead:c12">
        <xsl:element name="c" namespace="urn:isbn:1-931666-22-9">
            <xsl:apply-templates select="@*|node()"/>
        </xsl:element>
    </xsl:template>
    </xsl:stylesheet>
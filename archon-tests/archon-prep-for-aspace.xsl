<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:ead="urn:isbn:1-931666-22-9"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0">

    <!--
      include an extra stylesheet in one of the transformation
      scenarios to split out things like box 1-5 for the top container model
      (just in case)
    -->

    <xsl:output method="xml" encoding="UTF-8" indent="yes"/>

    <xsl:param name="add-default-titles-if-missing" select="true()"/>
    <xsl:param name="add-default-collection-extent-if-missing" select="true()"/>
    <xsl:param name="add-default-collection-date-if-missing" select="true()"/>
    <xsl:param name="add-default-collection-title-if-missing" select="true()"/>
    <xsl:param name="remove-bolded-titles" select="true()"/>

    <!--standard identity template, which does all of the copying-->
    <xsl:template match="@* | node()">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>

    <xsl:template
        match="
            ead:unittitle/ead:emph[@render = 'bold']
            | ead:titleproper/ead:emph[@render = 'bold']">
        <xsl:choose>
            <xsl:when test="$remove-bolded-titles = true()">
                <xsl:apply-templates select="node()"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:copy>
                    <xsl:apply-templates select="@* | node()"/>
                </xsl:copy>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="ead:archdesc/ead:did">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
            <xsl:if
                test="
                    $add-default-collection-title-if-missing = true()
                    and not(ead:unittitle[normalize-space()])">
                <xsl:element name="unittitle" namespace="urn:isbn:1-931666-22-9">
                    <xsl:text>***Untitled Collection***</xsl:text>
                </xsl:element>
            </xsl:if>
            <xsl:if
                test="
                    $add-default-collection-date-if-missing = true()
                    and not(ead:unitdate[normalize-space()])">
                <xsl:element name="unitdate" namespace="urn:isbn:1-931666-22-9">
                    <xsl:text>***Undated Collection***</xsl:text>
                </xsl:element>
            </xsl:if>
            <xsl:if
                test="
                    $add-default-collection-extent-if-missing = true()
                    and not(ead:physdesc/ead:extent)">
                <xsl:element name="physdesc" namespace="urn:isbn:1-931666-22-9">
                    <xsl:element name="extent" namespace="urn:isbn:1-931666-22-9">
                        <xsl:text>0 linear_feet</xsl:text>
                    </xsl:element>
                </xsl:element>
            </xsl:if>
        </xsl:copy>
    </xsl:template>

    <xsl:template
        match="
            ead:did[
            not(ead:unittitle[normalize-space()])
            and not(descendant::ead:unitdate[normalize-space()])
            and not(descendant::ead:unitdate/@normal)
            ]">
        <xsl:if test="$add-default-titles-if-missing = true()">
            <xsl:copy>
                <xsl:apply-templates select="@* | node()"/>
                <xsl:element name="unittitle" namespace="urn:isbn:1-931666-22-9">
                    <xsl:text>***No title or date provided***</xsl:text>
                </xsl:element>
            </xsl:copy>
        </xsl:if>
    </xsl:template>

    <xsl:template match="ead:extent[@type]">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
            <xsl:value-of select="concat(' ', @type)"/>
        </xsl:copy>
    </xsl:template>

    <!--adds an @id attribute to the first container element that doesn't already have an @id or @parent attribute-->
    <xsl:template match="ead:container[not(@id | @parent)][1]">
        <xsl:copy>
            <xsl:attribute name="id">
                <xsl:value-of select="generate-id()"/>
            </xsl:attribute>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>

    <!--adds a @parent attribute to the following container elements that don't already have an @Id or @parent attribute-->
    <xsl:template match="ead:container[not(@id | @parent)][position() > 1]">
        <xsl:copy>
            <xsl:attribute name="parent">
                <xsl:value-of select="generate-id(../ead:container[not(@id | @parent)][1])"/>
            </xsl:attribute>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>

    <!--add a @level='file' attribute if no level is expressed, prior to importing into ASpace -->
    <xsl:template match="ead:dsc//ead:*[ead:did][not(normalize-space(@level))]">
        <xsl:copy>
            <xsl:attribute name="level">
                <xsl:value-of select="'file'"/>
            </xsl:attribute>
            <xsl:apply-templates select="@* except @level | node()"/>
        </xsl:copy>
    </xsl:template>

    <!--add a @level='collection' attribute if no level is expressed within archdesc, prior to importing into ASpace -->
    <xsl:template match="ead:archdesc[not(@level)]">
        <xsl:copy>
            <xsl:attribute name="level">
                <xsl:value-of select="'collection'"/>
            </xsl:attribute>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>
</xsl:stylesheet>

<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:ead="urn:isbn:1-931666-22-9"
    exclude-result-prefixes="xs xsl xd ead xlink" version="2.0">
    <xd:doc scope="stylesheet">
        <xd:desc>
            <xd:p><xd:b>Created on:</xd:b> Aug 18, 2012</xd:p>
            <xd:p><xd:b>Author:</xd:b> Mark Custer</xd:p>
            <xd:p>A simple, if inelegant transformation to convert 'c' elements to enumerated EAD component elements...
            If there are more than 12 un-enumerated components within any hierarchy, however, the transformation will fail
            To run the transformation anyway (thereby removing any potential c13 elements and their descendants from the output), change the value of the terminate attribute to "no"</xd:p>
        </xd:desc>
    </xd:doc>
    <xsl:template match="@*|node()">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()"/>
        </xsl:copy>
    </xsl:template>
    <xsl:template match="ead:c">
        <xsl:param name="c-level" as="xs:integer" select="1"/>
        <xsl:if test="$c-level eq 13">
            <xsl:message terminate="yes">EAD doesn't like the number 13 and refuses to count that high (additionally, a c12 element cannot conceive a 'c' for a child).  Therefore, this EAD document would no longer be valid if all of its highly-nested  'c' elements were enumerated. To uphold validity, as well as the original integretity of this document, this transformation has thus been terminated.</xsl:message>
        </xsl:if>
        <xsl:choose>
            <xsl:when test="$c-level eq 1">
                <xsl:element name="c01" namespace="urn:isbn:1-931666-22-9">
                    <xsl:apply-templates select="@*|node()">
                        <xsl:with-param name="c-level" as="xs:integer" select="2"/>
                    </xsl:apply-templates>
                </xsl:element>
            </xsl:when>
            <xsl:when test="$c-level eq 2">
                <xsl:element name="c02" namespace="urn:isbn:1-931666-22-9">
                    <xsl:apply-templates select="@*|node()">
                        <xsl:with-param name="c-level" as="xs:integer" select="3"/>
                    </xsl:apply-templates>
                </xsl:element>
            </xsl:when>
            <xsl:when test="$c-level eq 3">
                <xsl:element name="c03" namespace="urn:isbn:1-931666-22-9">
                    <xsl:apply-templates select="@*|node()">
                        <xsl:with-param name="c-level" as="xs:integer" select="4"/>
                    </xsl:apply-templates>
                </xsl:element>
            </xsl:when>
            <xsl:when test="$c-level eq 4">
                <xsl:element name="c04" namespace="urn:isbn:1-931666-22-9">
                    <xsl:apply-templates select="@*|node()">
                        <xsl:with-param name="c-level" as="xs:integer" select="5"/>
                    </xsl:apply-templates>
                </xsl:element>
            </xsl:when>
            <xsl:when test="$c-level eq 5">
                <xsl:element name="c05" namespace="urn:isbn:1-931666-22-9">
                    <xsl:apply-templates select="@*|node()">
                        <xsl:with-param name="c-level" as="xs:integer" select="6"/>
                    </xsl:apply-templates>
                </xsl:element>
            </xsl:when>
            <xsl:when test="$c-level eq 6">
                <xsl:element name="c06" namespace="urn:isbn:1-931666-22-9">
                    <xsl:apply-templates select="@*|node()">
                        <xsl:with-param name="c-level" as="xs:integer" select="7"/>
                    </xsl:apply-templates>
                </xsl:element>
            </xsl:when>
            <xsl:when test="$c-level eq 7">
                <xsl:element name="c07" namespace="urn:isbn:1-931666-22-9">
                    <xsl:apply-templates select="@*|node()">
                        <xsl:with-param name="c-level" as="xs:integer" select="8"/>
                    </xsl:apply-templates>
                </xsl:element>
            </xsl:when>
            <xsl:when test="$c-level eq 8">
                <xsl:element name="c08" namespace="urn:isbn:1-931666-22-9">
                    <xsl:apply-templates select="@*|node()">
                        <xsl:with-param name="c-level" as="xs:integer" select="9"/>
                    </xsl:apply-templates>
                </xsl:element>
            </xsl:when>
            <xsl:when test="$c-level eq 9">
                <xsl:element name="c09" namespace="urn:isbn:1-931666-22-9">
                    <xsl:apply-templates select="@*|node()">
                        <xsl:with-param name="c-level" as="xs:integer" select="10"/>
                    </xsl:apply-templates>
                </xsl:element>
            </xsl:when>
            <xsl:when test="$c-level eq 10">
                <xsl:element name="c10" namespace="urn:isbn:1-931666-22-9">
                    <xsl:apply-templates select="@*|node()">
                        <xsl:with-param name="c-level" as="xs:integer" select="11"/>
                    </xsl:apply-templates>
                </xsl:element>
            </xsl:when>
            <xsl:when test="$c-level eq 11">
                <xsl:element name="c11" namespace="urn:isbn:1-931666-22-9">
                    <xsl:apply-templates select="@*|node()">
                        <xsl:with-param name="c-level" as="xs:integer" select="12"/>
                    </xsl:apply-templates>
                </xsl:element>
            </xsl:when>
            <xsl:when test="$c-level eq 12">
                <xsl:element name="c12" namespace="urn:isbn:1-931666-22-9">
                    <xsl:apply-templates select="@*|node()">
                        <xsl:with-param name="c-level" as="xs:integer" select="13"/>
                    </xsl:apply-templates>
                </xsl:element>
            </xsl:when>
        </xsl:choose>
    </xsl:template>
    </xsl:stylesheet>
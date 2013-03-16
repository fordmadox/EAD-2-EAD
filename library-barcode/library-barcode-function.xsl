<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:mdc="http://mdc" exclude-result-prefixes="xs"
    version="2.0">
   

    <xsl:function name="mdc:barcode-plus-check-digit">
        <xsl:param name="barcode" as="xs:string"/>
        
        <!-- The next two variables compute the Codabar barcode sum for 14-digit library barcodes according to the Luhn algorithm-->
        <xsl:variable name="barcode-sum">
            <xsl:sequence select="
                (: add up the even sequence :)
                sum(for $n in string-to-codepoints($barcode)[position() mod 2 eq 0]
                return
                xs:integer(codepoints-to-string($n)))
                +
                (: add up the odd sequence :)
                sum(for $n in string-to-codepoints($barcode)[position() mod 2 eq 1]
                return
                if (xs:integer(codepoints-to-string($n)) &gt;=  5) 
                then xs:integer(codepoints-to-string($n)) * 2 - 9
                else xs:integer(codepoints-to-string($n)) * 2)"/>
        </xsl:variable>
          
         <!-- calculate the check digit--> 
        <xsl:variable name="check-digit">
            <xsl:value-of select="if ($barcode-sum mod 10 = 0) then 0 else 10 - $barcode-sum mod 10"/>
        </xsl:variable>
        
        <!-- put the two together -->
        <xsl:value-of select="concat($barcode, $check-digit)"/>
    </xsl:function>

<xsl:template match="/">    
    <xsl:text>
        Test:  the check-digit returned at the end of the barcode should be 2:  </xsl:text>
    <xsl:value-of select="mdc:barcode-plus-check-digit('3123456789012')"/>
    <xsl:text>
        Test:  the check-digit returned at the end of the barcode should be 6:  </xsl:text>
    <xsl:value-of select="mdc:barcode-plus-check-digit('3900204393039')"/>
</xsl:template>
    

</xsl:stylesheet>

<?xml version='1.0' encoding='iso-8859-1'?>
<!--
XSL transformation from the XML files generated by doxygen into HTML source documentation.
Author: Jan Gaspar (jano_gaspar[at]yahoo.com)
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

  <xsl:import href="doxygen2html.xslt"/>

  <xsl:output method="xml" version="1.0" encoding="iso-8859-1" indent="yes" media-type="text/xml"/>
  
  <xsl:variable name="circular_buffer-ref" select="//compound[name='boost::circular_buffer' and @kind='class']/@refid"/>
  <xsl:variable name="circular_buffer-file" select="concat($xmldir, '/', $circular_buffer-ref, '.xml')"/>

  <xsl:template name="member-types">
    <xsl:variable name="inherited" select="document($circular_buffer-file)/doxygen/compounddef[@id = $circular_buffer-ref and @kind = 'class']/sectiondef[@kind='public-type']/memberdef"/>
    <xsl:for-each select="sectiondef[@kind='public-type']/memberdef | $inherited">
      <xsl:sort select="name"/>
      <xsl:choose>
        <xsl:when test="count($inherited[name=current()/name]) = 0">
          <xsl:apply-templates select="." mode="synopsis"/>
        </xsl:when>
        <xsl:when test="../../compoundname != 'boost::circular_buffer_space_optimized'">
          <xsl:apply-templates select="." mode="synopsis">
            <xsl:with-param name="link-prefix" select="'circular_buffer.html'"/>
          </xsl:apply-templates>
        </xsl:when>
      </xsl:choose>
    </xsl:for-each>
  </xsl:template>
  
  <xsl:template name="member-functions">
    <xsl:variable name="inherited" select="document($circular_buffer-file)/doxygen/compounddef[@id = $circular_buffer-ref and @kind = 'class']/sectiondef[@kind='public-func']/memberdef[type != '']"/>
    <xsl:for-each select="sectiondef[@kind='public-func']/memberdef[type != ''] | $inherited">
      <xsl:sort select="name"/>
      <xsl:choose>
        <xsl:when test="count($inherited[name=current()/name and argsstring=current()/argsstring]) = 0">
          <xsl:apply-templates select="." mode="synopsis"/>
        </xsl:when>
        <xsl:when test="../../compoundname != 'boost::circular_buffer_space_optimized'">
          <xsl:apply-templates select="." mode="synopsis">
            <xsl:with-param name="link-prefix" select="'circular_buffer.html'"/>
          </xsl:apply-templates>
        </xsl:when>
      </xsl:choose>
    </xsl:for-each>
  </xsl:template>

  <xsl:template name="exclude-method">
    <xsl:param name="name"/>
    <xsl:if test="$name = 'internal_capacity'">true</xsl:if>
  </xsl:template>

  <xsl:template name="standalone-functions">
    <xsl:apply-templates select="document(concat($xmldir, '/namespaceboost.xml'))/doxygen/compounddef/sectiondef[@kind='func']/memberdef[contains(argsstring, 'circular_buffer_space_optimized&lt;')]" mode="synopsis">
      <xsl:with-param name="indent" select="''"/>
      <xsl:sort select="name"/>
    </xsl:apply-templates>
  </xsl:template>

</xsl:stylesheet>

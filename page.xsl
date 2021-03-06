<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
                xmlns:cvs="http://www.FreeBSD.org/XML/CVS">
  <xsl:import href="includes.xsl"/>
  <xsl:import href="heading.xsl"/>
  <xsl:output method="html" indent="yes" encoding="UTF-8"
    doctype-public="-//W3C//DTD HTML 4.01 Transitional//EN"
    doctype-system="http://www.w3.org/TR/html4/loose.dtd"/>
  <!-- doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN" -->
  <!-- doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd" /> -->

  <xsl:variable name="date">
    <xsl:value-of select="//cvs:keyword[@name='freebsd']" />
  </xsl:variable>

  <!-- This is the main page element. -->
  <xsl:template match="page">

    <!-- To clear up confusion and scoping for other templates which use
	 this attribute. -->
    <xsl:variable name="role" select="@role" />

    <html>
    <head>
      <link rel="stylesheet" type="text/css" href="page.css"/>
      <title>
	TrustedBSD - <xsl:value-of select="title"/>
      </title>
    </head>

    <body xsl:use-attribute-sets="body-attributes">

      <table border="0" cellpadding="0" cellspacing="0">
      <tr>
	<td>

      <!-- Generate Web page header. -->
      <xsl:call-template name="page-heading">
	<xsl:with-param name="role" select="$role" />
      </xsl:call-template>

	</td>
      </tr>
      <tr>
	<td>
	<table width="90%" border="0" cellspacing="1" cellpadding="2">
	<tr>
	  <td valign="top" width="100">
	    <a href="beastie.html">
	      <img src="trustyteenie.gif" width="166" height="200"
		alt="Trusty" border="0" />
	    </a>
	    <br />

	    <!-- This is the sidebar magic. -->
	    <xsl:for-each select="document('sidebar.xml')/sidebar/section">
	      <xsl:if test="$role = @match">
		<xsl:copy-of select="child::*" />
	      </xsl:if>
	    </xsl:for-each>
	  </td>
	  <td valign="top" width="2" background="verticalbar1.gif">
	    <!-- <img src="verticalbar1.gif" alt="" width="4" height="450" /> -->
	  </td>
	  <td valign="top" colspan="2">
	    <xsl:apply-templates select="section"/>
	  </td>
	</tr>

	<!-- Include the "Network connectivity provided by Safeport" and
	     "Powered by FreeBSD" images on the main page. -->
	<xsl:if test="$role = 'home'">
	  <tr>
	    <td colspan="4">
	      <br />
	    </td>
	  </tr>
	  <tr>
	    <td></td>

	    <td></td>

	    <td valign="bottom">
	      <center>
		<a href="http://www.safeport.com/">
		  <img src="minipemaquidlight.jpg"
		  border="0" alt="Safeport Network Services" /><br />
		  Connectivity provided by<br />
		  Safeport Network Services
		</a>
	      </center>
	    </td>
	    <td valign="bottom">
	      <center>
		<a href="http://www.freebsd.org"><img
		  alt="[Powered by FreeBSD]" border="0" src="powerlogo.gif"
		  /></a>
		</center>
	    </td>

 	  </tr>
	</xsl:if>
      </table>
      <ul>
	<small>
	  <br />
	  Copyright 2000-2012 Robert N. M. Watson.  All rights reserved.<br />
	  Copyright 2005 SPARTA, Inc.  All rights reserved.<br />
          Copyright 2002, Leigh T. Denault.  All rights reserved.<br />
          Copyright 2002, 2003 Networks Associates, Inc.  All rights
	  reserved.<br />
	  <xsl:value-of select="//cvs:keyword[@name='freebsd']" />
	</small>
      </ul>
	</td>
      </tr>
      </table>
    </body>
    </html>
  </xsl:template>

  <!-- Mark up individual sections.  This could probably depend a bit less on
       HTML in the XML files, but it's fine for now. -->
  <xsl:template match="section">
    <a>
      <xsl:attribute name="name">
	<xsl:choose>
	  <xsl:when test="@id = ''">
	    <xsl:value-of select="translate(title, ' ', '-')"/>
	  </xsl:when>
	  <xsl:otherwise>
	    <xsl:value-of select="@id" />
	  </xsl:otherwise>
	</xsl:choose>
      </xsl:attribute>
      <h2 class="section"><xsl:value-of select="title"/></h2>
    </a>

    <xsl:apply-templates select="html"/>
  </xsl:template>

  <!-- Just copy in the contents of <html></html>. -->
  <xsl:template match="html">
    <xsl:copy-of select="child::node()"/>
  </xsl:template>
</xsl:stylesheet>

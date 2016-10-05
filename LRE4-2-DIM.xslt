<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:dim="http://www.dspace.org/xmlns/dspace/dim" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xmlns:lom="http://ltsc.ieee.org/xsd/LOM" xmlns:lom-rights="http://ltsc.ieee.org/xsd/LOM/imslode/ilox/any/rights"
	xmlns:work="http://www.imsglobal.org/xsd/imsloilox_v1p0" version="1.0">

	<xsl:output indent="yes" method="xml" />
	<xsl:strip-space elements="*" />
	<xsl:variable name="newline">
		<xsl:text />
	</xsl:variable>

	<xsl:template match="text()">
		<!-- Do nothing. (That is, override the built-in rule (which would print 
			out any otherwise not handled text), and suppress any otherwise not handled 
			text) -->
	</xsl:template>

	<!-- **** Variable declarations *** -->
	<xsl:param name="delim" select="','" />
	<xsl:param name="quote">
		"
	</xsl:param>

	<!-- *************************** -->
	<!-- **** Using WORK as root element **** -->
	<!-- *************************** -->
	<xsl:template match="work:work">
		<xsl:element name="dim:dim">
			<xsl:value-of select="$newline" />
			<xsl:comment>
				IMPORTANT NOTE:
				***************************************************************************************
				THIS "Dspace Intermediate Metadata" ('DIM') IS **NOT** TO BE USED
				FOR
				INTERCHANGE WITH OTHER SYSTEMS.
				***************************************************************************************
				It does NOT pretend to be a standard, interoperable representation
				of Dublin
				Core. It is EXPRESSLY used for transformation to and from
				source metadata XML
				vocabularies into and out of the DSpace object
				model. See
				http://wiki.dspace.org/DspaceIntermediateMetadata For more
				on Dublin Core
				standard schemata, see:
				http://dublincore.org/schemas/xmls/qdc/2003/04/02/qualifieddc.xsd
				http://dublincore.org/schemas/xmls/qdc/2003/04/02/dcterms.xsd Dublin
				Core
				usage guide: http://dublincore.org/documents/usageguide/ Also:
				http://dublincore.org/documents/dc-rdf/
			</xsl:comment>
			<xsl:value-of select="$newline" />
			<xsl:apply-templates />
		</xsl:element>
	</xsl:template>



	<!-- ******************************* -->
	<!-- ********* Temlates ************ -->
	<!-- ******************************* -->

	<!-- Add literal dim field -->
	<xsl:template name="addLiteralDimField">
		<xsl:param name="mdschema" />
		<xsl:param name="element" />
		<xsl:param name="lang" />
		<xsl:param name="value" />

		<xsl:if test="normalize-space($value)">
			<xsl:element name="dim:field">
				<xsl:attribute name="mdschema">
          <xsl:value-of select="$mdschema" />
        </xsl:attribute>
				<xsl:attribute name="element">
          <xsl:value-of select="$element" />
        </xsl:attribute>
				<xsl:if test="normalize-space($lang)">
					<xsl:attribute name="lang">
            <xsl:value-of select="$lang" />
          </xsl:attribute>
				</xsl:if>

				<xsl:value-of select="normalize-space($value)" />
			</xsl:element>
		</xsl:if>
	</xsl:template>


	<!-- Adds Literal fields including qualifier as simple strings -->
	<xsl:template name="addLiteralDimFieldInclQualifier">
		<xsl:param name="mdschema" />
		<xsl:param name="element" />
		<xsl:param name="qualifier" />
		<xsl:param name="lang" />
		<xsl:param name="value" />

		<xsl:if test="normalize-space($value)">
			<xsl:element name="dim:field">
				<xsl:attribute name="mdschema">
          <xsl:value-of select="$mdschema" />
        </xsl:attribute>
				<xsl:attribute name="element">
          <xsl:value-of select="$element" />
        </xsl:attribute>
				<xsl:attribute name="qualifier">
          <xsl:value-of select="$qualifier" />
        </xsl:attribute>
				<xsl:if test="normalize-space($lang)">
					<xsl:attribute name="lang">
            <xsl:value-of select="$lang" />
          </xsl:attribute>
				</xsl:if>

				<xsl:value-of select="normalize-space($value)" />
			</xsl:element>
		</xsl:if>
	</xsl:template>


	<!-- Format language, which is by reference 1 or 2 or... -->
	<xsl:template name="formatLanguage">
		<xsl:param name="mdschema" />
		<xsl:param name="element" />
		<xsl:param name="value" />

		<xsl:if test="normalize-space($value)">
			<xsl:element name="dim:field">
				<xsl:attribute name="mdschema">
          <xsl:value-of select="$mdschema" />
        </xsl:attribute>
				<xsl:attribute name="element">
          <xsl:value-of select="$element" />
        </xsl:attribute>
				<xsl:if test="$value = 'el'">
					<xsl:text>1</xsl:text>
				</xsl:if>
				<xsl:if test="$value = 'en'">
					<xsl:text>2</xsl:text>
				</xsl:if>
				<xsl:if test="$value = 'fr'">
					<xsl:text>3</xsl:text>
				</xsl:if>
				<xsl:if test="$value = 'de'">
					<xsl:text>4</xsl:text>
				</xsl:if>
				<xsl:if test="$value = 'it'">
					<xsl:text>5</xsl:text>
				</xsl:if>
				<xsl:if test="$value = 'es'">
					<xsl:text>6</xsl:text>
				</xsl:if>

			</xsl:element>
		</xsl:if>
	</xsl:template>

	<!-- Format Duration -->
	<xsl:template name="formatDuration">
		<xsl:param name="mdschema" />
		<xsl:param name="element" />
		<xsl:param name="value" />

		<xsl:if test="normalize-space($value)">
			<xsl:element name="dim:field">
				<xsl:attribute name="mdschema">
          <xsl:value-of select="$mdschema" />
        </xsl:attribute>
				<xsl:attribute name="element">
          <xsl:value-of select="$element" />
        </xsl:attribute>

				<xsl:variable name="hours">
					<xsl:choose>
						<xsl:when
							test="contains(substring(substring-after($value,'PT'),1,2),'H')">
							<xsl:value-of
								select="concat(0, substring(substring-after($value,'PT'),1,1))" />
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="substring(substring-after($value,'PT'),1,2)" />
						</xsl:otherwise>
					</xsl:choose>
				</xsl:variable>

				<xsl:variable name="mins">
					<xsl:value-of select="substring(substring-after($value,'H'),1,2)" />
				</xsl:variable>

				<xsl:variable name="secs">
					<xsl:value-of select="substring(substring-after($value,'M'),1,2)" />
				</xsl:variable>

				<xsl:value-of select="concat($hours,':', $mins,':', $secs)" />


			</xsl:element>
		</xsl:if>
	</xsl:template>

	<!-- format date template input:{date} 1987-04-09 new date format 09/04/1987 -->
	<xsl:template name="formatDate">
		<xsl:param name="mdschema" />
		<xsl:param name="element" />
		<xsl:param name="value" />

		<xsl:if test="normalize-space($value)">
			<xsl:element name="dim:field">
				<xsl:attribute name="mdschema">
          <xsl:value-of select="$mdschema" />
        </xsl:attribute>
				<xsl:attribute name="element">
          <xsl:value-of select="$element" />
        </xsl:attribute>
				<xsl:variable name="sep">
					<xsl:value-of select="'/'" />
				</xsl:variable>
				<xsl:variable name="year">
					<xsl:value-of select="substring($value,1,4)" />
				</xsl:variable>
				<xsl:variable name="month">
					<xsl:value-of select="substring($value,6,2)" />
				</xsl:variable>
				<xsl:variable name="day">
					<xsl:value-of select="substring($value,9,2)" />
				</xsl:variable>
				<xsl:value-of select="concat($day,$sep,$month,$sep,$year)" />
			</xsl:element>
		</xsl:if>
	</xsl:template>


	<!-- ************************************************** -->
	<!-- ********** Parsing non-LOM elements ************* -->
	<!-- ************************************************** -->

	<!-- These values are taken for the time being from the first manifestation instance ! -->
	<!-- They are not part of LOM schema for LRE -->
	<xsl:template match="work:expression/work:manifestation/work:name/work:value">
		<xsl:if test="normalize-space(.)">
			<xsl:variable name="theValue">
				<xsl:value-of select="text()" />
			</xsl:variable>
			<!-- ****** Relation.hasThumbnail *********-->
			<xsl:if test="contains($theValue, 'thumbnail')">
				<xsl:variable name="hasThumbnailValue"
					select="ancestor::*[1]/ancestor::*[1]/child::*[2]" />
				<xsl:call-template name="addLiteralDimField">
					<xsl:with-param name="mdschema" select="'lom'" />
					<xsl:with-param name="element" select="'relation-hasThumbnail'" />
					<xsl:with-param name="value" select="$hasThumbnailValue" />
				</xsl:call-template>
			</xsl:if>
			<!-- ******** Relation.isShownAt  *********-->
			<xsl:if test="contains($theValue, 'experience')">
				<xsl:variable name="shownAt"
					select="ancestor::*[1]/ancestor::*[1]/child::*[2]" />
				<xsl:call-template name="addLiteralDimField">
					<xsl:with-param name="mdschema" select="'lom'" />
					<xsl:with-param name="element" select="'relation-isShownAt'" />
					<xsl:with-param name="value" select="$shownAt" />
				</xsl:call-template>
			</xsl:if>
			<!-- ******** Technical.Location ********** -->
			<xsl:if test="contains($theValue, 'package in')">
				<xsl:variable name="location"
					select="ancestor::*[1]/ancestor::*[1]/child::*[3]" />
				<xsl:call-template name="addLiteralDimField">
					<xsl:with-param name="mdschema" select="'lom'" />
					<xsl:with-param name="element" select="'technical-location'" />
					<xsl:with-param name="value" select="$location" />
				</xsl:call-template>
			</xsl:if>
			<!-- ******** Technical.Format ********** -->
<!-- 			<xsl:if test="contains($theValue, 'package in')">
				<xsl:variable name="format"
					select="ancestor::*[1]/ancestor::*[1]/child::*[2]" />
				<xsl:call-template name="addLiteralDimField">
					<xsl:with-param name="mdschema" select="'lom'" />
					<xsl:with-param name="element" select="'technical-format'" />
					<xsl:with-param name="value" select="$format" />
				</xsl:call-template>
			</xsl:if> -->
		</xsl:if>
	</xsl:template>




	<!-- ********* Parsing LOM Fields ************ -->


	<!-- ***************** ********* -->
	<!-- ********* General ********* -->
	<!-- ***************** ********* -->

	<!-- *********General. Identifier ********* -->
	<xsl:template match="work:identifier/work:entry">
		<xsl:call-template name="addLiteralDimField">
			<xsl:with-param name="mdschema" select="'lom'" />
			<xsl:with-param name="element" select="'general-identifier'" />
			<xsl:with-param name="lang" select="@language" />
			<xsl:with-param name="value" select="text()" />
		</xsl:call-template>
	</xsl:template>


	<!-- ********* General.Title ********* -->
	<xsl:template match="lom:general/lom:title/lom:string">
		<xsl:call-template name="addLiteralDimField">
			<xsl:with-param name="mdschema" select="'lom'" />
			<xsl:with-param name="element" select="'general-title'" />
			<xsl:with-param name="lang" select="@language" />
			<xsl:with-param name="value" select="text()" />
		</xsl:call-template>
	</xsl:template>


	<!-- ********* General.Language ********* -->
	<xsl:template match="lom:general/lom:language">
		<xsl:call-template name="formatLanguage">
			<xsl:with-param name="mdschema" select="'lom'" />
			<xsl:with-param name="element" select="'general-language'" />
			<xsl:with-param name="value" select="text()" />
		</xsl:call-template>
	</xsl:template>


	<!-- ********* General.Coverage ********* -->
	<xsl:template match="lom:general/lom:coverage/lom:string">
		<xsl:call-template name="addLiteralDimField">
			<xsl:with-param name="mdschema" select="'lom'" />
			<xsl:with-param name="element" select="'general-coverage'" />
			<xsl:with-param name="lang" select="@language" />
			<xsl:with-param name="value" select="text()" />
		</xsl:call-template>
	</xsl:template>


	<!-- ********* General.Description ********* -->
	<xsl:template match="lom:general/lom:description/lom:string">
		<xsl:call-template name="addLiteralDimField">
			<xsl:with-param name="mdschema" select="'lom'" />
			<xsl:with-param name="element" select="'general-description'" />
			<xsl:with-param name="lang" select="@language" />
			<xsl:with-param name="value" select="text()" />
		</xsl:call-template>
	</xsl:template>


	<!-- ********* General.Keyword(s) ********* -->
	<xsl:template match="lom:general/lom:keyword/lom:string">
		<xsl:call-template name="addLiteralDimField">
			<xsl:with-param name="mdschema" select="'lom'" />
			<xsl:with-param name="element" select="'general-keyword'" />
			<xsl:with-param name="lang" select="@language" />
			<xsl:with-param name="value" select="text()" />
		</xsl:call-template>
	</xsl:template>




	<!-- ********************************** -->
	<!-- ********* Metametadata ********* -->
	<!-- ********************************** -->

	<!-- For anything EXCEPT scientific coordinator -->
	<xsl:template match="lom:metaMetadata/lom:contribute">
		<xsl:if test="normalize-space(.)">
			<xsl:variable name="metametadataContributeEntityValue"
				select="substring-before(substring-after(descendant::*[name()='entity'],'FN:'),' VERSION:')" />

			<xsl:if
				test="(not(contains(descendant::*[name()='value'], 'scientific metadata coordinator')))">


				<!-- ********* Metametadata.Contribute.Entity ********* -->
				<xsl:if test="descendant::*[name()='entity']">
					<xsl:call-template name="addLiteralDimField">
						<xsl:with-param name="mdschema" select="'lom'" />
						<xsl:with-param name="element"
							select="'metametadata-contribute-entity'" />
						<xsl:with-param name="value"
							select="$metametadataContributeEntityValue" />
					</xsl:call-template>
				</xsl:if>
				<xsl:if test="not(descendant::*[name()='entity'])">
					<xsl:call-template name="addLiteralDimField">
						<xsl:with-param name="mdschema" select="'lom'" />
						<xsl:with-param name="element"
							select="'metametadata-contribute-entity'" />
						<xsl:with-param name="value">
							none
						</xsl:with-param>
					</xsl:call-template>
				</xsl:if>


				<!-- ********* Metametadata.Contribute.Role ********* -->
				<xsl:variable name="metametadataContributeRoleValue"
					select="descendant::*[name()='value']" />
				<xsl:if test="descendant::*[name()='value']">
					<xsl:choose>
						<xsl:when test="$metametadataContributeRoleValue='metadata creator'">
							<xsl:call-template name="addLiteralDimField">
								<xsl:with-param name="mdschema" select="'lom'" />
								<xsl:with-param name="element"
									select="'metametadata-contribute-role'" />
								<xsl:with-param name="value">
									Δημιουργός
								</xsl:with-param>
							</xsl:call-template>
						</xsl:when>
						<xsl:when test="$metametadataContributeRoleValue='metadata validator'">
							<xsl:call-template name="addLiteralDimField">
								<xsl:with-param name="mdschema" select="'lom'" />
								<xsl:with-param name="element"
									select="'metametadata-contribute-role'" />
								<xsl:with-param name="value">
									Επικυρωτής
								</xsl:with-param>
							</xsl:call-template>
						</xsl:when>
						<xsl:otherwise>
							<xsl:call-template name="addLiteralDimField">
								<xsl:with-param name="mdschema" select="'lom'" />
								<xsl:with-param name="element"
									select="'metametadata-contribute-role'" />
								<xsl:with-param name="value"
									select="$metametadataContributeRoleValue" />
							</xsl:call-template>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:if>
				<xsl:if test="not(descendant::*[name()='value'])">
					<xsl:call-template name="addLiteralDimField">
						<xsl:with-param name="mdschema" select="'lom'" />
						<xsl:with-param name="element"
							select="'metametadata-contribute-role'" />
						<xsl:with-param name="value">
							none
						</xsl:with-param>
					</xsl:call-template>
				</xsl:if>


				<!-- ********* Metametadata.Contribute.Date ********* -->
				<xsl:variable name="metametadataContributeDateValue"
					select="descendant::*[name()='dateTime']" />
				<xsl:if test="descendant::*[name()='dateTime']">
					<xsl:call-template name="formatDate">
						<xsl:with-param name="mdschema" select="'lom'" />
						<xsl:with-param name="element"
							select="'metametadata-contribute-date'" />
						<xsl:with-param name="value"
							select="$metametadataContributeDateValue" />
					</xsl:call-template>
				</xsl:if>
				<xsl:if test="not(descendant::*[name()='dateTime'])">
					<xsl:call-template name="formatDate">
						<xsl:with-param name="mdschema" select="'lom'" />
						<xsl:with-param name="element"
							select="'metametadata-contribute-date'" />
						<xsl:with-param name="value">
							none
						</xsl:with-param>
					</xsl:call-template>
				</xsl:if>

			</xsl:if>

			<!-- For scientific coordinator: apparently in this case the Lifecycle.Contribute 
				is used in the output -->
			<xsl:if
				test="contains(descendant::*[name()='value'], 'scientific metadata coordinator')">

				<!-- ********* Metametadata.Contribute.Entity ********* -->
				<xsl:if test="descendant::*[name()='entity']">
					<xsl:call-template name="addLiteralDimField">
						<xsl:with-param name="mdschema" select="'lom'" />
						<xsl:with-param name="element"
							select="'lifecycle-contribute-entity'" />
						<xsl:with-param name="value"
							select="$metametadataContributeEntityValue" />
					</xsl:call-template>
				</xsl:if>
				<xsl:if test="not(descendant::*[name()='entity'])">
					<xsl:call-template name="addLiteralDimField">
						<xsl:with-param name="mdschema" select="'lom'" />
						<xsl:with-param name="element"
							select="'lifecycle-contribute-entity'" />
						<xsl:with-param name="value">
							none
						</xsl:with-param>
					</xsl:call-template>
				</xsl:if>


				<!-- ********* Metametadata.Contribute.Role ********* -->
				<xsl:variable name="metametadataContributeRoleValue"
					select="descendant::*[name()='value']" />
				<xsl:if test="descendant::*[name()='value']">
					<xsl:call-template name="addLiteralDimField">
						<xsl:with-param name="mdschema" select="'lom'" />
						<xsl:with-param name="element" select="'lifecycle-contribute-role'" />
						<xsl:with-param name="value"
							select="$metametadataContributeRoleValue" />
					</xsl:call-template>
				</xsl:if>
				<xsl:if test="not(descendant::*[name()='value'])">
					<xsl:call-template name="addLiteralDimField">
						<xsl:with-param name="mdschema" select="'lom'" />
						<xsl:with-param name="element" select="'lifecycle-contribute-role'" />
						<xsl:with-param name="value">
							none
						</xsl:with-param>
					</xsl:call-template>
				</xsl:if>


				<!-- ********* Metametadata.Contribute.Date ********* -->
				<xsl:variable name="metametadataContributeDateValue"
					select="descendant::*[name()='dateTime']" />
				<xsl:if test="descendant::*[name()='dateTime']">
					<xsl:call-template name="formatDate">
						<xsl:with-param name="mdschema" select="'lom'" />
						<xsl:with-param name="element" select="'lifecycle-contribute-date'" />
						<xsl:with-param name="value"
							select="$metametadataContributeDateValue" />
					</xsl:call-template>
				</xsl:if>
				<xsl:if test="not(descendant::*[name()='dateTime'])">
					<xsl:call-template name="formatDate">
						<xsl:with-param name="mdschema" select="'lom'" />
						<xsl:with-param name="element" select="'lifecycle-contribute-date'" />
						<xsl:with-param name="value">
							none
						</xsl:with-param>
					</xsl:call-template>
				</xsl:if>

			</xsl:if>

		</xsl:if>
	</xsl:template>

	<!-- ********* Metametadata.Schema ********* -->
	<xsl:template match="lom:metaMetadata/lom:metadataSchema">
		<xsl:call-template name="addLiteralDimField">
			<xsl:with-param name="mdschema" select="'lom'" />
			<xsl:with-param name="element" select="'metaMetadata-metaSchema'" />
			<xsl:with-param name="lang" select="@language" />
			<xsl:with-param name="value" select="text()" />
		</xsl:call-template>
	</xsl:template>



	<!-- ******************************* -->
	<!-- ********* Educational ********* -->
	<!-- ******************************* -->

	<!-- ********* Educational.Description ********* -->
	<xsl:template match="lom:educational/lom:description/lom:string">
		<xsl:call-template name="addLiteralDimField">
			<xsl:with-param name="mdschema" select="'lom'" />
			<xsl:with-param name="element" select="'educational-description'" />
			<xsl:with-param name="lang" select="@language" />
			<xsl:with-param name="value" select="text()" />
		</xsl:call-template>
	</xsl:template>


	<!-- ********* Educational.InteractivityType ********* -->
	<xsl:template match="lom:educational/lom:interactivityType/lom:value">
		<xsl:call-template name="addLiteralDimField">
			<xsl:with-param name="mdschema" select="'lom'" />
			<xsl:with-param name="element" select="'educational-interactivitytype'" />
			<xsl:with-param name="value" select="text()" />
		</xsl:call-template>
	</xsl:template>


	<!-- ********* Educational.LearningResourceType ********* -->
	<xsl:template match="lom:educational/lom:learningResourceType/lom:value">
		<xsl:call-template name="addLiteralDimField">
			<xsl:with-param name="mdschema" select="'lom'" />
			<xsl:with-param name="element"
				select="'educational-learningresourcetype'" />
			<xsl:with-param name="value" select="text()" />
		</xsl:call-template>
	</xsl:template>

	<!-- ********* Educational.IntendedEndUserRole ********* -->
	<xsl:template match="lom:educational/lom:intendedEndUserRole/lom:value">
		<xsl:call-template name="addLiteralDimField">
			<xsl:with-param name="mdschema" select="'lom'" />
			<xsl:with-param name="element" select="'educational-intendedenduser'" />
			<xsl:with-param name="value" select="text()" />
		</xsl:call-template>
	</xsl:template>


	<!-- ********* Educational.Context ********* -->
	<xsl:template match="lom:educational/lom:context/lom:value">
		<xsl:call-template name="addLiteralDimField">
			<xsl:with-param name="mdschema" select="'lom'" />
			<xsl:with-param name="element" select="'educational-context'" />
			<xsl:with-param name="value" select="text()" />
		</xsl:call-template>
	</xsl:template>

	<!-- ********* Educational.TypicalAgeRange ********* -->
	<xsl:template match="lom:educational/lom:typicalAgeRange/lom:string">
		<xsl:call-template name="addLiteralDimField">
			<xsl:with-param name="mdschema" select="'lom'" />
			<xsl:with-param name="element" select="'educational-typicalagerange'" />
			<xsl:with-param name="lang" select="@language" />
			<xsl:with-param name="value" select="text()" />
		</xsl:call-template>
	</xsl:template>


	<!-- ********* Educational.TypicalLearningTime ********* -->
	<xsl:template match="lom:educational/lom:typicalLearningTime/lom:duration">
		<xsl:call-template name="formatDuration">
			<xsl:with-param name="mdschema" select="'lom'" />
			<xsl:with-param name="element"
				select="'educational-typicallearningtime'" />
			<xsl:with-param name="value" select="text()" />
		</xsl:call-template>
	</xsl:template>


	<!-- ********* Educational.Language ********* -->
	<xsl:template match="lom:educational/lom:language">
		<xsl:call-template name="formatLanguage">
			<xsl:with-param name="mdschema" select="'lom'" />
			<xsl:with-param name="element" select="'educational-language'" />
			<xsl:with-param name="value" select="text()" />
		</xsl:call-template>
	</xsl:template>



	<!-- ************************* -->
	<!-- ********* Rights********* -->
	<!-- ************************* -->

	<!-- ********* Rights.Description ********* -->
	<xsl:template
		match="lom-rights:rights/lom-rights:description/lom-rights:string">
		<xsl:call-template name="addLiteralDimField">
			<xsl:with-param name="mdschema" select="'lom'" />
			<xsl:with-param name="element" select="'rights-description'" />
			<xsl:with-param name="lang" select="'en'" />
			<xsl:with-param name="value" select="text()" />
		</xsl:call-template>
	</xsl:template>


	<!-- ********* Rights.Cost ********* -->
	<xsl:template match="lom-rights:rights/lom-rights:cost/lom-rights:value">
		<xsl:if test="contains(text(),'no')">
			<xsl:call-template name="addLiteralDimField">
				<xsl:with-param name="mdschema" select="'lom'" />
				<xsl:with-param name="element" select="'rights-cc-noncommercial'" />
				<xsl:with-param name="value">
					true
				</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="addLiteralDimField">
				<xsl:with-param name="mdschema" select="'lom'" />
				<xsl:with-param name="element" select="'rights-cc-kind'" />
				<xsl:with-param name="value">
					sure
				</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="addLiteralDimField">
				<xsl:with-param name="mdschema" select="'lom'" />
				<xsl:with-param name="element" select="'rights-cc'" />
				<xsl:with-param name="value">
					Attribution-ShareAlike 3.0 Unported
				</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="addLiteralDimField">
				<xsl:with-param name="mdschema" select="'lom'" />
				<xsl:with-param name="element" select="'rights-cc-url'" />
				<xsl:with-param name="value">
					http://creativecommons.org/licenses/by-sa/3.0/
				</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="addLiteralDimField">
				<xsl:with-param name="mdschema" select="'lom'" />
				<xsl:with-param name="element" select="'licence-title'" />
				<xsl:with-param name="value">
					http://creativecommons.org/licenses/by-sa/3.0/
				</xsl:with-param>
			</xsl:call-template>
		</xsl:if>
		<xsl:if test="contains(text(),'yes')">
			<xsl:call-template name="addLiteralDimField">
				<xsl:with-param name="mdschema" select="'lom'" />
				<xsl:with-param name="element" select="'rights-cc-noncommercial'" />
				<xsl:with-param name="value">
					false
				</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="addLiteralDimField">
				<xsl:with-param name="mdschema" select="'lom'" />
				<xsl:with-param name="element" select="'rights-cc-kind'" />
				<xsl:with-param name="value"></xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="addLiteralDimField">
				<xsl:with-param name="mdschema" select="'lom'" />
				<xsl:with-param name="element" select="'rights-cc'" />
				<xsl:with-param name="value"></xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="addLiteralDimField">
				<xsl:with-param name="mdschema" select="'lom'" />
				<xsl:with-param name="element" select="'rights-cc-url'" />
				<xsl:with-param name="value"></xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="addLiteralDimField">
				<xsl:with-param name="mdschema" select="'lom'" />
				<xsl:with-param name="element" select="'licence-title'" />
				<xsl:with-param name="value"></xsl:with-param>
			</xsl:call-template>
		</xsl:if>
	</xsl:template>


	<!-- ********* Rights.CopyrightAndOtherRestrictions ********* -->
	<xsl:template
		match="lom-rights:rights/lom-rights:copyrightAndOtherRestrictions/lom-rights:value">
		<xsl:if test="contains(text(),'no')">
			<xsl:call-template name="addLiteralDimField">
				<xsl:with-param name="mdschema" select="'lom'" />
				<xsl:with-param name="element" select="'rights-cc-remix'" />
				<xsl:with-param name="value">
					true
				</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="addLiteralDimField">
				<xsl:with-param name="mdschema" select="'lom'" />
				<xsl:with-param name="element" select="'rights-cc-shareAlike'" />
				<xsl:with-param name="value">
					true
				</xsl:with-param>
			</xsl:call-template>
		</xsl:if>
		<xsl:if test="contains(text(),'yes')">
			<xsl:call-template name="addLiteralDimField">
				<xsl:with-param name="mdschema" select="'lom'" />
				<xsl:with-param name="element" select="'rights-cc-remix'" />
				<xsl:with-param name="value">
					false
				</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="addLiteralDimField">
				<xsl:with-param name="mdschema" select="'lom'" />
				<xsl:with-param name="element" select="'rights-cc-shareAlike'" />
				<xsl:with-param name="value"></xsl:with-param>
			</xsl:call-template>
		</xsl:if>
	</xsl:template>


	<!-- ******************************* -->
	<!-- ********* Classification ********* -->
	<!-- ******************************* -->

	<xsl:template match="lom:classification">

		<!-- ********* Classification.Taxonpath ********* -->
		<xsl:if test="lom:purpose/lom:value[contains(text(), 'discipline')]">
			<xsl:if test="normalize-space(.)">
				<xsl:variable name="hasDisciplineValue" select="descendant::*[name()='entry']" />
				<xsl:variable name="taxonMappedValue">
					<xsl:value-of
						select="document('lre4_lom_mapping.xml')//mapping[@id=$hasDisciplineValue]" />
				</xsl:variable>
				<xsl:call-template name="addLiteralDimField">
					<xsl:with-param name="mdschema" select="'lom'" />
					<xsl:with-param name="element" select="'classification-taxonpath'" />
					<xsl:with-param name="value" select="$taxonMappedValue" />
				</xsl:call-template>
			</xsl:if>
			<xsl:if test="normalize-space(.)">
				<xsl:variable name="hasDisciplineKValue" select="descendant::*[name()='keyword']" />
				<xsl:call-template name="addLiteralDimField">
					<xsl:with-param name="mdschema" select="'lom'" />
					<xsl:with-param name="element" select="'classification-keyword'" />
					<xsl:with-param name="value" select="$hasDisciplineKValue" />
				</xsl:call-template>
			</xsl:if>
			<xsl:if test="normalize-space(.)">
				<xsl:variable name="hasDisciplineDValue"
					select="descendant::*[name()='description']" />
				<xsl:call-template name="addLiteralDimField">
					<xsl:with-param name="mdschema" select="'lom'" />
					<xsl:with-param name="element" select="'classification-description'" />
					<xsl:with-param name="value" select="$hasDisciplineDValue" />
				</xsl:call-template>
			</xsl:if>
		</xsl:if>
	</xsl:template>



	<!-- ******************************* -->
	<!-- ********* Lifecycle ********* -->
	<!-- ******************************* -->

	<xsl:template match="lom:lifeCycle/lom:contribute">
		<xsl:if test="normalize-space(.)">
			<xsl:variable name="lifecycleContributeEntityValue"
				select="substring-before(substring-after(descendant::*[name()='entity'],'FN:'),' N:')" />

			<xsl:if
				test="(not(contains(descendant::*[name()='value'], 'funder'))) and (not(contains(descendant::*[name()='value'], 'certifier'))) and
               		(not(contains(descendant::*[name()='value'], 'distributor'))) and (not(contains(descendant::*[name()='value'], 'provider'))) and
                	(not(contains(descendant::*[name()='value'], 'data provider'))) and (not(contains(descendant::*[name()='value'], 'uploader')))">


				<!-- ********* Lifecycle.Contribute.Entity ********* -->
				<xsl:if test="descendant::*[name()='entity']">
					<xsl:call-template name="addLiteralDimField">
						<xsl:with-param name="mdschema" select="'lom'" />
						<xsl:with-param name="element"
							select="'lifecycle-contribute-entity'" />
						<xsl:with-param name="value"
							select="$lifecycleContributeEntityValue" />
					</xsl:call-template>
				</xsl:if>
				<xsl:if test="not(descendant::*[name()='entity'])">
					<xsl:call-template name="addLiteralDimField">
						<xsl:with-param name="mdschema" select="'lom'" />
						<xsl:with-param name="element"
							select="'lifecycle-contribute-entity'" />
						<xsl:with-param name="value">
							none
						</xsl:with-param>
					</xsl:call-template>
				</xsl:if>


				<!-- ********* Lifecycle.Contribute.Role ********* -->
				<xsl:variable name="lifecycleContributeRoleValue"
					select="descendant::*[name()='value']" />
				<xsl:if test="descendant::*[name()='value']">
					<xsl:call-template name="addLiteralDimField">
						<xsl:with-param name="mdschema" select="'lom'" />
						<xsl:with-param name="element" select="'lifecycle-contribute-role'" />
						<xsl:with-param name="value"
							select="$lifecycleContributeRoleValue" />
					</xsl:call-template>
				</xsl:if>
				<xsl:if test="not(descendant::*[name()='value'])">
					<xsl:call-template name="addLiteralDimField">
						<xsl:with-param name="mdschema" select="'lom'" />
						<xsl:with-param name="element" select="'lifecycle-contribute-role'" />
						<xsl:with-param name="value">
							none
						</xsl:with-param>
					</xsl:call-template>
				</xsl:if>


				<!-- ********* Lifecycle.Contribute.Date ********* -->
				<xsl:variable name="lifecycleContributeDateValue"
					select="descendant::*[name()='dateTime']" />
				<xsl:if test="descendant::*[name()='dateTime']">
					<xsl:call-template name="formatDate">
						<xsl:with-param name="mdschema" select="'lom'" />
						<xsl:with-param name="element" select="'lifecycle-contribute-date'" />
						<xsl:with-param name="value"
							select="$lifecycleContributeDateValue" />
					</xsl:call-template>
				</xsl:if>
				<xsl:if test="not(descendant::*[name()='dateTime'])">
					<xsl:call-template name="formatDate">
						<xsl:with-param name="mdschema" select="'lom'" />
						<xsl:with-param name="element" select="'lifecycle-contribute-date'" />
						<xsl:with-param name="value">
							none
						</xsl:with-param>
					</xsl:call-template>
				</xsl:if>

			</xsl:if>

		</xsl:if>
	</xsl:template>

</xsl:stylesheet>

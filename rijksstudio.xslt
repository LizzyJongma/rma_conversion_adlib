<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet version="2.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema">


	<xsl:output method="xml" indent="yes"/>


	<!-- Top Level element -->
	<xsl:template match="adlibXML">
		<xsl:element name="adlibXML">
			<xsl:apply-templates select="recordList"/>
			<xsl:apply-templates select="diagnostic"/>
		</xsl:element>
	</xsl:template>

	<!-- Level1: Recordlist. You could also add diagnostics here -->
	<xsl:template match="recordList">
		<!--xsl:element name="ListRecords" -->
		<xsl:element name="recordList">
			<xsl:apply-templates select="record"/>

		</xsl:element>
	</xsl:template>

	<!-- Level1: Diagnostics over de set -->
	<xsl:template match="diagnostic">
		<xsl:element name="diagnostic">
			<xsl:apply-templates select="hits" />
			<xsl:apply-templates select="xmltype" />
			<xsl:apply-templates select="first_item" />
			<xsl:apply-templates select="search" />
			<!--xsl:apply-templates select="sort" />
			<xsl:apply-templates select="limit" />
			<xsl:apply-templates select="hits_on_display" />
			<xsl:apply-templates select="response_time" />
			<xsl:apply-templates select="xml_creation_time" />
			<xsl:apply-templates select="link_resolve_time" />
			<xsl:apply-templates select="dbname" />
			<xsl:apply-templates select="dsname" /-->
			<xsl:apply-templates select="error" />
			<xsl:apply-templates select="cgistring" />
		</xsl:element>
	</xsl:template>

	<!-- Level2: De records -->
	<xsl:template match="record">

		
		<!--xsl:element name="record" gegevens in de record tag -->
		<xsl:element name="record">
			<xsl:attribute name="priref">
				<xsl:value-of select="priref"/>
			</xsl:attribute>
			<xsl:attribute name="created">
				<xsl:value-of select="@created"/>
			</xsl:attribute>
			<xsl:attribute name="modification">
				<xsl:value-of select="@modification"/>
			</xsl:attribute>
			<xsl:attribute name="selected">
				<xsl:value-of select="@selected"/>
			</xsl:attribute>

			<!-- Level3: metadata informatie binnen een record -->
			<xsl:apply-templates select="acquisition.creditline"/>
			<xsl:apply-templates select="acquisition.date"/>
			<xsl:apply-templates select="acquisition.method"/>
			<xsl:apply-templates select="conservationcredit"/>

			<xsl:apply-templates select="administration.name"/>


			<!--bibliografische bron/ in welk boek staat de prent -->
			<xsl:apply-templates select="BibliograficSource"/>

			<xsl:apply-templates select="catrefrpk"/>
			<xsl:apply-templates select="collection"/>
			<xsl:apply-templates select="current_location.name"/>
			<!-- Velden bestandscatalogus -->

			<!-- 20121109 - nieuwe velden ihkv De Nieuwe Handleiding LJ  -->
			<xsl:apply-templates select="content.classification.code"/>
			<xsl:apply-templates select="subjectdate"/>
			<xsl:apply-templates select="subject.event"/>
			<xsl:apply-templates select="subject.name"/>
			<xsl:apply-templates select="subject.location"/>


			<xsl:apply-templates select="copy_number"/>
			<xsl:apply-templates select="copyright"/>
			<xsl:apply-templates select="dating"/>
			<xsl:apply-templates select="description"/>
			<xsl:apply-templates select="date.period"/>
			<xsl:apply-templates select="dimension"/>
			<xsl:apply-templates select="documentation"/>
			<xsl:apply-templates select="documentation.free"/>
			<xsl:apply-templates select="edit[1]"/>
			<xsl:apply-templates select="edition"/>

			<!-- velden tentoonstellingen -->
			<!-- 2015-03-09 Uitgeschakeld ivm klachten dat er teveel foutieve info staat
			<xsl:apply-templates select="exhibition"/>
			-->
			<xsl:apply-templates select="fysic"/>
			<xsl:apply-templates select="inscription"/>
			<xsl:apply-templates select="label[1]"/>


			<xsl:apply-templates select="maker"/>
			<xsl:apply-templates select="maker.school.style"/>
			<xsl:apply-templates select="material"/>
			<xsl:apply-templates select="notes.public"/>
			<xsl:apply-templates select="object_name"/>
			<xsl:apply-templates select="object.number"/>
			<xsl:apply-templates select="part.of.ref"/>
			<xsl:apply-templates select="parts.ref"/>
			<xsl:apply-templates select="PersistentIdentifier"/>
			<xsl:apply-templates select="priref"/>
			<xsl:apply-templates select="project.label"/>
			<xsl:apply-templates select="provenance"/>
			<xsl:apply-templates select="publish.website"/>
			<xsl:apply-templates select="publish.api"/>
			<xsl:apply-templates select="related_object"/>
			<xsl:apply-templates select="reproduction.online.available"/>
			<xsl:apply-templates select="rights.copyrightnotice"/>
			<xsl:apply-templates select="rights.freeofrights"/>
			<xsl:apply-templates select="rights.type"/>

			<xsl:apply-templates select="technique"/>
			<xsl:apply-templates select="title"/>
			<xsl:apply-templates select="title.int"/>
			<!--xsl:apply-templates select="title.type"/-->

			<!-- velden die gelden voor bestandscatalogi -->
			<xsl:if test="string-length(bestCat/catalogue.title) > 0">
				<xsl:element name="collection.catalogue">
					<!-- meta informatie over de bestandscatalogus -->
					<xsl:apply-templates select="catalogue.object.title"/>
					<xsl:apply-templates select="bestCat/catalogue.title"/>

					<xsl:apply-templates select="technical_notes.gb"/>
					<xsl:if test="string-length(examination) > 0">
						<xsl:element name="scientific.examination">
							<xsl:apply-templates select="examination"/>
						</xsl:element>
					</xsl:if>
					<xsl:apply-templates select="assesment.literature"/>
					<xsl:apply-templates select="condition"/>
					<xsl:if test="string-length(treatment) > 0">
						<xsl:element name="conservations">
							<xsl:apply-templates select="treatment"/>
						</xsl:element>
					</xsl:if>

					<xsl:apply-templates select="bsRemark"/>

					<xsl:apply-templates select="literature.entry.gb"/>
					<xsl:apply-templates select="catalogue.prev.catalogs"/>
					<xsl:apply-templates select="literature.archive.gb"/>
					<xsl:apply-templates select="literature.object.gb"/>

				</xsl:element>
			</xsl:if>
		</xsl:element>
	</xsl:template>

	<!-- level drie de waarden van tags binnen de records -->
	<xsl:template match="acquisition.creditline">
		<xsl:element name="acquisition.creditline">
			<xsl:element name="value">
				<xsl:attribute name="lang">
					<xsl:text>0</xsl:text>
				</xsl:attribute>
				<xsl:value-of select="../acquisition.creditline.gb"/>
			</xsl:element>
			<xsl:element name="value">
				<xsl:attribute name="lang">
					<xsl:text>1</xsl:text>
				</xsl:attribute>
				<xsl:value-of select="."/>
			</xsl:element>
		</xsl:element>
	</xsl:template>

	<xsl:template match="conservationcredit">
		<xsl:element name="conservation.creditline">
			<xsl:element name="value">
				<xsl:attribute name="lang">
					<xsl:text>0</xsl:text>
				</xsl:attribute>
				<xsl:value-of select="financier"/>
			</xsl:element>
			<xsl:element name="value">
				<xsl:attribute name="lang">
					<xsl:text>1</xsl:text>
				</xsl:attribute>
				<xsl:value-of select="financier"/>
			</xsl:element>
			<xsl:element name="show.until">
				<xsl:value-of select="../creditrest/conservation.creditline.showtill"/>
			</xsl:element>
		</xsl:element>
	</xsl:template>

	<xsl:template match="acquisition.date">
		<xsl:element name="acquisition.date">
			<xsl:value-of select="."/>
		</xsl:element>
	</xsl:template>

	<xsl:template match="acquisition.method">
		<xsl:element name="acquisition.method">
			<xsl:element name="value">
				<xsl:attribute name="lang">
					<xsl:text>0</xsl:text>
				</xsl:attribute>
				<xsl:value-of select="term.gb"/>
			</xsl:element>
			<xsl:element name="value">
				<xsl:attribute name="lang">
					<xsl:text>1</xsl:text>
				</xsl:attribute>
				<xsl:value-of select="term"/>
			</xsl:element>
		</xsl:element>
	</xsl:template>

	<xsl:template match="administration.name">
		<xsl:element name="administration.name">
			<xsl:element name="value">
				<xsl:attribute name="lang">
					<xsl:text>0</xsl:text>
				</xsl:attribute>
				<xsl:value-of select="value[2]"/>
			</xsl:element>
			<xsl:element name="value">
				<xsl:attribute name="lang">
					<xsl:text>1</xsl:text>
				</xsl:attribute>
				<xsl:value-of select="value[1]"/>
			</xsl:element>
		</xsl:element>
	</xsl:template>


	<xsl:template match="subjectdate">
		<xsl:element name="content.period">
			<xsl:apply-templates select="subject.date.begin"/>
			<xsl:apply-templates select="subject.date.end"/>
		</xsl:element>
	</xsl:template>

	<xsl:template match="subject.date.begin">
		<xsl:element name="content.date.early">
			<xsl:value-of select="."/>
		</xsl:element>
	</xsl:template>

	<xsl:template match="subject.date.end">
		<xsl:element name="content.date.late">
			<xsl:value-of select="."/>
		</xsl:element>
	</xsl:template>

	<!-- velden geassocieerde persoon inc. biografische velden -->
	<xsl:template match="subject.name">
		<xsl:element name="content.person">
			<xsl:element name="value">
				<xsl:attribute name="lang">
					<xsl:text>0</xsl:text>
				</xsl:attribute>
				<xsl:value-of select="name"/>
			</xsl:element>
			<xsl:element name="value">
				<xsl:attribute name="lang">
					<xsl:text>1</xsl:text>
				</xsl:attribute>
				<xsl:value-of select="name"/>
			</xsl:element>

			<xsl:element name="identifier">
				<xsl:value-of select="PersistentIdentifier"/>
			</xsl:element>

			<xsl:element name="born.on">
				<xsl:attribute name="lang">
					<xsl:text>0</xsl:text>
				</xsl:attribute>
				<xsl:value-of select="birth_on_precision/value[2]"/>
				<xsl:text> </xsl:text>
				<xsl:value-of select="birth_on"/>
			</xsl:element>
			<xsl:element name="born.on">
				<xsl:attribute name="lang">
					<xsl:text>1</xsl:text>
				</xsl:attribute>
				<xsl:value-of select="birth_on_precision/value[3]"/>
				<xsl:text> </xsl:text>
				<xsl:value-of select="birth_on"/>
			</xsl:element>

			<xsl:apply-templates select="born_at"/>
			<xsl:apply-templates select="died_at"/>

			<xsl:element name="died.on">
				<xsl:attribute name="lang">
					<xsl:text>0</xsl:text>
				</xsl:attribute>
				<xsl:value-of select="died_on"/>
			</xsl:element>
			<xsl:element name="died.on">
				<xsl:attribute name="lang">
					<xsl:text>1</xsl:text>
				</xsl:attribute>
				<xsl:value-of select="died_on"/>
			</xsl:element>

			<xsl:apply-templates select="occupation"/>
			<xsl:apply-templates select="nationality"/>
		</xsl:element>
	</xsl:template>

	<xsl:template match="born_at">
		<xsl:element name="born.at">
			<xsl:attribute name="lang">
				<xsl:text>0</xsl:text>
			</xsl:attribute>
			<xsl:value-of select="."/>
		</xsl:element>
		<xsl:element name="born.at">
			<xsl:attribute name="lang">
				<xsl:text>1</xsl:text>
			</xsl:attribute>
			<xsl:value-of select="."/>
		</xsl:element>
	</xsl:template>

	<xsl:template match="died_at">
		<xsl:element name="died.at">
			<xsl:attribute name="lang">
				<xsl:text>0</xsl:text>
			</xsl:attribute>
			<xsl:value-of select="."/>
		</xsl:element>
		<xsl:element name="died.at">
			<xsl:attribute name="lang">
				<xsl:text>1</xsl:text>
			</xsl:attribute>
			<xsl:value-of select="."/>
		</xsl:element>
	</xsl:template>

	<xsl:template match="occupation">
		<xsl:element name="occupation">
			<xsl:attribute name="lang">
				<xsl:text>0</xsl:text>
			</xsl:attribute>
			<xsl:value-of select="term.gb"/>
		</xsl:element>
		<xsl:element name="occupation">
			<xsl:attribute name="lang">
				<xsl:text>1</xsl:text>
			</xsl:attribute>
			<xsl:value-of select="term"/>
		</xsl:element>
	</xsl:template>

	<xsl:template match="nationality">
		<xsl:element name="nationality">
			<xsl:attribute name="lang">
				<xsl:text>1</xsl:text>
			</xsl:attribute>
			<xsl:value-of select="."/>
		</xsl:element>
	</xsl:template>

	<!-- velden geassocieerde persoon inc. biografische velden -->
	<!-- de personen en instellingen database is nog niet meertalig gemaakt. Als fallback gebruik in nu twee maal het Nederlandse taalveld. Dit moet in een volgende itteratie aangepast worden! -->
	<xsl:template match="subject.location">
		<xsl:element name="content.location">
			<xsl:element name="value">
				<xsl:attribute name="lang">
					<xsl:text>0</xsl:text>
				</xsl:attribute>
				<xsl:value-of select="term.gb"/>
			</xsl:element>
			<xsl:element name="value">
				<xsl:attribute name="lang">
					<xsl:text>1</xsl:text>
				</xsl:attribute>
				<xsl:value-of select="term"/>
			</xsl:element>
		</xsl:element>
	</xsl:template>

	<!-- bibliografische velden -->
	<xsl:template match="BibliograficSource">
		<xsl:apply-templates select="bibliografic_source.title"/>
	</xsl:template>

	<xsl:template match="bibliografic_source.title">
		<xsl:element name="bibliografic_source">
			<xsl:element name="value">
				<xsl:attribute name="lang">
					<xsl:text>neutral</xsl:text>
				</xsl:attribute>
				<xsl:text> Gepubliceerd in: </xsl:text>
			</xsl:element>
			<xsl:element name="value">
				<xsl:attribute name="lang">
					<xsl:text>0</xsl:text>
				</xsl:attribute>
				<xsl:text> Published in: </xsl:text>
			</xsl:element>
			<xsl:element name="value">
				<xsl:attribute name="lang">
					<xsl:text>1</xsl:text>
				</xsl:attribute>
				<xsl:text> Gepubliceerd in: </xsl:text>
			</xsl:element>
			<xsl:element name="title">
				<xsl:value-of select="title"/>
			</xsl:element>
			<xsl:element name="year">
				<xsl:value-of select="year_of_publication" />
			</xsl:element>
			<xsl:element name="Cat.nr">
				<xsl:text> Cat.nr. </xsl:text>
				<xsl:value-of select="copy.number" />
			</xsl:element>
		</xsl:element>
	</xsl:template>

	<!-- velden specifiek voor het Prentenkabinet -->
	<xsl:template match="catrefrpk">
		<xsl:element name="catrefrpk">
			<xsl:apply-templates select="catalogue.ref.RPK.addition"/>
			<xsl:apply-templates select="catalogue.ref.RPK"/>
			<!--LJ: 2013/10/18 de index catalogue ref rpk combination geeft regelmatig problemen. Besloten is om gewoon de losse velden catalogue ref en cat.ref number samen te voegen in de tag
			zodat de index niet aangesproken wordt/-->
			<!--xsl:apply-templates select="catalogue.ref.RPK.combination"/-->
			<xsl:apply-templates select="catalogue.ref.RPK.remark" />
		</xsl:element>
	</xsl:template>

	<xsl:template match="catalogue.ref.RPK.addition">
		<xsl:element name="catalogue.ref.RPK.addition">
			<xsl:value-of select="."/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="catalogue.ref.RPK">
		<xsl:element name="catalogue.ref.RPK.combination">
			<xsl:value-of select="."/>
			<xsl:text> </xsl:text>
			<xsl:value-of select="../catalogue.ref.RPK.number"/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="catalogue.ref.RPK.remark">
		<xsl:element name="catalogue.ref.RPK.remark">
			<xsl:value-of select="."/>
		</xsl:element>
	</xsl:template>

	<xsl:template match="collection">
		<xsl:element name="collection">
			<xsl:element name="value">
				<xsl:attribute name="lang">
					<xsl:text>0</xsl:text>
				</xsl:attribute>
				<xsl:value-of select="term.gb"/>
			</xsl:element>
			<xsl:element name="value">
				<xsl:attribute name="lang">
					<xsl:text>1</xsl:text>
				</xsl:attribute>
				<xsl:value-of select="term"/>
			</xsl:element>
		</xsl:element>
	</xsl:template>

	<xsl:template match="content.classification.code">
		<xsl:element name="content.classification.code">				
			<!--xsl:attribute name="linkref">
					<xsl:value-of select="priref"/>
				</xsl:attribute>
				<xsl:attribute name="linkdb">
					<xsl:text>Thesau</xsl:text>
				</xsl:attribute-->
			<!-- bij de iconclass codes hebben we een value is neutral ingebouwd om de iconclass codes zo wie zo door te blijven leveren. -->
			<!-- de codes komne nu nog uit het veld term maar zullen op korte termijn uit het veld termcode gaan komen. Dan moet de verwijzing in neutral naar dta nieuwe veld aangepast worden -->
			<xsl:element name="value">
				<xsl:attribute name="lang">
					<xsl:text>neutral</xsl:text>
				</xsl:attribute>

				<xsl:value-of select="term"/>
			</xsl:element>
			<xsl:element name="value">
				<xsl:attribute name="lang">
					<xsl:text>0</xsl:text>
				</xsl:attribute>
				<xsl:value-of select="term.gb"/>
			</xsl:element>
			<xsl:element name="value">
				<xsl:attribute name="lang">
					<xsl:text>1</xsl:text>
				</xsl:attribute>
				<xsl:choose>
					<xsl:when test="string-length(term.addition) > 0">
						<xsl:value-of select="term.addition"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="term.gb"/>
					</xsl:otherwise>
				</xsl:choose>	
			</xsl:element>
		</xsl:element>
	</xsl:template>

	<xsl:template match="subject.event">
		<xsl:element name="content.event">
			<xsl:element name="value">
				<xsl:attribute name="lang">
					<xsl:text>0</xsl:text>
				</xsl:attribute>
				<xsl:value-of select="term.gb"/>
			</xsl:element>
			<xsl:element name="value">
				<xsl:attribute name="lang">
					<xsl:text>1</xsl:text>
				</xsl:attribute>
				<xsl:value-of select="term"/>
			</xsl:element>
			<xsl:element name="PersistentIdentifier">
				<xsl:choose>
					<xsl:when test="string-length(term.number) > 0">
						<xsl:value-of select="term.number"/>						
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="PersistentIdentifier"/>
					</xsl:otherwise>
				 </xsl:choose>
			</xsl:element>
		</xsl:element>
	</xsl:template>

	<xsl:template match="subject.location">
		<xsl:element name="content.place">
			<xsl:element name="value">
				<xsl:attribute name="lang">
					<xsl:text>0</xsl:text>
				</xsl:attribute>
				<xsl:value-of select="term.gb"/>
			</xsl:element>
			<xsl:element name="value">
				<xsl:attribute name="lang">
					<xsl:text>1</xsl:text>
				</xsl:attribute>
				<xsl:value-of select="term"/>
			</xsl:element>
		</xsl:element>
		<xsl:element name="content.place.location">
			<xsl:if test="string-length(longitude) > 0">
				<xsl:element name="longitude">
					<xsl:value-of select="longitude"/>
				</xsl:element>
			</xsl:if>
			<xsl:if test="string-length(latitude) > 0">
				<xsl:element name="latitude">
					<xsl:value-of select="latitude"/>
				</xsl:element>
			</xsl:if>

			<xsl:element name="PersistentIdentifier">
				<xsl:choose>
					<xsl:when test="string-length(term.number) > 0">
						<xsl:value-of select="term.number"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="PersistentIdentifier"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:element>
		</xsl:element>
	</xsl:template>


	<!-- Titel bibliografische bron -->
	<xsl:template match="copy_number">
		<xsl:element name="copy_number">
			<xsl:value-of select="."/>
		</xsl:element>
	</xsl:template>

	<!-- Copyright gegevens -->
	<xsl:template match="copyright">
		<xsl:element name="copyright">
			<xsl:value-of select="."/>
		</xsl:element>
	</xsl:template>

	<xsl:template match="date.period">
		<xsl:element name="date.period">
			<xsl:element name="value">
				<xsl:attribute name="lang">
					<xsl:text>0</xsl:text>
				</xsl:attribute>
				<xsl:value-of select="term.gb"/>
			</xsl:element>
			<xsl:element name="value">
				<xsl:attribute name="lang">
					<xsl:text>1</xsl:text>
				</xsl:attribute>
				<xsl:value-of select="term"/>
			</xsl:element>
		</xsl:element>
	</xsl:template>

	<!-- documentatievelden. Documentatie over het object. Dit zijn andere velden dan de bibliografische velden! -->
	<xsl:template match="documentation">
		<xsl:element name="documentation">
			<xsl:apply-templates select="documentation.author.tinlib"/>
			
			<xsl:if test="string-length(documentation.catalogue_number) > 0">
				<xsl:apply-templates select="documentation.catalogue_number"/>
			</xsl:if>

			<xsl:if test="string-length(documentation.copy_number) > 0">
				<xsl:apply-templates select="documentation.copy_number"/>
			</xsl:if>

			<xsl:if test="string-length(documentation.issue) > 0">
				<xsl:apply-templates select="documentation.issue"/>
			</xsl:if>
			
			<xsl:if test="string-length(documentation.koha_id) > 0">
				<xsl:apply-templates select="documentation.koha_id"/>
			</xsl:if>


			<xsl:if test="string-length(documentation.page_reference) > 0">
				<xsl:apply-templates select="documentation.page_reference"/>
			</xsl:if>
			
			<xsl:if test="string-length(documentation.pagination.catalogue) > 0">
				<xsl:apply-templates select="documentation.pagination.catalogue"/>
			</xsl:if>

			<xsl:if test="string-length(documentation.place.tinlib) > 0">
				<xsl:apply-templates select="documentation.place.tinlib"/>
			</xsl:if>

			<xsl:if test="string-length(documentation.publication.year) > 0">
				<xsl:apply-templates select="documentation.publication.year"/>
			</xsl:if>

			<xsl:if test="string-length(documentation.publisher.tinlib) > 0">
				<xsl:apply-templates select="documentation.publisher.tinlib"/>
			</xsl:if>
			
			<xsl:if test="string-length(documentation.source.title) > 0">
				<xsl:apply-templates select="documentation.source.title"/>
			</xsl:if>
			
			<xsl:apply-templates select="documentation.title"/>
			
			<xsl:if test="string-length(documentation.volume) > 0">
				<xsl:apply-templates select="documentation.volume"/>
			</xsl:if>

			<xsl:if test="string-length(documentation.year) > 0">
				<xsl:apply-templates select="documentation.year"/>
			</xsl:if>

			<xsl:if test="string-length(documentation.URL.online-available) > 0">
				<xsl:apply-templates select="documentation.URL"/>
			</xsl:if>

			<!-- velden die gelden voor bestandscatalogi -->
			<xsl:if test="string-length(../bestCat/catalogue.title) > 0">
				<xsl:if test="string-length(documentation.authoritative) > 0">
					<xsl:apply-templates select="documentation.authoritative"/>
				</xsl:if>
				<xsl:if test="string-length(documentation.presentation-title) > 0">
					<xsl:apply-templates select="documentation.presentation-title"/>
				</xsl:if>
			</xsl:if>	
			
		</xsl:element>
	</xsl:template>

	<xsl:template match="documentation.authoritative">
		<xsl:element name="documentation.authoritative">
			<xsl:value-of select="."/>
		</xsl:element>
	</xsl:template>

	<xsl:template match="documentation.presentation-title">
		<xsl:element name="documentation.presentation-title">
			<xsl:value-of select="."/>
		</xsl:element>
	</xsl:template>
	
	<xsl:template match="documentation.author.tinlib">
		<xsl:element name="documentation.author">
			<xsl:value-of select="."/>
		</xsl:element>
	</xsl:template>

	<xsl:template match="documentation.title">
		<xsl:element name="documentation.title">
			<xsl:value-of select="title"/>
		</xsl:element>
	</xsl:template>

	<xsl:template match="documentation.source.title">
		<xsl:element name="documentation.source.title">
			<xsl:value-of select="."/>
		</xsl:element>
	</xsl:template>

	<xsl:template match="documentation.catalogue_number">
		<xsl:element name="documentation.catalogue_number">
			<xsl:text>cat.nr. </xsl:text>
			<xsl:value-of select="."/>
		</xsl:element>
	</xsl:template>

	<xsl:template match="documentation.copy_number">
		<xsl:element name="documentation.copy_number">
			<xsl:value-of select="."/>
		</xsl:element>
	</xsl:template>

	<xsl:template match="documentation.pagination.catalogue">
		<xsl:element name="documentation.pagination.catalogue">
			<xsl:value-of select="."/>
		</xsl:element>
	</xsl:template>


	<xsl:template match="documentation.free">
		<xsl:element name="documentation.free">
			<xsl:value-of select="."/>
		</xsl:element>
	</xsl:template>

	<xsl:template match="documentation.koha_id">
		<xsl:element name="documentation.koha_id">
			<xsl:value-of select="."/>
		</xsl:element>
	</xsl:template>

	<xsl:template match="documentation.issue">
		<xsl:element name="documentation.issue">
			<xsl:value-of select="."/>
		</xsl:element>
	</xsl:template>

	<xsl:template match="documentation.page-reference">
		<xsl:element name="documentation.page-reference">
			<xsl:value-of select="."/>
		</xsl:element>
	</xsl:template>

	<xsl:template match="documentation.place.tinlib">
		<xsl:element name="documentation.place">
			<xsl:value-of select="."/>
		</xsl:element>
	</xsl:template>

	<xsl:template match="documentation.publication.year">
		<xsl:element name="documentation.publication.year">
			<xsl:value-of select="."/>
		</xsl:element>
	</xsl:template>

	<xsl:template match="documentation.publisher.tinlib">
		<xsl:element name="documentation.publisher">
			<xsl:value-of select="."/>
		</xsl:element>
	</xsl:template>

	<xsl:template match="documentation.URL">
		<xsl:element name="documentation.URL">
			<xsl:value-of select="."/>
		</xsl:element>
	</xsl:template>

	<xsl:template match="documentation.volume">
		<xsl:element name="documentation.volume">
			<xsl:value-of select="."/>
		</xsl:element>
	</xsl:template>


	<xsl:template match="documentation.year">
		<xsl:element name="documentation.year">
			<xsl:value-of select="."/>
		</xsl:element>
	</xsl:template>
	
	<!-- velden datering object -->
	<xsl:template match="dating">
		<xsl:element name="dating">
			<xsl:apply-templates select="date.early"/>
			<xsl:apply-templates select="date.early.precision"/>
			<xsl:apply-templates select="date.late"/>
			<xsl:apply-templates select="date.late.precision"/>
		</xsl:element>
	</xsl:template>

	<xsl:template match="date.early">
		<xsl:element name="date.early">
			<xsl:value-of select="."/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="date.early.precision">
		<xsl:element name="date.early.precision">
			<xsl:element name="value">
				<xsl:attribute name="lang">
					<xsl:text>0</xsl:text>
				</xsl:attribute>
				<xsl:value-of select="value[2]"/>
			</xsl:element>
			<xsl:element name="value">
				<xsl:attribute name="lang">
					<xsl:text>1</xsl:text>
				</xsl:attribute>
				<xsl:value-of select="value[3]"/>
			</xsl:element>
		</xsl:element>
	</xsl:template>
	<xsl:template match="date.late">
		<xsl:element name="date.late">
			<xsl:value-of select="."/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="date.late.precision">
		<xsl:element name="date.late.precision">
			<xsl:element name="value">
				<xsl:attribute name="lang">
					<xsl:text>0</xsl:text>
				</xsl:attribute>
				<xsl:value-of select="value[2]"/>
			</xsl:element>
			<xsl:element name="value">
				<xsl:attribute name="lang">
					<xsl:text>1</xsl:text>
				</xsl:attribute>
				<xsl:value-of select="value[3]"/>
			</xsl:element>
		</xsl:element>
	</xsl:template>

	<!-- velden beschrijving object -->
	<xsl:template match="description">
		<xsl:element name="description">
			<xsl:value-of select="description"/>
		</xsl:element>
	</xsl:template>

	<xsl:template match="dimension">
		<xsl:element name="dimension">
			<xsl:apply-templates select="dimension.part"/>
			<xsl:apply-templates select="dimension.notes"/>
			<xsl:apply-templates select="dimension.unit"/>
			<xsl:apply-templates select="dimension.value"/>
			<xsl:apply-templates select="dimension.type"/>
		</xsl:element>
	</xsl:template>

	<!-- velden afmeting object -->
	<!-- velden afmeting object -->
	<xsl:template match="dimension.part">
		<xsl:element name="dimension.part">
			<xsl:element name="value">
				<xsl:attribute name="lang">
					<xsl:text>0</xsl:text>
				</xsl:attribute>
				<xsl:value-of select="../dimension.part.gb"/>
			</xsl:element>
			<xsl:element name="value">
				<xsl:attribute name="lang">
					<xsl:text>1</xsl:text>
				</xsl:attribute>
				<xsl:value-of select="."/>
			</xsl:element>
		</xsl:element>
	</xsl:template>

	<xsl:template match="dimension.notes">
		<xsl:element name="dimension.notes">
			<xsl:element name="value">
				<xsl:attribute name="lang">
					<xsl:text>0</xsl:text>
				</xsl:attribute>
				<xsl:value-of select="../dimension.notes.gb"/>
			</xsl:element>
			<xsl:element name="value">
				<xsl:attribute name="lang">
					<xsl:text>1</xsl:text>
				</xsl:attribute>
				<xsl:value-of select="."/>
			</xsl:element>
		</xsl:element>
	</xsl:template>

	<xsl:template match="dimension.unit">
		<xsl:element name="dimension.unit">
			<xsl:element name="value">
				<xsl:attribute name="lang">
					<xsl:text>0</xsl:text>
				</xsl:attribute>
				<xsl:value-of select="value[2]"/>
			</xsl:element>
			<xsl:element name="value">
				<xsl:attribute name="lang">
					<xsl:text>1</xsl:text>
				</xsl:attribute>
				<xsl:value-of select="value[3]"/>
			</xsl:element>
		</xsl:element>
	</xsl:template>

	<xsl:template match="dimension.value">
		<xsl:element name="dimension.value">
			<xsl:choose>
				<xsl:when test="contains(.,'.')">
					<xsl:element name="value">
						<xsl:attribute name="lang">
							<xsl:text>0</xsl:text>
						</xsl:attribute>
						<xsl:value-of select="substring-before(.,'.')"/>
						<xsl:text>.</xsl:text>
						<xsl:value-of select="substring-after(., '.')"/>
					</xsl:element>
					<xsl:element name="value">
						<xsl:attribute name="lang">
							<xsl:text>1</xsl:text>
						</xsl:attribute>
						<xsl:value-of select="substring-before(.,'.')"/>
						<xsl:text>,</xsl:text>
						<xsl:value-of select="substring-after(., '.')"/>
					</xsl:element>
				</xsl:when>
				<xsl:when test="contains(.,',')">
					<xsl:element name="value">
						<xsl:attribute name="lang">
							<xsl:text>0</xsl:text>
						</xsl:attribute>
						<xsl:value-of select="substring-before(.,',')"/>
						<xsl:text>.</xsl:text>
						<xsl:value-of select="substring-after(., ',')"/>
					</xsl:element>
					<xsl:element name="value">
						<xsl:attribute name="lang">
							<xsl:text>1</xsl:text>
						</xsl:attribute>
						<xsl:value-of select="substring-before(.,',')"/>
						<xsl:text>,</xsl:text>
						<xsl:value-of select="substring-after(., ',')"/>
					</xsl:element>
				</xsl:when>
				<xsl:otherwise>
					<xsl:element name="value">
						<xsl:attribute name="lang">
							<xsl:text>0</xsl:text>
						</xsl:attribute>
						<xsl:value-of select="."/>
					</xsl:element>
					<xsl:element name="value">
						<xsl:attribute name="lang">
							<xsl:text>1</xsl:text>
						</xsl:attribute>
						<xsl:value-of select="."/>
					</xsl:element>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:element>
	</xsl:template>


	<xsl:template match="dimension.type">
		<xsl:element name="dimension.type">
			<xsl:element name="value">
				<xsl:attribute name="lang">
					<xsl:text>0</xsl:text>
				</xsl:attribute>
				<xsl:value-of select="term.gb"/>
			</xsl:element>
			<xsl:element name="value">
				<xsl:attribute name="lang">
					<xsl:text>1</xsl:text>
				</xsl:attribute>
				<xsl:value-of select="term"/>
			</xsl:element>
		</xsl:element>
	</xsl:template>

	<!-- wijzigingsdatum record. Dit is belangrijk voor check wanneer record voor het laatst gemuteerd is -->
	<xsl:template match="edit">
		<xsl:element name="edit">
			<xsl:apply-templates select="edit.date"/>
			<xsl:apply-templates select="edit.name"/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="edit.date">
		<xsl:element name="edit.date">
			<xsl:value-of select="."/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="edit.name">
		<xsl:element name="edit.name">
			<xsl:value-of select="."/>
		</xsl:element>
	</xsl:template>

	<!-- editie. Mn relevant bij prenten -->
	<xsl:template match="edition">
		<xsl:element name="edition">
			<xsl:value-of select="."/>
		</xsl:element>
	</xsl:template>

	<!-- velden tentoonstellingen -->
	<xsl:template match="exhibition">
		<xsl:element name="exhibition">
			<xsl:apply-templates select="exhibition.title"/>
		</xsl:element>
	</xsl:template>

	<xsl:template match="exhibition.title">
		<xsl:element name="exhibition.title">
			<xsl:value-of select="title"/>
		</xsl:element>

		<xsl:apply-templates select="organizer"/>
		<xsl:apply-templates select="venue.date.start"/>
		<xsl:apply-templates select="venue.date.end"/>
	</xsl:template>

	<xsl:template match="organizer">
		<xsl:element name="exhibition.organizer">
			<xsl:value-of select="../../exhibition.organiser"/>
		</xsl:element>
		<xsl:element name="exhibition.place">
			<xsl:value-of select="place"/>
		</xsl:element>
		<xsl:if test="country != 'Nederland'">
			<xsl:element name="exhibition.country">
				<xsl:value-of select="country"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="venue.date.start">
		<xsl:element name="exhibition.date.start">
			<xsl:value-of select="."/>
		</xsl:element>
	</xsl:template>

	<xsl:template match="venue.date.end">
		<xsl:element name="exhibition.date.end">
			<xsl:value-of select="."/>
		</xsl:element>
	</xsl:template>

	<!-- fysiek medium -->
	<xsl:template match="fysic">
		<xsl:element name="physical.medium">
			<xsl:element name="value">
				<xsl:attribute name="lang">
					<xsl:text>0</xsl:text>
				</xsl:attribute>
				<xsl:value-of select="physical.medium.gb"/>
			</xsl:element>
			<xsl:element name="value">
				<xsl:attribute name="lang">
					<xsl:text>1</xsl:text>
				</xsl:attribute>
				<xsl:value-of select="physical.medium"/>
			</xsl:element>
		</xsl:element>
	</xsl:template>


	<!-- inscriptie velden -->
	<xsl:template match="inscription">
		<xsl:element name="inscription">
			
			<xsl:if test="string-length(../inscription.scholarly.notes) > 0">
				<xsl:element name="inscription.freetext">
					<xsl:value-of select="../inscription.scholarly.notes"/>
				</xsl:element>	
			</xsl:if>	
			
			<xsl:element name="inscription.type">
				<xsl:if test="string-length(inscription.type/term) > 0">
					<xsl:element name="value">
						<xsl:attribute name="lang">
							<xsl:text>0</xsl:text>
						</xsl:attribute>
						<xsl:value-of select="inscription.type/term.gb"/>
					</xsl:element>
					<xsl:element name="value">
						<xsl:attribute name="lang">
							<xsl:text>1</xsl:text>
						</xsl:attribute>
						<xsl:value-of select="inscription.type/term"/>
					</xsl:element>
				</xsl:if>
			</xsl:element>

			<xsl:element name="inscription.position">
				<xsl:if test="string-length(inscription.position.gb) > 0">
					<xsl:element name="value">
						<xsl:attribute name="lang">
							<xsl:text>0</xsl:text>
						</xsl:attribute>
						<xsl:value-of select="inscription.position.gb"/>
					</xsl:element>
				</xsl:if>
				<xsl:if test="string-length(inscription.position) > 0">
					<xsl:element name="value">
						<xsl:attribute name="lang">
							<xsl:text>1</xsl:text>
						</xsl:attribute>
						<xsl:value-of select="inscription.position"/>
					</xsl:element>
				</xsl:if>
			</xsl:element>

			<xsl:element name="inscription.content">
				<xsl:choose>
					<xsl:when test="string-length(inscription.content.gb) > 0">
						<xsl:element name="value">
							<xsl:attribute name="lang">
								<xsl:text>0</xsl:text>
							</xsl:attribute>
							<xsl:value-of select="inscription.content.gb"/>
						</xsl:element>
					</xsl:when>
					<xsl:otherwise>
						<xsl:if test="string-length(inscription.content) > 0">
							<xsl:element name="value">
								<xsl:attribute name="lang">
									<xsl:text>0</xsl:text>
								</xsl:attribute>
								<xsl:value-of select="inscription.content"/>
							</xsl:element>
						</xsl:if>
					</xsl:otherwise>
				</xsl:choose>
				<xsl:if test="string-length(inscription.content) > 0">
					<xsl:element name="value">
						<xsl:attribute name="lang">
							<xsl:text>1</xsl:text>
						</xsl:attribute>
						<xsl:value-of select="inscription.content"/>
					</xsl:element>
				</xsl:if>
			</xsl:element>

			<xsl:element name="inscription.method">
				<xsl:choose>
					<xsl:when test="string-length(inscription.method.gb) > 0">
						<xsl:element name="value">
							<xsl:attribute name="lang">
								<xsl:text>0</xsl:text>
							</xsl:attribute>
							<xsl:value-of select="inscription.method.gb"/>
						</xsl:element>
					</xsl:when>
					<xsl:otherwise>
						<xsl:if test="string-length(inscription.method) > 0">
							<xsl:element name="value">
								<xsl:attribute name="lang">
									<xsl:text>0</xsl:text>
								</xsl:attribute>
								<xsl:value-of select="inscription.method"/>
							</xsl:element>
						</xsl:if>
					</xsl:otherwise>
				</xsl:choose>
				<xsl:if test="string-length(inscription.method) > 0">
					<xsl:element name="value">
						<xsl:attribute name="lang">
							<xsl:text>1</xsl:text>
						</xsl:attribute>
						<xsl:value-of select="inscription.method"/>
					</xsl:element>
				</xsl:if>
			</xsl:element>

			<xsl:element name="inscription.description">
				<xsl:if test="string-length(inscription.description.gb) > 0">
					<xsl:element name="value">
						<xsl:attribute name="lang">
							<xsl:text>0</xsl:text>
						</xsl:attribute>
						<xsl:value-of select="inscription.description.gb"/>
					</xsl:element>
				</xsl:if>
				<xsl:if test="string-length(inscription.description) > 0">
					<xsl:element name="value">
						<xsl:attribute name="lang">
							<xsl:text>1</xsl:text>
						</xsl:attribute>
						<xsl:value-of select="inscription.description"/>
					</xsl:element>
				</xsl:if>
			</xsl:element>

			<xsl:element name="inscription.figures">
				<xsl:if test="string-length(inscription.notes.gb) > 0">
					<xsl:element name="value">
						<xsl:attribute name="lang">
							<xsl:text>0</xsl:text>
						</xsl:attribute>
						<xsl:value-of select="inscription.notes.gb"/>
					</xsl:element>
				</xsl:if>
				<xsl:if test="string-length(inscription.notes) > 0">
					<xsl:element name="value">
						<xsl:attribute name="lang">
							<xsl:text>1</xsl:text>
						</xsl:attribute>
						<xsl:value-of select="inscription.notes"/>
					</xsl:element>
				</xsl:if>
			</xsl:element>
		</xsl:element>
	</xsl:template>

	<xsl:template match="label">
		<!-- parameter om alleen nieuwere etiketteksten online te tonen -->
		<xsl:param name="num">
			<xsl:value-of select="substring(label.date,1,4)"/>
		</xsl:param>

		<!-- alleen etiketteksten van na 2010 worden doorgeleverd -->
		<xsl:if test="$num > 2010">
			<xsl:element name="label">
				<xsl:apply-templates select="label.date"/>
				<xsl:apply-templates select="label.title"/>
				<xsl:apply-templates select="label.manufacture" />
				<xsl:apply-templates select="label.text"/>
				<!--xsl:apply-templates select="label.notes"/-->
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<!-- velden voor etiketteksten -->
	<xsl:template match="label.date">
		<xsl:element name="label.date">
			<xsl:element name="value">
				<xsl:attribute name="lang">
					<xsl:text>0</xsl:text>
				</xsl:attribute>
				<xsl:value-of select="../../labelgb/label.date.gb"/>
			</xsl:element>
			<xsl:element name="value">
				<xsl:attribute name="lang">
					<xsl:text>1</xsl:text>
				</xsl:attribute>
				<xsl:value-of select="."/>
			</xsl:element>
		</xsl:element>
	</xsl:template>

	<xsl:template match="label.title">
		<xsl:element name="label.title">
			<xsl:element name="value">
				<xsl:attribute name="lang">
					<xsl:text>0</xsl:text>
				</xsl:attribute>
				<xsl:value-of select="../../labelgb/label.title.gb"/>
			</xsl:element>
			<xsl:element name="value">
				<xsl:attribute name="lang">
					<xsl:text>1</xsl:text>
				</xsl:attribute>
				<xsl:value-of select="."/>
			</xsl:element>
		</xsl:element>
	</xsl:template>
	<xsl:template match="label.manufacture">
		<xsl:element name="label.maker">
			<xsl:element name="value">
				<xsl:attribute name="lang">
					<xsl:text>0</xsl:text>
				</xsl:attribute>
				<xsl:value-of select="../../labelgb/label.manufacture.gb"/>
			</xsl:element>
			<xsl:element name="value">
				<xsl:attribute name="lang">
					<xsl:text>1</xsl:text>
				</xsl:attribute>
				<xsl:value-of select="."/>
			</xsl:element>
		</xsl:element>
	</xsl:template>

	<xsl:template match="label.text">
		<xsl:element name="label.text">
			<xsl:element name="value">
				<xsl:attribute name="lang">
					<xsl:text>0</xsl:text>
				</xsl:attribute>
				<xsl:value-of select="../../labelgb/label.text.gb"/>
			</xsl:element>
			<xsl:element name="value">
				<xsl:attribute name="lang">
					<xsl:text>1</xsl:text>
				</xsl:attribute>
				<xsl:value-of select="."/>
			</xsl:element>
		</xsl:element>
	</xsl:template>

	<xsl:template match="label.notes">
		<xsl:element name="label.notes">
			<xsl:element name="value">
				<xsl:attribute name="lang">
					<xsl:text>0</xsl:text>
				</xsl:attribute>
				<xsl:value-of select="../../labelgb/label.notes.gb"/>
			</xsl:element>
			<xsl:element name="value">
				<xsl:attribute name="lang">
					<xsl:text>1</xsl:text>
				</xsl:attribute>
				<xsl:value-of select="."/>
			</xsl:element>
		</xsl:element>
	</xsl:template>

	<xsl:template match="current_location.name">
		<xsl:choose>
			<xsl:when test="contains(.,'PH')">
				<!-- philipsvleugel-->
				<xsl:element name="location">
					<xsl:value-of select="."/>
				</xsl:element>
			</xsl:when>
			<xsl:when test="contains(.,'HG')">
				<!--Hoofdgebouw -->
				<xsl:element name="location">
					<xsl:choose>
						<xsl:when test="string-length(part_of) > 0">
							<xsl:value-of select="part_of"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="name"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:element>
			</xsl:when>
			<xsl:when test="contains(.,'AK')">
			<!--Hoofdgebouw -->
			<xsl:element name="location">
				<xsl:choose>
					<xsl:when test="string-length(part_of) > 0">
						<xsl:value-of select="part_of"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="name"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:element>
			</xsl:when>
			<xsl:when test="contains(.,'BI-1.1')">
				<!--Cuypersbibliotheek -->
				<xsl:element name="location">
					<xsl:value-of select="."/>
				</xsl:element>
			</xsl:when>
			<xsl:when test="contains(.,'AK')">
				<!-- Aziatisch paviljoen -->
				<xsl:element name="location">
					<xsl:value-of select="."/>
				</xsl:element>
			</xsl:when>
			<!--xsl:when test="contains(.,'RM-SCHIPHOL')" -->
				<!-- Schiphol -->
				<!--xsl:element name="location">
					<xsl:text>Rijksmuseum Schiphol</xsl:text>
				</xsl:element>
			</xsl:when-->
			<!--xsl:otherwise>
				<xsl:text>n.a.</xsl:text>
			</xsl:otherwise-->
		</xsl:choose>
	</xsl:template>

	<!-- velden vervaardiger inc. biografische velden -->
	<xsl:template match="maker">
		<xsl:element name="maker">
			<xsl:apply-templates select="maker.type"/>			
			<xsl:apply-templates select="maker/name"/>
			<xsl:apply-templates select="maker/equivalent"/>
			<xsl:apply-templates select="maker/used_for"/>
			<!--xsl:apply-templates select="maker/birth_on"/-->
			<xsl:apply-templates select="maker/birth_on_precision"/>
			<xsl:apply-templates select="maker/birth.date.end"/>
			<xsl:apply-templates select="maker/born_at"/>
			<!--xsl:apply-templates select="maker/born_at_unknown"/-->
			<!--xsl:apply-templates select="maker/died_on"/-->
			<xsl:apply-templates select="maker/died_on_precision"/>
			<xsl:apply-templates select="maker/death.date.end"/>
			<xsl:apply-templates select="maker/died_at"/>
			<!--xsl:apply-templates select="maker/died_at_unkown"/-->
			<xsl:apply-templates select="maker/occupation"/>
			<xsl:apply-templates select="maker/nationality"/>
			<xsl:apply-templates select="maker/gender"/>
			<xsl:apply-templates select="maker/biography.nl"/>
			<xsl:apply-templates select="maker.rejected"/>
			<xsl:apply-templates select="maker.qualifier"/>
			<xsl:apply-templates select="maker.role"/>
			<xsl:apply-templates select="production.place"/>
			<xsl:apply-templates select="maker/PersistentIdentifier"/>
		</xsl:element>
	</xsl:template>
	
	<xsl:template match="maker.type">
		<xsl:element name="maker.type">
			<xsl:value-of select="value[@lang=0]"/>
		</xsl:element>
	</xsl:template>

	<xsl:template match="maker/name">
		<xsl:element name="name">
			<xsl:element name="value">
				<xsl:attribute name="lang">
					<xsl:text>0</xsl:text>
				</xsl:attribute>
				<xsl:choose>
					<xsl:when test="string-length(../name.gb) > 0">
						<xsl:value-of select="../name.gb"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="."/>
					</xsl:otherwise>
				</xsl:choose>

			</xsl:element>
			<xsl:element name="value">
				<xsl:attribute name="lang">
					<xsl:text>1</xsl:text>
				</xsl:attribute>
				<xsl:value-of select="."/>
			</xsl:element>
		</xsl:element>

		<xsl:element name="collection.catalogue">
			<xsl:element name="short.biography">
				<xsl:value-of select="../name.BS"/>
			</xsl:element>
			<xsl:element name="reference">
				<xsl:value-of select="literature.biography"/>
			</xsl:element>
		</xsl:element>
	</xsl:template>

	<!--xsl:template match="maker/birth_on">
		<xsl:element name="birth_on">
			<xsl:value-of select="."/>
		</xsl:element>
	</xsl:template-->

	<xsl:template match="maker/birth_on_precision">
		<xsl:element name="birth_on_precision">
			<xsl:element name="value">
				<xsl:attribute name="lang">
					<xsl:text>0</xsl:text>
				</xsl:attribute>
				<xsl:value-of select="value[2]"/>
			</xsl:element>
			<xsl:element name="value">
				<xsl:attribute name="lang">
					<xsl:text>1</xsl:text>
				</xsl:attribute>
				<xsl:value-of select="value[3]"/>
			</xsl:element>
		</xsl:element>
	</xsl:template>

	<xsl:template match="maker/birth.date.end">
		<xsl:element name="birth.date.end">
			<xsl:value-of select="."/>
		</xsl:element>
	</xsl:template>


	<xsl:template match="maker/died_on_precision">
		<xsl:element name="died_on_precision">
			<xsl:element name="value">
				<xsl:attribute name="lang">
					<xsl:text>0</xsl:text>
				</xsl:attribute>
				<xsl:value-of select="value[2]"/>
			</xsl:element>
			<xsl:element name="value">
				<xsl:attribute name="lang">
					<xsl:text>1</xsl:text>
				</xsl:attribute>
				<xsl:value-of select="value[3]"/>
			</xsl:element>
		</xsl:element>
	</xsl:template>

	<xsl:template match="maker/born_at">
		<xsl:element name="born_at">
			<xsl:value-of select="."/>
		</xsl:element>
	</xsl:template>

	<!--xsl:template match="maker/born_at_unknown">
		<xsl:element name="born_at_unkown">
			<xsl:value-of select="."/>
		</xsl:element>
	</xsl:template-->

	<!--xsl:template match="maker/died_on">
		<xsl:element name="died_on">
			<xsl:value-of select="."/>
		</xsl:element>
	</xsl:template-->

	<xsl:template match="maker/death.date.end">
		<xsl:element name="death.date.end">
			<xsl:value-of select="."/>
		</xsl:element>
	</xsl:template>

	<xsl:template match="maker/died_at">
		<xsl:element name="died_at">
			<xsl:value-of select="."/>
		</xsl:element>
	</xsl:template>

	<!--xsl:template match="maker/died_at_unknown">
		<xsl:element name="died_at_unkown">
			<xsl:value-of select="."/>
		</xsl:element>
	</xsl:template-->

	<xsl:template match="maker/occupation">
		<xsl:element name="occupation">
			<xsl:element name="value">
				<xsl:attribute name="lang">
					<xsl:text>0</xsl:text>
				</xsl:attribute>
				<xsl:value-of select="term.gb"/>
			</xsl:element>
			<xsl:element name="value">
				<xsl:attribute name="lang">
					<xsl:text>1</xsl:text>
				</xsl:attribute>
				<xsl:value-of select="term"/>
			</xsl:element>
		</xsl:element>
	</xsl:template>

	<xsl:template match="maker/nationality">
		<xsl:element name="nationality">
			<xsl:value-of select="."/>
		</xsl:element>
	</xsl:template>


	<xsl:template match="maker/gender">
		<xsl:element name="gender">
			<xsl:value-of select="value[2]"/>
		</xsl:element>
	</xsl:template>
	
	<xsl:template match="maker/biography.nl">
		<xsl:element name="biography.nl">
			<xsl:value-of select="."/>
		</xsl:element>
	</xsl:template>

	<xsl:template match="production.place">
		<xsl:element name="production.place">
			<!--xsl:element name="term"-->
			<xsl:element name="value">
				<xsl:attribute name="lang">
					<xsl:text>0</xsl:text>
				</xsl:attribute>
				<xsl:value-of select="term.gb"/>
			</xsl:element>
			<xsl:element name="value">
				<xsl:attribute name="lang">
					<xsl:text>1</xsl:text>
				</xsl:attribute>
				<xsl:value-of select="term"/>
			</xsl:element>
		</xsl:element>
		<xsl:element name="production.place.location">
			<xsl:if test="string-length(longitude) > 0">
				<xsl:element name="longitude">
					<xsl:value-of select="longitude"/>
				</xsl:element>
			</xsl:if>
			<xsl:if test="string-length(latitude) > 0">
				<xsl:element name="latitude">
					<xsl:value-of select="latitude"/>
				</xsl:element>
			</xsl:if>	
			<xsl:element name="PersistentIdentifier">
				<xsl:choose>
					<xsl:when test="string-length(term.number) > 0">
						<xsl:value-of select="term.number"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="PersistentIdentifier"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:element>
			<xsl:if test="string-length(../production.place.unknown/value[1]) > 0">
				<xsl:value-of select="../production.place.unknown/value[1]" />
			</xsl:if>	
			<!--/xsl:element-->
		</xsl:element>
	</xsl:template>

	<xsl:template match="maker.qualifier">
		<xsl:element name="maker.qualifier">
			<xsl:element name="value">
				<xsl:attribute name="lang">
					<xsl:text>0</xsl:text>
				</xsl:attribute>
				<xsl:value-of select="value[2]"/>
			</xsl:element>
			<xsl:element name="value">
				<xsl:attribute name="lang">
					<xsl:text>1</xsl:text>
				</xsl:attribute>
				<xsl:value-of select="value[3]"/>
			</xsl:element>
		</xsl:element>
	</xsl:template>

	<xsl:template match="maker.rejected">
		<xsl:if test=". = 'x'">
			<xsl:element name="maker.qualifier">
				<xsl:element name="value">
					<xsl:attribute name="lang">
						<xsl:text>0</xsl:text>
					</xsl:attribute>
					<xsl:text>rejected attribution</xsl:text>
				</xsl:element>
				<xsl:element name="value">
					<xsl:attribute name="lang">
						<xsl:text>1</xsl:text>
					</xsl:attribute>
					<xsl:text>verworpen toeschrijving</xsl:text>
				</xsl:element>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="maker.role">
		<xsl:element name="maker.role">
			<xsl:element name="value">
				<xsl:attribute name="lang">
					<xsl:text>0</xsl:text>
				</xsl:attribute>
				<xsl:value-of select="term.gb"/>
			</xsl:element>
			<xsl:element name="value">
				<xsl:attribute name="lang">
					<xsl:text>1</xsl:text>
				</xsl:attribute>
				<xsl:value-of select="term"/>
			</xsl:element>
		</xsl:element>
	</xsl:template>

	<xsl:template match="maker.school.style">
		<xsl:element name="maker.school.style">
			<xsl:element name="value">
				<xsl:attribute name="lang">
					<xsl:text>0</xsl:text>
				</xsl:attribute>
				<xsl:value-of select="term.gb"/>
			</xsl:element>
			<xsl:element name="value">
				<xsl:attribute name="lang">
					<xsl:text>1</xsl:text>
				</xsl:attribute>
				<xsl:value-of select="term"/>
			</xsl:element>
		</xsl:element>
	</xsl:template>


	<xsl:template match="maker/PersistentIdentifier">
		<xsl:element name="PersistentIdentifier">
				<xsl:value-of select="."/>
			</xsl:element>
	</xsl:template>
	
	<!-- Materiaalvelden in thesaurusvorm -->
	<xsl:template match="material">
		<xsl:element name="material">
			<xsl:element name="material">
				<xsl:apply-templates select="material/term"/>
			</xsl:element>
			<!--xsl:if test="string-length(material/term.number) > 0">
				<xsl:element name="PersistentIdentifier">
					<xsl:value-of select="material/term.number"/>
				</xsl:element>	
			</xsl:if-->
			<xsl:element name="PersistentIdentifier">
				<xsl:choose>
					<xsl:when test="string-length(material/source/term.number) > 0">
						<xsl:value-of select="material/source/term.number"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="material/PersistentIdentifier"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:element>
			<xsl:apply-templates select="material.part"/>
			<xsl:apply-templates select="material.notes"/>
		</xsl:element>
	</xsl:template>

	<xsl:template match="material.part">
		<xsl:element name="material.part">
			<xsl:value-of select="."/>
		</xsl:element>
	</xsl:template>

	<xsl:template match="material.notes">
		<xsl:element name="material.notes">
			<xsl:value-of select="."/>
		</xsl:element>
	</xsl:template>

	<xsl:template match="notes.public">
		<xsl:element name="curators.comment">
			<xsl:value-of select="."/>
		</xsl:element>
		<xsl:element name="curators.comment.date">
			<xsl:value-of select="../notes.public.date"/>
		</xsl:element>
	</xsl:template>

	<!-- objectnaam velden. Thesaurusvorm. zou uitgebreid kunnen worden met ET en NT -->
	<xsl:template match="object_name">
		<xsl:apply-templates select="object.name"/>
	</xsl:template>

	<xsl:template match="object.name">
		<xsl:element name="object.name">
			<xsl:element name="value">
				<xsl:attribute name="lang">
					<xsl:text>0</xsl:text>
				</xsl:attribute>
				<xsl:value-of select="term.gb"/>
			</xsl:element>
			<xsl:element name="value">
				<xsl:attribute name="lang">
					<xsl:text>1</xsl:text>
				</xsl:attribute>
				<xsl:value-of select="term"/>
			</xsl:element>
			<!-- LJ: voor OAI uitleveringen gaan we nu deze gegevens meezenden -->
			<xsl:element name="PersistentIdentifier">
				<xsl:choose>
					<xsl:when test="string-length(source/term.number) > 0">
						<xsl:value-of select="source/term.number"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="PersistentIdentifier"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:element>
		</xsl:element>
	</xsl:template>

	<xsl:template match="object.number">
		<xsl:element name="object.number">
			<xsl:value-of select="."/>
		</xsl:element>
	</xsl:template>

	<xsl:template match="part.of.ref">
		<xsl:element name="part.of.ref">
			<xsl:value-of select="."/>
		</xsl:element>
		<xsl:element name="part.of.title">
			<xsl:value-of select="../part.of.title"/>
		</xsl:element>
	</xsl:template>

	<xsl:template match="parts.ref">
		<xsl:element name="parts.ref">
			<xsl:value-of select="."/>
		</xsl:element>
		<xsl:element name="parts.title">
			<xsl:value-of select="../parts.title"/>
		</xsl:element>
	</xsl:template>

	<xsl:template match="priref">
		<xsl:element name="priref">
			<xsl:value-of select="."/>
		</xsl:element>
	</xsl:template>

	<xsl:template match="PersistentIdentifier">
		<xsl:element name="PersistentIdentifier">
			<xsl:text>hdl.handle.net/10934/</xsl:text>
			<xsl:value-of select="."/>
		</xsl:element>
	</xsl:template>

	<xsl:template match="provenance">
		<xsl:element name="provenance">
			<xsl:value-of select="provenance.project.txt"/>
		</xsl:element>
	</xsl:template>

	<xsl:template match="related_object">
		<xsl:choose>
			<xsl:when test="contains(.,'SK-L')">
			</xsl:when>
			<xsl:otherwise>
				<xsl:element name="related_object">
					<xsl:apply-templates select="related.ref"/>
					<!--xsl:apply-templates select="related.ref.type"/-->
					<xsl:apply-templates select="related.title"/>
				</xsl:element>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="related.ref">
		<xsl:element name="related.ref">
			<xsl:value-of select="."/>
		</xsl:element>
	</xsl:template>

	<!--xsl:template match="related.ref.type">
		<xsl:element name="related.ref.type">
			<xsl:apply-templates select="value"/>
		</xsl:element>
	</xsl:template-->

	<xsl:template match="related.title">
		<xsl:element name="related.title">
			<xsl:value-of select="."/>
		</xsl:element>
	</xsl:template>
	
	<xsl:template match="reproduction.online.available">
		<xsl:if test="contains(value[1],'J')">
		<xsl:element name="image.available">
			<xsl:value-of select="value[2]"/>
		</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="rights.copyrightnotice">
		<xsl:element name="rights.copyrightnotice">
			<xsl:value-of select="."/>
		</xsl:element>
		<xsl:element name="license">
			<xsl:text>Copyright protected</xsl:text>
		</xsl:element>
	</xsl:template>
	<xsl:template match="rights.type">
		<xsl:element name="rights.type">
			<xsl:value-of select="."/>
		</xsl:element>
	</xsl:template>

	<xsl:template match="rights.freeofrights">
		<xsl:element name="rights.freeofrights">
			<!-- hier ook waarde neutral meeleveren omdat er op gefilterd mag worden -->
			<xsl:apply-templates select="value"/>
			<xsl:choose>
				<xsl:when test="value[1] = 'YES'">
					<xsl:element name="license">
						<xsl:element name="content">Public Domain/Free of rights</xsl:element>
						<xsl:element name="reference">
							<xsl:text>http://creativecommons.org/publicdomain/mark/1.0/</xsl:text>
						</xsl:element>
					</xsl:element>
				</xsl:when>	
				<xsl:otherwise>
					<xsl:element name="license">
						<xsl:element name="content">Copyright protected/Legal rights attached to this objects</xsl:element>
					</xsl:element>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:element>
	</xsl:template>

	
	<xsl:template match="technique">
		<xsl:element name="technique">
			<xsl:element name="technique">
				<xsl:apply-templates select="technique/term"/>
			</xsl:element>
			<xsl:element name="PersistentIdentifier">
				<xsl:choose>
					<xsl:when test="string-length(technique/source/term.number) > 0">
						<xsl:value-of select="technique/source/term.number"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="technique/PersistentIdentifier"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:element>
			<xsl:apply-templates select="technique.part"/>
			<xsl:apply-templates select="technique.notes"/>
		</xsl:element>
	</xsl:template>

	<xsl:template match="technique.part">
		<xsl:element name="technique.part">
			<xsl:value-of select="."/>
		</xsl:element>
	</xsl:template>

	<xsl:template match="technique.notes">
		<xsl:element name="technique.notes">
			<xsl:value-of select="."/>
		</xsl:element>
	</xsl:template>


	<xsl:template match="title">
		<xsl:element name="title">
			<xsl:element name="title">
				<xsl:if test="string-length(title.gb) > 0">
					<xsl:element name="value">
						<xsl:attribute name="lang">
							<xsl:text>0</xsl:text>
						</xsl:attribute>
						<xsl:value-of select="title.gb"/>
					</xsl:element>
				</xsl:if>
				<xsl:element name="value">
					<xsl:attribute name="lang">
						<xsl:text>1</xsl:text>
					</xsl:attribute>
					<xsl:value-of select="title"/>
				</xsl:element>
			</xsl:element>
			<xsl:if test="string-length(title.type) > 0">
				<xsl:apply-templates select="title.type"/>
			</xsl:if>
		</xsl:element>
	</xsl:template>

	<xsl:template match="title.type">
		<xsl:element name="title.type">
			<xsl:element name="value">
				<xsl:attribute name="lang">
					<xsl:text>0</xsl:text>
				</xsl:attribute>
				<xsl:value-of select="value[2]"/>
			</xsl:element>
			<xsl:element name="value">
				<xsl:attribute name="lang">
					<xsl:text>1</xsl:text>
				</xsl:attribute>
				<xsl:value-of select="value[3]"/>
			</xsl:element>
		</xsl:element>
	</xsl:template>

	<xsl:template match="title.int">
		<xsl:element name="title.international">
			<xsl:value-of select="."/>
		</xsl:element>
	</xsl:template>

	<!-- wijze waarop een record online gepresenteerd mag worden: het mag wel\niet en wel\niet met afbeelding getoond worden -->
	<xsl:template match="publish.api">
		<xsl:element name="publication.api">
			<!-- hier ook waarde neutral meeleveren omdat er op gefilterd mag worden -->
			<xsl:apply-templates select="value"/>
		</xsl:element>
		<xsl:if test="string-length(../publish.api.spec-set) > 0">
		<xsl:element name="publication.api">
			<xsl:element name="value">
				<xsl:attribute name="lang">
					<xsl:text>neutral</xsl:text>
				</xsl:attribute>
				<!-- hier ook waarde neutral meeleveren omdat er op gefilterd mag worden -->
				<xsl:value-of select="../publish.api.spec-set/value[1]"/>
			</xsl:element>
			<xsl:element name="value">
				<xsl:attribute name="lang">
					<xsl:text>neutral</xsl:text>
				</xsl:attribute>
				<!-- hier ook waarde neutral meeleveren omdat er op gefilterd mag worden -->
				<xsl:value-of select="../publish.api.spec-set/value[2]"/>
			</xsl:element>
			<xsl:element name="value">
				<xsl:attribute name="lang">
					<xsl:text>neutral</xsl:text>
				</xsl:attribute>
				<!-- hier ook waarde neutral meeleveren omdat er op gefilterd mag worden -->
				<xsl:value-of select="../publish.api.spec-set/value[3]"/>
			</xsl:element>			
		</xsl:element>
		</xsl:if>	
	</xsl:template>

	<xsl:template match="publish.website">
		<xsl:element name="publish.website">
		<xsl:choose> <!-- LJ:2015-08 alleen als de beeldkwaliteit niet snapshot is dan mag het beeldmateriaal op de website getoond worden. Om dat vast te stellen wordt het veld publish.website.image-quality uitgelezen -->
			<xsl:when test="../publish.website.image-quality/value[1] = 'NO'">
				<xsl:element name="value">				
					<xsl:attribute name="lang">
						<xsl:text>neutral</xsl:text>
					</xsl:attribute>
					<xsl:text>2</xsl:text>
				</xsl:element>
				<xsl:element name="value">
					<xsl:attribute name="lang">
						<xsl:text>0</xsl:text>
					</xsl:attribute>
					<xsl:text>Publish without image</xsl:text>
				</xsl:element>
				<xsl:element name="value">
					<xsl:attribute name="lang">
						<xsl:text>1</xsl:text>
					</xsl:attribute>
					<xsl:text>Publiceren zonder beeld</xsl:text>
				</xsl:element>
			</xsl:when>
			<xsl:otherwise>
				<!-- hier ook waarde neutral meeleveren omdat er op gefilterd mag worden -->
				<xsl:apply-templates select="value"/>
			</xsl:otherwise>	
		</xsl:choose>	
		</xsl:element>
	</xsl:template>

	<xsl:template match="project.label">
		<xsl:element name="project.label">
			<!-- hier ook waarde neutral meeleveren omdat er op gefilterd mag worden -->
			<xsl:apply-templates select="value"/>
		</xsl:element>
	</xsl:template>

	<!-- velden die alleen voor bestandscatalogus gelden -->
	<xsl:template match="catalogue.object.title">
		<xsl:element name="object.title">
			<xsl:element name="value">
				<xsl:attribute name="lang">
					<xsl:text>0</xsl:text>
				</xsl:attribute>
				<xsl:value-of select="."/>
			</xsl:element>
		</xsl:element>
	</xsl:template>

	<xsl:template match="bestCat/catalogue.title">
		<xsl:element name="catalogue.title">
			<xsl:value-of select="."/>
		</xsl:element>
		<xsl:element name="catalogue.author">
			<xsl:value-of select="../author.catalogue.entry"/>
		</xsl:element>
		<xsl:element name="catalogue.date">
			<xsl:value-of select="../date.catalogue.entry"/>
		</xsl:element>
		<xsl:apply-templates select="../catalgueRevision"/>
	</xsl:template>

	<xsl:template match="catalgueRevision">
		<xsl:element name="catalogue.revision">
			<xsl:element name="author">
				<xsl:value-of select="author.catalogue.entry.revision"/>
			</xsl:element>
			<xsl:element name="date">
				<xsl:value-of select="date.catalogue.entry.revision"/>
			</xsl:element>
		</xsl:element>
	</xsl:template>


	<xsl:template match="technical_notes.gb">
		<xsl:element name="technical.notes">
			<xsl:element name="value">
				<xsl:attribute name="lang">
					<xsl:text>0</xsl:text>
				</xsl:attribute>
				<xsl:value-of select="."/>
			</xsl:element>
			<!-- LJ: er is geen nederlandse versie van dit veld!
					xsl:element name="value">
						<xsl:attribute name="lang">
							<xsl:text>1</xsl:text>
						</xsl:attribute>
						<xsl:value-of select="inscription.description"/>
					</xsl:element -->
		</xsl:element>
	</xsl:template>

	<xsl:template match="examination">
		<xsl:element name="assesment">
			<xsl:element name="assesment.method">
				<xsl:element name="value">
					<xsl:attribute name="lang">
						<xsl:text>0</xsl:text>
					</xsl:attribute>
					<xsl:value-of select="assesment.method/value[2]"/>
				</xsl:element>
				<xsl:element name="value">
					<xsl:attribute name="lang">
						<xsl:text>1</xsl:text>
					</xsl:attribute>
					<xsl:value-of select="assesment.method/value[3]"/>
				</xsl:element>
			</xsl:element>
			<xsl:element name="investigator">
				<xsl:value-of select="investigator.gb"/>
			</xsl:element>
			<xsl:element name="institution">
				<xsl:value-of select="institution.gb"/>
			</xsl:element>
			<xsl:if test="string-length(reference.number.gb) > 0">
				<xsl:element name="reference.number">
					<xsl:value-of select="reference.number.gb"/>
				</xsl:element>
			</xsl:if>
			<xsl:element name="research.date">
				<xsl:value-of select="date.early.research.gb"/>
				<xsl:if test="(date.early.research.gb &lt; date.late.research.gb) ">
					<xsl:text> - </xsl:text>
					<xsl:value-of select="date.late.research.gb"/>
				</xsl:if>
			</xsl:element>
		</xsl:element>
	</xsl:template>

	<xsl:template match="assesment.literature">
		<xsl:element name="scientific.examination">
			<xsl:element name="literature">
				<xsl:value-of select="."/>
			</xsl:element>
		</xsl:element>
	</xsl:template>

	<xsl:template match="condition">
		<xsl:element name="condition">
			<xsl:element name="value">
				<xsl:attribute name="lang">
					<xsl:text>0</xsl:text>
				</xsl:attribute>
				<xsl:value-of select="condition.description.gb"/>
			</xsl:element>
			<xsl:if test="string-length(condition.description) > 0">
				<xsl:element name="value">
					<xsl:attribute name="lang">
						<xsl:text>1</xsl:text>
					</xsl:attribute>
					<xsl:value-of select="condition.description"/>
				</xsl:element>
			</xsl:if>
		</xsl:element>
	</xsl:template>

	<xsl:template match="treatment">
		<xsl:element name="conservation">
			<xsl:element name="conservator">
				<xsl:value-of select="treatment.name"/>
			</xsl:element>
			<xsl:if test="string-length(treatment.reference) > 0">
				<xsl:element name="reference">
					<xsl:value-of select="treatment.reference"/>
				</xsl:element>
			</xsl:if>
			<xsl:element name="date">
				<xsl:value-of select="treatment.date.early"/>
			</xsl:element>
			<xsl:if test="string-length(treatment.notes.gb) > 0">
				<xsl:element name="notes">
					<xsl:value-of select="treatment.notes.gb"/>
				</xsl:element>
			</xsl:if>
		</xsl:element>
	</xsl:template>

	<xsl:template match="literature.entry.gb">
		<xsl:element name="literature">
			<xsl:value-of select="."/>
		</xsl:element>
	</xsl:template>

	<xsl:template match="catalogue.prev.catalogs">
		<xsl:element name="collection.catalogue">
			<xsl:value-of select="."/>
		</xsl:element>
	</xsl:template>

	<xsl:template match="literature.archive.gb">
		<xsl:element name="archives">
			<xsl:value-of select="."/>
		</xsl:element>
	</xsl:template>

	<xsl:template match="literature.object.gb">
		<xsl:element name="reference.objects">
			<xsl:value-of select="."/>
		</xsl:element>
	</xsl:template>

	<xsl:template match="bsRemark">
		<xsl:element name="add.tech.information">
			<xsl:choose>
				<xsl:when test="string-length(bestandscatalogus.technical.notes.type.gb/value[1]) > 0">
					<xsl:variable name="TECHNO" select="bestandscatalogus.technical.notes.type.gb/value[1]" />
					<xsl:element name="{$TECHNO}">
						<xsl:value-of select="bestandscatalogus.technical.notes.gb"/>
					</xsl:element>
				</xsl:when>
				<xsl:otherwise>
					<xsl:element name="original.framing">
						<xsl:value-of select="bestandscatalogus.technical.notes.gb"/>
					</xsl:element>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:element>
	</xsl:template>

	<!-- end of stylesheet -->

	<!-- Vierde laag: Nested field matches -->
	<xsl:template match="value">
		<xsl:element name="value">
			<xsl:attribute name="lang">
				<xsl:value-of select="@lang"/>
			</xsl:attribute>
			<xsl:value-of select="."/>
		</xsl:element>
	</xsl:template>

	<!--thesauruslagen -->
	<xsl:template match="term">
		<xsl:element name="value">
			<xsl:attribute name="lang">
				<xsl:text>0</xsl:text>
			</xsl:attribute>
			<xsl:value-of select="../term.gb"/>
		</xsl:element>
		<xsl:element name="value">
			<xsl:attribute name="lang">
				<xsl:text>1</xsl:text>
			</xsl:attribute>
			<xsl:value-of select="."/>
		</xsl:element>
	</xsl:template>


	<!-- Level2: diagnostische informatie over de dataset -->
	<xsl:template match="hits">
		<xsl:element name="hits">
			<xsl:value-of select="."/>
		</xsl:element>
	</xsl:template>

	<xsl:template match="xmltype">
		<xsl:element name="xmltype">
			<xsl:value-of select="."/>
		</xsl:element>
	</xsl:template>

	<xsl:template match="first_item">
		<xsl:element name="first_item">
			<xsl:value-of select="."/>
		</xsl:element>
	</xsl:template>

	<xsl:template match="search">
		<xsl:element name="search">
			<xsl:value-of select="."/>
		</xsl:element>
	</xsl:template>

	<xsl:template match="sort">
		<xsl:element name="sort">
			<xsl:value-of select="."/>
		</xsl:element>
	</xsl:template>

	<xsl:template match="limit">
		<xsl:element name="limit">
			<xsl:value-of select="."/>
		</xsl:element>
	</xsl:template>

	<xsl:template match="hits_on_display">
		<xsl:element name="hits_on_display">
			<xsl:value-of select="."/>
		</xsl:element>
	</xsl:template>

	<!--xsl:template match="response_time">
		<xsl:element name="response_time">
			<xsl:attribute name="unit">
				<xsl:text>mS</xsl:text>
			</xsl:attribute>
			<xsl:attribute name="culture">
				<xsl:text>en-US</xsl:text>
			</xsl:attribute>
			<xsl:value-of select="."/>
		</xsl:element>
	</xsl:template>

	<xsl:template match="xml_creation_time">
		<xsl:element name="xml_creation_time">
			<xsl:attribute name="unit">
				<xsl:text>mS</xsl:text>
			</xsl:attribute>
			<xsl:attribute name="culture">
				<xsl:text>en-US</xsl:text>
			</xsl:attribute>
			<xsl:value-of select="."/>
		</xsl:element>
	</xsl:template>

	<xsl:template match="link_resolve_time">
		<xsl:element name="link_resolve_time">
			<xsl:attribute name="unit">
				<xsl:text>mS</xsl:text>
			</xsl:attribute>
			<xsl:attribute name="culture">
				<xsl:text>en-US</xsl:text>
			</xsl:attribute>
			<xsl:value-of select="."/>
		</xsl:element>
	</xsl:template>

	<xsl:template match="dbname">
		<xsl:element name="dbname">
			<xsl:value-of select="."/>
		</xsl:element>
	</xsl:template>

	<xsl:template match="dsname">
		<xsl:element name="dsname">
			<xsl:value-of select="."/>
		</xsl:element>
	</xsl:template-->


	<xsl:template match="error">
		<xsl:element name="error">
			<xsl:value-of select="message"/>
		</xsl:element>
	</xsl:template>

	<xsl:template match="cgistring">
		<xsl:element name="cgistring">
			<xsl:value-of select="."/>
		</xsl:element>
	</xsl:template>

</xsl:stylesheet>


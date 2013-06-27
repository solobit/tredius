Als voorbeeld overgebleven
Als voorbeeld overgebleven

        collections:

            pages: -> @getCollection('documents').findAllLive({pageOrder:$exists:true},[pageOrder:1])

        }
        collections:

            pages: -> @getCollection('documents').findAllLive({pageOrder:$exists:true},[pageOrder:1])

        }

### (Web 3.0) Vocabularies of web ontologies
XML Namespace URI's for the semantic web <http://www.w3.org/2001/sw/>

What is the Semantic Web? The Semantic Web provides a common framework that
allows data to be shared and reused across application, enterprise, and
community boundaries. It is a collaborative, very-long term effort led by
[W3C][w3c] with participation from a large number of researchers and industrial
partners.

It is based on the [Resource Description Framework (RDF)][rdf].

[rdf]: <www>
[w3c]: <www>

                vocabulaire: {'xmlns:s'     : 'http://schema.org/'

[Schema.org][s] provides a collection of shared vocabularies webmasters can use
to mark up their pages in ways that can be understood by the major search
engines: Google, Microsoft, Yandex and Yahoo! You use the schema.org
[vocabulary][sv], along with the microdata format, to add information to your
HTML content. While the long term goal is to support a wider range of formats,
the initial focus is on Microdata.


                            , 'xmlns:gr'    : 'http://purl.org/goodrelations/v1#'
                            , 'xmlns:rdfs'  : 'http://www.w3.org/2000/01/rdf-schema#'
                            , 'xmlns:vcard' : 'http://www.w3.org/2006/vcard/ns#'


The [Friend of a Friend (FOAF)][foaf] project is creating a Web of machine-
readable pages describing people, the links between them and the things they
create and do; it is a contribution to the linked information system known as
the Web. FOAF [defines][foafs] an open, decentralized technology for connecting
social Web sites, and the people they describe. FOAF is a simple technology that
makes it easier to share and use information about people and their activities
(eg. photos, calendars, weblogs), to transfer information between Web sites, and
to automatically extend, merge and re-use it online.

                            , 'xmlns:foaf'  : 'http://xmlns.com/foaf/0.1/'


The Open Graph protocol enables any web page to become a rich object in a social
graph. For instance, this is used on Facebook to allow any web page to have the
same functionality as any other object on Facebook.

[Klik hier voor meer informatie](/handleiding/semantisch/ogp.html)


                            , 'xmlns:xsd'   : 'http://www.w3.org/2001/XMLSchema#'
                            , 'xmlns:v'     : 'http://rdf.data-vocabulary.org/#'
                            , 'xmlns:pto'   : 'http://www.productontology.org/id/'
                            , 'xmlns:wn'    : 'http://xmlns.com/wordnet/1.6/'}

[s]: <http://schema.org/docs/gs.html>
[sv]: <http://schema.org/docs/full.html>
[ogp]: <http://ogp.me/>
[foaf]: <http://www.xml.com/pub/a/2004/02/04/foaf.html>
[foafs]: <http://xmlns.com/foaf/spec/>

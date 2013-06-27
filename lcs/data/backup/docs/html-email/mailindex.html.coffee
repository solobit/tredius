### cson
titel:			'Tredius vertelt'
subtitel:		'Fiscale voordelen en een interview met René Goeth'
layout:		'nieuwsmail'
kenmerk:		'ttNieuwsOverzicht'
uitgave:		'april'
jaargang:		'2013'
datum:			'dinsdag 16 april 2013'
bannier:		'/media/afbeeldingen/bg_ttime.jpg'
postbannier:	'/media/afbeeldingen/bg_ttime_vervaagd.jpg'
illustratie:	'/media/afbeeldingen/tredius_juridisch.png'

samenvatting: """Lees nu alles omtrent de laatste fiscale voordelen voor u als
ondernemer in T-Time. En lees het interview dat Tredius had met René Goeth,
franchisenemer van Rivièra Maison, wat zij verstaan onder ondernemen en hoe
Tredius hen daar bij helpt."""

###

# Data ophalen QueryEngine en Backbone
nieuwsbrieven = @verzameling({nieuwsbrief:@document.uitgave},[date:-1])
testimonials  = @verzameling({testimonial:@document.uitgave},[date:-1])

# PDF testing


# Weergeven informatie
h1 '.ttNieuwsOverzicht-kop1', 'U onderneemt, Tredius doet de rest'

section '.ttNieuwsOverzicht-headlines', ->

	# List comprehensions
	for item in testimonials

		a '.ttNieuwsOverzicht--openen', href: item.urls[0], ->

			# Testimonials
			article '.ttNieuwsOverzicht-artikel', ->

				# Kolom links
				section '.ttNieuwsOverzicht-illustratie', ->
					img src: item.illustratie

				# Kolom rechts
				section '.ttNieuwsOverzicht-katern', ->
					h3  '.ttNieuwsOverzicht-titel'		, item.titel
					p   '.ttNieuwsOverzicht-intro'		, item.samenvatting
					a   '.ttNieuwsOverzicht-verder'	, href: item.urls[0]
					, 'Lees Verder'


# Actualiteiten (artikelen)
h1 '.ttNieuwsOverzicht-kop2', 'Tredius Actualiteiten'

section '.ttNieuwsOverzicht-actualiteit', ->

	# List comprehensions actueel
	for nieuws in nieuwsbrieven

		article '.ttNieuwsOverzicht-artikel', ->
			h3  '.ttNieuwsOverzicht-titel'		, nieuws.titel
			p   '.ttNieuwsOverzicht-intro'		, nieuws.samenvatting
			a   '.ttNieuwsOverzicht-verder'	, href: nieuws.urls[0]
			, 'Lees Verder'




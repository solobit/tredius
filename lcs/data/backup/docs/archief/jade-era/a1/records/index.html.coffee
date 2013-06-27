---
layout: 'page'
---

# Post Listing
nb = []
for document in @getCollection('nieuwsbrieven').toJSON()
	nb.push(document)
if nb.length
	text @partial 'overzicht/nieuwsbrief-lijst.html.coffee', {
		documents: nb
	}

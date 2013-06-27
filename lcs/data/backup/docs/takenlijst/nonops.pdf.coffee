
        maakPDF: ->
            PDFDocument = require 'pdfkit'
            doc = new PDFDocument

            # Meta-data pdf
            info:
                Title: 'Test Document'
                Author: 'Solobit'
                Subject: 'T-Time nieuwsbrief'
                Keywords: "tredius, nieuwsbrief, actualiteiten,
                ondernemers, MKB Nederland, juridisch, belasting"
                CreationDate: new Date()

            doc.addPage
                size: 'A4'
                layout: 'portrait'

            doc.output (string) ->
                console.log string
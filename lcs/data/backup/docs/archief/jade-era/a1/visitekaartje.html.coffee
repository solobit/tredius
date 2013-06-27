
//-

  vCard is een bestandstype en standaard voor de uitwisseling van
  persoonsgegevens, met name voor elektronische visitekaartjes. vCards worden
  vaak als bijlage met e-mailberichten meegestuurd. Maar ze kunnen ook op andere
  manieren uitgewisseld worden, bijvoorbeeld via het wereldwijde web of mobiele
  telefonie. Ze kunnen naam- en adresgegevens bevatten, telefoonnummers, URLs,
  logo's, foto's, en zelfs stukjes geluid.

.vcard(itemscope, itemtype="s:Person")

  .fn(itemprop="name") #{naam}

  .title(itemprop="jobTitle") #{titel}

  a.email(itemprop="email", href="mailto:#{email}") #{email}

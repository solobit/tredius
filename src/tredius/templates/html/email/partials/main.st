
/*
  The following styles should be moved to inline styles!
  -----------------------------------------------------
*/

/* Sensible defaults for images */

img {
  outline: none;
  text-decoration: none;
  -ms-interpolation-mode: bicubic;
}

a img {
  border: none;
}

.image_fix {
  display: block;
}

/* Yahoo paragraph fix */

p {
  margin: 1em 0;
}

/* Hotmail header color reset	*/

h1, h2, h3, h4, h5, h6
{
  color: $header$ !important;
}

h1 a, h2 a, h3 a, h4 a, h5 a, h6 a
{
  color: $hlink$ !important;
}

/* Preferably not the same color as normal header link.
Limited support for psuedo classes in mail clients, added for good measure. */

h1 a:active,
h2 a:active,
h3 a:active,
h4 a:active,
h5 a:active,
h6 a:active
{
  color: $hactive$ !important;
}

/* Preferably not the same color (visited) */

h1 a:visited,
h2 a:visited,
h3 a:visited,
h4 a:visited,
h5 a:visited,
h6 a:visited
{
  color: $hvisited$ !important;
}

/* Remove spacing around Outlook 07, 10 tables Bring inline: Yes */

table
{
  border-collapse: collapse;
  mso-table-lspace: 0pt;
  mso-table-rspace: 0pt;
}

/* Yahoo: colors uniform across clients when brought inline. */

a {
  color: $anchor$;
}

/*
a:link { color: $alink$; }
a:visited { color: $$avisited; }
a:hover { color: $$ahover; }
*/

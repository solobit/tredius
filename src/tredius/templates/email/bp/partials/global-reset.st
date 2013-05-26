

/*
  Global reset + fixes
  --------------------
*/

/* Force Outlook to provide a 'view in browser' menu link. */

#outlook a {
  padding:0 ;
}

body{
  width:100% !important;
  -webkit-text-size-adjust: 100%;
  -ms-text-size-adjust: 100%;
  margin: 0;
  padding: 0;
}

/* Prevent Webkit and Win Mobile from changing default font sizes.*/

.ExternalClass {
  width: 100%;
}

/* Force Hotmail to display emails at full width */

.ExternalClass,
.ExternalClass p,
.ExternalClass span,
.ExternalClass font,
.ExternalClass td,
.ExternalClass div
{
  line-height: 100%;
}

/* Force Hotmail to normal line spacing. */

#backgroundTable {
  margin: 0;
  padding: 0;
  width: 100% !important;
  line-height: 100% !important;
}

/* Outlook 07, 10 Padding issue fix */

table td
{
  border-collapse: collapse;
}


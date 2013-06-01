
/*
  Mobile targeting using media queries
  Use @media queries with care!!!
*/

@media only screen and (max-device-width: 480px) {

  /* controlling phone number linking for mobile */
  a[href^="tel"],
  a[href^="sms"] {
    text-decoration: none;
    color: $primary$;
    pointer-events: none;
    cursor: default;
  }

  .mobile_link a[href^="tel"],
  .mobile_link a[href^="sms"] {
    text-decoration: default;
    color: $alternate$ !important;
    pointer-events: auto;
    cursor: default;
  }

}

/* Medius sized screens: ipad (tablets, smaller screens, etc)  */

@media only screen and (min-device-width: 768px) and (max-device-width: 1024px) {

  a[href^="tel"],
  a[href^="sms"] {
    text-decoration: none;
    color: $primary$;
    pointer-events: none;
    cursor: default;
  }

  .mobile_link a[href^="tel"],
  .mobile_link a[href^="sms"] {
    text-decoration: default;
    color: $alternate$ !important;
    pointer-events: auto;
    cursor: default;
  }
}

/* Target specific devices */

$android-low()$

$android-medium()$

$android-high()$

$iphone-4g()$







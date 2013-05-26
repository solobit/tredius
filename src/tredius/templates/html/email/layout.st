<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>

  <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

	<meta name="viewport" content="width=device-width, initial-scale=$scale$"/>

  <title>$title$</title>

	<style type="text/css">

    $partials/reset()$

    $partials/main()$

    $partials/queries()$

	</style>

    $vendors/ie-mobile7()$

    $vendors/msoffice-9()$

</head>


<body>

<!-- Wrapper: control width and background consistently, instead of using body attributes. -->
<table cellpadding="0" cellspacing="0" border="0" id="backgroundTable" style="$wrapper$">
	<tr>
		<td valign="top">

      <!-- Inner table main body-->
      $partials/body()$



      <!--todo-->

		<a href="$links.url$" target ="_blank" title="$links.title$" style="color: $alink$; text-decoration: none;">$links.text$</a>


    <img class="image_fix" src="$images.path$" alt="$images.alt$" title="$images.title$" width="$images.width$" height="$images.height$" />


		<!-- Working with telephone numbers (including sms prompts).  Use the ??? "mobile" class to style appropriately in desktop clients
		versus mobile clients. -->
		<span class="mobile_link">$mobile$</span>



		</td>
	</tr>
</table>

</body>
</html>


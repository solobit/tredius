-*- markdown -*-

# Clj-StringTemplate v0.2

Clj-StringTemplate is a simple wrapper around the StringTemplate
library. The supported operations are:

* Create empty view template or one from a string template
* Load view template from classpath
* Load view template from directory
* Reset view template (side effect) to a string template
* Populate view template with attribute/values
* Render view template as java.lang.String


## Usage

Maven/Leiningen dependency details are here: [http://clojars.org/org.bituf/clj-stringtemplate](http://clojars.org/org.bituf/clj-stringtemplate)

Examples for usage can be found in the tutorial below:


## Building/Installation

You will need Maven 2 to build from sources. Execute the following:

    $ mvn clean package  # packages up a JAR in "target" dir
    $ mvn install        # to install to your local Maven repo
    $ mvn clojure:gendoc # generate Clojure API documentation


## License

Copyright (C) 2010 Shantanu Kumar (kumar.shantanu at gmail dot com)

Distributed under the Apache 2 License.


# Tutorial

Clj-StringTemplate can be used by including the following in your
namespace:

    (ns example.app
      (:use org.bituf.clj-stringtemplate))


## Create empty view template

    (create-view)

This creates an empty view template, which is not very useful by itself. You
can reset the template using reset-view! (described below).


## Create view template from specified string template

    (create-view "hello $adjective$ world")

The snippet above will create a view template using the specified string
"hello $adjective$ world".


## Load view template from classpath

    (get-view-from-classpath "hello")

The snippet above will look for the file called <i>hello.st</i> at the
top level in classpath, and will return the view template.

    (get-view-from-classpath "foo/hello")

The above snippet will look for the file called <i>hello.st</i> under
the package <i>foo</i> at the top level in classpath, and will return
the view template.

    (get-view-from-classpath "foo/bar/hello")

The above snippet will do the same as the earlier one, but under the
package <i>foo.bar</i>.


## Load view template from directory

    (get-view-from-dir "hello" "/home/joe/templates")

The above snippet will look for the file
<i>/home/joe/templates/hello.st</i> and will return the view template.

    (get-view-from-dir "foo/hello" "/home/joe/templates")

The above snippet will look for the file
<i>/home/joe/templates/foo/hello.st</i> and will return the view
template.

    (get-view-from-dir "foo/bar/hello" "/home/joe/templates")

The above snippet will look for the file
<i>/home/joe/templates/foo/bar/hello.st</i> and will return the view
template.


## Reset view template using specified string template

    (let [view (create-view "hello")]
      ...
      (reset-view! view "hello $adjective$ world")
      ...
      (fill-view! view "name" "Henry")
      ...)

The snippet above first creates a view template, then resets it with another
template.


## Populate view template with attribute/values

    (let [view (get-view-from-classpath "hello")]
      (fill-view! view "name" "Henry")
      ...)

The snippet above sets value for the attribute "name" in the view
template.

    (let [view (get-view-from-classpath "hello")]
      (fill-view! view "names" ["Henry" "Neal" "Rama"])
      ...)

The snippet above sets a multi-value (essentially a List) for the
attribute "names" in the view template.

    (let [view (get-view-from-classpath "hello")]
      (fill-view! view {"names" ["Henry" "Neal" "Rama"]
                        "title" "List of names"} )
      ...)

The snippet above sets the corresponding values for the
attributes "names" and "title" in the view template.


## Render view template as <i>java.lang.String</i>

    (let [view   (get-view-from-classpath "hello")
          filled (fill-view! view "name" "Henry")]
      (println (render-view filled)))

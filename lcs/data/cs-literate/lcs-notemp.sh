#!/usr/bin/env bash
# vim: ft=sh:ts=4:sts=4:sw=4:et:nospell

# Robust portable bash shell script for Literate CoffeeScript
# ===========================================================

# made by Rob Jentzema (supersym) on 【ツ】 Fri 03 May 2013

# Untangles the .litcoffee file given as the only input parameter to this
# script and both creates the bare-metal `.js` and from this file, round-trip
# to `.coffee` with all text stripped and only code left.

# Syntax highlighting and other tools for Sublime2 and Vim
# https://github.com/jashkenas/coffee-script-tmbundle
# https://github.com/mintplant/vim-literate-coffeescript


# Protect subshell
set -o errexit
set -o nounset

# Some terminal color
norm=$(tput sgr0)
fail=$(tput setaf 1)
good=$(tput setaf 2)
name=$(tput setaf 3)


# More eye-candy from way back
artwork () {
x="$fail❤$norm"
cat <<EOF

            __..._ _...__                 )  (
       _..-"     \`Y\`     "-.._          (   ) )
      \\ Once upon | Literate /           ) ( (
      \\\\  a time, |    $x    //        (_______)_
      \\\\\\  two..  | Coffee ///      .-'---------|
       \\\\\\ _..---.|.---.._ ///     ( C|S\/\\/\\/\\/|
      LP\\\\\`_..---.Y.---.. \`//       '-./\\/\\/\\/\\/|
         '\`               \`'          '_________'
                                       '-------'

EOF
}

# Helper functions
die () {  printf >&2 "%s %s\n" "$fail✗$norm Failed! " "$@" && exit 1; }
show () { printf "%s %s\n" "$good ✓$norm" "Created a file $name$1$norm"; }
#clean () { rm -rf $tmpdir; exit 1; } # ok to reference var already

# Sanity checks and to limit what we accept as valid input
[ "$#" -eq 1 ] || die "1 argument required, $# provided"

# Member variables for file name can be interpolated now
filename="${1}" # safety first, escape and brace expand properly
basename=$(basename $filename) # strips only path from sanitized name
extension="${filename##*.}" # obtains file extension from the input
shortname="${basename%.*}" # stripped off path and no extension

# Pre-flight final safety checks before take-off
[[ -s "$filename" ]] || die "This file doesn't exist or is 0 bytes in size."
[[ -r "$filename" ]] || die "You don't have permissions to read this file."
[[ $extension = "litcoffee" ]] || die "You must provide a .litcoffee file"
[[ $shortname != "" ]] || die "Name can't be a empty string value"
#trap clean SIGHUP SIGINT SIGTERM # trap errors

artwork # Showtime!


coffee -p -b "${filename}.litcoffee" > "${shortname}.js" && show "${shortname}.js"
js2coffee "${shortname}.js" > "${shortname}.coffee" && show "${shortname}.coffee"

exit $?


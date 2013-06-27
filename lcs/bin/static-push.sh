
checked() { echo "[$(tput setaf 3)done($tput sgr0)]" }

echo -n "Cleaning docpad..........."                 &&\
(docpad clean &> /dev/null)                          && checked &&\
echo -n "Generating static files..."                 &&\
(docpad generate --env static &> /dev/null)          && checked &&\
echo -n "Adding files to git......."                 &&\
(git add . &> /dev/null)                             &&\
(git commit -am \"update $(date +%s)\" &> /dev/null) && checked
  # do not push just yet


printf "\n%s%s\n" "$(tput setaf 2)
Static file changes:$(tput sgr0)" "
--------------------"

git show --pretty="format:" --name-only|grep 'uitvoer/'

# When invoked directly from the command line, the sed expression which is used by this script
# should look as follows;
#
#   sed -n -e 's/^[.]\?\([0-9]\+\)$/\1/p'
#
# If however, this sed expression is invoked from within an Autoconf macro, then some alterations
# will need to be made to it in order to prevent the Autoconf utility from interpreting some of the
# characters.
#
# In particular, the following substitutions will need to be made;
#
#   Replace the '[' character with the following character sequence : @<:@
#   Replace the ']' character with the following character sequence : @:>@
#
# Furthermore, some of the characters need to be backslash escaped in either scenario, i.e. whether
# the sed expression is being used directly from the command line or within an Autoconf macro. These
# characters include;
#
#   '?'
#   '+'
#   '('
#   ')'
#
# Finally, the sed command line utiliry does not support the lookbehind feature. It is for this
# reason that the sed commands which are used by this function, aren't as comprehensive as they
# otherwise could be.

# It is possible that a version number component could be passed to this sed script using one of the
# following two formats;
#
#   1   # Major version number component
#   .1  # Minor or release version number component 
#
# The sed script takes this into account by way of the;
#
#   [.]\?
#
# component in the regex.

s/^[.]\?\([0-9]\+\)$/\1/p

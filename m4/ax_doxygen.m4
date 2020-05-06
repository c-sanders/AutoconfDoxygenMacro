# ------------------------------------------------------------------------------
# Macro : AX_DOXYGEN
# ==================
#
#
# URL
# ---
#
#   https://github.com/c-sanders/AutoconfDoxygenMacro
#
#
# SYNOPSIS
# --------
#
# -> New (2 October, 2019)
#
#   AX_DOXYGEN(
#
#     [min-required-version-number],
#     [action-if-found],
#     [action-if-not-found]
#   )
#
# -> Old
#
#   AX_DOXYGEN(MAJOR_VERSION, MINOR_VERSION, RELEASE_NUMBER)
#
#
#   This Autoconf macro sets the following variables;
#
#     HAVE_DOXYGEN
#
#
# DESCRIPTION
# -----------
#
#   This Autoconf macro can be used to specify or search for the doxygen command
#   line utility.
#
#   If a package uses the doxygen command line utility, then the maintainer of
#   that package can use the AX_DOXYGEN Autoconf macro to assist anyone who is
#   trying to configure and build the package. This macro provides assistance,
#   by making the following configure script options available to anyone who
#   runs the Autotools generated configure script which is created for the
#   package;
#
#     --with-doxygen
#     --wihtout-doxygen
#
#   When configuring any package which makes use of the AX_DOXYGEN Autoconf
#   macro, these two options can be used to specify or search for the doxygen
#   command line utility that should be used during the build process.
#
#   Furthermore, the Package maintainer can stipulate a minimum required version
#   number of the doxygen command line utility which should used during the
#   build process. This minimum required version number can be passed as three
#   arguments (major version number, minor version number, and release number)
#   to the Autoconf macro, when it is invoked from within the package's
#   configure script template, i.e. configure.ac.
#
#   Examples
#
#   1) Invocation of the macro from within configure.ac
#
#   AX_DOXYGEN(["1"], ["2"], ["3"])
#
#   The build process for the package should use a version of the doxygen
#   command line utility which is equal to version 1.2.3 or greater.
#
#   2) Use of the configure script options : Scenario 1
#
#   configure ... --with-doxygen
#
#   or
#
#   configure ... --with-doxygen=yes
#
#   Both of these scenarios will cause the configure script to search for the
#   doxygen command line utility within the PATH of the user who invoked the
#   configure script. If an instance of it is found, then the build process is
#   instructed to use that instance of it.
#
#   3) Use of the configure script options : Scenario 2
#
#   configure ... --with-doxygen=/home/foo/local/bin/doxygen
#
#   In this scenario, the configure script has been instructed to use an
#   instance of the doxygen command line utility which supposedly resides at a
#   particular location within the filesystem hierarchy. The configure script
#   will check to see if an instance of the doxygen command line utility does
#   indeed reside at this particular location within the filesystem hierarchy,
#   and if it does, then the configure script will instruct the build process
#   to use that instance of it.
#
#   4) Use of the configure script options : Scenario 3
#
#   configure ... --with-doxygen=no
#
#   or
#
#   configure ... --without-doxygen
#
#   Both of these scenarios will cause the configure script to instruct the
#   build process to NOT use the doxygen command line utility.
#
#
# URL
# ---
#
#   https://github.com/c-sanders/AutoconfDoxygenMacro/blob/master/m4/ax_gnuplot.m4.annotated
#
#
# LICENCE
# -------
#
#   Copyright (c) 2020 Craig Sanders
#
#   Copying and/or distribution of this file - with or without modification, is
#   permitted in any medium without royalty, provided the copyright notice
#   and this notice are preserved. This file is offered as-is, without any
#   warranty.
#
# ------------------------------------------------------------------------------
#
# Not specified                     :  withval=yes  (default value due to non
#                                                    specification)
# --with-doxygen                    :  withval=yes  (default value due to
#                                                    partial specification)
# --with-doxygen=yes                :  withval=yes
# --with-doxygen=<path_to_doxygen>  :  withval=<path_to_doxygen>
# --without-doxygen                 :  withval=no
#
# ------------------------------------------------------------------------------
#
# - AX_DOXYGEN
#    |
#    |- _AX_DOXYGEN_SET_VERSION_NUMBER_COMPONENTS                               : Function A : Uses AC_MSG_NOTICE = No  === Raises : _AX_DOXYGEN_ERROR_MIN_REQD_VER_INVALID | _AX_DOXYGEN_ERROR_FOUND_VER_INVALID
#        |
#        |- _AX_DOXYGEN_CHECK_IF_VERSION_STRING_IS_VALID                        : Function B : Uses AC_MSG_NOTICE = No
#        |
#        |- _AX_DOXYGEN_EXTRACT_VERSION_NUMBER_COMPONENTS                       : Function C : Uses AC_MSG_NOTICE = Yes
#            |
#            |- _AX_DOXYGEN_PROCESS_VERSION_NUMBER_COMPONENTS                   : Function D : Uses AC_MSG_NOTICE = Yes
#                |                                                                Raises     : _AX_DOXYGEN_ERROR_MIN_REQD_VER_MAJOR_INVALID
#                |                                                                             _AX_DOXYGEN_ERROR_MIN_REQD_VER_MINOR_INVALID
#                |                                                                             _AX_DOXYGEN_ERROR_MIN_REQD_VER_RELEASE_INVALID
#                |                                                                             _AX_DOXYGEN_ERROR_FOUND_VER_MAJOR_INVALID
#                |                                                                             _AX_DOXYGEN_ERROR_FOUND_VER_MINOR_INVALID
#                |                                                                             _AX_DOXYGEN_ERROR_FOUND_VER_RELEASE_INVALID
#                |
#                |- _AX_DOXYGEN_SET_VERSION_NUMBER_COMPONENTS_TO_ZERO_IF_EMPTY  : Function E : Uses AC_MSG_NOTICE = No
#
# ------------------------------------------------------------------------------

# Define the Autoconf macro which is named AX_DOXYGEN.
#
##
## @brief   The AX_DOXYGEN function implements a GNU Autoconf macro which will have the same as
##          this function. This function also acts as the entry point to this macro.
##
## @details 
##

# Function
# ========
#
# Invoked by : * Client *
#
# Invokes    : _AX_DOXYGEN_SET_MIN_REQUIRED_VERSION_NUMBER_COMPONENTS
#              _AX_VERIFY_VERSION_NUMBERS
#              AX_VERSION_COMPARE
#
#
# Error codes
# ===========
#
# -1 : Minimum required version number string appears to be invalid
# -2 : Found version number string appears to be invalid.
#
# -3 : Package Maintainer has specified an invalid minimum required major version number for Doxygen.
# -4 : Package Maintainer has specified an invalid minimum required minor version number for Doxygen.
# -5 : Package Maintainer has specified an invalid minimum required release version number for Doxygen.
#
# -6 : Found instance of Doxygen has reported an invalid major version number.
# -7 : Found instance of Doxygen has reported an invalid minor version number.
# -8 : Found instance of Doxygen has reported an invalid release version number.


AC_DEFUN(

	[AX_DOXYGEN],

	[
		nameFunction="AX-DOXYGEN"

		_AX_DOXYGEN_ERROR_MIN_REQD_VER_INVALID=-1
		_AX_DOXYGEN_ERROR_FOUND_VER_INVALID=-2

		_AX_DOXYGEN_ERROR_MIN_REQD_VER_MAJOR_INVALID=-3
		_AX_DOXYGEN_ERROR_MIN_REQD_VER_MINOR_INVALID=-4
		_AX_DOXYGEN_ERROR_MIN_REQD_VER_RELEASE_INVALID=-5

		_AX_DOXYGEN_ERROR_FOUND_VER_MAJOR_INVALID=-6
		_AX_DOXYGEN_ERROR_FOUND_VER_MINOR_INVALID=-7
		_AX_DOXYGEN_ERROR_FOUND_VER_RELEASE_INVALID=-8
		
		error=0

		minVersionNumber=$1
		# actionIfFound=$2
		# actionIfNotFound=$3

		AC_ARG_WITH(

			[doxygen],

			[AS_HELP_STRING(

				[--with-doxygen=@<:@yes|no|path_to_doxygen@:>@],
				[Instruct the build process to either, 1) use the first instance of doxygen which is found within the build user's PATH (ARG=yes), 2) not use an instance of doxygen at all (ARG=no), or 3) use the instance of doxygen which resides at a specific loction (ARG=path_to_doxygen). @<:@default=yes@:>@]
				)
			],

			[
				AS_BOX(

					["--with-doxygen specified : withval = ${withval}"],
					[=])
			],

			[
				withval=yes
				with_doxygen=yes
				AS_BOX(

					["--with-doxygen not specified : withval = ${withval}"],
					[=])
			]
		)

		# If the Configure script user specified either;
		#
		#   --with-doxygen
		#
		#   or
		#
		#   --with-doxygen=yes
		#
		# then search for the doxygen command line utility within the Configure user's PATH. If an
		# instance of it was found, then set the variable DOXYGEN to the result.
		#
		# If the Configure user specified;
		#
		#   --with-doxygen=no
		#
		# then set the variable DOXYGEN to an empty string.
		#
		# If the Configure user specified;
		#
		#   --with-doxygen=<path_to_doxygen>
		#
		# then set the variable DOXYGEN to <path_to_doxygen>.

		AS_CASE(

			[${withval}],
			[yes],
				[
					want_doxygen="yes"
					AC_CHECK_PROG(
					
						[DOXYGEN],
						[doxygen],
						[doxygen],
						[""]
					)
				],
			[no], 
				[
					want_doxygen="no"
					DOXYGEN=""
				],
			[
				want_doxygen="yes"
				DOXYGEN="${withval}"
			]
		)

		AC_MSG_NOTICE([want_doxygen = ${want_doxygen}])
		AC_MSG_NOTICE([DOXYGEN = ${DOXYGEN}])

		AS_IF(
		
			[test -z "${DOXYGEN}"],
			[
				# Either;
				#
				# the person configuring the package does not want to use the doxygen command line utility, or
				#
				# the doxygen command line utility could not be found.

				AC_MSG_NOTICE([Test message])
			],
			[
				_AX_DOXYGEN_CHECK_IF_SED_SCRIPT_IS_PRESENT()

				# ---------------------------------------------------------------------------------
				# Get the minimum version of Doxygen which is required by this package.
				# ---------------------------------------------------------------------------------

				_AX_DOXYGEN_SET_VERSION_NUMBER_COMPONENTS(

					["MinimumRequired"],
					[${minVersionNumber}],
					["Minimum required version number of doxygen"]
				)

				AC_MSG_NOTICE([--------------------------------------------------])

				AS_IF(

					[test ${error} == 0],
					[
						# ---------------------------------------------------------------------------------
						# Get the version of Doxygen which has been found on this system.
						# ---------------------------------------------------------------------------------

						# Get the version of the doxygen command line utility.

						versionDoxygen=$(${DOXYGEN} --version)
						# versionDoxygen=""

						_AX_DOXYGEN_SET_VERSION_NUMBER_COMPONENTS(

							["Found"],
							[${versionDoxygen}],
							["Found version number of doxygen"]
						)

						AC_MSG_NOTICE([--------------------------------------------------])

						AS_IF(

							[test ${error} == 0],
							[

								# _AX_VERIFY_VERSION_NUMBERS(
								#
								#	[${foundVersionMajor}],
								#	[${foundVersionMinor}],
								#	[${foundVersionRelease}]
								# )

								# ---------------------------------------------------------------------------------
								# Compare the minimum required version to the version which has been found on this
								# system.
								# ---------------------------------------------------------------------------------

								AX_VERSION_COMPARE([${minVersionMajor}], [${minVersionMinor}], [${minVersionRelease}])

								$2
							],
							[
								AC_MSG_NOTICE([An error has occurred])
							]

						)  # End of AS_IF
					],
					[
						AC_MSG_NOTICE([An error has occurred])
					]

				)  # End of AS_IF

				AS_IF(

					[test ${error} == 0],
					[
						# No errors occurred.
					],
					[
						# _AX_DOXYGEN_SET_VERSION_NUMBER_COMPONENTS returned an error.
						#
						# Perform action-if-not-found.

						$3
					]

				)  # End of AS_IF [test ${error} == 0]
			]

		)  # End of AS_IF [test -z "${DOXYGEN}"]
	]
)


AC_DEFUN(

	[_AX_DOXYGEN_CHECK_IF_SED_SCRIPT_IS_PRESENT],

	[
		# Save the name of the previous (calling) function and set the name of the current function.

		namePreviousFunction_check_if_sed_script_is_present=${nameFunction}

		nameFunction="-AX-DOXYGEN-CHECK-IF-SED-SCRIPT-IS-PRESENT"


		AC_MSG_NOTICE([${namePreviousFunction_check_if_sed_script_present} : >>>>> Relinquishing control >>>>>])
		AC_MSG_NOTICE([${nameFunction} : Enter])

		AS_IF(

			[test -s "${srcdir}/sed/get_version_component.sed"],
			[
				AC_MSG_NOTICE([${nameFunction} : sed script is present in the correct location])
			],
			[
				# The required sed script does not appear to reside at the correct location.
				#
				# This is probably because the Package Maintainer forgot to add it to the package.

				AC_MSG_NOTICE([${nameFunction} : Could not find the sed script])

				#             10        20        30        40        50        60        70        80
				#     ---------|---------|---------|---------|---------|---------|---------|---------|

				echo    "# 1) The sed expression"                                                          >  "${srcdir}/sed/get_version_component.sed"
				echo    "# ---------------------"                                                          >> "${srcdir}/sed/get_version_component.sed"
				echo    "#"                                                                                >> "${srcdir}/sed/get_version_component.sed"
				echo    "# When invoked directly from the command line, the sed expression which is used " >> "${srcdir}/sed/get_version_component.sed"
				echo    "# by this script should look as follows;"                                         >> "${srcdir}/sed/get_version_component.sed"
				echo    "#"                                                                                >> "${srcdir}/sed/get_version_component.sed"
				echo    "#   sed -n -e 's/^@<:@.@:>@\?\(@<:@0-9@:>@\+\)$/\1/p'"                            >> "${srcdir}/sed/get_version_component.sed"
				echo    "#"                                                                                >> "${srcdir}/sed/get_version_component.sed"
				echo    "#"                                                                                >> "${srcdir}/sed/get_version_component.sed"
				echo    "# 2) Backslash substitutions"                                                     >> "${srcdir}/sed/get_version_component.sed"
				echo    "# --------------------------"                                                     >> "${srcdir}/sed/get_version_component.sed"
				echo    "#"                                                                                >> "${srcdir}/sed/get_version_component.sed"
				echo    "# If however, this sed expression is invoked from within an Autoconf macro, then" >> "${srcdir}/sed/get_version_component.sed"
				echo    "# some alterations will need to be made to it in order to prevent the Autoconf"   >> "${srcdir}/sed/get_version_component.sed"
				echo    "# utility from interpreting some of the characters which comprise it."            >> "${srcdir}/sed/get_version_component.sed"
				echo    "#"                                                                                >> "${srcdir}/sed/get_version_component.sed"
				echo    "# In particular, the following substitutions will need to be made;"               >> "${srcdir}/sed/get_version_component.sed"
				echo    "#"                                                                                >> "${srcdir}/sed/get_version_component.sed"
				echo -n "#   Replace the '@<:@' character with the following character sequence : @<:"     >> "${srcdir}/sed/get_version_component.sed"
				echo    "@"                                                                                >> "${srcdir}/sed/get_version_component.sed"
				echo -n "#   Replace the '@:>@' character with the following character sequence : @:>"     >> "${srcdir}/sed/get_version_component.sed"
				echo    "@"                                                                                >> "${srcdir}/sed/get_version_component.sed"
				echo    "#"                                                                                >> "${srcdir}/sed/get_version_component.sed"
				echo    "# Furthermore, some of the characters need to be backslash escaped in either"     >> "${srcdir}/sed/get_version_component.sed"
				echo    "# scenario, i.e. whether the sed expression is being invoked directly from the"   >> "${srcdir}/sed/get_version_component.sed"
				echo    "# command line or from within an Autoconf macro. These characters include;"       >> "${srcdir}/sed/get_version_component.sed"
				echo    "#"                                                                                >> "${srcdir}/sed/get_version_component.sed"
				echo    "#   '?'"                                                                          >> "${srcdir}/sed/get_version_component.sed"
				echo    "#   '+'"                                                                          >> "${srcdir}/sed/get_version_component.sed"
				echo    "#   '('"                                                                          >> "${srcdir}/sed/get_version_component.sed"
				echo    "#   ')'"                                                                          >> "${srcdir}/sed/get_version_component.sed"
				echo    "#"                                                                                >> "${srcdir}/sed/get_version_component.sed"
				echo    "#"                                                                                >> "${srcdir}/sed/get_version_component.sed"
				echo    "# 3) Deficiencies with sed and the sed expression"                                >> "${srcdir}/sed/get_version_component.sed"
				echo    "# -----------------------------------------------"                                >> "${srcdir}/sed/get_version_component.sed"
				echo    "#"                                                                                >> "${srcdir}/sed/get_version_component.sed"
				echo    "# It is worth noting that the sed command line utiliry does not support the"      >> "${srcdir}/sed/get_version_component.sed"
				echo    "# lookbehind feature. It is for this reason that the sed command which is used"   >> "${srcdir}/sed/get_version_component.sed"
				echo    "# by this function, is not as comprehensive as it otherwise could be."            >> "${srcdir}/sed/get_version_component.sed"
				echo    "#"                                                                                >> "${srcdir}/sed/get_version_component.sed"
				echo    "#"                                                                                >> "${srcdir}/sed/get_version_component.sed"
				echo    "# 4) The string to be operated on"                                                >> "${srcdir}/sed/get_version_component.sed"
				echo    "# -------------------------------"                                                >> "${srcdir}/sed/get_version_component.sed"
				echo    "#"                                                                                >> "${srcdir}/sed/get_version_component.sed"
				echo    "# The string which is to be operated on by this sed expression, could be in one"  >> "${srcdir}/sed/get_version_component.sed"
				echo    "# of the following two formats;"                                                  >> "${srcdir}/sed/get_version_component.sed"
				echo    "#"                                                                                >> "${srcdir}/sed/get_version_component.sed"
				echo    "#   1   # Major version number component"                                         >> "${srcdir}/sed/get_version_component.sed"
				echo    "#   .1  # Minor or release version number component"                              >> "${srcdir}/sed/get_version_component.sed"
				echo    "#"                                                                                >> "${srcdir}/sed/get_version_component.sed"
				echo    "# The sed script takes this into account by way of the;"                          >> "${srcdir}/sed/get_version_component.sed"
				echo    "#"                                                                                >> "${srcdir}/sed/get_version_component.sed"
				echo    "#   @<:@.@:>@\?"                                                                  >> "${srcdir}/sed/get_version_component.sed"
				echo    "#"                                                                                >> "${srcdir}/sed/get_version_component.sed"
				echo    "# component in the regex."                                                        >> "${srcdir}/sed/get_version_component.sed"
				echo    "#"                                                                                >> "${srcdir}/sed/get_version_component.sed"
				echo    ""                                                                                 >> "${srcdir}/sed/get_version_component.sed"
				echo    "s/^@<:@.@:>@\?\(@<:@0-9@:>@\+\)$/\1/p"                                            >> "${srcdir}/sed/get_version_component.sed"
			]

		)  # End of AS_IF

		AC_MSG_NOTICE([${nameFunction} : Exit])


		# Restore the name of the previous (calling) function.

		nameFunction=${namePreviousFunction_check_if_sed_script_is_present}

		AC_MSG_NOTICE([${nameFunction} : <<<<< Resuming control <<<<<])

	]  # End of definition of function : _AX_DOXYGEN_CHECK_IF_SED_SCRIPT_IS_PRESENT

)  # End of function : _AX_DOXYGEN_CHECK_IF_SED_SCRIPT_IS_PRESENT


# ==================================================================================================
# Function
# ==================================================================================================
#
# Name       : _AX_DOXYGEN_SET_VERSION_NUMBER_COMPONENTS : Function A
#
# Invoked by : AX_DOXYGEN
#
# Invokes    : _AX_DOXYGEN_CHECK_IF_VERSION_STRING_IS_VALID
#              _AX_DOXYGEN_EXTRACT_VERSION_NUMBER_COMPONENTS
#
# Parameters :
#
#   1) version       : E.g. "MinimumRequired" | "Found"
#
#   2) versionNumber : E.g. "1.8.11"
#
#   3) displayString : E.g. "Found version number of doxygen"
#
# Test if the version string which was passed to this function is valid. If it is, then set the
# values for the individual components which make up the version string.


AC_DEFUN(

	[_AX_DOXYGEN_SET_VERSION_NUMBER_COMPONENTS],

	[
		version=$1

		versionNumber=$2

		displayString=$3


		# Save the name of the previous (calling) function and set the name of the current function.

		namePreviousFunction_set_version_number_components=${nameFunction}

		nameFunction="-AX-DOXYGEN-SET-VERSION-NUMBER-COMPONENTS"


		AC_MSG_NOTICE([${namePreviousFunction_set_version_number_components} : >>>>> Relinquishing control >>>>>])
		AC_MSG_NOTICE([${nameFunction} : Enter])

		_AX_DOXYGEN_CHECK_IF_VERSION_STRING_IS_VALID(

			[${version}],
			[${versionNumber}], 
			[${displayString}]
		)

		AS_IF(
		
			[test "x${version}" == "xMinimumRequired"],
			[
				# Set the Minimum required version number components.

				AS_IF(

					[test "x${versionStringValid}" == "xTrue"],
					[
						_AX_DOXYGEN_EXTRACT_VERSION_NUMBER_COMPONENTS(

							[${version}],
							[${versionNumber}],
							[${displayString}]
						)
					],
					[
						# Minimum required version number string appears to be invalid.

						error=_AX_DOXYGEN_ERROR_MIN_REQD_VER_INVALID
					]
				)
			],
			[
				# Set the Found version number components.

				AS_IF(

					[test "x${versionStringValid}" == "xTrue"],
					[
						_AX_DOXYGEN_EXTRACT_VERSION_NUMBER_COMPONENTS(

							[${version}],
							[${versionNumber}],
							[${displayString}]
						)
					],
					[
						# Found version number string appears to be invalid.

						error=_AX_DOXYGEN_ERROR_FOUND_VER_INVALID
					]
				)
			]
		)

		AC_MSG_NOTICE([${nameFunction} : Exit])


		# Restore the name of the previous (calling) function.

		nameFunction=${namePreviousFunction_set_version_number_components}

		AC_MSG_NOTICE([${nameFunction} : <<<<< Resuming control <<<<<])

	]  # End of definition of function : _AX_DOXYGEN_SET_VERSION_NUMBER_COMPONENTS

)  # End of function : _AX_DOXYGEN_SET_VERSION_NUMBER_COMPONENTS


# ==================================================================================================
# Function
# ==================================================================================================
#
# Name       : _AX_DOXYGEN_CHECK_IF_VERSION_STRING_IS_VALID : Function B
#
# Invoked by : _AX_DOXYGEN_SET_MIN_REQUIRED_VERSION_NUMBER_COMPONENTS
#
# Invokes    : NA
#
# Parameters :
#
#   1) version       : E.g. "MinimumRequired" | "Found"
#
#   2) versionNumber : E.g. "1.8.11"
#
#   3) displayString : E.g. "Found version number of doxygen"
#
# Test if the version string which was passed to this function is valid.

AC_DEFUN(

	[_AX_DOXYGEN_CHECK_IF_VERSION_STRING_IS_VALID],

	[
		version=$1

		versionNumber=$2

		displayString=$3


		# Save the name of the previous (calling) function and set the name of the current function.

		namePreviousFunction_check_if_version_string_is_valid=${nameFunction}

		nameFunction="-AX-DOXYGEN-CHECK-IF-VERSION-STRING-IS-VALID"


		AC_MSG_NOTICE([${namePreviousFunction_check_if_version_string_is_valid} : >>>>> Relinquishing control >>>>>])
		AC_MSG_NOTICE([${nameFunction} : Enter])

		# minVersionNumber="Doxygen version 1 Public Relese rc2"

		AC_MSG_NOTICE([${nameFunction} : ${displayString} = ${versionNumber}])

		versionStringValid=$(echo ${versionNumber} | ${SED} -n -e 's/^.*@<:@0-9@:>@\+\(@<:@.@:>@@<:@0-9@:>@\+\)\?\(@<:@.@:>@@<:@0-9@:>@\+\)\?.*$/True/p')

		AC_MSG_NOTICE([${nameFunction} : Version string from regex match = ${versionStringValid}])

		AC_MSG_NOTICE([${nameFunction} : Exit])


		# Restore the name of the previous (calling) function.

		nameFunction=${namePreviousFunction_check_if_version_string_is_valid}

		AC_MSG_NOTICE([${nameFunction} : <<<<< Resuming control <<<<<])

	]  # End of definition of function : _AX_DOXYGEN_CHECK_IF_VERSION_STRING_IS_VALID

)  # End of function : _AX_DOXYGEN_CHECK_IF_VERSION_STRING_IS_VALID


# ==================================================================================================
# Function
# ==================================================================================================
#
# Name       : _AX_DOXYGEN_EXTRACT_VERSION_NUMBER_COMPONENTS : Function C
#
# Invoked by : _AX_DOXYGEN_SET_VERSION_NUMBER_COMPONENTS
#
# Invokes    : _AX_DOXYGEN_PROCESS_VERSION_NUMBER_COMPONENTS
#
# Parameters :
#
#   1) version       : E.g. "MinimumRequired" | "Found"
#
#   2) versionNumber : E.g. "1.8.11"
#
#   3) displayString : E.g. "Found version number of doxygen"
#
# Extract the version number components from the version string which was passed to this function.

AC_DEFUN(

	[_AX_DOXYGEN_EXTRACT_VERSION_NUMBER_COMPONENTS],

	[
		version=$1

		versionNumber=$2

		displayString=$3


		# Save the name of the previous (calling) function and set the name of the current function.

		namePreviousFunction_extract_version_number_components=${nameFunction}

		nameFunction="-AX-DOXYGEN-EXTRACT-VERSION-NUMBER-COMPONENTS"


		AC_MSG_NOTICE([${namePreviousFunction_extract_version_number_components} : >>>>> Relinquishing control >>>>>])
		AC_MSG_NOTICE([${nameFunction} : Enter])

		AC_MSG_NOTICE([${nameFunction} : ${displayString} = ${versionNumber}])

		# Brief explanation of sed options;
		#
		#   -n : No automatic printing of the Pattern space.
		#   -e : Execute the script which follows this option.
		#
		# Replacing the escape sequences with the characters they represent, the regex which is used
		# below by sed would become;
		#
		#   ^([0-9]+)([.][0-9]+)?([.][0-9]+)?.*$
		#
		# This will match version strings like the following;
		#
		#   1.8.11
		#
		# However, it won't match version string such as;
		#
		#   GNU sed version 1.8.11
		#
		# Altering the regex to the following;
		#
		#   ^.*([0-9]+)([.][0-9]+)?([.][0-9]+)?.*$
		#
		# by inserting .* after ^ would cause it to match the later version of the string. The
		# trouble with doing this though, is the that .* will behave in a greedy fashion and match
		# as much of the string as it can.
		#
		# As far as the author is aware, sed does not have the ability to perform non-greedy
		# matching. This means that this regex will NOT be able to extract the minor and release
		# components from a string.

		versionMajor=$(echo ${versionNumber}   | ${SED} -n -e 's/^\(@<:@0-9@:>@\+\)\(@<:@.@:>@@<:@0-9@:>@\+\)\?\(@<:@.@:>@@<:@0-9@:>@\+\)\?.*$/\1/p')
		versionMinor=$(echo ${versionNumber}   | ${SED} -n -e 's/^\(@<:@0-9@:>@\+\)\(@<:@.@:>@@<:@0-9@:>@\+\)\?\(@<:@.@:>@@<:@0-9@:>@\+\)\?.*$/\2/p')
		versionRelease=$(echo ${versionNumber} | ${SED} -n -e 's/^\(@<:@0-9@:>@\+\)\(@<:@.@:>@@<:@0-9@:>@\+\)\?\(@<:@.@:>@@<:@0-9@:>@\+\)\?.*$/\3/p')

		AS_IF(

			[test "x${version}" == "xMinimumRequired"],
			[
				minVersionMajor=${versionMajor}
				minVersionMinor=${versionMinor}
				minVersionRelease=${versionRelease}
			],
			[
				foundVersionMajor=${versionMajor}
				foundVersionMinor=${versionMinor}
				foundVersionRelease=${versionRelease}
			]
		)

		AC_MSG_NOTICE([${nameFunction} : ${displayString} (major)   = ${versionMajor}])
		AC_MSG_NOTICE([${nameFunction} : ${displayString} (minor)   = ${versionMinor}])
		AC_MSG_NOTICE([${nameFunction} : ${displayString} (release) = ${versionRelease}])

		# The following function can raise errors.

		_AX_DOXYGEN_PROCESS_VERSION_NUMBER_COMPONENTS(
		
			[${version}],
			[${versionNumber}],
			[${displayString}]
		)

		AC_MSG_NOTICE([${nameFunction} : Exit])


		# Restore the name of the previous (calling) function.

		nameFunction=${namePreviousFunction_extract_version_number_components}

		AC_MSG_NOTICE([${nameFunction} : <<<<< Resuming control <<<<<])

	]   # End of definition of function : _AX_DOXYGEN_EXTRACT_VERSION_NUMBER_COMPONENTS

)  # End of function : _AX_DOXYGEN_EXTRACT_VERSION_NUMBER_COMPONENTS


# ==================================================================================================
# Function
# ==================================================================================================
#
# Invoked by : _AX_DOXYGEN_EXTRACT_VERSION_NUMBER_COMPONENTS
#
# Invokes    : _AX_DOXYGEN_SET_VERSION_NUMBER_COMPONENTS_TO_ZERO_IF_EMPTY

AC_DEFUN(

	[_AX_DOXYGEN_PROCESS_VERSION_NUMBER_COMPONENTS],

	[
		version=$1

		versionNumber=$2

		displayString=$3


		# Save the name of the previous (calling) function and set the name of the current function.

		namePreviousFunction_process_version_number_components=${nameFunction}

		nameFunction="-AX-DOXYGEN-PROCESS-VERSION-NUMBER-COMPONENTS"


		AC_MSG_NOTICE([${namePreviousFunction_process_version_number_components} : >>>>> Relinquishing control >>>>>])
		AC_MSG_NOTICE([${nameFunction} : Enter])

		AC_MSG_NOTICE([${nameFunction} : version = ${version}])

		AC_MSG_NOTICE([${nameFunction} : versionNumber = ${versionNumber}])

		_AX_DOXYGEN_SET_VERSION_NUMBER_COMPONENTS_TO_ZERO_IF_EMPTY(

			[${version}],
			[${versionNumber}],
			[${displayString}]
		)

		AS_IF(

			[test "x${version}" == "xMinimumRequired"],
			[
				# Set the Minimum required version major number. 

				AC_MSG_NOTICE([${nameFunction} : Minumum required version number of doxygen (major)   = ${minVersionMajor}])
				AC_MSG_NOTICE([${nameFunction} : Minumum required version number of doxygen (minor)   = ${minVersionMinor}])
				AC_MSG_NOTICE([${nameFunction} : Minumum required version number of doxygen (release) = ${minVersionRelease}])

				# minVersionMinor=".8A"

				temp_versionMajor=$(echo ${minVersionMajor} | ${SED} -n -f ${srcdir}/sed/get_version_component.sed)

				# temp_minVersionMajor="A123B"

				AS_IF(

					# The following test needs to sit snug within the square brackets, otherwise the
					# resulting configure script will exit prematurely with an error.

					[test -z ${temp_versionMajor}],
					[
						error=_AX_DOXYGEN_ERROR_MIN_REQD_VER_MAJOR_INVALID
					],
					[
						minVersionMajor=${temp_versionMajor}

						# Set the Minimum required version minor number.
						
						temp_versionMinor=$(echo ${minVersionMinor} | ${SED} -n -f ${srcdir}/sed/get_version_component.sed)
						
						AS_IF(
						
							[test -z ${temp_versionMinor}],
							[
								error=_AX_DOXYGEN_ERROR_MIN_REQD_VER_MINOR_INVALID
							],
							[
								minVersionMinor=${temp_versionMinor}

								# Set the Minimum required version release number.

								# temp_versionRelease=$(echo ${minVersionRelease} | ${SED} -n -e 's/^@<:@.@:>@\?\(@<:@0-9@:>@\+\)$/\1/p')

								temp_versionRelease=$(echo ${minVersionRelease} | ${SED} -n -f ${srcdir}/sed/get_version_component.sed)

								AS_IF(

									[test -z ${temp_versionRelease}],
									[
										error=_AX_DOXYGEN_ERROR_MIN_REQD_VER_RELEASE_INVALID
									],
									[
										minVersionRelease=${temp_versionRelease}
									]
								)
							]
						)
					]
				)

				AC_MSG_NOTICE([${nameFunction} : Minumum required version number of doxygen (major)   = ${minVersionMajor}])
				AC_MSG_NOTICE([${nameFunction} : Minumum required version number of doxygen (minor)   = ${minVersionMinor}])
				AC_MSG_NOTICE([${nameFunction} : Minumum required version number of doxygen (release) = ${minVersionRelease}])
			],
			[
				# Set the Found version major number. 

				AC_MSG_NOTICE([${nameFunction} : Found version number of doxygen (major)   = ${foundVersionMajor}])
				AC_MSG_NOTICE([${nameFunction} : Found version number of doxygen (minor)   = ${foundVersionMinor}])
				AC_MSG_NOTICE([${nameFunction} : Found version number of doxygen (release) = ${foundVersionRelease}])

				temp_versionMajor=$(echo ${foundVersionMajor} | ${SED} -n -e 's/^\(@<:@0-9@:>@\+\)$/\1/p')

				AS_IF(

					[test -z ${temp_versionMajor}],
					[
						error=_AX_DOXYGEN_ERROR_FOUND_VER_MAJOR_INVALID
					],
					[
						foundVersionMajor=${temp_versionMajor}

						# Set the Found version minor number.

						temp_versionMinor=$(echo ${foundVersionMinor} | ${SED} -n -e 's/^@<:@.@:>@\(@<:@0-9@:>@\+\)$/\1/p')

						AS_IF(
						
							[test -z ${temp_versionMinor}],
							[
								error=_AX_DOXYGEN_ERROR_FOUND_VER_MINOR_INVALID
							],
							[
								foundVersionMinor=${temp_versionMinor}

								# Set the Found version release number.

								temp_versionRelease=$(echo ${foundVersionRelease} | ${SED} -n -e 's/^@<:@.@:>@\(@<:@0-9@:>@\+\)$/\1/p')

								AS_IF(

									[test -z ${temp_versionRelease}],
									[
										error=_AX_DOXYGEN_ERROR_FOUND_VER_RELEASE_INVALID
									],
									[
										foundVersionRelease=${temp_versionRelease}
									]
								)
							]
						)
					]
				)

				AC_MSG_NOTICE([${nameFunction} : Found version number of doxygen (major)   = ${foundVersionMajor}])
				AC_MSG_NOTICE([${nameFunction} : Found version number of doxygen (minor)   = ${foundVersionMinor}])
				AC_MSG_NOTICE([${nameFunction} : Found version number of doxygen (release) = ${foundVersionRelease}])
			]
		)

		AC_MSG_NOTICE([${nameFunction} : Exit])


		# Restore the name of the previous (calling) function.

		nameFunction=${namePreviousFunction_process_version_number_components}

		AC_MSG_NOTICE([${nameFunction} : <<<<< Resuming control <<<<<])

	]  # End of definition of function : _AX_DOXYGEN_PROCESS_VERSION_NUMBER_COMPONENTS

)  # End of function : _AX_DOXYGEN_PROCESS_VERSION_NUMBER_COMPONENTS


# ==================================================================================================
# Function
# ==================================================================================================
#
# Invoked by : _AX_DOXYGEN_PROCESS_VERSION_NUMBER_COMPONENTS
#
# Invokes    : NA

AC_DEFUN(

	[_AX_DOXYGEN_SET_VERSION_NUMBER_COMPONENTS_TO_ZERO_IF_EMPTY],

	[
		versionNumber=$1

		version=$2

		displayString=$3


		# Save the name of the previous (calling) function and set the name of the current function.

		namePreviousFunction_set_version_number_components_to_zero_if_empty=${nameFunction}

		nameFunction="-AX-DOXYGEN-SET-VERSION-NUMBER-COMPONENTS-TO-ZERO-IF-EMPTY"


		AC_MSG_NOTICE([${namePreviousFunction_set_version_number_components_to_zero_if_empty} : >>>>> Relinquishing control >>>>>])
		AC_MSG_NOTICE([${nameFunction} : Enter])

		# The values of minVersionMinor and minVersionRelease could vary depending upon the value of
		# minVersionNumber. For example;
		#
		#   If minVersionNumber = "1"   then minVersionMinor = ""
		#   If minVersionNumber = "1.8" then minVersionMinor = ".8"
		#
		#   If minVersionNumber = "1"      then minVersionRelease = ""
		#   If minVersionNumber = "1.8"    then minVersionRelease = ""
		#   If minVersionNumber = "1.8.11" then minVersionRelease = ".11" 
		#
		# As a result of this, check if any of the minimum required version numbers which were just
		# set above, are zero length strings, i.e. equal to "". valid. If any of them are, then set
		# their values to 0.

		AS_IF(

			[test "x${version}" == "xMinimumRequired"],
			[
				AS_IF(

					[test -z ${minVersionMajor}],
					[minVersionMajor=0],
					[minVersionMajor=${minVersionMajor}]
				)
				AS_IF(

					[test -z ${minVersionMinor}],
					[minVersionMinor=0],
					[minVersionMinor=${minVersionMinor}]
				)
				AS_IF(

					[test -z ${minVersionRelease}],
					[minVersionRelease=0],
					[minVersionRelease=${minVersionRelease}]
				)
			],
			[
				AS_IF(

					[test -z ${foundVersionMajor}],
					[foundVersionMajor=0],
					[foundVersionMajor=${foundVersionMajor}]
				)
				AS_IF(

					[test -z ${foundVersionMinor}],
					[foundVersionMinor=0],
					[foundVersionMinor=${foundVersionMinor}]
				)
				AS_IF(

					[test -z ${foundVersionRelease}],
					[foundVersionRelease=0],
					[foundVersionRelease=${foundVersionRelease}]
				)
			]
		)

		AC_MSG_NOTICE([${nameFunction} : Exit])


		# Restore the name of the previous (calling) function.

		nameFunction=${namePreviousFunction_set_version_number_components_to_zero_if_empty}

		AC_MSG_NOTICE([${nameFunction} : <<<<< Resuming control <<<<<])

	]  # End of definition of function : _AX_DOXYGEN_SET_VERSION_NUMBER_COMPONENTS_TO_ZERO_IF_EMPTY

)  # End of function : _AX_DOXYGEN_SET_VERSION_NUMBER_COMPONENTS_TO_ZERO_IF_EMPTY


# ==================================================================================================
# Function
# ==================================================================================================
#
# Invoked by : AX_DOXYGEN
#
# Invokes    : NA

AC_DEFUN(

	[_AX_VERIFY_VERSION_NUMBERS],

	[
		# Check if all the minimum version required numbers just set, are indeed valid. If
		# any of them aren't, then set the values of those that aren't to 0.
	
		AS_IF(
	
			[test -z ${minVersionMajor}],
			[minVersionMajor=0],
			[minVersionMajor=${minVersionMajor}]
		)
		AS_IF(
	
			[test -z ${minVersionMinor}],
			[minVersionMinor=0],
			[minVersionMinor=${minVersionMinor}]
		)
		AS_IF(
	
			[test -z "$3"],
			[minVersionRelease=0],
			[minVersionRelease=$3]
		)

	]
)

# Define the Autoconf macro which is named AX_VERSION_COMPARE.
#
# This is a helper Autoconf macro.
#
# It attempts to get the minimum required version number which might have been stipulated by the
# Package Maintainer, and the actual version number of the doxygen command line utility, provided
# that an instance of it was found. Once it has these two version numbers, this Autoconf macro then
# compares them to see if the found version of the doxygen command line utility is new enough.

AC_DEFUN(

	[AX_VERSION_COMPARE],

	[
		# If this function has been invoked, then we can assume that the configure script user does
		# want to use the doxygen command line utility.

		AC_MSG_NOTICE(["DOXYGEN = ${DOXYGEN}"])

		# Attempt to get the minimum version required for the major, minor, and release numbers.
		# If these were specified, then they should have been passed as arguments to this Autoconf
		# macro when it was invoked from within the configure.ac file by the Package Maintainer.

		minVersionMajor=$1
		minVersionMinor=$2
		minVersionRelease=$3

		# Generate a string which represents the minimum version required number in the form;
		#
		#   major.minor.release
		#
		# The version of the doxygen command line utility, will be checked against this string to
		# ensure that it new enough.

		minVersion="${minVersionMajor}.${minVersionMinor}.${minVersionRelease}"

		# Code cut from here.

		AS_IF(
		
			[test -z "${versionMajor}"],
			[
				# The invocation above of the following command;
				#
				#   ${DOXYGEN} --version
				#
				# does not appear to have returned a value.
				#
				# Either;
				#
				#   - ${DOXYGEN} does not exist within the filesystem, or
				#
				#   - ${DOXYGEN} does exist within the filesystem, but it didn't return a version
				#     string.
				#
				# If this was caused by the latter case, then because it didn't return a version
				# string, assume the worst and assume that the version of ${DOXYGEN} is too old.

				${actionIfNotFound}
			],
			[
				# ${versionMajor} has been set.
				#
				# As a result, check that the values of;
				#
				#   - ${versionMinor}, and
				#   - ${versionRelease}
				#
				# valid.

				AC_MSG_NOTICE([Found major   version of doxygen = ${versionMajor}])

				AS_IF(

					[test -z "${versionMinor}"],
					[
						# ${versionMinor} has not been set.
						#
						# As a result, forcibly set its value to equal 0.

						versionMinor="0"
					],
					[
						# The first character of ${versionMinor} should be a '.' character. This
						# will be removed by the following command.

						versionMinor=$(echo ${versionMinor} | ${SED} -e 's/^[.]\(@<:@0-9@:>@\+\)*$/\1/')

						AC_MSG_NOTICE([Found minor   version of doxygen = ${versionMinor}])
					]
				)

				AS_IF(
	
					[test -z "${versionRelease}"],
					[
						# ${versionRelease} has not been set.
						#
						# As a result, forcibly set its value to equal 0.

						versionRelease="0"

						AC_MSG_NOTICE([Set release version of doxygen = ${versionRelease}])
					],
					[
						# The first character of ${versionRelease should be a '.' character. This
						# will be removed by the following command.

						versionRelease=$(echo ${versionRelease} | ${SED} -e 's/^[.]\(@<:@0-9@:>@\+\)*$/\1/')

						AC_MSG_NOTICE([Found release version of doxygen = ${versionRelease}])
					]
				)

				versionNumber="${versionMajor}.${versionMinor}.${versionRelease}"

				AC_MSG_NOTICE([Minumum required version of doxygen = ${minVersion}])
				AC_MSG_NOTICE([doxygen version string   = ${versionDoxygen}])
				AC_MSG_NOTICE([Found version of doxygen = ${versionNumber}])

				AS_VERSION_COMPARE(

					[${versionNumber}],
					[${minVersion}],
					[
						AS_BOX(
				
							[Minimum required version of doxygen = ${minVersion} : Found version of doxygen = ${versionNumber}],
							[=])
						AC_MSG_ERROR([Version of doxygen found is unacceptable - probably because it is too old!])
					],
					[AC_MSG_NOTICE([Version of doxygen found is acceptable.])],
					[AC_MSG_NOTICE([Version of doxygen found is acceptable.])]
				)
				
				# If the Autoconf macro has got to this point, then it has been successful.
				#
				# Define the macro HAVE_DOXYGEN to signify this.

				AC_DEFINE(

					[HAVE_DOXYGEN],
					["1"],
					[define if the Doxygen command line utility is available]
				)
			]
		)
	]
)

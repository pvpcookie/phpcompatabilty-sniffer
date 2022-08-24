#!/bin/bash
############################################################
# Help                                                     #
############################################################
Help()
{
   # Display Help
   echo "Run PHPCompatibility using phpcompatibility/php-compatibility/PHPCompatibility and PHPCS "
   echo
   echo "Syntax: bash sniffer_php8.sh -d {your directory to scan}"

   echo ""
   echo "======================================================="
   echo "           PHP 8.1 compatability Sniffer"
   echo "======================================================="
   echo ""
   echo "options:"
   echo ""
   echo "-d             Set directory to sun php sniffer in"
   echo "-h             Print this Help."
   echo
}

############################################################
# SNIFFER                                                  #
############################################################

# Set variables
Script="vendor/bin/phpcs";
Sniffer="vendor/phpcompatibility/php-compatibility/PHPCompatibility";
Directory="./";
PHP="8.1";

############################################################
# Process the input options. Add options as needed.        #
############################################################
# Get the options

while getopts ":hd:" option; do
   case $option in
      h) # display Help
         Help
         exit;;
      d) # Enter a name
         Directory=$OPTARG;;
     \?) # Invalid option
         echo "Error: Invalid option"
         exit;;
   esac
done

############################################################
# Validate                                                 #
############################################################

if [ ! -f "$Script" ]; then
    echo "$Script does not exist. please install [ composer require squizlabs/php_codesniffer --dev ]"
    exit;
fi

if [ ! -d "$Sniffer" ]; then
    echo "$Sniffer does not exist. please install [ using composer require phpcompatibility/php-compatibility --dev]"
    exit;
fi

############################################################
# RUN                                                      #
############################################################

printf  "\n - RUNNING SCAN ON $Directory FOR COMPATABILITY WITH $PHP: \n \n"
$Script -p "$Directory" --standard="$Sniffer" --runtime-set testVersion "$PHP"

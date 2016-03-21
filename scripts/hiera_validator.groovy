#!/usr/bin/env groovy
import java.io.File
// Regex made with: https://regex101.com/
path = ""
debug = false
keys = []
usedKeys = []
invalidKeys = []

void p(String msg) {
    println "rcs_hiera_validator: ==> ${msg}"
}

void fail(String msg) {
    usage()
    if (msg && !msg.IsEmpty()) {
        p "ERRORED ==> ${msg}"
    }
    p "Exiting ..."
    System.exit 1
}

void intro() {
    println "\n\n"
    p "Starting RCS Hiera Validator...\n\n"
}

void usage() {
    p ""
    p "RCS Hiera Validator Usage:"
    p "Usage: This script is used to find hiera key's without values."
    p "Usage: Generally this occurs when a key has an overlooked dependency"
    p ""
    p "Usage: Correct usage is: ./rcs_hiera_validator -[OPTIONS]* <Custom Path to Yaml>*"
    p "Usage: "
    p "Usage: Options are OPTIONAL!"
    p "Usage: -d Prints EVERYTHING"
    p "Usage: Custom Path to Yaml: Well you guessed...the path to yaml containing hiera data"
    p ""
    p "Usage: WARNING"
    p "Usage: Paths with symlinks are not supported! Use at YOUR OWN RISK!"
    p ""
}

void checkArgs() {
    p ""
    def yamlPath = System.getProperty("user.dir")
    path = yamlPath + "/puppet/hiera/hieradata/common.yaml"
    // Two args, path to file or options (prefixed with -)
    if (args && args.length > 0) {
        // We have args, parse for -d and <path_to_yaml>
        args.each { arg ->
            if( arg.charAt(0) == '-') {
                debug = arg.charAt(1) == 'd'
            } else {
                // This is a path, test it both absolute & then relative
                if (new File(arg).exists()) {
                    path = arg
                    p "Args: Arg path verified. Setting path..."
                } else if (new File(yamlPath + "/" + arg).exists()) {
                    path = yamplPath + "/" + arg
                    p "Args: Arg path verified. Setting path..."
                } else {
                    fail ""
                }
                if(debug) {
                    p "Args: Yaml Path set to: ${path}"
                }
            }
        }
    } else {
        // if no args, check default path
        if (new File(path).exists()) {
            path = yamlPath + "/puppet/hiera/hieradata/common.yaml"
            p "Args: Using default path for hiera data of: <root>/puppet/hiera/hieradata/common.yaml"
        } else {
            fail ""
        }
    }
    if (debug) {
        p "Args: Hiera file path is: ${path}"
        p "Args: All script args are: ${args}"
    }
}

void checkHieraFile() {
    p ""
//    Check file before using
    if (!new File(path).exists()) {
        p "Hiera File ==> File NOT Found!"
        fail "Hiera File ==> Path used is: ${path}"
    } else {
        p "Hiera File ==> Exists! Starting key validation..."
//        Find all keys, then used keys and compare
        File hdata = new File(path)
        // Find Keys
        hdata.eachLine() { line ->
            // Keys
            (line =~ /(((\w+::)+\w+:)[^:])/).each { match ->
                keys << match[0].toString().substring(0, match[0].length()-2) // removes last ':'
            }
            // Used Keys
            (line =~ /('(\w+::)+(\w)+')/).each {match ->
                def m = match[0].replaceAll('\'', '') // removes leading/trailing '
                if(!usedKeys.contains(m)) {
                    usedKeys << m
                }
            }
        }

        if (debug) {
            p ""
            keys.each {
                p "Hiera File ==> Keys are ==> ${it}"
            }
            p ""
            usedKeys.each {
                p "Hiera File ==> USED keys are ==> ${it}"
            }
        }

        // Compare
        invalidKeys = usedKeys - keys
        if(invalidKeys.size() > 0) {
            p ""
            invalidKeys.each {
                p "Hiera File ==> INVALID KEY ==> KEY NEVER DECLARED ==> ${it}"
            }
        } else {
            p ""
            p "Hiera File ==> ALL KEYS GOOD!!!"
        }
    }
}

// ### Start of main code ###
intro()
checkArgs()
checkHieraFile()
p ""
p "RCS Hiera Validator has finished. Exiting..."
p ""
System.exit 0

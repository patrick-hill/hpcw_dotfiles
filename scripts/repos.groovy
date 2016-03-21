#!/usr/bin/env groovy
import groovy.json.*


serverList = args[0]
isGithub = (serverList == 'github')
if ((isGithub && args.size() < 3) || (!isGithub && args.size() < 3)) {
    println "\n Script Usage is: <ServerList> <SourceRoot> <Username> <Password>"
    println "<ServerList>:  [REQUIRED]: Choose from 'bitbucket' or 'github'"
    println "<SourceRoot>:  [REQUIRED]: You must provide the root directory projects will be cloned to"
    println "<Username>:    [REQUIRED]: Enter your username"
    println "<Password>:    [OPTIONAL-Prompts if needed]: Enter your BitBucket password"
    System.exit(1)
}
rootDir = args[1] + ((isGithub) ? '/hpcw' : (!isGithub) ? '/rcs' : '')
username = args[2]
password = (isGithub) ? '' : (args && args.size() >= 4) ? args[3] : ''
if (!isGithub && password == '') {
    password = System.console().readPassword('> Please enter your password for BitBucket: ')
}
username_password = "${username}:${password}" 
url = ''
if (isGithub) {
    url = "https://api.github.com/users/${username}/repos"
    proj_keys = [ 'hpcw': [] ]
} else {
    url = 'https://source.rcsdev.net/rest/api/1.0/projects'
    proj_keys = [:]
}

def doRestCall(def url) {
    println "Calling rest api on URL: ${url}"
    def call = ['curl', '-u', username_password, url].execute()
    def json = new JsonSlurper().parseText(call.text)
    return json
}

// BitBucket: Get all project names
def bb_getProjectList() {
    def proj_json = doRestCall(url)
    proj_json.values.each{
        proj_keys[it.key] = []
    }    
}

// BitBucket: Get all git links for each project
def bb_getProjectLinks() {
    proj_keys.each { key, link ->
        def json = doRestCall(url + '/' + key + '/repos?limit=100')
        json.values.each {
            it.links.clone.each { href ->
                if (href.name == 'ssh') {
                    proj_keys[key] << [ name: it.name, link: href.href ]
                }
            }
        }
    }
}

// BitBucket: Clone each project
def bb_cloneRepos() {
    proj_keys.each { key, proj_map ->
        def dir = new File(rootDir + "/" + key)
        dir.mkdirs()
        proj_map.each { proj ->
            gitClone(key, proj.link, "${dir.path}/${proj.name}")
        }
    }
}

// GitHub: Clone each project
def gh_getRepos() {
    def json = new JsonSlurper().parseText(url.toURL().text)
    json.each {
        proj_keys['hpcw'] << [ name: it.name, link: it.ssh_url ]
    }
    def dir = new File(rootDir)
    proj_keys['hpcw'].each {
        gitClone('hpcw', it.link, "${dir.path}/${it.name}")
    }
}

// Call Git clone
def gitClone(def proj, def link, def path) {
    printf("%-20s %-100s %-50s\n", "Cloning: $proj", "With: $link", "To: $path")
    def clone = "git clone ${link} ${path}".execute()
    clone.waitFor()
    if(!clone.exitValue()) {
        println "This repo failed to clone properly..."
    }
}

// Main Code Block
if (isGithub) {
    gh_getRepos()
} else {
    bb_getProjectList()
    bb_getProjectLinks()
    bb_cloneRepos()
}
println "Done"

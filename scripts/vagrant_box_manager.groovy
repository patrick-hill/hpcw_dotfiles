#!/usr/bin/env groovy


import groovy.util.CliBuilder

// Variables
def boxes = []

// Helper Methods
def p(def msg, def headerless=false) {
	if (headerless) {
		println msg
	} else {
    	println "Vagrant Box Manger ==> ${msg}"		
	}
}

def get_input(def msg) {
	System.console().readLine msg
}

def exec_cmd(def cmd) {
	cmd.execute()
}

def print_box_names(def parsed=false) {
	p 'Vagrant box printout: [START]' 
	if (parsed) {
		p boxes.join('\n')
	} else {
		p 'vagrant box list'.execute().text, true		
	}
	p 'Vagrant box printout: [END]'
}

def groups() {
	// I want to list boxes brouped by the version ;)
}

// Main Code
def get_installed_boxes() {
	boxes = 'vagrant box list'.execute().text.split('\n').collect{ it.split(' ')[0] }
}

def remove_box(def param) {
	p 'remove_box param is: ' + param
	/*
	Find boxes to remove
	Confirm action
	Perform action
	*/
	def toRemove = boxes.findAll { it.contains(param) }
	p 'Boxes to Remove are: [START]'
	toRemove.each { p it, true }
	p 'Boxes to Remove are: [END]'
	
	def confirm = get_input('Do you want to remove these boxes? (yes/no)')
	if (confirm ==~ /Y|YES|y|yes/) {
		p 'Removing boxes: [START]'
		toRemove.each {
			println 'Vagrant ==> Removing ==> ' + it
			exec_cmd "vagrant box remove ${it}"
		}
		p 'Removing boxes: [END]'
	} else {
		p 'Expected: Y,y,Yes,yes but got: ' + confirm
	}
}

def vbm() {
	def cli = new CliBuilder(usage:'vagrnt-box-manager.sh [command] [options]')
	cli.with {
		h	longOpt: 'help',		'Show usage info'
		l 	longOpt: 'list',		'List all boxes (Unparsed)'
		lp	longOpt: 'list-parsed', 'List all boxes (Parsed output)'
		lg 	longOpt: 'list-grouped','List all boxes grouped by version'	
		r 	longOpt: 'remove',		args: 1,	argName: 'target',	'Removes a box(es)'
		
	}
	def opt = cli.parse(args)
	
	if (!opt | opt.h) cli.usage()
	else if (opt.r) remove_box(opt.r)
	else if (opt.l) print_box_names()
	else if (opt.lp) print_box_names(true)
	else if (opt.lg) groups() 
	// else cli.usage()
	
}

get_installed_boxes()
vbm()

// def oldBoxes = get_installed_boxes(~/.*1.4.1.*/)
Raptor RDF Extension for RDF.rb
===================================

This is an [RDF.rb][] extension that adds support for parsing/serializing [NTriples][],
[RDF/XML][], [Turtle][], [RDFa][], and [Graphviz][] data using the [Raptor RDF Parser][Raptor]
library.

[![Gem Version](https://badge.fury.io/rb/rdf-raptor.svg)](https://badge.fury.io/rb/rdf-raptor)
[![Build Status](https://github.com/ruby-rdf/rdf-raptor/workflows/CI/badge.svg?branch=develop)](https://github.com/ruby-rdf/rdf-raptor/actions?query=workflow%3ACI)
[![Gitter chat](https://badges.gitter.im/ruby-rdf/rdf.png)](https://gitter.im/ruby-rdf/rdf)

Features
--------

* Uses the fast [Raptor][] C library.
* Parses and serializes RDF data from/into the NTriples, RDF/XML, and Turtle formats.
* Extracts RDF statements from XHTML+RDFa documents.
* Serializes RDF statements into Graphviz format.
* Provides serialization format auto-detection for RDF/XML, Turtle and RDFa.
* Compatible with any operating system supported by Raptor and Ruby.
* Compatible with MRI >= 2.6, JRuby and Rubinius.

Examples
--------

    require 'rdf/raptor'

### Ensuring Raptor is installed and obtaining the version number

    RDF::Raptor.available?         #=> true
    RDF::Raptor.version            #=> "3.2.0"

### Parsing RDF statements from an NTriples file

    RDF::Reader.open("http://datagraph.org/jhacker/foaf.nt") do |reader|
      reader.each_statement do |statement|
        puts statement.inspect
      end
    end

### Parsing RDF statements from an RDF/XML file

    RDF::Reader.open("http://datagraph.org/jhacker/foaf.rdf") do |reader|
      reader.each_statement do |statement|
        puts statement.inspect
      end
    end

### Parsing RDF statements from a Turtle file

    RDF::Reader.open("http://datagraph.org/jhacker/foaf.ttl") do |reader|
      reader.each_statement do |statement|
        puts statement.inspect
      end
    end

### Extracting RDF statements from an HTML+RDFa document

    RDF::Reader.open(url = "http://bblfish.net/", format: :rdfa, base_uri: url) do |reader|
      reader.each_statement do |statement|
        puts statement.inspect
      end
    end

### Serializing RDF statements into an RDF/XML file

    data = RDF::Repository.load("http://datagraph.org/jhacker/foaf.nt")
    
    RDF::Writer.open("output.rdf") do |writer|
      data.each_statement do |statement|
        writer << statement
      end
    end

### Serializing RDF statements into a Turtle file

    data = RDF::Repository.load("http://datagraph.org/jhacker/foaf.nt")
    
    RDF::Writer.open("output.ttl") do |writer|
      data.each_statement do |statement|
        writer << statement
      end
    end

### Obtaining the NTriples format specification class

    RDF::Format.for(:ntriples)      #=> RDF::Raptor::NTriples::Format
    RDF::Format.for("input.nt")
    RDF::Format.for(file_name:      "input.nt")
    RDF::Format.for(file_extension: "nt")
    RDF::Format.for(content_type:   "application/n-triples")

### Obtaining the RDF/XML format specification class

    RDF::Format.for(:rdfxml)       #=> RDF::Raptor::RDFXML::Format
    RDF::Format.for("input.rdf")
    RDF::Format.for(file_name:      "input.rdf")
    RDF::Format.for(file_extension: "rdf")
    RDF::Format.for(content_type:   "application/rdf+xml")

### Obtaining the Turtle format specification class

    RDF::Format.for(:turtle)       #=> RDF::Raptor::Turtle::Format
    RDF::Format.for("input.ttl")
    RDF::Format.for(file_name:      "input.ttl")
    RDF::Format.for(file_extension: "ttl")
    RDF::Format.for(content_type:   "text/turtle")

### Obtaining the RDFa format specification class

    RDF::Format.for(:rdfa)         #=> RDF::Raptor::RDFa::Format
    RDF::Format.for("input.html")
    RDF::Format.for(file_name:      "input.html")
    RDF::Format.for(file_extension: "html")
    RDF::Format.for(content_type:   "application/xhtml+xml")

### Obtaining the Graphviz format specification class

    RDF::Format.for(:graphviz)     #=> RDF::Raptor::Graphviz::Format
    RDF::Format.for("output.dot")
    RDF::Format.for(file_name:      "output.dot")
    RDF::Format.for(file_extension: "")
    RDF::Format.for(content_type:   "text/vnd.graphviz")

Documentation
-------------

<https://ruby-rdf.github.io/rdf-raptor/>

* {RDF::Raptor}
  * {RDF::Raptor::NTriples}
  * {RDF::Raptor::Turtle}
  * {RDF::Raptor::RDFXML}
  * {RDF::Raptor::RDFa}
  * {RDF::Raptor::Graphviz}

Dependencies
------------

* [RDF.rb](https://rubygems.org/gems/rdf) (~> 3.2)
* [FFI](https://rubygems.org/gems/ffi) (~> 1.15)
* [Raptor][] (>= 2.0), the `libraptor` library or the `rapper` binary

Installation
------------

The recommended installation method is via [RubyGems](https://rubygems.org/).
To install the latest official release of the `RDF::Raptor` gem, do:

    % [sudo] gem install rdf-raptor

To install the required [Raptor][] command-line tools themselves, look for a
`raptor` or `raptor-utils` package in your platform's package management
system. For your convenience, here follow installation instructions for the
Mac and the most common Linux and BSD distributions:

    % [sudo] port install raptor             # Mac OS X with MacPorts
    % [sudo] fink install raptor-bin         # Mac OS X with Fink
    % brew install raptor                    # Mac OS X with Homebrew
    % [sudo] aptitude install raptor-utils   # Ubuntu / Debian with aptitude
    % [sudo] apt-get install libraptor2-0    # Ubuntu / Debian with apt-get
    % [sudo] yum install raptor2             # Fedora / CentOS / RHEL
    % [sudo] zypper install raptor           # openSUSE
    % [sudo] emerge raptor                   # Gentoo Linux
    % [sudo] pacman -S raptor                # Arch Linux
    % [sudo] pkg_add -r raptor               # FreeBSD
    % [sudo] pkg_add raptor                  # OpenBSD / NetBSD

If the `libraptor2` library is in the standard library search path, and
the `rapper` command is in the standard command search path, all should
be well and work fine out of the box. However, if either is in a
non-standard location, be sure to set the `RDF_RAPTOR_LIBPATH` and/or
`RDF_RAPTOR_BINPATH` environment variables appropriately before
requiring `rdf/raptor`.

Download
--------

To get a local working copy of the development repository, do:

    % git clone git@github.com:ruby-rdf/rdf-raptor.git

Alternatively, download the latest development version as a tarball as
follows:

    % wget https://github.com/ruby-rdf/rdf-raptor/tarball/master

Mailing List
------------

* <https://lists.w3.org/Archives/Public/public-rdf-ruby/>

Authors
-------

* [Arto Bendiken](https://github.com/artob) - <https://ar.to/>
* [John Fieber](https://github.com/jfieber) - <https://github.com/jfieber>

Contributors
------------

* [Ben Lavender](https://github.com/bhuga) - <https://bhuga.net/>
* [David Butler](https://github.com/dwbutler) - <https://github.com/dwbutler>
* [Gregg Kellogg](https://github.com/gkellogg) - <https://greggkellogg.net/>

License
-------

This is free and unencumbered public domain software. For more information,
see <https://unlicense.org/> or the accompanying [UNLICENSE][] file.

[RDF.rb]:   https://ruby-rdf.github.io/rdf
[NTriples]: https://en.wikipedia.org/wiki/N-Triples
[RDF/XML]:  https://www.w3.org/TR/REC-rdf-syntax/
[Turtle]:   https://en.wikipedia.org/wiki/Turtle_(syntax)
[RDFa]:     https://rdfa.info/
[Graphviz]: https://www.graphviz.org/
[Raptor]:   https://librdf.org/raptor/
[rapper]:   https://librdf.org/raptor/rapper.html
[UNLICENSE]:https://github.com/ruby-rdf/rdf-raptor/blob/master/UNLICENSE

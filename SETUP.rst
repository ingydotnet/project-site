=================================
Setting up a Project Site website
=================================

Project Site is easy to set up. Just follow these easy steps::

    > cd your/server/website/path/
    > git clone git://github.com/ingydotnet/project-site.git
    > mkdir your-project-name
    > cd your-project-name
    > make -f ../project-site/Makefile project-site
    ... edit the config.yaml file appropriately
    ... add the appropriate image files to site/images/
    ... edit files in the content directory ... (See below)
    > make
    ... repeat edit/make as necessary ...

The directory ``your/server/website/path/your-project-name/site/`` is your
website's root directory. You'll need to configure your web server to point at
that directory. HINT: Symlinks might come in handy.

That's it.

====================================
Creating and Editing Website Content
====================================

You create web pages by editing files under the directory called ``content/``.
The file ending indicates the markup you are using. Pages get transformed to
html using the following mapping::

    content/home.st                 -> site/home/index.html
    content/reference/.pod          -> site/reference/index.html
    content/reference/manual.html   -> site/reference/manual/index.html

Project Site currently support these markups:

* ``.pod`` -- POD (Perl doc format)
* ``.st`` -- Socialtext Wiki Markup
* ``.html`` -- HTML (Just the contents of the <body> tag)

Adding other formatters is trivial. Let me know if you want something or just
send me a patch.

===================
System Requirements
===================

You'll need the following tools installed on your system:

* ``git`` version control system
* GNU ``make``
* Perl 5.8 or higher
* The Perl ``Template::Toolkit::Simple`` module
* The Perl ``Wikitext::Socialtext`` module for ``.st`` content files


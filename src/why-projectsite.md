---
title: Why ProjectSite?
---
This is the story of why ProjectSite was made, why I use it, and why you might want to as well.

I'm really into Open Source.
I've been doing since before the term was coined.
I have a [lot of projects](http://github.com/ingydotnet) and a lot of domain names.
When I think up of a cool new idea, I usually start by giving it a good name, and often I'll buy a domain name for it.

Sadly, I have very few actual web sites for those projects.
Making and maintaining web sites has always been a pain in the butt, even when the projects were for building web sites.
Really all I want on these sites is good documentation, maybe a blog, maybe a book, maybe some demos.
I actually really like writing content for all these things.

What I've really needed and wanted is a way to make websites by just writing the content and pressing a button.
That's what ProjectSite is for me.
Of course there no end of existing frameworks for doing this, so bear with me while I explain why I needed something more.

I actually made a really terrible toolset that I called `project-site` around 2010 that I used to make a half dozen really basic sites for some of my projects I was excited about at the time.
This year I decided to use the same name but make it modern.

I've been a big fan of static sites for the last 10 years.
With the right JavaScript parts they can be made to be as engaging and interactive as any program driven site.
On top of that they end up being very fast and very secure.

I've also been an avid user of [GitHub](ihttps://github.com/) for at least as long.
GitHub embraces and supports static sites with [GitHub Pages](https://pages.github.com/).
The sites they host are fast and they now support SSL with no work.
This website is built by ProjectSite and hosted on GitHub Pages; as are all ProjectSite sites, by default.

## What about Jekyll and Hugo, etc?

This is actually the main point of ProjectSite!

With ProjectSite you pretty much just write content (in [Markdown](https://en.wikipedia.org/wiki/Markdown)) and configuration (in [YAML](https://en.wikipedia.org/wiki/YAML)).
You organize the content into a directory structure that matches your site layout.
Every layer inherits the config from the layer above it.

ProjectSite takes your input and blasts it into a [Jekyll](https://jekyllrb.com/) or [Hugo](https://gohugo.io/) or etc **builder** environment that does its thing without you needing to learn the details.
That means you can migrate your entire site from a Jekyll based builder to a Hugo based one, by changing one line in a YAML file.

### Jekyll is Hard

Don't get me wrong.
Jekyll did an outstanding job of making building a website way easier than doing it by hand.
But creating a new site with Jekyll or any other framework has a learning curve and still involves a lot of development.
The advantage is that you can build a website that does almost anything you want it to.
On the other hand, not everyone (like me) wants all that flexibility.

Say you stumble upon a static site that you really like, and you just want your site to be pretty much the same; maybe with a few different colors and buttons.
Well that's not so hard, because most of these sites point back to their sources, often on GitHub.
All you need to do is fork, clone, tweak, commit and push.
If you have 20 projects, all you need to do is do that 20 times.

Eventually you'll find another project's site that you like, and want to change 10 of your sites to that.
Now you need to figure out what you tweaked when you made those sites and migrate them into the right tweaks in the new system.

There's another problem you might run into.
If the site you built over is more than a year old, you might have trouble recreating the build system for it locally.
All the package pinning tools out there are meant to prevent this, but sadly sometimes it just doesn't work out as planned.

ProjectSite deals with all this by having builders.
A builder uses a specific framework, configured a certain way.
ProjectSite encapsulates the framework and configuration into a [Docker](https://www.docker.com/) image, so that (theoretically) it will never stop working.

## Give me an Example

The real world driver for this was that I wanted to make a new <https://yaml.com>.
There is some renewed energy in the development of the YAML data language, and I wanted to get that information out into the world.
I also realized that if I was happy with the new site, I wanted to very quickly make 20 more sites that looked and worked the same.

This Summer (2020) I went looking for a Jekyll theme with some good enough navigation components.
I found something that was ok, but to my dismay I realized that a Jekyll theme is really just Jekyll configured a certain way.
I had hoped that it would be configurable in a single file, so that I could turn the blues to oranges, and enable and disable a list of things.
I really wasn't interested in diving into any CSS variants and learning how it all worked.

I gave up until the Fall, and then decided that I really liked the [Bootstrap 4.5 documentation site](https://getbootstrap.com/docs/4.5/).
Jekyll 5.0 had moved on to Hugo, but I was easily able to build the doc site from the [4.5 branch](https://github.com/twbs/bootstrap/tree/v4.5.3).
I wrote a Dockerfile to set up the build environment, and started figuring out how to rearrange things to make the site work like I wanted it to.

It was and still is a lot of work.
It's worth it to me because I know that all the hard work isn't wasted on a single site.
As I make my 20 sites, I know that every improvement will be able to benefit all of them.
If the new change needs to be used only by some sites, I'll make it into a config option.
Simple.

I gave the builder a name "bootstrap45".
At the moment this is the only builder available.
As I add functionality I try to stay aware that it will need to work with future builders.

## The Good Parts

There was a lot to like about Jekyll and the Bootstrap docs configuration of it.
There were also a number of additional things I wanted.
There were also some parts of the Jekyll process that I didn't like.
I just fixed those things in the builder.

Basically I wanted to layout everything in a way such that I never had to repeat myself.
For instance, Jekyll lets you have a main config file and per-page front-matter style config.
I wanted options that applied to all the pages in a folder and every folder under that one (unless, of course, I changed it with another config file).

I realized that I could just gather all the config together for each individual page and generate a giant front matter.
The only thing people would see was my clean config and the final website result.
I could get messy in between.

Here's some of the features of ProjectSite and the bootstrap45 builder.

### The Bootstrap / Jekyll Parts

* Multiple Section Top Navigation Bar

  I want sites that contain both Doc and Blog and more.
  When I chose something from the top, the whole site feel for that section can change.

* Left Side Bar Navigation for Each Site Section

  When a top nav section is selected the side bar nav (can and probably should) change to represent the new section.

* Right Side Table of Contents Navigation

  On the right you can have a table-of-contents navigation for long pages.
  Just to be clear, every page can have a different nav component (or none) for any of those 3.
  It's all extrememely configurable, but setting an option for all the pages inb a section or group is something you only need to do n one place.

* Extremely Responsive Results

  Your final website is going to look good just about everywhere.
  Since this is Bootstrap's site, it had better!

* Every Page Links to GitHub

  There's a little button on every page linking it back to the GitHub source file.
  A reader can view it, edit it, and make a resulting pull request for the changes.

* The Copy Button

  Every code block section in your docs will have a Copy button next to it.

* Social Navigation Icons

  You can config GitHub, Twitter and Slack links into your navbar.
  Each by adding a line to the top config.

* The `redirect_from` Jekyll Plugin

  This handy Jekyll plugin lets you list some urls that should redirect to the page where you put it.
  This is so much simpler than having to create dummy pages for each url you want to redirect.
  Note: you can also do that with `redirect_to`.

### The ProjectSite Parts

* A CommandLine Utility

  ProjectSite installs the `project-site` command which can be used to create and deploy your site.

* A Smart Makefile

  When you make a new ProjectSite, it comes with a sample site and a Makefile.
  The Makefile makes it even easier to do the commonb tasks.

  For instance you can fork (on GitHub) any ProjectSite site's source.
  If you then clone it, and run `make publish` it will actually put your version on the web!
  This let's you actually live test your changes before making a Pull Request.

* Per Directory and File Config

  Every level of your site source is configurable and inherits from the level above it.
  Effectively your top level config is inheritaing from ProjectSite and your chosen builder.

* Logo and FavIcon Generator

  If you don't mind that your logo image is just 1 or 2 letters, you can add those letters to your main config and get the logo for free!
  Later on you can add something better, but who wants to bother with that when you just want to get your ideas out.

There's really a lot more goodness baked in.
That's just a taste.
Hope you found it yummy!

## Conclusion

If you have a project that you want a decent website for with the absolute minimum fuss, ProjectSite might be for you.
Especially if you just want to write the content and pick out a few layout options.

If you want your site to be unique, then it's probably not what you want.

However if you end up crafting something so excellent that you know everyone will be jealous, and you are willing to share...
Consider crafting it into a ProjectSite builder!

I might know of 20 or so sites that would switch to it. `:-)`

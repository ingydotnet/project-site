ProjectSite
===========

Create a website for your Open Source project.

## Description

The [ProjectSite](http://project-site.org) web site builder lets you define rich websites using only [Markdown](https://daringfireball.net/projects/markdown/) and [YAML](https://yaml.com).
The software builds and publishes state off the art, mobile ready websites with a single command.
The generated websites are static which means they are very secure and blindingly fast.

ProjectSite is geared towards make informational websites for software projects.

## How it Works

The `project-site` command takes your input files and injects them into a builder environment using Docker.
The builder environment is a third party static site builder with a preconfigured theme and plugins.

At this point there is only one builder available:

* `bootstrap45`

  This builder is a modified version of the tooling used to produce the [Bootsrap 4.5 documenation website](https://getbootstrap.com/docs/4.5/).
  Its main features are that it has a site section contents sidebar on the left and page contents navigation on the right.
  It has a lot of other little formatting niceties and given that its Bootstrap's site you can expect it will work well everywhere.

  The Bootstrap site is built with the popular [Jekyll](https://jekyllrb.com/) static site framework.
  ProjectSite injects its YAML and Markdown content into Jekyll and triggers its build system.
  ProjectSite allows you to put YAML in more appropriate places and then collects it and puts it in the places Jekyll wants.

* Even though ProjectSite only has one builder/backend at this early stage, it is geared towards front-ending lots of static builders.
  This means you can (in the future) change your website to a completely different framework, like [Hugo](https://gohugo.io/) or [WordPress](https://wordpress.com/), by changing a single line in a YAML file.

## Prerequisites

ProjectSite is designed to use a very minimal set of prerequisite software components that are likely already installed for most modern software developers.
All the complexities are encapsulated away in the builder Docker images.

* Docker -- For running the complex website builders.
* Bash -- Just needs to be on your system. (Not your required interactive shell).
* Git -- For installing the framework and publishing your site.
* GitHub account -- Sites are published to GitHub Pages.
* GNU Make -- Not strictly necessary but all actions have Makefile support by default.

## Installation

Installation is also a trivial clone and source style:

```
# Clone this repository:
git clone git@github.com:ingydotnet/project-site

# In your Bash, Zsh (or similar) shell startup file:
source /path/to/project-site/.rc
```

## Commands

There are more than this, but here's the commands you need to know:

* Show all the `project-site` commandline commands and options:
  ```
  project-site --help
  ```

* Create a new project-site website:
  ```
  project-site --new my-project-site
  ```
  This will create a directory called `my-project-site` with your new website.

* Build your site and view it locally:
  ```
  project-site --local
  ```

* Publish your site live to the internet:
  ```
  project-site --publish
  ```

## See Also

Here are some sites currently using ProjectSite:

* [project-site.org](https://project-site.com)
* [yaml.com](https://yaml.com)

## License and Copyright

Copyright 2020. Ingy döt Net <ingy@ingy.net>.

ProjectSite is released under the MIT license.

See the file License for more details.

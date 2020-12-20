---
title: Forking a ProjectSite
---
If you are visiting a site created by ProjectSite and see a change you want to make, it's very easy to do.

First make sure you have the ProjectSite software [installed](/Installation/).

Next find the GitHub repository for that website.
If you are lucky it will have a GitHub icon in the top navigation bar.

From GitHub fork the repository to your account.
Then clone the fork to your computer.

If the site uses the standard ProjectSite Makefile, just run:
```
make publish
```

When you are done your copy of the site should be live on the internet!
The URL will look like:

> `http://<your-github-id>.github.io/<their-site-repo-name>`

Now you can make your changes and when they look good on the web, submit a Pull Request to the original site's maintainer(s).

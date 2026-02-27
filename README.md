===============================================================================
LIBERTYBSD-WEBSITE                             Static site for GitHub Pages
===============================================================================

This repository now contains prebuilt static HTML pages and shared assets.
There is no server-side SSI or shell execution at runtime.

----------------------------------------
SITE STRUCTURE
----------------------------------------
English pages (root):
	- index.html
	- faq.html
	- errata.html
	- download.html (redirects to the GitHub scripts repo)

Localized pages:
	- es/index.html, es/faq.html, es/errata.html, es/download.html (redirect)
	- eo/index.html, eo/faq.html, eo/errata.html, eo/download.html (redirect)

Shared assets:
	- res/style.css
	- res/img/*

----------------------------------------
LOCAL REGENERATION
----------------------------------------
If you edit translation values under `res/lang/*.sh`, regenerate all static
pages with:
	`./gen.sh`

This rewrites the HTML pages listed above and keeps links compatible with
GitHub Pages project URLs (relative paths, no domain-root assumptions).

----------------------------------------
GITHUB PAGES
----------------------------------------
Deploy this repo as a static site from the repository root (main/master
branch root folder).

A `.nojekyll` file is included so GitHub serves files as-is.

----------------------------------------
BORING STUFF
----------------------------------------
Maintainer is Jaidyn Levesque <jadedctrl@posteo.net>,
license is CC 0,
and sauce is at https://git.eunichx.us/libertybsd-website

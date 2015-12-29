# gnucash-reports
Custom reports for use with GnuCash, the open source personal and small business financial accounting software.

See http://gnucash.org/.

## Installation

To add a custom report to GnuCash:

1. Download the corresponding .scm files (note: there are two .scm files for each report, a definition file, e.g., custom.scm, and an implementation file, e.g., custom_imp.scm), or clone this github repository.

2. Add the following to config.user in your GnuCash configuration directory:

 ```scheme
 (set! %load-path (append %load-path '("PATH TO .SCM FILES")))
 (use-modules (NAME))
 ```

 Note: By default, the GnuCash configuration directory is located at ~/.gnucash/ (on Linux) or ~/Library/Application Support/GnuCash/ (on OS X).

3. Start GnuCash using something like:

 ```
 gnucash --debug --log gnc.scm=debug --logto stdout
 ```

 The custom report(s) should appear under *Reports* -> *Sample & Custom*.

## An Example

The files *custom.scm* and *custom_imp.scm* define a bare bones template for a GnuCash report. Assuming you clone this github repository in
~/gnucash-reports.git, you could add the template custom report to GnuCash by adding the following to config.user:

```scheme
(define (homedir) (passwd:dir (getpw (getlogin))))
(set! %load-path (append %load-path (list (string-append (homedir) '"/gnucash-reports.git"))))
(use-modules (custom))
```

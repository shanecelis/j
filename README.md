README
======

`j.sh` maintains a jump-list of directories you actually use.  Old
directories eventually fall off the list.  It was inspired by
[autojump](http://wiki.github.com/joelthelion/autojump).

INSTALL
=======

Source the file `j.sh` in `.bashrc`.  Add the following line to your
`.bashrc` file.

    source "~/j.sh"

USAGE
-----

Essentially one `cd`s around as normal, and uses the `j` command when
one wants to jump to a directory he or she has recently been to.  `j`
has tab-completion of course.  Here is usage.

       j [--l] [regex1 ... regexn]
         regex1 ... regexn jump to the most used directory matching all masks
         --h               Show usage (this)
         --l               Show the list instead of jumping
                           with no args, shows full list

After installation, here is what a sample session might look like.

    $ j --l;                                      # List is initially empty.
    $ cd /Library/Frameworks/Python.framework;    # cd'd directory placed in the list. 
    $ j --l;                                      # Let's look at the list.
    1	/Library/Frameworks/Python.framework
    $ cd $HOME
    $ j py[TAB]
    $ j /Library/Frameworks/Python.framework[RETURN]


Editor Integration
==================

For those who are not satisfied with having this awesome shell tool at
their disposal and instead want this kind of functionality everywhere,
one can integrate it into their editor, provided their editor is
Emacs.  However, we hope to accept patches for other environments.

Emacs
-----

The file `j.el` integrates `j.sh` jump-list functionality with Emacs.

### Install

To install add the following lines to `.emacs` file.
 
    (load-library "~/j/j.el")        ; or whatever the path is to j.el

One can bind this to a key with the following code:

    (global-set-key (kbd "C-c j") 'j)

That will bind `j` function to the `C-c j`.

### Usage

Type `M-x j[RETURN]`, and it will ask for a directory, then bring the
directory up in
[dired](http://www.gnu.org/software/emacs/manual/html_node/emacs/Dired.html#Dired).
The emacs version of `j` has tab-completion as well.  So the
minibuffer would work like this:

    M-x j[RETURN]
    Directory: 
    Directory: py[TAB]
    Directory: /Library/Frameworks/Python.framework[RETURN]

Most importantly, the Emacs version shares the same jump list so what
you work on in shell is automatically conveniently accessible in
Emacs.

Note: If `ido` is loaded, it will use `ido-completion`.
([ido](http://www.emacswiki.org/emacs/InteractivelyDoThings) is a very
nice emacs package, heartily recommended.)

### Future

Potential future ideas include having Emacs cross pollinating `j.sh`'s
jump-list of directories.  Currently, only `j.sh` goes into emacs.

vi
--

No such code available.  Happy to accept patches though.

CREDITS
=======

* rupa

* Joel Schaerer aka joelthelion for autojump.

* Daniel Drucker aka dmd for finding a zillion bugs and making me late
  for lunch.

* Shane Celis aka secelis added Emacs integration.

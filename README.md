This plugin changes the current working directory to the projects root. It
works by searching from a files directory upwards until a project file is
found.

The [defaults](autoload/project_chdir.vim) can be overridden or extended by
associating filenames with priorities:

```vim
let g:project_chdir#items =
  \ {
  \   '.git':      2,
  \   'Makefile':  1,
  \   'README.md': 0,
  \ }
```

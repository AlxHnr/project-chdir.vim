This plugin changes the current working directory to the projects root. It
works by searching from a files directory upwards until a project file is
found. The behaviour can be configured by associating filenames with
priorities:

```vim
let g:project_chdir#items =
  \ {
  \   '.hg':            1,
  \   '.bzr':           1,
  \   '.git':           1,
  \   '.svn':           1,
  \   'makefile':       0,
  \   'Makefile':       0,
  \   'configure':      0,
  \   'CMakeLists.txt': 0,
  \ }
```

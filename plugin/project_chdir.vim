if exists('g:loaded_project_chdir')
  finish
endif
let g:loaded_project_chdir = 1

if !exists('g:project_chdir#items')
  " Associates files/directories with their priorities.
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
endif

augroup project_chdir
  autocmd!
  autocmd BufNewFile,BufRead * call project_chdir#run()
augroup END

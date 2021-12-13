if exists('g:loaded_project_chdir')
  finish
endif
let g:loaded_project_chdir = 1

augroup project_chdir
  autocmd!
  autocmd BufWinEnter * call project_chdir#run()
augroup END

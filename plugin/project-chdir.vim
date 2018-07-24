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

function! s:project_chdir() " {{{
  let l:path = expand('%:p')
  if !strlen(l:path)
    return
  endif

  let l:priority = -1
  while l:path !~ '\v^(\/|\.)$'
    let l:path = fnamemodify(l:path, ':h')
    for l:file_to_search in keys(g:project_chdir#items)
      if l:priority >= g:project_chdir#items[l:file_to_search]
        continue
      endif

      let l:path_to_check = l:path . '/' . l:file_to_search
      if filereadable(l:path_to_check) || isdirectory(l:path_to_check)
        execute 'lchdir! ' . escape(l:path, '\ ')
        let l:priority = g:project_chdir#items[l:file_to_search]
      endif
    endfor
  endwhile
endfunction " }}}

augroup project_chdir
  autocmd!
  autocmd BufNewFile,BufRead * call s:project_chdir()
augroup END

let s:default_items =
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

function! project_chdir#run() " {{{
  let l:path = expand('%:p')
  if !strlen(l:path)
    return
  endif

  let l:items = copy(s:default_items)
  if exists('g:project_chdir#items')
    call extend(l:items, g:project_chdir#items)
  endif

  let l:priority = -1
  while l:path !~ '\v^(\/|\.)$'
    let l:path = fnamemodify(l:path, ':h')
    for l:file_to_search in keys(l:items)
      if l:priority >= l:items[l:file_to_search]
        continue
      endif

      let l:path_to_check = l:path . '/' . l:file_to_search
      if filereadable(l:path_to_check) || isdirectory(l:path_to_check)
        execute 'lchdir! ' . escape(l:path, '\ ')
        let l:priority = l:items[l:file_to_search]
      endif
    endfor
  endwhile
endfunction " }}}

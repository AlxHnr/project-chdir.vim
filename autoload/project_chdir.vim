function! project_chdir#run() " {{{
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

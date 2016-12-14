" This is free and unencumbered software released into the public domain. {{{
"
" Anyone is free to copy, modify, publish, use, compile, sell, or
" distribute this software, either in source code form or as a compiled
" binary, for any purpose, commercial or non-commercial, and by any
" means.
"
" In jurisdictions that recognize copyright laws, the author or authors
" of this software dedicate any and all copyright interest in the
" software to the public domain. We make this dedication for the benefit
" of the public at large and to the detriment of our heirs and
" successors. We intend this dedication to be an overt act of
" relinquishment in perpetuity of all present and future rights to this
" software under copyright law.
"
" THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
" EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
" MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
" IN NO EVENT SHALL THE AUTHORS BE LIABLE FOR ANY CLAIM, DAMAGES OR
" OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
" ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
" OTHER DEALINGS IN THE SOFTWARE.
"
" For more information, please refer to <http://unlicense.org/>
" }}}

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
        break
      endif
    endfor
  endwhile
endfunction " }}}

augroup project_chdir
  autocmd!
  autocmd BufNewFile,BufRead * call s:project_chdir()
augroup END

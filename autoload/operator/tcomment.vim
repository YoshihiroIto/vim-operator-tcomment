"=============================================================================
" FILE: tcomment.vim
" AUTHOR: Yoshihiro Ito <yo.i.jewelry.bab@gmail.com@gmail.com>
" License: MIT license  {{{
"     Permission is hereby granted, free of charge, to any person obtaining
"     a copy of this software and associated documentation files (the
"     "Software"), to deal in the Software without restriction, including
"     without limitation the rights to use, copy, modify, merge, publish,
"     distribute, sublicense, and/or sell copies of the Software, and to
"     permit persons to whom the Software is furnished to do so, subject to
"     the following conditions:
"
"     The above copyright notice and this permission notice shall be included
"     in all copies or substantial portions of the Software.
"
"     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
"     OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
"     MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
"     IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
"     CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
"     TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
"     SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
" }}}
"=============================================================================
function! s:restore_screen_pos()
  let line_diff = line('w0') - g:operator#tcomment#save_screen_pos
  if line_diff > 0
    execute 'silent normal!' line_diff."\<C-y>"
  elseif line_diff < 0
    execute 'silent normal!' (-line_diff)."\<C-e>"
  endif
endfunction

function! operator#tcomment#save_pos()
  let g:operator#tcomment#save_pos        = getpos(".")
  let g:operator#tcomment#save_screen_pos = line("w0")
endfunction

function! operator#tcomment#op_tcomment(motion_wiseness)

  if a:motion_wiseness == 'char'
    " todo:起動１度目に暴発してしまう。なぜ？
    " TCommentInline
  else
    execute "silent! normal" "`[V`]\gc"
  endif

  if exists('g:operator#tcomment#save_pos')
    call setpos('.', g:operator#tcomment#save_pos)
    " unlet g:operator#tcomment#save_pos
  endif

  if exists('g:operator#tcomment#save_screen_pos')
    call s:restore_screen_pos()
    " unlet g:operator#tcomment#save_screen_pos
  endif

  echom "C"
endfunction
" vim: set ts=2 sw=2 sts=2 et :

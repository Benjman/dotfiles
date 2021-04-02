
" appends class descriptor to the end of the class body
function! AppendClassDescriptor()
	if getline('.') !~? 'class \S\+ {'
		return
	endif
	
	norm 0/class<cr>
	norm wy2wf{%$a // 
	norm p

endfunction

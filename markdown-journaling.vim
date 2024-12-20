" Automatically insert markdown header template on new file creation
augroup markdown_header
    autocmd!
    autocmd BufNewFile,BufRead *.md call s:InsertHeader()
augroup END

" Insert markdown header template
function! s:InsertHeader()
    if getline(1) =~ '^---'
        echom "Header already present"
    else
        echom "Inserting markdown header template"
        let l:header = [
            \ '---',
            \ 'title: ',
            \ 'tags: ',
            \ 'date: ' . strftime('%Y-%m-%d'),
	    \ 'happiness: ',
            \ '---',
            \ ''
            \ ]
        call append(0, l:header)
        echom "Header template inserted"
    endif
endfunction

" --- Rename Markdown File ---
autocmd BufWritePost *.md call s:RenameMarkdownFile()

function! s:RenameMarkdownFile()
    echom "s:RenameMarkdownFile called"
    let l:header = s:GetHeader()
    if has_key(l:header, 'title') && has_key(l:header, 'date')
        echom "Header detected"
        let l:title = s:FormatTitle(l:header['title'])
        let l:date = l:header['date']
        echom "Extracted title: " . l:title
        echom "Extracted date: " . l:date
        call s:Rename(s:GetFilename(), l:date . '-' . l:title . '.md')
    else
        echom "No valid header found"
    endif
endfunction

function! s:GetHeader()
    echom "s:GetHeader called"
    let l:header = {}
    let l:content = getline(1, '$')
    let l:start = -1
    let l:end = -1
    for l:i in range(len(l:content))
        if l:content[l:i] =~ '^---\s*$'
            if l:start == -1
                let l:start = l:i
            else
                let l:end = l:i
                break
            endif
        endif
    endfor
    if l:start != -1 && l:end != -1
        for l:i in range(l:start + 1, l:end - 1)
            let l:line = split(l:content[l:i], ':', 2)
            if len(l:line) == 2
                let l:key = tolower(trim(l:line[0]))
                let l:value = trim(l:line[1])
                let l:header[l:key] = l:value
            endif
        endfor
    endif
    return l:header
endfunction

function! s:FormatTitle(title)
    echom "s:FormatTitle called"
    return substitute(a:title, '\s\+', '-', 'g')
endfunction

function! s:GetFilename()
    echom "s:GetFilename called"
    let l:file_name = expand('%:t')
    echom "Current filename: " . l:file_name
    if l:file_name !~ '\.md$'
        return substitute(l:file_name, '\..*$', '.md', '')
    endif
    return l:file_name
endfunction

function! s:Rename(from, to)
    echom "s:Rename called with " . a:from . " to " . a:to
    let l:from_path = expand('%:p:h') . '/' . a:from
    let l:to_path = expand('%:p:h') . '/' . a:to
    echom "From path: " . l:from_path
    echom "To path: " . l:to_path

    " Perform the rename operation
    if l:from_path != l:to_path
        call rename(l:from_path, l:to_path)
        " Reload the buffer with the new filename
        execute 'edit ' . fnameescape(l:to_path)
        echom "File renamed to " . l:to_path
    else
        echom "Source and destination paths are the same. Rename skipped."
    endif
endfunction

endfunction


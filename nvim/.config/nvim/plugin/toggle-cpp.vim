function! Header(cpp)
    let header=""
    if a:cpp[-4:] == ".cpp"
      let header=substitute(a:cpp, "\.cpp$", ".h", "")
    elseif a:cpp[-2:] == ".c"
      let header=substitute(a:cpp, "\.c$", ".h", "")
    else
      return a:cpp
    endif
    if filereadable(header)
      return header
    endif
    let header=split(header, "/")
    let header=header[:-2] + ["include", header[-2], header[-1]]
    let header=join(header, "/")
    return header
endfunction

function! CppFile(h)
    let cpp=""
    if a:h[-4:] == ".hpp"
      let cpp=substitute(a:h, "\.hpp$", ".cpp", "")
    elseif a:h[-2:] == ".h"
      let cpp=substitute(a:h, "\.h$", ".cpp", "")
    else
      return a:h
    endif
    if filereadable(cpp)
      return cpp
    endif
    let cpp=split(cpp, "/")
    if len(cpp) >= 4 && cpp[-3] == "include" && cpp[-2] == cpp[-4]
        let cpp=cpp[:-4] + [cpp[-1]]
        let cpp=join(cpp, "/")
        return cpp
    endif
    return a:h
endfunction

function! ToggleCPPHeader()
    let current=expand("%")

    if current[-4:] == ".cpp" || current[-2:] == ".c"
      let header=Header(current)
      if filereadable(header)
        exec "edit " . header
      endif
    elseif current[-2:] == ".h" || current[-4:] == ".hpp"
      let cpp=CppFile(current)
      if filereadable(cpp)
        exec "edit " . cpp
      endif
    endif
endfunction

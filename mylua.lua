function Image(img)
    if img.classes:find('mylua', 1) then
	-- Open file
        local f = io.open("myfile/" .. img.src, 'r')
        if f then
  	    -- Read file
            local file_content = f:read('*a')
            f:close()
		
	    -- Read the file content from the file that is pointed
            local doc = pandoc.read(file_content)
            local caption = pandoc.utils.stringify(doc.meta.caption)
            local name = pandoc.utils.stringify(doc.meta.name)
            local am = pandoc.utils.stringify(doc.meta.id)

	    -- Customizing LaTeX syntax
            local mylua = "\\begin{quote}\n"
            mylua = mylua .. "\\textit{" .. caption .. "}\n"
            mylua = mylua .. "\n"
            mylua = mylua .. "\\textbf{Author:} \\textit{" .. name .. "} (" .. am .. ")\n"
            mylua = mylua .. "\\end{quote}\n"

            -- Return the formatted LaTeX block
            return pandoc.RawInline('latex', mylua)
        else
            -- If the file doesn't exist, return a LaTeX error message
            return pandoc.RawInline('latex', '\\textbf{Error: file ' .. img.src .. ' not found!}')
        end
    end
end

function Image(img)
    if img.classes:find('mylua', 1) then
        -- Open the file specified in img.src
        local f = io.open("myfile/" .. img.src, 'r')
        if f then
            local file_content = f:read('*a')
            f:close()

            -- Read metadata from the file
            local doc = pandoc.read(file_content)
            local caption = pandoc.utils.stringify(doc.meta.caption)
            local name = pandoc.utils.stringify(doc.meta.name)
            local am = pandoc.utils.stringify(doc.meta.id)

            -- Construct the custom content
            local line = "_____________________________________________________________"
            local mylua = line .. "\n\n"
            mylua = mylua .. "> _" .. caption .. "_ \n>"
            mylua = mylua .. "\n\n" .. line .. "\n\n"
            mylua = mylua .. "> _" .. name .. " " .. am .. "_ \n>"
            mylua = mylua .. "\n\n" .. line .. "\n\n"

            -- Return the content as a raw LaTeX block (since we're generating a LaTeX file)
            return pandoc.RawInline('latex', '\\begin{quote}\n' .. mylua .. '\\end{quote}')
        else
            -- If file doesn't exist, return a warning in LaTeX
            return pandoc.RawInline('latex', '\\textbf{Error: file ' .. img.src .. ' not found!}')
        end
    end
end

for _, fn in next, getgc(true) do
    if type(fn) == "function" then
        local info = debug.getinfo(fn)
        if info and info.name and info.name:lower():find("customvalidation") then
            local old
            old = hookfunction(fn, function(...)
                local success, result = pcall(old, ...)
                if not success then
                    return true
                end
                local t = typeof(result)
                if t == "boolean" then
                    return true
                elseif t == "number" then
                    return 999999
                elseif t == "string" then
                    return "validated"
                elseif t == "table" then
                    return {} 
                else
                    return result
                end
            end)
            print("Hooked CustomValidation -> enhanced safe bypass")
        end
    end
end

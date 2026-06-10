return {
    cmd = {"solargraph", "stdio"},
    filetypes = {"ruby"},
    root_markers = {".git", "Gemfile"},
    settings = {
        solargraph = {
            diagnostics = true,
            completion = true,
            useBundler = true,
        }
    }
}

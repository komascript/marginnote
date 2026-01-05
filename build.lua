#!/usr/bin/env texlua

--[[
  Build script for marginnote project
  Copyright (c) 2021–2026 Markus Kohm

  This file is part of the build system of marginnote.

  It may be distributed and/or modified under the conditions of the
  LaTeX Project Public License (LPPL), either version 1.3c of this
  license or (at your option) any later version.  The latest version
  of this license is in the file

    https://www.latex-project.org/lppl.txt
]]

release_info = "2026-01-05 v1.4d"

-- Bundle and modules

module       = "marginnote"

unpackfiles  = { "marginnote.dtx" }

installfiles = { "marginnote.sty" }

-- Package

packtdszip   = false

-- CTAN information

ctanpkg   = "marginnote"

uploadconfig = {
  pkg         = "marginnote",
  version     = release_info,
  author      = "Markus Kohm (inactive)",
  license     = "lppl1.3c",
  summary     = "Notes in the margin, even where \\marginpar fails",
  topic       = "notes",
  ctanPath    = "/macros/latex/contrib/marginnote",
  bugtracker  = "https://codeberg.org/komascript/marginnote/issues",
  home        = "https://codeberg.org/komascript/marginnote",
  repository  = "https://codeberg.org/komascript/marginnote.git",
  note        = "From version 1.4b the package is unmaintained."
}

-- Typesetting

typesetruns  = 5

-- Tagging
-- Example: `l3build tag --date 2026-01-02 v1.4d'

tagfiles = {module..".dtx","README.md","build.lua"}

function update_tag (file,content,tagname,tagdate)
   tagname = string.gsub (tagname, "v(%d+%.%d+%l?)", "%1")
   tagyear = string.sub (tagdate, 1, 4)
   -- fix the copyright year
   content = string.gsub (content,
                          "(©%s*%d%d%d%d)—%d%d%d%d",
                          "%1—" .. tagyear)
   content = string.gsub (content,
                          "(©%s*%d%d%d%d)%s+",
                          "%1–" .. tagyear .. " ")
   content = string.gsub (content, tagyear .. "–" .. tagyear, tagyear)
   if string.match (file, "%.dtx$") then
      return string.gsub (content,
                          "%[%d%d%d%d/%d%d/%d%d%s+v[%d%.]*%d+%l?",
                          "[" .. tagdate .. " v" .. tagname)
   elseif string.match (file, "%.md$") then
      return string.gsub (content,
                          "\nRelease: %d%d%d%d%-%d%d%-%d%d%s+v[%d%.]*%d+%l?",
                          "\nRelease: " .. tagdate .. " v" .. tagname )
   elseif string.match (file, "%.lua$") then
      return string.gsub (content,
                          '\nrelease_info%s*=%s*"%d%d%d%d%-%d%d%-%d%d%s*v[%d%.]*%d+%l?"',
                          '\nrelease_info = "' .. tagdate .. " v" .. tagname .. '"' )
   end
   return content
end

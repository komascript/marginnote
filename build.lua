#!/usr/bin/env texlua

--[[
  Build script for marginnote project
  Copyright (c) 2021–2023 Markus Kohm

  This file is part of the build system of marginnote.

  It may be distributed and/or modified under the conditions of the
  LaTeX Project Public License (LPPL), either version 1.3c of this
  license or (at your option) any later version.  The latest version
  of this license is in the file

    https://www.latex-project.org/lppl.txt
]]

release_info = "2022-07-08 v0.2.2"

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
  bugtracker  = "https://github.com/komascript/marginnote/issues",
  home        = "https://github.com/komascript/marginnote",
  repository  = "https://github.com/komascript/marginnote.git",
  note        = "From version 1.4b the package is unmaintained."
}

-- Typesetting

typesetruns  = 5

-- Tagging
-- NOTE: Tagging is currently not supported, because there are different
--       versions for the manual and the package.

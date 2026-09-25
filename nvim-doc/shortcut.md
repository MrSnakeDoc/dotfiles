# Shortcuts

# Neovim / Vim Cheatsheet

## Substitutions

| Cheat                       | Description                                             |
| --------------------------- | ------------------------------------------------------- |
| `:%s/foo/bar/`              | Replace first occurrence per line in entire file        |
| `:%s/foo/bar/g`             | Replace all occurrences in entire file                  |
| `:%s/foo/bar/gc`            | Global replace with confirmation prompt                 |
| `:%s#foo/bar#baz/qux#g`     | Same replace using `#` delimiter (great for paths/URLs) |
| `:s/foo/bar/`               | Replace only on current line                            |
| `:10,20s/foo/bar/g`         | Replace between lines 10 and 20                         |
| `:.,$s/foo/bar/g`           | Replace from current line to end of file                |
| `:'<,'>s/foo/bar/g`         | Replace only inside visual selection                    |
| `:/BEGIN/,/END/s/foo/bar/g` | Replace between two matching patterns                   |

---

## Search

| Cheat      | Description                        |
| ---------- | ---------------------------------- |
| `/pattern` | Search forward for next match      |
| `?pattern` | Search backward for previous match |
| `n`        | Next search result                 |
| `N`        | Previous search result             |
| `gn`       | Select the next search match       |
| `gN`       | Select the previous search match   |
| `:noh`     | Clear the current search highlight |

### Search and Repeat Changes

After searching with `/word<Enter>`, `n` moves to the next match and `N` moves to the previous one. The `.` command repeats the last change at the current cursor position.

| Cheat                       | Description                                                  |
| --------------------------- | ------------------------------------------------------------ |
| `/word<Enter>`              | Search for `word`                                            |
| `n`                         | Move to the next occurrence                                  |
| `N`                         | Move to the previous occurrence                              |
| `n.`                        | Go to the next match, then repeat the last change like `ciw` |
| `N.`                        | Go to the previous match, then repeat the last change        |
| `cgn` + replacement + `Esc` | Change the next search match                                 |
| `.`                         | Repeat `cgn` on the next match                               |
| `dgn`                       | Delete the next search match                                 |

Example workflow:

```text
/word<Enter>
ciwfoobar<Esc>
n.
n.
```

For repeated search-and-replace, `cgn` is often safer than `ciw` + `n.` because the search match itself becomes the next change target.

---

## Substitute Characters and Flash

In native Vim, `s` substitutes characters. LazyVim maps `s` to Flash.nvim, so use an operator and a motion when you want to edit a precise number of non-word characters.

| Cheat      | Description                                                           |
| ---------- | --------------------------------------------------------------------- |
| `s`        | Native Vim: change one character and enter Insert mode                |
| `2s`       | Native Vim: change the next two characters                            |
| `c2l`      | Change the current character and the next character                   |
| `c3l`      | Change the current character and the next two characters              |
| `r{char}`  | Replace the character under the cursor                                |
| `2r{char}` | Replace the next two characters with the same character               |
| `s`        | LazyVim: start a Flash jump                                           |
| `2s`       | LazyVim: start Flash with a count; it is not native `2s` substitution |

Example for changing a literal `\\n`:

```text
c2l
replacement<Esc>
```

If the cursor is on the first character of `\\n`, `c2l` changes exactly the two-character token. This is useful for punctuation, escape sequences, and other text that is not matched by a word text object such as `ciw`.

---

## Undo / Redo

| Cheat    | Description |
| -------- | ----------- |
| `u`      | Undo        |
| `Ctrl-r` | Redo        |

---

## Visual Modes

| Cheat              | Description                                |
| ------------------ | ------------------------------------------ |
| `v`                | Character visual mode                      |
| `V`                | Line visual mode                           |
| `Ctrl-v`           | Visual block mode                          |
| `:` in visual mode | Automatically inserts `'<,'>` visual range |

---

## Text Objects

| Cheat | Description                               |
| ----- | ----------------------------------------- |
| `vip` | Select the current paragraph              |
| `vap` | Select the current paragraph with a space |
| `yip` | Yank the text inside the paragraph        |
| `cip` | Change the current paragraph              |
| `dap` | Delete the current paragraph              |
| `viw` | Select the word under the cursor          |
| `vaw` | Select the word and surrounding space     |
| `ciw` | Change the word under the cursor          |
| `diw` | Delete the word under the cursor          |
| `yiw` | Yank the word under the cursor            |
| `vis` | Select the current sentence               |
| `vas` | Select the sentence and surrounding space |
| `vit` | Select inside an HTML/XML tag             |
| `vat` | Select around an HTML/XML tag             |
| `vi(` | Select inside parentheses                 |
| `va(` | Select around parentheses                 |
| `vi[` | Select inside brackets                    |
| `va[` | Select around brackets                    |
| `vi{` | Select inside braces                      |
| `va{` | Select around braces                      |
| `yi<` | Yank inside `< >` without delimiters      |
| `ya<` | Yank around `< >` including delimiters    |
| `ci<` | Change inside `< >`                       |
| `ca<` | Change around `< >` including delimiters  |
| `di<` | Delete inside `< >`                       |
| `da<` | Delete around `< >` including delimiters  |
| `vi<` | Select inside `< >`                       |
| `va<` | Select around `< >` including delimiters  |
| `yi"` | Yank inside quotes                        |
| `ci"` | Change inside quotes                      |
| `da"` | Delete quotes and content                 |

`i` means “inside” and `a` means “around”. The same object can be combined with `y` (yank), `d` (delete), `c` (change), or `v` (select).

---

## Surrounds

LazyVim uses `mini.surround` for adding, deleting, replacing, and inspecting surrounding characters. The general grammar is:

```text
gsa + motion/text object + surrounding character
```

| Cheat | Description |
| ----- | ----------- |
| `gsaiw"` | Surround the word under the cursor with double quotes |
| `gsaiw'` | Surround the word under the cursor with single quotes |
| `gsaiw(` | Surround the word with parentheses |
| `gsaiw[` | Surround the word with brackets |
| `gsaiw{` | Surround the word with braces |
| `gsaiw*` | Surround the word with `*` characters |
| `gsaip"` | Surround the current paragraph with double quotes |
| `gsa2l"` | Surround the next two characters with double quotes |
| `gsd"` | Delete the double quotes around the current text |
| `gsd(` | Delete the parentheses around the current text |
| `gsr"'` | Replace double quotes around the current text with single quotes |
| `gsr('` | Replace parentheses around the current text with single quotes |
| `gsf"` | Find the next surrounding double quote |
| `gsF"` | Find the previous surrounding double quote |
| `gsh"` | Highlight the surrounding double quote |

Examples:

```text
gsaiw"
gsai(
gsaip"
gsd"
gsr"'
```

For parentheses, brackets, and braces, the opening character usually creates the matching pair automatically. The exact behavior can vary slightly with the configured `mini.surround` settings.

---

## Editing Operators

| Cheat         | Description                                      |
| ------------- | ------------------------------------------------ |
| `.`           | Repeat the last change                           |
| `u`           | Undo the last change                             |
| `Ctrl-r`      | Redo                                             |
| `J`           | Join the current line with the next one          |
| `gJ`          | Join lines without adding a space                |
| `>>`          | Indent the current line                          |
| `<<`          | Unindent the current line                        |
| `==`          | Reindent the current line                        |
| `gg=G`        | Reindent the entire file                         |
| `gqap`        | Reflow the current paragraph                     |
| `gq` + motion | Format text over a motion                        |
| `]p`          | Paste and adjust indentation                     |
| `gp`          | Paste and place the cursor after the pasted text |
| `g&`          | Repeat the last substitution on the entire file  |

## Character and Line Motions

| Cheat               | Description                                  |
| ------------------- | -------------------------------------------- |
| `0`                 | Start of the line                            |
| `^`                 | First non-whitespace character               |
| `$`                 | End of the line                              |
| `g_`                | Last non-whitespace character                |
| `w` / `b`           | Next / previous word                         |
| `e` / `ge`          | End of next / previous word                  |
| `f{char}`           | Jump forward to a character on the line      |
| `F{char}`           | Jump backward to a character on the line     |
| `t{char}`           | Jump just before a character forward         |
| `T{char}`           | Jump just before a character backward        |
| `;` / `,`           | Repeat the last `f`, `F`, `t`, or `T` motion |
| `%`                 | Jump between matching brackets               |
| `gg` / `G`          | Start / end of file                          |
| `{` / `}`           | Previous / next paragraph                    |
| `Ctrl-d` / `Ctrl-u` | Scroll half a screen down / up               |
| `Ctrl-f` / `Ctrl-b` | Scroll a full screen down / up               |
| `zz`                | Center the current line on screen            |

## Operators with Line Boundaries

The operator comes first, followed by the motion. `^` goes to the first non-whitespace character and `$` goes to the end of the line.

| Cheat | Description                                                                  |
| ----- | ---------------------------------------------------------------------------- |
| `y^`  | Yank from the cursor to the first non-whitespace character                   |
| `y$`  | Yank from the cursor to the end of the line                                  |
| `d^`  | Delete from the cursor to the first non-whitespace character                 |
| `d$`  | Delete from the cursor to the end of the line                                |
| `c^`  | Change from the cursor to the first non-whitespace character                 |
| `c$`  | Change from the cursor to the end of the line                                |
| `v^`  | Select from the cursor to the first non-whitespace character                 |
| `v$`  | Select from the cursor to the end of the line                                |
| `^y$` | Go to the first non-whitespace character, then yank to the end of the line   |
| `^d$` | Go to the first non-whitespace character, then delete to the end of the line |
| `^c$` | Go to the first non-whitespace character, then change to the end of the line |
| `^v$` | Go to the first non-whitespace character, then select to the end of the line |
| `yg_` | Yank to the last non-whitespace character of the line                        |
| `d0`  | Delete from the cursor to the absolute start of the line                     |
| `c0`  | Change from the cursor to the absolute start of the line                     |

## Macros and Marks

| Cheat    | Description                                           |
| -------- | ----------------------------------------------------- |
| `qa`     | Start recording macro register `a`                    |
| `q`      | Stop recording a macro                                |
| `@a`     | Execute macro register `a`                            |
| `@@`     | Repeat the last executed macro                        |
| `10@a`   | Execute macro `a` ten times                           |
| `ma`     | Set mark `a` at the current position                  |
| `` `a `` | Jump to the exact position of mark `a`                |
| `'a`     | Jump to the beginning of the line containing mark `a` |
| `''`     | Return to the previous jump position                  |

## Folds

| Cheat       | Description                      |
| ----------- | -------------------------------- |
| `za`        | Toggle the fold under the cursor |
| `zc`        | Close the fold                   |
| `zo`        | Open the fold                    |
| `zM`        | Close all folds                  |
| `zR`        | Open all folds                   |
| `zj` / `zk` | Move to the next / previous fold |

---

## Comments

These are provided by the commenting plugin used by LazyVim.

| Cheat        | Description                                      |
| ------------ | ------------------------------------------------ |
| `gcc`        | Toggle comment on the current line               |
| `gc{motion}` | Toggle comment over a motion, for example `gcap` |
| `gbc`        | Toggle a block comment on the current line       |
| `gb{motion}` | Toggle a block comment over a motion             |
| `gco`        | Add a commented line below                       |
| `gcO`        | Add a commented line above                       |

---

## Buffers and Windows

| Cheat                                 | Description                        |
| ------------------------------------- | ---------------------------------- |
| `<S-h>` / `<S-l>`                     | Previous / next buffer             |
| `[b` / `]b`                           | Previous / next buffer             |
| `<leader>bb`                          | Switch to the alternate buffer     |
| `<leader>bd`                          | Delete the current buffer          |
| `<leader>-`                           | Split horizontally                 |
| `<leader>                             | `                                  | Split vertically |
| `<C-h>` / `<C-j>` / `<C-k>` / `<C-l>` | Move between windows               |
| `<leader>wd`                          | Delete the current window          |
| `<leader>w=`                          | Equalize window sizes              |
| `<leader>wm`                          | Toggle maximize the current window |

---

## LazyVim Essentials

| Cheat             | Description                      |
| ----------------- | -------------------------------- |
| `<leader><space>` | Find files                       |
| `<leader>sg`      | Search text in the project       |
| `<leader>sw`      | Search the word under the cursor |
| `<leader>sk`      | Search keymaps                   |
| `<leader>sh`      | Search help                      |
| `<leader>sr`      | Search and replace               |
| `<leader>gg`      | Open LazyGit                     |
| `<leader>l`       | Open Lazy.nvim                   |
| `<leader>cm`      | Open Mason                       |
| `<leader>uf`      | Toggle format-on-save            |
| `<leader>us`      | Toggle spell checking            |
| `<leader>uw`      | Toggle word wrap                 |
| `<leader>ul`      | Toggle line numbers              |
| `<leader>un`      | Dismiss notifications            |

## Diagnostics and Code Actions

| Cheat        | Description                |
| ------------ | -------------------------- |
| `]d` / `[d`  | Next / previous diagnostic |
| `]e` / `[e`  | Next / previous error      |
| `]w` / `[w`  | Next / previous warning    |
| `<leader>cd` | Line diagnostics           |
| `<leader>ca` | Code actions               |
| `<leader>cf` | Format the current buffer  |
| `grr`        | Find references            |
| `gri`        | Go to implementation       |
| `grt`        | Go to type definition      |
| `gO`         | Open document symbols      |

---

## Files

| Cheat        | Description  |
| ------------ | ------------ |
| `<leader>ff` | Find Files   |
| `<leader>fr` | Recent files |
| `<leader>e`  | Explorer     |

---

## Registers

| Cheat                      | Description                                      |
| -------------------------- | ------------------------------------------------ |
| `<C-r>"`                   | Paste current register into command line         |
| `:%s/<C-r>"/replacement/g` | Use current register content inside substitution |

---

## Search & Replace

| Cheat            | Description                             |
| ---------------- | --------------------------------------- |
| `*`              |                                         |
| `<leader>sr`     | Open Grug Far (Search & Replace projet) |
| `<localleader>r` | Execute replacement (`\r`)              |
| `<localleader>s` | Synchronize all changes (`\s`)          |
| `<localleader>l` | Synchronize current line                |
| `<localleader>n` | Synchronize then go to next result      |
| `<localleader>p` | Synchronize then go to previous result  |
| `<localleader>o` | Open result under cursor                |
| `<Enter>`        | Go to file/result                       |
| `g?`             | Aide Grug Far                           |

---

# Diagnostics / Erreurs

| Cheat        | Description                       |
| ------------ | --------------------------------- |
| `<leader>xx` | Open Trouble (diagnostics projet) |
| `<leader>xX` | Diagnostics current buffer        |
| `<Enter>`    | Go to selected error              |

---

## TODO / FIXME

| Cheat               | Description                   |
| ------------------- | ----------------------------- |
| `// TODO: message`  | Create aTODO                  |
| `// FIXME: message` | Create a FIXME                |
| `// NOTE: message`  | Create a NOTE                 |
| `// HACK: message`  | Create a HACK                 |
| `:TodoTrouble`      | Open all project's TODO/FIXME |
| `<Enter>`           | Go to selected commentary     |

---

## ext Objects (Functions)

| Cheat | Description                         |
| ----- | ----------------------------------- |
| `vaf` | Select all the function             |
| `yaf` | Copy all the function               |
| `daf` | Delete all the function             |
| `caf` | Replace all the function            |
| `dif` | Delete the content of the function  |
| `cif` | Replace the content of the function |
| `yif` | Copy the content of the function    |
| `vif` | Select the content of the function  |

---

## Sessions

| Cheat                       | Description              |
| --------------------------- | ------------------------ |
| `<leader>qs`                | Restore a session        |
| Dashboard → Restore Session | Restore the last session |

---

## Flash.nvim

| Cheat | Description                           |
| ----- | ------------------------------------- |
| `s`   | Quick jump to a visible word searched |
| `S`   | Treesitter Flash                      |
| `r`   | Remote Flash operator                 |
| `R`   | Treesitter Search                     |

---

## LSP

| Cheat                  | Description                   |
| ---------------------- | ----------------------------- |
| `vim.lsp.buf.rename()` | LSP smart rename across files |

---

## LSP Navigation

| Cheat        | Description                                                       |
| ------------ | ----------------------------------------------------------------- |
| `]s`         | Next top-level symbol (struct, interface, func, method, etc.)     |
| `[s`         | Previous top-level symbol (struct, interface, func, method, etc.) |
| `<leader>cs` | Open LSP Symbols picker                                           |
| `gd`         | Go to definition                                                  |
| `gD`         | Go to declaration                                                 |
| `gr`         | Find references                                                   |
| `gI`         | Go to implementation                                              |
| `gt`         | Go to type definition                                             |
| `K`          | Hover documentation                                               |
| `<leader>ca` | Code action                                                       |
| `<leader>cr` | Rename symbol                                                     |

---

## Ranges

| Cheat         | Description                       |
| ------------- | --------------------------------- |
| `%`           | Range = entire file               |
| `.`           | Current line                      |
| `$`           | Last line in file                 |
| `10,20`       | Range between two line numbers    |
| `/foo/,/bar/` | Range between two search patterns |

---

## Suggested F2 Mapping

```lua
vim.keymap.set("n", "<F2>", function()
  local text = vim.fn.getreg('"')

  text = vim.fn.escape(text, [[\.*$^~[]])

  vim.fn.feedkeys(":%s#" .. text .. "#", "n")
end)
```

## Example Workflow

```vim
ya<
F2
replacement#g
```

Or with confirmation:

```vim
replacement#gc
```

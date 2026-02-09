# Vim Configuration for HPC Cluster Development

A minimal, well-documented Vim 8+ configuration for scientific computing on Linux HPC clusters. Supports Python, C, C++, CUDA, cuDAQ, and Qiskit development.

---

## Plugins

| Plugin | Purpose |
|--------|---------|
| gruvbox | Dark color scheme |
| vim-airline | Status bar (mode, file, git branch, lint status) |
| NERDTree | File explorer sidebar |
| fzf / fzf.vim | Fuzzy file and content search |
| vim-fugitive | Git commands inside Vim |
| vim-gitgutter | Git diff markers in the sign column |
| vim-commentary | Toggle comments with `gcc` or `gc` |
| vim-surround | Add/change/delete surrounding quotes and brackets |
| auto-pairs | Auto-close brackets and quotes |
| vim-repeat | Extend `.` repeat to plugin commands |
| vim-polyglot | Syntax highlighting for 100+ languages |
| ALE | Async linting and fixing |
| undotree | Visual undo history |
| vim-better-whitespace | Highlight and strip trailing whitespace |
| indentLine | Vertical indent guide lines |
| tagbar | Function and class outline sidebar (requires ctags) |

---

## Key Mappings

Leader key is `Space`.

### Escape

| Keys | Mode | Action |
|------|------|--------|
| `jj` | Insert | Return to normal mode |
| `Ctrl+C` | Insert | Return to normal mode |

### File Explorer

| Keys | Action |
|------|--------|
| `Space e` | Toggle NERDTree |
| `Space nf` | Find current file in NERDTree |

### Fuzzy Finder

| Keys | Action |
|------|--------|
| `Ctrl+P` | Find files |
| `Space ff` | Find files |
| `Space fg` | Grep file contents (requires ripgrep) |
| `Space fb` | Search open buffers |
| `Space fh` | Search help tags |
| `Space fl` | Search lines in current buffer |
| `Space fr` | Recent files |

### Git

| Keys | Action |
|------|--------|
| `Space gs` | Git status |
| `Space gd` | Git diff |
| `Space gb` | Git blame |
| `Space gl` | Git log |

### Linting (ALE)

| Keys | Action |
|------|--------|
| `Space an` | Next error/warning |
| `Space ap` | Previous error/warning |
| `Space af` | Auto-fix file |
| `Space ad` | Show error detail |
| `Space at` | Toggle ALE on/off |

### Windows and Buffers

| Keys | Action |
|------|--------|
| `Space h/j/k/l` | Move between splits |
| `Space +` | Widen split |
| `Space -` | Narrow split |
| `Space =` | Equalize splits |
| `Tab` | Next buffer |
| `Shift+Tab` | Previous buffer |
| `Space bd` | Close buffer |

### Editing

| Keys | Mode | Action |
|------|------|--------|
| `J` | Visual | Move selected lines down |
| `K` | Visual | Move selected lines up |
| `X` | Visual | Delete without yanking |
| `Space p` | Visual | Paste without overwriting register |
| `gcc` | Normal | Toggle comment on line |
| `gc{motion}` | Normal | Toggle comment on motion |

### Compile Shortcuts

| Keys | Language | Action |
|------|----------|--------|
| `Space cc` | C | Compile with gcc and run |
| `Space cc` | C++ | Compile with g++ and run |
| `Space cc` | CUDA | Compile with nvcc and run |
| `Space cq` | cuDAQ | Compile with nvq++ and run |

### Utility

| Keys | Action |
|------|--------|
| `Space u` | Toggle undo tree |
| `Space t` | Toggle tagbar |
| `Space w` | Save |
| `Space q` | Quit |
| `Space /` | Clear search highlighting |
| `Space sv` | Reload .vimrc |

---

## File Structure

```
vim-config/
  .vimrc       Main configuration
  README.md    This file
  setup.sh     Automated install script
```

After setup:

```
~/.vim/
  autoload/plug.vim    Plugin manager
  plugged/             Installed plugins
  undodir/             Persistent undo files
~/.vimrc               Symlink to vim-config/.vimrc
```

---

## Troubleshooting

| Problem | Fix |
|---------|-----|
| Colors look wrong | Add `export TERM=xterm-256color` to ~/.bashrc |
| Plugins not loading | Run `:PlugInstall` inside Vim |
| ALE not showing errors | Check that linters are installed and modules are loaded |
| fzf is slow | Install ripgrep locally for faster searching |
| Tagbar says ctags not found | Try `module load ctags` or install Universal Ctags |
| jj triggers unexpectedly | Lower `timeoutlen` in .vimrc (e.g., 300) |
| CUDA not highlighted | Ensure file extension is .cu or .cuh |

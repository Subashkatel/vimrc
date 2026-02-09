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
| vimtex | LaTeX editing, compiling, and PDF viewing |
| vim-tmux-navigator | Move between Vim splits and tmux panes with Ctrl+h/j/k/l |
| vimux | Send commands from Vim to a tmux pane |

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

### Tmux Integration

| Keys | Action |
|------|--------|
| `Ctrl+h` | Move to tmux pane / Vim split on the left |
| `Ctrl+j` | Move to tmux pane / Vim split below |
| `Ctrl+k` | Move to tmux pane / Vim split above |
| `Ctrl+l` | Move to tmux pane / Vim split on the right |
| `Space vp` | Prompt for a command and run it in a tmux pane |
| `Space vl` | Re-run the last vimux command |
| `Space vs` | Submit current file with sbatch |
| `Space vr` | Run current file with python |
| `Space vc` | Close the vimux runner pane |
| `Space vi` | Scroll through the runner pane output |

### LaTeX (vimtex)

| Keys | Action |
|------|--------|
| `Space ll` | Start/stop continuous compilation |
| `Space lv` | View compiled PDF |
| `Space le` | Show errors and warnings |
| `Space lc` | Clean auxiliary files |
| `Space lt` | Toggle table of contents |

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

## Setup

```bash
# Clone your repo
git clone https://github.com/YOUR_USERNAME/vimrc.git ~/vimrc

# Symlink the config
ln -sf ~/vimrc/.vimrc ~/.vimrc

# Create the undo directory
mkdir -p ~/.vim/undodir

# Install vim-plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Open vim and install plugins
vim -c "PlugInstall"
# When finished, press Esc then type :qa and hit Enter to exit
```

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

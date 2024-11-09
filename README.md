# Markdown Journaling Plugin

This Vim plugin automatically inserts a markdown header template when you create or open a markdown file. It also renames the file based on the header information when you save the file.

## Features

- Automatically inserts a markdown header template with `title`, `tags`, and `date` fields.
- Renames markdown files based on the header information.
- Easy to set up and use.

## Installation

### Using vim-plug

1. Add the following line to your `.vimrc` or `init.vim`:
    ```vim
    Plug 'asamountain/markdown-Journaling'
    ```

2. Install the plugin:
    ```bash
    :PlugInstall
    ```

### Manual Installation

1. Clone the repository:
    ```bash
    git clone https://github.com/asamountain/markdown-Journaling ~/.vim/pack/plugins/start/markdown-Journaling
    ```

2. Restart Vim.

## Usage

### Automatic Header Insertion

The plugin will automatically insert a markdown header template when you create or open a markdown file. If the header is already present, it will not insert a new one.

### File Renaming

The plugin will rename the markdown file based on the header information (title and date) when you save the file.

## Configuration

You can customize the header template by modifying the `s:InsertHeader` function in the plugin's code.

## License

This plugin is licensed under the MIT License.


# AGENTS.md

## Build, Lint, and Test Commands

- **Build**: No explicit build step is required for this configuration.
- **Lint**: Ensure your Lua code adheres to the Neovim Lua style guidelines.
- **Test**: No specific test framework is configured. Use manual testing within Neovim.

## Code Style Guidelines

1. **Imports**: Use `require` for importing Lua modules. Organize imports at the top of the file.
2. **Formatting**: Follow Lua conventions. Use 4 spaces for indentation.
3. **Types**: Use Lua tables and functions appropriately. Avoid global variables.
4. **Naming Conventions**:
   - Use `snake_case` for variables and functions.
   - Use `PascalCase` for module names.
5. **Error Handling**: Use `pcall` for protected calls to handle errors gracefully.
6. **Keybindings**: Define keymaps using `vim.keymap.set` with descriptive comments.
7. **Autocommands**: Use `vim.api.nvim_create_autocmd` for event handling.
8. **Highlighting**: Use `vim.api.nvim_set_hl` for setting highlights.
9. **Leader Key**: The leader key is set to `<Space>`.
10. **Clipboard**: Integrated with system clipboard using `osc52`.

## Additional Notes

- Ensure all configurations are reloaded using `<leader>rr`.
- Clear search highlights with `<leader><space>`.
- Use `<leader>w` to save files.
- Test keybindings and settings interactively in Neovim.
vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "<leader>zig", "<cmd>LspRestart<cr>")

vim.keymap.set("n", "<leader>vwm", function()
  require("vim-with-me").StartVimWithMe()
end)
vim.keymap.set("n", "<leader>svwm", function()
  require("vim-with-me").StopVimWithMe()
end)

-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]])

-- next greatest remap ever : asbjornHaland
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

-- This is going to get me cancelled
vim.keymap.set("i", "<C-c>", "<Esc>")

vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

vim.keymap.set(
  "n",
  "<leader>ee",
  "oif err != nil {<CR>}<Esc>Oreturn err<Esc>"
)

vim.keymap.set("n", "<leader>vpp", "<cmd>e ~/.dotfiles/nvim/.config/nvim/init.lua<CR>");
vim.keymap.set("n", "<leader>mr", "<cmd>CellularAutomaton make_it_rain<CR>");

vim.keymap.set("n", "<leader><leader>", function()
  vim.cmd("so")
end)

-- Show diagnostics for current line in a floating window
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float)

-- Go to next diagnostic
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)

-- Go to previous diagnostic
vim.keymap.set("n", "]d", vim.diagnostic.goto_next)

-- Show diagnostics list in quickfix window
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist)

vim.keymap.set("n", "]f", function()
  require("nvim-treesitter.textobjects.move").goto_next_start("@function.outer")
end, { desc = "Next function start" })

vim.keymap.set("n", "[f", function()
  require("nvim-treesitter.textobjects.move").goto_previous_start("@function.outer")
end, { desc = "Prev function start" })

vim.keymap.set("n", "]F", function()
  require("nvim-treesitter.textobjects.move").goto_next_end("@function.outer")
end, { desc = "Next function end" })

vim.keymap.set("n", "[F", function()
  require("nvim-treesitter.textobjects.move").goto_previous_end("@function.outer")
end, { desc = "Prev function end" })

-- Add this to your Neovim configuration (init.lua or a separate keymaps file)

local function compile_and_run()
    local filetype = vim.bo.filetype
    local filename = vim.fn.expand('%:p')
    local filename_no_ext = vim.fn.expand('%:p:r')
    
    -- Save the current file first
    vim.cmd('write')
    
    local commands = {
        -- Compiled languages
        c = string.format("gcc -o %s %s && %s", filename_no_ext, filename, filename_no_ext),
        cpp = string.format("g++ -o %s %s && %s", filename_no_ext, filename, filename_no_ext),
        rust = "cargo run",
        go = string.format("go run %s", filename),
        java = string.format("javac %s && java %s", filename, vim.fn.expand('%:t:r')),
        
        -- Interpreted languages
        python = string.format("python3 %s", filename),
        javascript = string.format("node %s", filename),
        typescript = string.format("npx ts-node %s", filename),
        lua = string.format("lua %s", filename),
        ruby = string.format("ruby %s", filename),
        perl = string.format("perl %s", filename),
        php = string.format("php %s", filename),
        bash = string.format("bash %s", filename),
        zsh = string.format("zsh %s", filename),
        sh = string.format("sh %s", filename),
        
        -- Other languages
        kotlin = string.format("kotlinc %s -include-runtime -d %s.jar && java -jar %s.jar", filename, filename_no_ext, filename_no_ext),
        scala = string.format("scalac %s && scala %s", filename, vim.fn.expand('%:t:r')),
        dart = string.format("dart run %s", filename),
        
        -- Web files (using live-server or similar)
        html = string.format("xdg-open %s", filename), -- Linux
        -- html = string.format("open %s", filename), -- macOS
        -- html = string.format("start %s", filename), -- Windows
    }
    
    local cmd = commands[filetype]
    
    if cmd then
        -- Use toggleterm to run the command
        local Terminal = require('toggleterm.terminal').Terminal
        local compile_run_term = Terminal:new({
            cmd = cmd,
            dir = vim.fn.expand('%:p:h'), -- Set working directory to file's directory
            direction = "vertical",
            size = 40,
            close_on_exit = false,
            on_open = function(term)
                vim.cmd("startinsert!")
                vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", {noremap = true, silent = true})
            end,
        })
        compile_run_term:toggle()
    else
        vim.notify("No compile/run command defined for filetype: " .. filetype, vim.log.levels.WARN)
    end
end

-- Set up the keymap
vim.keymap.set('n', '<F5>', compile_and_run, { desc = 'Compile and run current file' })
vim.keymap.set('n', '<leader>r', compile_and_run, { desc = 'Compile and run current file' })

-- Optional: Add a keymap to kill all terminals
vim.keymap.set('n', '<leader>tk', '<cmd>TermExec cmd="exit"<CR>', { desc = 'Kill all terminals' })

-- Optional: Add keymap to open a general terminal
vim.keymap.set('n', '<leader>tt', '<cmd>ToggleTerm<CR>', { desc = 'Toggle terminal' })

-- Simple keymap to open/toggle terminal
vim.keymap.set('n', '<leader>t', '<cmd>ToggleTerm<CR>', { desc = 'Toggle terminal' })
vim.keymap.set('t', '<leader>t', '<cmd>ToggleTerm<CR>', { desc = 'Toggle terminal' })

-- Java template creation
local function create_java_file()
    local filename = vim.fn.input("Java class name: ")
    if filename == "" then
        return
    end
    
    -- Ensure .java extension
    if not filename:match("%.java$") then
        filename = filename .. ".java"
    end
    
    local class_name = filename:gsub("%.java$", "")
    local template_path = vim.fn.stdpath("config") .. "/templates/java_class.java"
    local template_content = ""
    
    -- Read template file
    local template_file = io.open(template_path, "r")
    if template_file then
        template_content = template_file:read("*all")
        template_file:close()
        
        -- Replace placeholders
        template_content = template_content:gsub("{{FILE_NAME}}", class_name)
        template_content = template_content:gsub("{{USER}}", os.getenv("USER") or "Unknown")
        template_content = template_content:gsub("{{DATE}}", os.date("%Y-%m-%d"))
    else
        -- Fallback template
        template_content = string.format([[
/**
 * @author %s
 * @date %s
 */
public class %s {
    
    public static void main(String[] args) {
        
    }
}
]], os.getenv("USER") or "Unknown", os.date("%Y-%m-%d"), class_name)
    end
    
    -- Create the file
    vim.cmd("edit " .. filename)
    vim.api.nvim_buf_set_lines(0, 0, -1, false, vim.split(template_content, "\n"))
    vim.cmd("write")
end

-- Keymap for creating new Java files
vim.keymap.set("n", "<leader>jf", create_java_file, { desc = "Create new Java file from template" })



return {
    {
        "mfussenegger/nvim-dap",
        dependencies = { "rcarriga/nvim-dap-ui",
            "nvim-neotest/nvim-nio",
            "williamboman/mason.nvim",
        },
        config = function()
            local dap = require("dap")
            local dapui = require("dapui")

            require("dapui").setup()



            dap.adapters["pwa-node"] = {
                type = "server",
                host = "127.0.0.1",
                port = 8123,
                executable = {
                    command = "node",
                    args = {"/home/heisenberg/vscode-js-debug/src/dapDebugServer.ts", 8123},
                }
            }

            for _, language in ipairs { "typescript", "javascript" } do
                dap.configurations[language] = {
                    {
                        type = "pwa-node",
                        request = "launch",
                        name = "Launch file",
                        program = "${file}",
                        cwd = "${workspaceFolder}",
                        runtimeExecutable = "node",
                    },
                }
            end


            vim.keymap.set("n", "<Leader>dt", dap.toggle_breakpoint, {})
            vim.keymap.set("n", "<Leader>dc", dap.continue, {})


            dap.listeners.before.attach.dapui_config = function()
                dapui.open()
            end
            dap.listeners.before.launch.dapui_config = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated.dapui_config = function()
                dapui.close()
            end
            dap.listeners.before.event_exited.dapui_config = function()
                dapui.close()
            end

        end,
    },
}

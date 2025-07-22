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

            -- Enhanced Java debugging configuration
            dap.configurations.java = {
                {
                    type = 'java',
                    request = 'attach',
                    name = "Debug (Attach) - Remote",
                    hostName = "127.0.0.1",
                    port = 5005,
                },
                {
                    type = 'java',
                    request = 'launch',
                    name = "Debug Launch (2GB)",
                    vmArgs = '' ..
                        '-Xmx2g '
                },
                {
                    type = 'java',
                    request = 'launch',
                    name = "Debug JavaFX Application",
                    mainClass = function()
                        return vim.fn.input('Main class: ', '', 'file')
                    end,
                    vmArgs = '' ..
                        '-Xmx1g ' ..
                        '--module-path /usr/share/openjfx/lib ' ..
                        '--add-modules javafx.controls,javafx.fxml ',
                    classPaths = {"${workspaceFolder}/build/classes"}
                },
                {
                    type = 'java',
                    request = 'launch',
                    name = "Debug JUnit Test",
                    mainClass = function()
                        return vim.fn.input('Test class: ', '', 'file')
                    end,
                    vmArgs = '' ..
                        '-Xmx512m ',
                    classPaths = {"${workspaceFolder}/build/classes", "${workspaceFolder}/build/test-classes"}
                }
            }

            -- Kotlin debugging configuration (uses same adapter as Java)
            dap.configurations.kotlin = {
                {
                    type = 'java',
                    request = 'attach',
                    name = "Debug (Attach) - Remote",
                    hostName = "127.0.0.1",
                    port = 5005,
                },
                {
                    type = 'java',
                    request = 'launch',
                    name = "Debug Kotlin Application",
                    mainClass = function()
                        return vim.fn.input('Main class: ', '', 'file')
                    end,
                    vmArgs = '' ..
                        '-Xmx1g ',
                    classPaths = {"${workspaceFolder}/build/classes/kotlin/main"}
                },
                {
                    type = 'java',
                    request = 'launch',
                    name = "Debug Kotlin Test",
                    mainClass = function()
                        return vim.fn.input('Test class: ', '', 'file')
                    end,
                    vmArgs = '' ..
                        '-Xmx512m ',
                    classPaths = {"${workspaceFolder}/build/classes/kotlin/main", "${workspaceFolder}/build/classes/kotlin/test"}
                }
            }


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

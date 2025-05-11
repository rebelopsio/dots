-- plugins/mcphub.lua
return {
  "ravitemer/mcphub.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim", -- Required for Job and HTTP requests
  },
  -- Uncomment the following line to load hub lazily if you prefer
  -- cmd = "MCPHub",

  -- Install required mcp-hub npm module
  build = "npm install -g mcp-hub@latest",
  -- Or use this if you don't want mcp-hub to be available globally:
  -- build = "bundled_build.lua",

  opts = {
    port = 37373, -- Default port for MCP Hub

    -- Set config to use directory in neovim's stdpath instead of ~/.config
    config = vim.fn.stdpath("data") .. "/mcphub/servers.json",

    -- Auto approve mcp tool calls to avoid confirmation prompts
    auto_approve = true,

    -- Let LLMs start and stop MCP servers automatically
    auto_toggle_mcp_servers = true,

    -- Extensions configuration
    extensions = {
      avante = {
        make_slash_commands = true, -- Make /slash commands from MCP server prompts
      },
    },

    -- Default window settings
    ui = {
      window = {
        width = 0.8,
        height = 0.8,
        relative = "editor",
        zindex = 50,
        border = "rounded",
      },
    },

    -- Event callbacks
    on_ready = function(hub)
      -- Called when hub is ready
      vim.notify("MCPHub ready", vim.log.levels.INFO)
    end,

    on_error = function(err)
      -- Called on errors
      vim.notify("MCPHub error: " .. err, vim.log.levels.ERROR)
    end,

    -- Set this to true when using build = "bundled_build.lua"
    -- use_bundled_binary = true,

    -- Multi-instance Support - delay before shutting down when last instance closes
    shutdown_delay = 600000, -- 10 minutes

    -- Logging configuration
    log = {
      level = vim.log.levels.WARN,
      to_file = false,
      file_path = nil,
      prefix = "MCPHub",
    },
  },
  config = function(_, opts)
    -- Create the mcphub directory in Neovim's data path if it doesn't exist
    local config_dir = vim.fn.fnamemodify(opts.config, ":h")
    if vim.fn.isdirectory(config_dir) == 0 then
      -- Create the directory
      vim.fn.mkdir(config_dir, "p")
    end

    -- Create an empty config file if it doesn't exist
    if vim.fn.filereadable(opts.config) == 0 then
      local initial_config = vim.json.encode({ mcpServers = {} })
      vim.fn.writefile({ initial_config }, opts.config)
    end

    -- Set up MCPHub with the options
    require("mcphub").setup(opts)

    -- Make the auto_approve setting available globally
    vim.g.mcphub_auto_approve = opts.auto_approve

    -- Add a useful keymap to toggle MCPHub auto_approve
    vim.keymap.set("n", "<leader>mta", function()
      local mcphub = require("mcphub")
      local config = mcphub.get_config()
      config.auto_approve = not config.auto_approve
      vim.g.mcphub_auto_approve = config.auto_approve
      vim.notify("MCPHub auto_approve: " .. tostring(config.auto_approve), vim.log.levels.INFO)
    end, { desc = "MCPHub: Toggle auto approve" })
  end,
}

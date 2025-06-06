-- plugins/avante.lua
return {
  "yetone/avante.nvim",
  event = "VeryLazy",
  version = false, -- Never set this value to "*" as per documentation
  build = "make", -- For Linux/macOS
  -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false", -- For Windows
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "stevearc/dressing.nvim",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    -- Recommended optional dependencies
    "ibhagwan/fzf-lua", -- For file selection
    "nvim-tree/nvim-web-devicons", -- For icons
    "HakonHarnes/img-clip.nvim", -- For image pasting
    "ravitemer/mcphub.nvim", -- For MCP integration
    {
      "MeanderingProgrammer/render-markdown.nvim",
      opts = {
        file_types = { "markdown", "Avante" },
      },
      ft = { "markdown", "Avante" },
    },
  },
  keys = {
    {
      "<leader>aa",
      function()
        require("avante.api").ask()
      end,
      desc = "Avante: Ask",
    },
    {
      "<leader>at",
      function()
        require("avante").toggle()
      end,
      desc = "Avante: Toggle Sidebar",
    },
    {
      "<leader>ar",
      function()
        require("avante.api").refresh()
      end,
      desc = "Avante: Refresh",
    },
    {
      "<leader>af",
      function()
        require("avante").focus()
      end,
      desc = "Avante: Switch Focus",
    },
    {
      "<leader>ae",
      function()
        require("avante.api").edit()
      end,
      desc = "Avante: Edit Selected",
    },
    {
      "<leader>aS",
      function()
        require("avante.api").stop()
      end,
      desc = "Avante: Stop Request",
    },
    { "<leader>ah", "<cmd>AvanteHistory<CR>", desc = "Avante: History" },
    { "<leader>am", "<cmd>MCPHub<CR>", desc = "MCPHub: Open UI" },
  },
  opts = {
    -- Use Claude as the only provider
    provider = "claude",

    -- Configure Claude provider
    claude = {
      endpoint = "https://api.anthropic.com",
      model = "claude-3-5-sonnet-20241022",
      temperature = 0,
      max_tokens = 4096,
      -- Get API key from 1Password CLI
      api_key = function()
        local handle = io.popen("op read 'op://Private/Anthropic API Key/password'")
        if handle then
          local result = handle:read("*a")
          handle:close()
          -- Remove any trailing whitespace/newlines
          return result:gsub("%s+$", "")
        end
        vim.notify("Failed to get Claude API key from 1Password", vim.log.levels.ERROR)
        return nil
      end,
    },

    -- Mode configuration
    mode = "agentic", -- Uses tools to automatically generate code

    -- Window configuration
    windows = {
      position = "right", -- Position the sidebar on the right
      wrap = true,
      width = 30, -- Set width to 30% of available window space
      sidebar_header = {
        enabled = true,
        align = "center",
        rounded = true,
      },
      input = {
        prefix = "> ",
        height = 8,
      },
      edit = {
        border = "rounded",
        start_insert = true,
      },
      ask = {
        floating = false,
        start_insert = true,
        border = "rounded",
        focus_on_apply = "ours",
      },
    },

    -- Behavior configuration
    behaviour = {
      auto_suggestions = false, -- Disable auto suggestions
      auto_set_highlight_group = true,
      auto_set_keymaps = true,
      auto_apply_diff_after_generation = false,
      support_paste_from_clipboard = true,
      minimize_diff = true,
      enable_token_counting = true,
    },

    -- File selector configuration (using fzf-lua)
    selector = {
      provider = "fzf_lua", -- Use fzf-lua for file selection
    },

    -- Web search configuration (optional)
    web_search_engine = {
      provider = "tavily", -- Change as needed
      proxy = nil, -- Set a proxy if needed, e.g., "http://127.0.0.1:7890"
    },

    -- Highlight configuration
    highlights = {
      diff = {
        current = "DiffText",
        incoming = "DiffAdd",
      },
    },

    -- Conflict resolution configuration
    diff = {
      autojump = true,
      list_opener = "copen",
      override_timeoutlen = 500,
    },

    -- Disable built-in tools that might conflict with MCPHub's Neovim server
    disabled_tools = {
      "list_files",
      "search_files",
      "read_file",
      "create_file",
      "rename_file",
      "delete_file",
      "create_dir",
      "rename_dir",
      "delete_dir",
      "bash",
    },

    -- MCPHub Integration for system prompt and custom tools
    -- Using functions to ensure MCPHub is loaded before accessing it
    system_prompt = function()
      local hub = require("mcphub").get_hub_instance()
      return hub:get_active_servers_prompt()
    end,

    custom_tools = function()
      -- Only add MCP tools if MCPHub is available
      local status, mcphub_ext = pcall(require, "mcphub.extensions.avante")
      if status then
        return {
          mcphub_ext.mcp_tool(),
        }
      end
      return {}
    end,
  },
  config = function(_, opts)
    -- Configure Neovim for better experience with Avante
    vim.opt.laststatus = 3 -- Global statusline for better views

    -- Setup img-clip if available
    pcall(function()
      require("img-clip").setup({
        default = {
          embed_image_as_base64 = false,
          prompt_for_file_name = false,
          drag_and_drop = {
            insert_mode = true,
          },
          use_absolute_path = true, -- Important for Windows users
        },
      })
    end)

    -- Setup render-markdown
    pcall(function()
      require("render-markdown").setup({
        file_types = { "markdown", "Avante" },
      })
    end)

    -- Initialize Avante
    require("avante").setup(opts)
  end,
}

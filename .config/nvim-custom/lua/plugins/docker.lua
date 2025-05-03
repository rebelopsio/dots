-- Create a file: lua/plugins/docker.lua
return {
    {
        "skanehira/docker.vim",
        cmd = { "Docker" },
        config = function()
            vim.g.docker_registry_auth = {}
            vim.g.docker_plugin_disable_commands = 0
        end,
    },
}

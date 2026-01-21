return {
  "folke/snacks.nvim",
  opts = {
    picker = {
      sources = {
        explorer = {
          win = {
            list = {
              keys = {
                ["h"] = "down", -- h moves down
                ["l"] = "up", -- l moves up
              },
            },
          },
        },
      },
    },
  },
}

return {
  "folke/snacks.nvim",
  opts = {
    image = {
      formats = {
        "png",
        "jpg",
        "jpeg",
        "gif",
        "bmp",
        "webp",
        "tiff",
        "heic",
        "avif",
        "mp4",
        "mov",
        "avi",
        "mkv",
        "webm",
      },
      force = false, -- try displaying the image, even if the terminal does not support it
      doc = {
        enabled = true,
        inline = true,
        float = true,
        max_width = 80,
        max_height = 40,
      },
      img_dirs = { "img", "images", "assets", "static", "public", "media", "attachments" },
      cache = vim.fn.stdpath("cache") .. "/snacks/image",
    },
  },
}

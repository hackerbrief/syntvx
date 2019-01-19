# TODO |CONFIG| Production : Update Asset Version & Notes if Changes before Deployment
# TODO [CONFIG] Production : Changes: /assets & /public & /vendor - Ext: .css .scss .js .coffee .json .jpg .jpeg .png

# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
# 01-18-2018 : 8:00 PM : v1.57
# Format: '#.##' | after #.#9 Increment to New Decedant | if .99 = New Full Version
Rails.application.config.assets.version = '1.57'

# Add additional assets to the asset load path.
# Rails.application.config.assets.paths << Emoji.images_path
# Add Yarn node_modules folder to the asset load path.
Rails.application.config.assets.paths << Rails.root.join('node_modules')

Rails.application.config.assets.paths << Rails.root.join("app", "assets", "fonts")

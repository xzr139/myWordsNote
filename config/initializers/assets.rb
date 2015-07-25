# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )
Rails.application.config.assets.precompile += %w( sessions.css )
Rails.application.config.assets.precompile += %w( notes.css )
Rails.application.config.assets.precompile += %w( bootstrap/bootstrap.css )
Rails.application.config.assets.precompile += %w( bootstrap/bootstrap-overrides.css )
Rails.application.config.assets.precompile += %w( globals/elements.css )
Rails.application.config.assets.precompile += %w( globals/icons.css )
Rails.application.config.assets.precompile += %w( globals/layout.css )
Rails.application.config.assets.precompile += %w( lib/font-awesome.css )
Rails.application.config.assets.precompile += %w( lib/jquery-ui-1.10.2.custom.css )
Rails.application.config.assets.precompile += %w( lib/tables.css )
Rails.application.config.assets.precompile += %w( lib/jquery.dataTables.css )
Rails.application.config.assets.precompile += %w( lib/fullcalendar.css )
Rails.application.config.assets.precompile += %w( lib/fullcalendar.print.css )

Rails.application.config.assets.precompile += %w( bootstrap.min.js )
Rails.application.config.assets.precompile += %w( theme.js )
Rails.application.config.assets.precompile += %w( sessions.js )
Rails.application.config.assets.precompile += %w( notes.js )
Rails.application.config.assets.precompile += %w( jquery-ui-1.10.2.custom.min.js )
Rails.application.config.assets.precompile += %w( jquery.flot.js )
Rails.application.config.assets.precompile += %w( jquery.flot.resize.js )
Rails.application.config.assets.precompile += %w( jquery.flot.stack.js )
Rails.application.config.assets.precompile += %w( jquery.knob.js )
Rails.application.config.assets.precompile += %w( jquery.dataTables.js )
Rails.application.config.assets.precompile += %w( fullcalendar.js)
Rails.application.config.assets.precompile += %w( skpublishapi.js)
# frozen_string_literal: true

# Eliminates "page=1" in the link for the first page of results
require "pagy/extras/trim"

# Prevents Pagy::OverflowError exception when viewing an out of bound page number
require "pagy/extras/overflow"

# Allows for paging without doing a COUNT(*) query
require "pagy/extras/countless"

# Additional helpers
require "pagy/extras/support"

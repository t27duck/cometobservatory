# frozen_string_literal: true

class PendingPost < ApplicationRecord
  belongs_to :source
end

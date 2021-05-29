# frozen_string_literal: true

class PendingPostProcessor
  def initialize
    @source_ids = []
  end

  def process
    @source_ids = PendingPost.distinct.pluck(:source_id)

    return if @source_ids.empty?

    run_through
  end

  private

  def run_through
    @source_ids.shuffle

    @source_ids.dup.each do |source_id|
      pending_post = PendingPost.where(source_id: source_id).first

      if pending_post
        pending_post.create_post!
      else
        @source_ids.delete(source_id)
      end
    end

    run_through unless @source_ids.empty?
  end
end

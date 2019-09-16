# frozen_string_literal: true
require 'rails_helper'

RSpec.describe FeedItem, type: :model do
  it { is_expected.to validate_presence_of :url }

  describe '#add_tags' do
    context 'a feed with with tag "a" exists' do
      before do
        @context = 'tags'
        @tag = create(:tag, name: 'a')
        @feed = create(:feed)
        @feed_item = create(:feed_item_from_feed, :tagged, feed: @feed,
                                                           tag: @tag.name, tag_context: @context)
      end
      it 'deactivates the old tag "a" tagging when a new one is added' do
        pre_tagging = @feed_item.taggings.where(tag_id: @tag.id).first
        @feed_item.add_tags([@tag.name], @context, @feed)
        post_tagging = @feed_item.taggings.where(tag_id: @tag.id).first
        expect(pre_tagging).not_to eq(post_tagging)
      end
    end
  end

  describe '#copy_global_tags_to_hubs' do
    context 'a feed item with tag "a" exists in two hubs' do
      before do
        @hub1 = create(:hub)
        @hub2 = create(:hub)
        @feed = create(:feed)
        @tag = create(:tag, name: 'a')
        @hub1.feeds << @feed
        @hub2.feeds << @feed
      end

      def tags_in_context(feed_item, context)
        feed_item.taggings
                 .where(context: context)
                 .map { |tagging| [tagging.tag_id, tagging.taggable, tagging.tagger] }
      end

      it 'copies all taggings into each hub' do
        feed_item = create(:feed_item_from_feed, :tagged, tag: @tag, feed: @feed)

        original_taggings = tags_in_context(feed_item, 'tags')
        copied_taggings1 = tags_in_context(feed_item, @hub1.tagging_key)
        copied_taggings2 = tags_in_context(feed_item, @hub2.tagging_key)

        expect(original_taggings.count).to be > 0
        expect(original_taggings).to match_array(copied_taggings1)
        expect(original_taggings).to match_array(copied_taggings2)
      end

      it 'does not create duplicate taggings' do
        feed_item = create(:feed_item_from_feed, :tagged, tag: @tag, feed: @feed)
        expect do
          feed_item.copy_global_tags_to_hubs
        end.not_to raise_error
      end
    end
  end
end

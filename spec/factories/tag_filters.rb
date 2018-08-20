# frozen_string_literal: true

FactoryBot.define do
  factory :tag_filter do
    hub
    tag
    scope { hub }

    factory :add_tag_filter, class: AddTagFilter
    factory :delete_tag_filter, class: DeleteTagFilter
    factory :modify_tag_filter, class: ModifyTagFilter do
      association :new_tag, factory: :tag
    end
    factory :supplement_tag_filter, class: SupplementTagFilter do
      association :new_tag, factory: :tag
    end
  end
end

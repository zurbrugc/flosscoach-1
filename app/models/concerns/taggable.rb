module Taggable
  extend ActiveSupport::Concern
  included do
    has_and_belongs_to_many :tags, -> { distinct } do
      def <<(tag)
        tag = Tag.find_or_create_by(name: tag) if tag.kind_of?(String)
        super(tag)
      end
      def delete(tag)
        tag = Tag.find_or_create_by(name: tag) if tag.kind_of?(String)
        super(tag)
      end
    end
  end
end

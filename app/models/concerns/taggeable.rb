module Taggable
  extend ActiveSupport::Concern
  included do
    validate :no_repeated_tag

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

    def no_repeated_tag
     if tags.uniq.length != tags.length
       errors.add(:tags, "No repeated tags accepted!")
     end
   end

  end
end

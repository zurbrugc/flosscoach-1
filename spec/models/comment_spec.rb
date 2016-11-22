require "rails_helper"

RSpec.describe Comment, type: :model do

  before do
    @comment = Comment.new
    @comment.content = "Potatoes!"
    @comment.save

    @comment2 = Comment.new
    @comment2.content = "Potatoes!"
    @comment2.reply_to = @comment
    @comment2.save

  end

  describe "#nested comment" do
    it "nested comment" do
      search_comment = @comment.replies.first
      expect(search_comment) ==  @comment2
    end

 
  end

end

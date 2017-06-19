class OpinionWidget < Widget
  before_create :define_slug

  def self.generate
    OpinionWidget.build("Opinion by the others newcomes", tab: :about, x: 0, y: 11, width: 12, height: 5)
  end
  def content
    ApplicationController.render 'widgets/opinion_widget', layout: false,assigns:{ project: project }
  end

  def to_partial_path
     'widgets/widget'
   end

   private
   def define_slug
     self.slug = 'opinion_widget'
   end
end

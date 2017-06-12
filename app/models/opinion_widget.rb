class OpinionWidget < Widget
  def self.build(title, slug: 'opinion_widget' , tab:, x:, y:, width:, height:, editable: false, deletable: false)
    widget = OpinionWidget.new
    widget.title = title
    widget.slug = slug
    widget.tab = tab
    widget.pos_x = x
    widget.pos_y = y
    widget.width = width
    widget.height = height
    widget.content = nil
    widget.deletable = deletable
    widget.editable = editable
    widget
  end
  def self.generate
    OpinionWidget.build("Opinion by the others newcomes", tab: :about, x: 0, y: 11, width: 12, height: 5)
  end
  def content
    ApplicationController.render 'widgets/opinion_widget', layout: false,assigns:{ project: project }
  end

  def to_partial_path
     'widgets/widget'
   end
end

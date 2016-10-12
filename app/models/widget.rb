class Widget < ActiveRecord::Base
	validates_presence_of :title
	validates_presence_of :tab #tab-slug?
	validates_presence_of :pos_x
	validates_presence_of :pos_y
	validates_presence_of :width
	validates_presence_of :height
	validates_presence_of :content

	belongs_to :project




	scope :from_tab_about, -> {where("lower(trim(tab))= ?", "about")}
	scope :from_tab_how_to_start, -> {where("lower(trim(tab))= ?", "how_to_start")}
	scope :from_tab_configure_workspace, -> {where("lower(trim(tab))= ?", "configure_workspace")}
	scope :from_tab_know_the_code, -> {where("lower(trim(tab))= ?", "know_the_code")}
	scope :from_tab_send_contribution, -> {where("lower(trim(tab))= ?", "send_contribution")}


	
end

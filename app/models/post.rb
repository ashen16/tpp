class Post < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: [:slugged, :finders]
	acts_as_taggable

  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h

  after_update :crop_image
  mount_uploader :image, ImageUploader

	def should_generate_new_friendly_id?
  	slug.blank? || title_changed?
	end

  def crop_image
    image.recreate_versions! if crop_x.present?
  end
end

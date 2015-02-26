class Article < ActiveRecord::Base
  has_many :comments, dependent: :destroy
  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings, dependent: :destroy
  has_attached_file :image, styles: { medium: "300x300>" }
  validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png"]


  def tag_list
    tags.join(", ")
  end

  def tag_list=(tag_string)
    tag_names = tag_string.split(',').map { |s| s.strip.downcase }.uniq
    new_or_found_tags = tag_names.map { |name| Tag.find_or_create_by(name: name) }
    self.tags = new_or_found_tags
  end
end

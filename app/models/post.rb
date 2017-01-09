class Post < ApplicationRecord

  scope :published, -> { where(state: "published") }
  scope :draft, -> { where(state: "draft") }

  before_save do
    self.words = self.description.split(/[[:alnum:]]+/).size
  end

  def to_html
    self.description
  end

end

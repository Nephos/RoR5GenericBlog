class Post < ApplicationRecord

  scope :published, -> { where(state: "published") }
  scope :draft, -> { where(state: "draft") }

  before_save do
    self.words = self.description.split(/[[:alnum:]]+/).size
    self.description = self.description.to_s
  end

  def to_html
    MARKDOWN.render(self.description).html_safe
  end

  def to_short_html
    MARKDOWN.render(self.description.split(/\r?\n---+\r?\n/).first).html_safe
  end

  def duration
    (words / 300.0).ceil
  end

  def date
    [updated_at != created_at ? :'updated at' : :'created at', updated_at.strftime("%d/%m/%Y %H:%M")]
  end

end

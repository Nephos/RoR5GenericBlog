class Post < ApplicationRecord
  acts_as_taggable

  scope :published, -> { where(state: "published") }
  scope :draft, -> { where(state: "draft") }

  DEFAULT_STATE = "draft"
  STATES = %(draft published)
  before_save do
    self.description = self.description.to_s
    self.words = self.description.split(/[[:alnum:]]+/).size
    self.tag_list = self.tag_list.map &:downcase
    unless STATES.include? self.state
      self.state = DEFAULT_STATE
    end
  end

  def to_html
    MARKDOWN.render(self.description).html_safe
  end

  def to_short_html
    MARKDOWN.render(self.description.split(/\r?\n---+\r?\n/).first.to_s).html_safe
  end

  def duration
    (words / 300.0).ceil
  end

  def date
    [updated_at != created_at ? :'updated at' : :'created at', updated_at.strftime("%d/%m/%Y %H:%M")]
  end

end

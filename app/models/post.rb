class Post < ApplicationRecord
  acts_as_taggable

  scope :published, -> { where(state: "published") }
  scope :draft, -> { where(state: "draft") }

  DEFAULT_STATE = "draft"
  STATES = %(draft published)
  before_save do
    self.subtitle = nil if self.subtitle.to_s.strip.empty?
    self.image = nil if self.image.to_s.strip.empty?
    self.description = self.description.to_s
    self.words = self.description.to_s.split(/[[:alnum:]]+/).size
    self.tag_list = self.tag_list.map(&:downcase).sort
    self.state = DEFAULT_STATE unless STATES.include? self.state
    self.created_at = Time.now if self.state_was == DEFAULT_STATE
  end

  def clean_description
    self.description.gsub(/\r?\n~~~+\r?\n/, '')
  end

  def to_html
    MARKDOWN.render(self.clean_description).html_safe
  end

  def to_short_html
    MARKDOWN.render(self.description.split(/\r?\n~~~+\r?\n/).first.to_s).html_safe
  end

  # If it is likely to display short by default
  def short!
    @short = true
  end

  def short?
    @short == true
  end

  def pandoc!(format=:tex)
    f = Tempfile.open
    f.puts "%#{self.title} \\newline \\small{(#{self.duration} minutes reading, #{self.words} words)} \n%#{ENV['BLOG_AUTHOR']}\n%\\today\n#{self.clean_description}"
    f.flush

    o = Tempfile.open
    output_path = "#{o.path}.#{format}"
    `pandoc #{f.path} --standalone -o #{output_path}`
    data = File.open(output_path).read
    File.unlink(output_path)
    data
  end

  def duration
    (words / 300.0).ceil
  end

  def date
    [updated_at != created_at ? :'updated at' : :'created at', updated_at.strftime("%d/%m/%Y %H:%M")]
  end

end

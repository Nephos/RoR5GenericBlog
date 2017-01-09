class Post < ApplicationRecord

  before_save do
    self.words = self.description.split(/[[:alnum:]]+/).size
  end

end

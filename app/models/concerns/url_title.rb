module UrlTitle
  extend ActiveSupport::Concern
  
  included do
    before_validation :set_url_title
  end
  
  module ClassMethods
    def validates_url_title_unique uniqueness_scope = true
      validates :url_title, presence: true, uniqueness: uniqueness_scope
    end
  end
  
  def to_param
    url_title
  end
  
  protected
  
  def set_url_title
    self.url_title ||= title.to_s.parameterize if title?
  end
end

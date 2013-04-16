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
    self.url_title ||= unique_url_title(title.parameterize) if title?
  end
  
  def unique_url_title title
    title.dup.tap do |value|
      # FIXME: uniqueness_scope for Page
      scope   = new_record? ? self.class : self.class.where('id != ?', id)
      counter = 0
      
      while scope.where(url_title: value).exists?
        value.replace "#{title}-#{counter += 1}"
      end
    end
  end
end

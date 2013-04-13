class Section < ActiveRecord::Base
  include OrderByPosition
  
  has_many :pages, inverse_of: :section
  
  validates :title, length: { maximum: 100 }
  
  protected
  
  def order_scope
    self.class.all
  end
end

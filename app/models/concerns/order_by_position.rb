module OrderByPosition
  extend ActiveSupport::Concern
  
  included do
    default_scope { order(:position) }
    
    before_validation :set_position
    
    validates :position, presence: true, numericality: true
  end
  
  protected
  
  def set_position
    if scope = order_scope
      self.position ||= (scope.maximum(:position) || 0) + 1
    end
  end
end

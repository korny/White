module OrderByPosition
  extend ActiveSupport::Concern
  
  included do
    default_scope { order(:position) }
    
    before_save :set_position
    
    validates :position, presence: true, numericality: true, allow_nil: true
    
    after_destroy :cleanup_positions
  end
  
  module ClassMethods
    def update_order ids
      if ids.size == count
        ids.each_with_index do |id, index|
          where(:id => id).update_all ['position = ?', index + 1]
        end
      else
        raise 'number of given ids differs from records to order: %p != %p' % [ids.size, count]
      end
    end
  end
  
  protected
  
  def set_position
    order_scope.try(:update_all, 'position = position + 1')
    
    self.position = 1
  end
  
  def cleanup_positions
    order_scope.try(:update_order, order_scope.ids)
  end
end

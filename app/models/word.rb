class Word < ActiveRecord::Base
  default_scope :order => 'remembercount ASC, updated_at ASC'
  attr_accessible :english, :translation, :remembercount, :remembered

  after_initialize :init

  validates_presence_of :english
  validates_presence_of :translation

  def init
    self.remembered = true if self.remembered.nil?
    self.remembercount ||= 0
  end
end

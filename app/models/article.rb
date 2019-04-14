class Article < ApplicationRecord

  validates :title, :text, presence: true
  validates :title, length: {minimum: 5, maximum: 40}, uniqueness: true

  validate :text_can_not_contain_title, if: :text

  before_validation :stripwhitespace
  after_validation
  before_save :striphtmlanduse_markdown, if: :text

  private

  def text_can_not_contain_title
    if text.is_a? String
      if text.index(title)
        errors.add(:text, cannot_contain_title)
      end
    end
  end

  def stripwhitespace
    if title.is_a? String
      title.strip!
    end
    if text.is_a? String
      text.strip!
    end
  end

  def striphtmlanduse_markdown
    text.gsub!(/<[^>]*>/, '')
    text.gsub!(/\*(.+?)\*/, '<b>\1</b>')
  end

end

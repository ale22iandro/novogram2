class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user
  # Не может быть комментария без события
  validates  :post, presence: true
  # Пустой комментарий тоже недопустим
  validates :body, presence: true, length: {maximum: 140}

  # Это поле должно быть, только если не выполняется user.present? (у объекта на задан юзер)
  validates :user_name, presence: true, unless: -> { user.present? }

  def username
    if user.present?
      user.name
    else
      super
    end
  end

end

class CommentPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    true
  end

  def update?
    @user.admin? or @record.user == @user
  end

  def destroy?
    @user.admin? or @record.user == @user
  end

end

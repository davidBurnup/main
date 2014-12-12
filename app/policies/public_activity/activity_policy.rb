class PublicActivity::ActivityPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    @user.admin?
  end

  def update?
    @user.admin?
  end

  def destroy?
    @user.admin? or @record.user == @user
  end

end

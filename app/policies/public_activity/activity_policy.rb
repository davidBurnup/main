class PublicActivity::ActivityPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    true
  end

  def show?
    true
  end

  def update?
    true
  end

  def destroy?
    @user.present? and (@user.admin? or @record.owner == @user)
  end

end

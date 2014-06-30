class ChurchPolicy
  attr_reader :user, :church

  def initialize(user, church)
    @user = user
    @church = church
  end

  def index?
    @user.admin?
  end

  def new?
    @user.admin?
  end

  def create?
    @user.admin?
  end

  def edit?
    @user.admin?
  end

  def update?
    @user.admin?
  end

  def destroy?
    @user.admin?
  end

end
class PagePolicy
  attr_reader :user, :page

  def initialize(user, page)
    @user = user
    @page = page
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

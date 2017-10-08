class SongPolicy
  attr_reader :user, :page

  def initialize(user, song)
    @user = user
    @song = song
  end

  def index?
    true
  end

  def show?
    true
  end

  def new?
    page_atomic_authorization
  end

  def create?
    page_atomic_authorization
  end

  def edit?
    page_atomic_authorization
  end

  def update?
    page_atomic_authorization
  end

  def destroy?
    page_atomic_authorization
  end

  def page_atomic_authorization
    can = false

    # User is superadmin
    if is_super_admin = @user.has_role?("admin")
      can = true
    end

    # User is moderator of the origin page of the song
    if @user.page and (@user.page == @song.origin_page or @song.new_record?) and @song.origin_page and @user.has_page_role?(@song.origin_page, "moderator")
      can = true
    end

    can
  end

end
